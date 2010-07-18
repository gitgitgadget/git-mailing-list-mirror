From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 01:19:04 +0200
Message-ID: <201007190119.04873.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <201007181355.36691.jnareb@gmail.com> <1279484847.8999.22.camel@dreddbeard>
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
X-From: git-owner@vger.kernel.org Mon Jul 19 01:19:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oad8n-0000OP-3H
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 01:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab0GRXTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 19:19:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57089 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab0GRXTG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 19:19:06 -0400
Received: by bwz1 with SMTP id 1so2006955bwz.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oxs/oQCCzEAVcEJiyvuPm6DYibyNb7lz3NN3vBDgk9k=;
        b=la28eFf52i7HMpK7qpU1Q1+P6gYm2qdDe2OcdeHQ0m/PYMKeajW3GXBebcAaCR3PDZ
         /WSEH59VJuXP11+FQ/SnTYxUhVjhNLIWPZULfk0ympv5bIVfgGyb1x/P3xDOjo+aw/1G
         WPH8qhCQk9G7s4kapRkugIxLwDY/WKRKcYin0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nDWGLT3JJqu3/GGVLcE681X3Olpjx7ym5ohJg9VVkgPhQBEOhRkObq9L4o3Wus4ina
         QqsmsCY+8/8CdM8YuHYteJXVQ5wtF8KgyfDyDR8sKkXxPGA3qeiznQRNQYPwPfMwWQLd
         A+1BKrlXqkgXFiDVkGAKMLEdb6jzlgug9e0DA=
Received: by 10.204.99.74 with SMTP id t10mr3274334bkn.170.1279495144725;
        Sun, 18 Jul 2010 16:19:04 -0700 (PDT)
Received: from [192.168.1.13] (abwa30.neoplus.adsl.tpnet.pl [83.8.224.30])
        by mx.google.com with ESMTPS id o20sm22882850bkw.3.2010.07.18.16.19.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 16:19:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279484847.8999.22.camel@dreddbeard>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151242>

On Sun, 18 Jul 2010, Will Palmer wrote:
> On Sun, 2010-07-18 at 13:55 +0200, Jakub Narebski wrote:
> > On Sun, 18 Jul 2010, Jonathan Nieder wrote:

> > The same as with D/F conflict.  If you rename branch 'foo' to 'bar',
> > you also rename its reflog, but logs/refs/heads/bar would not conflict
> > with reflog for deleted branch, logs/refs~/heads~/bar (if you had 
> > deleted branch 'bar').
> 
> having any kind of suffix like refs~/heads~/bar is just asking for
> someone to delete a branch twice.

I don't understand what you wanted to say here.  Using the

  $GIT_DIR/logs/refs~/heads~/bar

(and not $GIT_DIR/refs~/heads~/bar) as a reflog for a deleted branch
'bar' is an implementation detail.  You wouldn't see refs~/heads~/bar
when listing branches... well, perhaps 'git branch --list-deleted'
could be used to list deleted branches (by scanning for reflogs).
 
> Regardless of whether or not it would be difficult to implement, I think
> the ideal (for me) would be:
>
> 1) existing syntax should work as-is. I like my reflog and don't want
>    people screwing with it ;)

Nobody proposes anything different.

> 2) new syntax should be added for "some/ref@{..even if it's been
>    renamed or deleted..}", perhaps an entry in the reflog which points
>    to the "old name" / fact that it's been resurrected, for
>    moves/resurrections 

Here comes hard part: naming ;-)  Or rather chosing API for refering to
deleted branches and their reflogs.

> 3) getting rid of something "for real" should be a simple command away.
>    If the steps are getting too numerous (delete, expire, /then/ prune?
>    Anything else?) then perhaps we just need a "git shred <ref>" which
>    takes care of listing out what will be involved, giving you lots of
>    chances to abort, etc, and which maybe is less of a sledgehammer than
>    the current method.

Depending on default safety net, i.e. on default expire time for
reflogs of deleted branches (perhaps just 1 day, or at most 7 days?),
it could be as simple as 'git gc'.

> 
> From the discussion, I think the things we agree that we all want are:
>
> 1) For git to not lose data by accident. Maybe there is disagreement
>    as to whether or not this already happens. I think the information
>    currently lost is: 
>      a) the name (i.e. ease of finding the "lost" commit)

Usually HEAD reflog would be enough at least when "safely" deleting
with 'git branch -d' (and not '-D'), but it is not the case after
relaxing rules a bit.
      
>      b) the reflog (which I think is utterly lost on delete at the
>         moment?). 

Yes it is.  So even if you manage to resurrect branch thanks to HEAD
reflog or tools like contrib/git-resurrect.sh, the data in reflog would
be lost.

> Both of these are often useless after a delete, but sometimes wanted.

True.

> 2) A straightforward way to restore information which has not been
>    lost (again, perhaps there is disagreement as to whether this
>    already exists)

'git branch <old name> <old SHA-1>' is good, though it is perhaps not
quite that straighforward.

> 3) A way to distinguish between "the reflog entries of a deleted ref
>    with the same name as our new ref" and "the new ref's entries"
>    (these are the "attic" discussions, etc) (not applicable to the
>    current situation)

This is a problem of API design.  Probably overloading @{...} yet again
(@{<n>}, @{<time>}, @{-<n>}, @{upstream}), though using '~' as suffix
(or ~@{<n>} when refering to reflog of deleted branch) could be
a solution.

> 4) A way to really get rid of things which are no longer wanted. This
>    should be straightforward and have sane defaults so that, as mentioned,
>    adding then removing the wrong remote doesn't leave you with an extra
>    repos' worth of data for the next six months. (obviously this one
>    already exists)

Well, 'git -c gc.reflogexpire=0 -c gc.reflogexpireunreachable=0 gc --prune=now'
is a bit mouthfull ;-)

> 
> Did I miss anything?

-- 
Jakub Narebski
Poland
