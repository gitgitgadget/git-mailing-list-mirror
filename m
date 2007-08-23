From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-svn: update documentation with CAVEATS section
Date: Thu, 23 Aug 2007 08:00:32 +0200
Message-ID: <85r6luiydb.fsf@lola.goethe.zz>
References: <20070816085645.GA3159@soma>
	<7v4piri44r.fsf@gitster.siamese.dyndns.org>
	<853aybkwsc.fsf@lola.goethe.zz> <20070823053009.GC4978@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 08:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO5kF-0007xj-C4
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 08:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbXHWGAg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 02:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbXHWGAf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 02:00:35 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:38427 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbXHWGAf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 02:00:35 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 3EB5C1E56B8;
	Thu, 23 Aug 2007 08:00:33 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 281215BF3B;
	Thu, 23 Aug 2007 08:00:33 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-050-128.pools.arcor-ip.net [84.61.50.128])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id F3F8136E864;
	Thu, 23 Aug 2007 08:00:32 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9DB001C36605; Thu, 23 Aug 2007 08:00:32 +0200 (CEST)
In-Reply-To: <20070823053009.GC4978@muzzle> (Eric Wong's message of "Wed\, 22 Aug 2007 22\:30\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56456>

Eric Wong <normalperson@yhbt.net> writes:

> David Kastrup <dak@gnu.org> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Eric Wong <normalperson@yhbt.net> writes:
>> >
>> >>   I've been meaning to do this for a while, hopefully this cuts
>> >>   down on the redundant mailing list traffic about these subjects.
>> >> ...
>> >> +CAVEATS
>> >> +-------
>> >> +
>> >> +For the sake of simplicity and interoperating with a less-capable system
>> >> +(SVN), it is recommended that all git-svn users clone, fetch and dcommit
>> >> +directly from the SVN server, and avoid all git-clone/pull/merge/push
>> >> +operations between git repositories and branches.  The recommended
>> >> +method of exchanging code between git branches and users is
>> >> +git-format-patch and git-am, or just dcommiting to the SVN repository.
>> >> +
>> >> +Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
>> >> +plan to dcommit from.  Subversion does not represent merges in any
>> >> +reasonable or useful fashion; so users using Subversion cannot see any
>> >> +merges you've made.
>> >
>> > Ok, my ruling before 1.5.3 is to take this patch, and encourage
>> > interested parties to help Eric adding reliable support for the
>> > feature after that, if such is possible.
>> 
>> Couldn't we at least get a _documentation_ of the current behavior
>> when actually using git for branch work?  Knowing what will fail how
>> and when is not as good as things just working as one would expect,
>> but it certainly beats obscure warnings.
>> 
>> For example, I consider it rather unacceptable that nowhere is
>> documented just _how_ git-svn chooses one Subversion branch to commit
>> to.
>
> dcommit always chooses the last SVN branch it branched off from.

No, it doesn't.  That's the problem.  If I do
git-merge master
in a side branch, and do git-svn dcommit afterwards, the commit
goes to the master branch.

Which is utterly unexpected.

>> It also drastically misrepresents the consequences: the problem is
>> _not_ that users using Subversion cannot see merges.  That is
>> something that one can readily accept.  The problem is that git-svn
>> will dcommit to a seemingly random branch.
>
> Interesting, I've never considered it a problem (probably because
> I know and trust the code I wrote :).  Good idea though.
>
> Junio: could you please apply the following trivial patch?  Thanks.
>
> From a8ae91019a2ededd0e3d455fdd78655c086ea3b3 Mon Sep 17 00:00:00 2001
> From: Eric Wong <normalperson@yhbt.net>
> Date: Wed, 22 Aug 2007 22:14:31 -0700
> Subject: [PATCH] git-svn: dcommit prints out the URL to be committed to
>
> This will print out the URL that dcommit will operate on.
> If used with --dry-run this will print out the URL without
> making changes to the repository.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
Acked-by: David Kastrup<dak@gnu.org>

This is already a _large_ help for avoiding clobbering the central
repository.  But I stress that it would be much better if git-svn
dcommit/rebase stayed exclusively on the branch that is associated
with it/fetching in the "svn" config section, like git does in general
with remotes.  No random branch jumping after merges or (to be
_really_ avoided) rebases and certainly after cherry-picking within
git.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
