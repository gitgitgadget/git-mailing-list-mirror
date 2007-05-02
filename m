From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Thu, 3 May 2007 01:30:43 +0200
Message-ID: <200705030130.44018.jnareb@gmail.com>
References: <200705012346.14997.jnareb@gmail.com> <200705021624.25560.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: dev@tools.openoffice.org
To: Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 01:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjOHc-0006Aw-9f
	for gcvg-git@gmane.org; Thu, 03 May 2007 01:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767246AbXEBXat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 19:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767245AbXEBXat
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 19:30:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:15204 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767246AbXEBXar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 19:30:47 -0400
Received: by ug-out-1314.google.com with SMTP id 44so351201uga
        for <git@vger.kernel.org>; Wed, 02 May 2007 16:30:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z/aGZTGcj4HFe7jjceYU0ENjOV67mvNc5a5aVMCrRdLRiQSw40Wzm7Gljdt48nzpPzjud69WTSc6wgv7uuSJdwcLhWK1PZXcNe4KrooVDYCWZ0/3WlnK3nMspLqZ9Z0lsUy1Z6ELLDBb3OVnbmGSiKUVr/SnVrKQrJTUm4Pfh40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bXMDRQl2xSVddRop7RmlMjaQZqPq2KsBDq2jbLvw8bjj6Oj0qlc4h/NLW2Y+Kph/Tb/vbp7iRJ2AHrhAs2cLqC3KivwPMsUQS0yif4LJkqQWXQSFhUgx3sZe3C1e+JJeTciPlVNiGcoz9GPBEAnNFGZl7BAdnhA32JZ6Cm/KW5Y=
Received: by 10.82.185.12 with SMTP id i12mr2474062buf.1178148645546;
        Wed, 02 May 2007 16:30:45 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id k28sm2258913ugd.2007.05.02.16.30.43;
        Wed, 02 May 2007 16:30:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200705021624.25560.kendy@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46052>

Jan Holesovsky wrote:
> On Tuesday 01 May 2007 23:46, Jakub Narebski wrote:
> 
>> What I am concerned about is some of git benchmark results at Git page
>> on OpenOffice.org wiki:
>>   http://wiki.services.openoffice.org/wiki/Git#Comparison

>> The problem is with 'Size of checkout': to start working in repository
>> one needs 1.4G (sources) and 98M (third party) for CVS checkout (it is
>> 1.5G for sources for Subversion checkout). Ordinary for distributed SCM
>> you would need size of repository + size of sources (working area),
>> which is 2.8G for sources and 688M for third party stuff files you can
>> hack on + the history]. This makes some prefer to go centralized SCM
>> route, i.e. Subversion as replacement for CVS (+ CWS, ChildWorkSpace).
> 
> Considering the size OOo needs for build (>8G without languages),
> the ~1.4G overhead for history is very well bearable.  I am surprised about
> the 100M overhead for SVN as well - from my experience it is usually about
> the size of the project itself; but maybe they improved something in SVN
> in the meantime.

I think the supposition that SVN uses hardlinks for pristine copy
of sources (HEAD version) seems probable; then there it is 100M overhead
plus size of changed files, and of course this tricks works only on
filesystems which support hardlinks, and assumes either hardlinks being
COW-links (copy-on-write) or editor behaving.
 
>> What might help here is splitting repository into current (e.g. from
>> OOo 2.0) and historical part,
> 
> No, I don't want this ;-)

I forgot to add there is possible to graft historical repository to the
current work repository, resulting in full history available. For example
Linux kernel repository has backported from BK historical repository, and
there is grafts file which connect those two repositories.

>> and / or using shallow clone. 

git-clone(1):

--depth <depth>::
        Create a 'shallow' clone with a history truncated to the
        specified number of revs.  A shallow repository has
        number of limitations (you cannot clone or fetch from
        it, nor push from nor into it), but is adequate if you
        want to only look at near the tip of a large project
        with a long history, and would want to send in a fixes
        as patches.

It is possible that those limitations will be lifted in the future
(if possible), so there is alternate possibility to reduce needed
disk space for git checkout. But certainly this is not for everybody.

>> Implementing  
>> partial checkouts, i.e. checking out only part of working area (...)

The problem with implementing this feature (you can do partial checkout
using low level commands, but this feature is not implemented [yet?]
per se) is with doing merge on part which is not checked out. Might
not be a problem for OOo; but this might be also not needed for OOo.
Sometimes submodules are better, sometimes partial checkout is the
only way: see below.

>> Splitting repository into submodules, and submodule 
>> support -- it depends on organization of OOo sources, would certainly
>> help for third party stuff repository.
> 
> We should better split the OOo sources; it's a process that already started
> [UNO runtime environment vs. OOo without URE], and I proposed some more
> changes already.

In my opinion each submodule should be able to compile and test by
itself. You can go X.Org route with splitting sources into modules...
or you can make use of the new submodules support (currently plumbing
level, i.e. low level commands), aka. gitlinks.

The submodules support makes it possible to split sources into
independent modules (parts), which can be developed independently,
and which you can download (clone, fetch) or not, while making it
possible to bind it all together into one superproject.

See (somewhat not up to date) http://git.or.cz/gitwiki/SubprojectSupport
page on git wiki.

>> What I'm really concerned about is branch switch and merging branches,
>> when one of the branches is an old one (e.g. unxsplash branch), which
>> takes 3min (!) according to the benchmark. 13-25sec for commit is also
>> bit long, but BRANCH SWITCHING which takes 3 MINUTES!? There is no
>> comparison benchmark for CVS or Subversion, though...

By the way, the time to switch branch should be proportional to number
of changed files, which you can get with "git diff --summary unxsplash
HEAD". Or to be more realistic to checkout some old version
(some old tag), as usually branches which got merged in are deleted
(or even never got published). For example when bisecting some bug:
Subversion doesn't have bisect, does it?

I wonder if running "git pack-refs" would help this benchmark...

-- 
Jakub Narebski
Poland
