From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 13:01:20 +0200
Message-ID: <201007191301.22287.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <201007190119.04873.jnareb@gmail.com> <1279523523.3077.8.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 19 13:01:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oao6P-0006bm-Oe
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 13:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760542Ab0GSLBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 07:01:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56559 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760501Ab0GSLBe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 07:01:34 -0400
Received: by bwz1 with SMTP id 1so2191500bwz.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sc7huYca31KhE4V7JKKLU4YEAD5EU6TUsUQyJTH0gtM=;
        b=nTMJnMiM2NZDzN9oKUfyVp/Ak/8Hn5uFZ3ZdNN5EfkMt57SG/2Ccfmm3ZaCBvv/1C7
         Y/f1rG+u5umFzPRc0tRgvOvx/kIn0y3YOkxOre+3NJtG1h5/M+lO1l5CvtB5znKVw4Ov
         N5gX6a677QpDiesXFb3A0FIN8SJOAfcNVGYMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GUqpRMyos1UUKjohT9NeBO9Qxu/AeHlR7Vqc1s870GSd5d647G8ycxfgIc7hXpTImb
         Nh/2JjGwTFblLzi80TBpSF5NWb0Mo9JvocdYN6Kj2U1WGf56GyQv+6FrO2Uu7bgwF4bz
         9oo4pF+9/tbxqVSG2245MtAbGAsU84ndB4iho=
Received: by 10.204.15.148 with SMTP id k20mr3720658bka.74.1279537292874;
        Mon, 19 Jul 2010 04:01:32 -0700 (PDT)
Received: from [192.168.1.13] (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id a9sm25259831bky.23.2010.07.19.04.01.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 04:01:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279523523.3077.8.camel@dreddbeard>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151248>

On Mon, 19 Jul 2010, Will Palmer wrote:
> On Mon, 2010-07-19 at 01:19 +0200, Jakub Narebski wrote:
> > On Sun, 18 Jul 2010, Will Palmer wrote:
> > > On Sun, 2010-07-18 at 13:55 +0200, Jakub Narebski wrote:

> > > having any kind of suffix like refs~/heads~/bar is just asking for
> > > someone to delete a branch twice.
> > 
> > I don't understand what you wanted to say here.  Using the
> > 
> >   $GIT_DIR/logs/refs~/heads~/bar
> > 
> > (and not $GIT_DIR/refs~/heads~/bar) as a reflog for a deleted branch
> > 'bar' is an implementation detail.  You wouldn't see refs~/heads~/bar
> > when listing branches... well, perhaps 'git branch --list-deleted'
> > could be used to list deleted branches (by scanning for reflogs).
> 
> git branch -d integration
> # git renames logs/refs/heads/integration to logs/refs~/heads~/integration
  # git adds deletion event to logs/refs~/heads~/integration reflog
    (similar to putting creation or rename event in reflog)
> git co -b integration sometopic
> # git creates refs/heads/integration, unrelated to the old one
> (do some work)
> (merge into the main branch)
> git branch -d integration

You touch interesting and important issue.

> 
> Now what?
> git renames refs/heads/integration to ... what?
> - does the old refs~/heads~/integration get clobbered? If that's ever
>   okay, why are we even having this discussion?

That's one solution.  We give some safety net, but not too much of
safety net.

> - does the "old reflog" stuff get combined? If that's ever okay, why
>   even have an extra reflog, instead of just using the reflog we
>   already have?

That's another solution.  We have deletion events in reflog to find
events for first 'integration', and distinguish them from events for
second (unrelated) 'integration' branch.

We can't just deal with reflogs of deleted branches by leaving them
as they are, not moved to logs/refs~/heads~/..., and combining them
because of possibility of D/F conflict (and yet another issue,
described below).  The reflog for branch 'foo' would block creating
reflog for branch 'foo/bar'.  Besides I think it's O.K. to require
more work to access reflogs for deleted branches, but not good to
force more work for reflogs for normal branches.


There is also a variant of the situation you described that makes
it harder for the 'concatenate reflogs of deleted branches' solution
to work well, namely:

 $ git branch -d foo
 $ git branch -m bar foo   
 $ git branch -d foo

where branch 'bar', renamed to 'foo' and then deleted has reflog from
before deletion of first 'foo' branch.

> - do we move everything else one step down, so refs~/heads~/integration
>   becomes refs~2/heads~2/integration? (ie: 2-dimensional reflog, which
>   sounds rather too fancy, to me)

This is yet another solution, although I think the better naming would
be to borrow concept of numbered backups, i.e. have

  logs/refs~/heads~/integration~1~
  logs/refs~/heads~/integration~2~
  ...

BTW., we can even make git branch ask (prompt for answer) whether to
delete old reflog of first 'integration' branch, or keep it in some
form... unless confiogured to always choose one solution.


Sigh... this makes eventual solution complicated, but the problem is
also complicated...


P.S. Wouldn't 'refs~' and 'foo~1~' filenames/pathnames be a problem
on MS Windows / on MS Windows filesystems: NTFS or FAT28^W FAT32?
Or on HFS+ on MacOS X?

-- 
Jakub Narebski
Poland
