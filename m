From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not  author
Date: Fri, 6 Feb 2009 22:12:05 +0100
Message-ID: <200902062212.08857.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <200902050038.57999.jnareb@gmail.com> <cb7bb73a0902060314u4741528bs196a43d45ff7f283@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 22:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVY1D-0004a1-9g
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 22:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbZBFVMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 16:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbZBFVMT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 16:12:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:56640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbZBFVMT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 16:12:19 -0500
Received: by fg-out-1718.google.com with SMTP id 16so620861fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6RLMlMMYlG2b896cR2p4RAZLhbtqPJTTZrcx5R60G0U=;
        b=MnnGd9x5B2oQlQnGpfIbbDeXn0vRrczang/Rlo0phAT4hgJrn7hYqZ8LP5WkzxiSub
         Vx+ewo7LNrBYZXh4dMSiPyKwetwNd/hga42BNMRXevoXyHdc4gu29Wa28ZHo3hKyAG0r
         LlUFv9yNzcmUmxL8n7fLcFNguaxC3qRVPFfJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Uw1G9l5V7WjVN0Vf/5v6/Fz8qg1SNszZYPlSvt9XAsJOZjuax4mrCXYcQszUQOfxz6
         m1o4p+DMgI1UuuNTJa5DMnbH2jMTUDvFGjqVONLyofzyYJFVMuc+Bt1cErrgPDXwwsfr
         jPo83+v0NGHHp2kjEpcc53jeBcHgqkEBARjz0=
Received: by 10.223.124.209 with SMTP id v17mr1112384far.6.1233954736520;
        Fri, 06 Feb 2009 13:12:16 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id e17sm1641466fke.8.2009.02.06.13.12.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 13:12:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0902060314u4741528bs196a43d45ff7f283@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108785>

On Fri, 06 Feb 2009, Giuseppe Bilotta wrote:
> On Thu, Feb 5, 2009 at 12:38 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>>
>>> The last-modified time header added by RSS to increase cache hits from
>>> readers should be set to the date the repository was last modified. The
>>> author time in this respect is not a good guess because the last commit
>>> might come from a oldish patch.
>>>
>>> Use the committer time for the last-modified header to ensure a more
>>> correct guess of the last time the repository was modified.

[...]
>> Second, author time reflects when change (commit) was made, according
>> to authors (perhaps skewed) clock.  Committer time reflects when given
>> commit (version of a commit) was entered into repository, or to be more
>> exact into some clone of given project.  But there is also an issue of
>> when changes got into given instance of repository (given clone): that
>> I guess might be found by stat-ing HEAD (if it arrived by commit),
>> FETCH_HEAD (if it arrived by fetch or pull) and ??? (if it arrived by
>> push)... err... it looks like it wouldn't work in most common case,
>> sorry, unless we want to stat all refs and packed-refs file. But while
>> this date might be better for Last-Modified, I'm not sure if it is good
>> at all for publication date.
>>
>> So committer time is better than author time, and looks like good
>> middle ground.
> 
> Oops should have finished reading your comments before my previous
> reply. The solution would be to introduce a way to determine robustly
> when a branch was last _physically_ updated. Checking the
> corresponding entry in refs/ would work for non-packed refs, and maybe
> one would hope that if the ref got packed, it means it hasn't updated
> in a long time ... but I'm not enough of an expert on git's internal
> to really know about this. Suggestions?

The point is I am not that sure if the date branch was _physically_
updated (it was updated in given clone of repository) is a good
choice for publish date in feed (RSS or Atom), whether it is good
choice for Last-Modified (and If-Modified-Since), and whether publish
date can be different from Last-Modified.  

Using committime doesn't ensure that it is monotonical (but it is
highly probable, much more than authortime), but it is the same for
every clone of repository, and for every gitweb installation that
hosts given repository.

Using update time does ensure that it is monotonical, and it
wouldn't ever be earlier than the time repository started to be
available, but it changes from clone to clone.

-- 
Jakub Narebski
Poland
