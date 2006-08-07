From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Mon, 07 Aug 2006 23:47:37 +0200
Organization: At home
Message-ID: <eb8cdh$s6n$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 07 23:48:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GACxG-0000LY-Iv
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 23:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWHGVrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 17:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWHGVrw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 17:47:52 -0400
Received: from main.gmane.org ([80.91.229.2]:25001 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751078AbWHGVrv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 17:47:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GACwl-0000Fl-Qf
	for git@vger.kernel.org; Mon, 07 Aug 2006 23:47:39 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 23:47:39 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 23:47:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25042>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> This RFC is about better naming of subroutines in gitweb. The patch was
>> generated on top of 'next' (7c7e45d0cc0f482aeb19ecb0b56e9e7b65472c56)
>> using embedded gitweb-rename.sh script.
[...]
>> * git_read_ prefix for subroutines directly accessing git
>>   repository files
> 
>  - (I am not complaining or objecting yet -- this is just an
>    observation. ) The distinction between git_get_foo and
>    git_read_foo is an implementation detail.  The latter could
>    signal that the implementation bypasses the published
>    interface but depends on the implementation detail of the
>    low-level git, so it might be a good idea, but on the other
>    hand the only instance is git_read_info_refs which reads from
>    .git/info/refs -- and its format is part of the published
>    interface -- so I am not so sure this distinction is worth
>    it.  And certainly we would not want to rely too heavily on
>    the current implementation of the low-level git, so we
>    obviously do not want to add more git_read_foo's needlessly,
>    which makes me feel even less sure if we would want
>    git_read_foo...

Currently after rename we have the following git_read_* functions

* git_read_info_refs, which reads .git/info/refs directly and relies on it's
format
* git_read_hash which translates ref to hash by reading ref file
(e.g. .git/refs/heads/master) which means that it doesn't support symrefs
yet; but first, it should be easy to implement without invoking any git
command, and second, there are usually no symrefs beside HEAD, and I'm not
sure that git would work with non-HEAD symref.
* git_read_refs (or rather git_readdir_refs) which reads .git/refs directory
* git_read_projects (or rather git_readdir_projects) which checks for
projects checking if HEAD file exists
* git_read_description which reads .git/description; but in the future
description might be stored in repository config

What is also important is the fast that git_read_* functions are fast,
with exception of git_read_info_refs...

[...]
> If we are to have many more fixes and clean-ups on gitweb,
> readable and consistent names would be very helpful.
> 
> The problem is when.  If we are going to apply this, we need to
> pick a point of time when not many patches on gitweb are in
> flight; otherwise I'd end up asking people to resend using new
> names.

With two scripts attached to the first post in this thread it would be
simple to apply pre-rename patch, by converting gitweb to pre-rename using
gitweb-unrename.sh script, then applying patch, then restoring new names
using gitweb-rename.sh script, and finally comitting changes (or amending
commit).

But I agree that it would be best to do "subroutine renaming" during lull in
gitweb development.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
