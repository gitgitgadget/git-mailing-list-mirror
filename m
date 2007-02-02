From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 10:55:48 +0100
Message-ID: <200702021055.49428.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Matt Mackall <mpm@selenic.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 10:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCv7s-00078w-O5
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 10:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbXBBJye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 04:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXBBJye
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 04:54:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:12782 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbXBBJyc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 04:54:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so714717uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 01:54:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mpMsJf2vHSdqbsqatsYYqYS38YGCpv5cp8ZyeN3LyHi7E18wcDZNsnaS4ji5o2FEqYWLTRXBR+FOxW4sbjrywHEi6cD5QHK1LDpXGHd0JZscgr5wJSMVVkAA24bYcUYgM3Fzuz7nuSS1uZw/xqZj0JUtQ49YOacShb9wiPrFp+s=
Received: by 10.67.101.10 with SMTP id d10mr4128012ugm.1170410071403;
        Fri, 02 Feb 2007 01:54:31 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id j1sm4994198ugf.2007.02.02.01.54.29;
        Fri, 02 Feb 2007 01:54:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070201003429.GQ10108@waste.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38483>

On Thu, 01 Feb 2007 00:00:00 +0100, Matt Mackall wrote:
> On Thu, Feb 01, 2007 at 12:58:42AM +0100, Jakub Narebski wrote:
>> Matt Mackall wrote:

>> On the other hand hg repository structure (namely log like append changelog
>> / revlog to store commits) makes it I think hard to have multiple persistent
>> branches.
> 
> Not sure why you think that. There are some difficulties here, but
> they're mostly owing to the fact that we've always emphasized the one
> branch per repo approach as being the most user-friendly.

Well, perhaps I should say that append-log changelog / revlog[*1*] structure
to store commits makes it natural to have one branch per repository, as
branch (in the lineage of given commit meaning, i.e. all commits which
are ancestors of given commit) is roughly equivalent to changelog / revlog
and branch tip (latest commit on a branch) is top commit (latest entry)
in changelog / revlog.

In git, with its DAG (direct acyclic graph) of commits and branch tip as
a moving pointer (top of stack pointer like moving) to a commit in DAG
makes it natural to have multiple branches in a repository (current branch
is branch pointed by HEAD, another pointer - to branch this time[*2*]).

Perhaps multiple branch repository makes learning curve a bit steeper,
but also encourages using temporary branches and topic branches, which
makes _development_ (as opposed to using version control tool) more
(power)user-friendly; and makes SCM more powerfull.


How Mercurial solves problem of multiple _persistent_ branches? Does it
add pointers to commits somewhere deeper in changelog / revlog?

BTW does Mercurial have tags?

>>> In either case, both provide strong integrity checks with recursive
>>> SHA1 hashing, zlib CRCs, and GPG signatures (as well as distributed
>>> "back-up"!) so this is largely a non-issue relative to traditional
>>> systems.
>> 
>> Integrity checks can tell you that repository is corrupted, but it would
>> be better if it didn't get corrupted in first place.
> 
> Obviously. Hence our append-only design. Data that's written to a repo
> is never rewritten, which minimizes exposure to software bugs and I/O
> errors.

By the way, RCS / CVS rewrote relevant data (to have diff from the top
structure) on each commit.

I wonder if git could generate pack on the fly fastimport like...

>> Besides: zlib CRC for Mercurial? I thought that hg didn't compress the
>> data, only delta chain store it?
> 
> We use zlib compression of deltas and have since April 6, 2005.

Nice to know. You compress only file deltas, or also file revision
metadata? Do you compress manifests (trees) and commits (or at least
commit messages) too?

Footnotes:
----------

[*1*] I don't know what nomenclature Mercurial uses for blobs (file
contents), trees (directory contents) and commits (revision contents)
storage.

[*2*] I disregard here latest work on "detached HEAD" in git.

-- 
Jakub Narebski
Poland
