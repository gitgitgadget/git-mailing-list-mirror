From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Fri, 24 Jun 2005 12:29:14 +0100
Message-ID: <tnxhdfo56yd.fsf@arm.com>
References: <tnxy899zzu7.fsf@arm.com> <20050623175848.1cf41a52.pj@sgi.com>
	<tnxd5qc6s5o.fsf@arm.com> <20050624034743.6c3bdae4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 13:25:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlmHf-0007SP-A3
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 13:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbVFXL3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 07:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVFXL3y
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 07:29:54 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:9916 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S263247AbVFXL3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 07:29:44 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5OBT76i021990;
	Fri, 24 Jun 2005 12:29:07 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id MAA18188;
	Fri, 24 Jun 2005 12:29:35 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 24 Jun 2005 12:29:29 +0100
To: Paul Jackson <pj@sgi.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 24 Jun 2005 11:29:29.0851 (UTC) FILETIME=[FC5D4CB0:01C578AF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>> it should at least
>> check whether the commit message was modified.
>
> I suspect not.
>
> Beware that quilt has tended toward the philosophy of doing just
> what you said, with no more, perhaps less than, the minimum critical
> consistency checking.  If you tried to shoot you foot off with it,
> it shot your foot off, quickly.
>
> If I try to make a change without a meaninguful log entry, what
> business of stgit is that?

The way to modify a patch with stgit is via 'stg commit'. The problem
is that you can end up with a commit log you didn't want simply
because the editor crashed or $EDITOR is invalid and there is no way
to modify the log history.

With stgit you don't have files only specific to a patch (the 'quilt
add' command equivalent is missing). When you modify a file and commit
the changes, it will be included in the topmost patch. IMO, this
simplifies the command set and avoids having two different add
commands (or a single add command with different behaviours). Now,
some people might not run a 'stg status' before a commit but they find
out from the commit msg that an unrelated file was modified. You could
simply exit without saving the commit msg and the changes won't be
checked in (and the tree is left in a consistent state - the one
before the commit).

Anyway, if you don't care about the commit history for individual
patches, I can simply remove all this commit/editor/msg check and just
use a standard text, maybe a description of the patch so that people
pulling from your git tree would know what it is about.

> And it certainly should not leave the
> tree in some unspecified, inconsistent state without prior warning
> on account of such.

'commit' failing doesn't leave the tree in an unspecified state (at
least not the yesterday's snapshot). There are other commands that do
this, unfortunately, but I'm still working on this.

> Don't add inessential sanity checks on user input.  It won't sell
> well to the "quilt replacement" market.

I'm not keen on keeping these sanity checks but see my reasons above
for the commit message. Anyway, I'm open to suggestions. The main
advantage of stgit over quilt is that it uses diff3 instead of patch
for pushing patches. For this to work properly, the top and bottom of
a patch have to be valid commit or tree objects containing the whole
tree even if most of the files are not modified by this patch.

-- 
Catalin

