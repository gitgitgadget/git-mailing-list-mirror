From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Sun, 19 Jun 2005 10:24:49 +0100
Message-ID: <tnxll56y9zy.fsf@arm.com>
References: <Pine.LNX.4.21.0506182338300.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 11:21:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjvzG-0001fN-Rd
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 11:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVFSJ0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 05:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVFSJ0Q
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 05:26:16 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:40186 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262220AbVFSJZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 05:25:38 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5J9Oe6i015929;
	Sun, 19 Jun 2005 10:24:40 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA20411;
	Sun, 19 Jun 2005 10:25:04 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 19 Jun 2005 10:25:03 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506182338300.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Sun, 19 Jun 2005 00:26:25 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 19 Jun 2005 09:25:03.0783 (UTC) FILETIME=[C62CFB70:01C574B0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Sat, 18 Jun 2005, Catalin Marinas wrote:
>> Having different series would be a good idea but it might complicate
>> the tool usage. I will thing about it once I'm sure the basic
>> operations work fine.
>
> You could future-proof yourself a bit by simply saving the base as
> .git/refs/bases/master and making the patches be
> .git/patches/master/. That way, you'd be ready when you start to support
> multiple series.

You are right. I will do this for the next release (0.2, probably of
the end of this week), something like the tree structure below:

.git/refs/bases/<head>
.git/series/<head>/
.git/series/<head>/applied
.git/series/<head>/unapplied
.git/series/<head>/current
.git/series/<head>/patches/*

I don't know whether a git-diff-* command would look into
.git/refs/bases (I can do this in stgit but, this was only for
convenience).

[...]
> Note that it gets more complex if mainline takes only your second patch
> (due to it not requiring your first, and your first not being as
> acceptable). In this case, it needs to entire mainline as a patch, because
> merges can't cherrypick, whereas patches can act arbitrarily. But it would
> be nice to store the information of what happened even with patches that
> cherrypick, such that we have a better chance for managing things
> later.

You can cherry-pick the second patch by first commuting it with the
previous patches. If they are independent, the commuting via diff3
wouldn't generate any conflict. Even with the current stgit, you can
pop all the patches and only push those to be merged upstream. HEAD
would only contain the those patches.

If you want to implement a full-featured patch treacking, you might
end up with something like darcs which doesn't scale to the size of
the Linux kernel. On the other hand, you might not agree with the
changes to your accepted patch and a conflict is welcomed so that you
can choose whether to keep the old version or not.

> But I think that you have the right ideas about how
> patches should be represented, and it would be good to get your
> representation implemented inside git, because operations more central to
> git would benefit from having this information.

Do you mean creating a new git type like the blob, tree or commit? I
would prefer not to modify git or have my own version of git. StGIT
should be a tool running directly on top of an existing installation
of git.

Instead of having a directory for every patch (with bottom, top
etc. files), I could create a git blob to store this information and
the series files (applied/unapplied files) would only contain the blob
id. This could simplify things if, in a future version, stgit would
allow patch cherry-picking.

-- 
Catalin

