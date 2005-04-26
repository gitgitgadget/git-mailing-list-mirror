From: Bram Cohen <bram@bitconjurer.org>
Subject: (unknown)
Date: Tue, 26 Apr 2005 12:14:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504261159180.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Apr 26 21:10:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQVR5-00073a-Kz
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 21:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVDZTOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 15:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDZTOm
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 15:14:42 -0400
Received: from wax.eds.org ([64.147.163.246]:10168 "EHLO wax.eds.org")
	by vger.kernel.org with ESMTP id S261750AbVDZTOe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 15:14:34 -0400
Received: by wax.eds.org (Postfix, from userid 1044)
	id 2F21C324028; Tue, 26 Apr 2005 12:14:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by wax.eds.org (Postfix) with ESMTP id 2CD3FB401A
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 12:14:34 -0700 (PDT)
X-X-Sender: bram@wax.eds.org
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> What you can do at an SCM level, is that if you want to track renames,
> you track them as a separate commit altogether. Ie if you notice a
> rename, you first commit the rename (and you can _see_ it's a rename,
> since the object didn't change, and the sha1 stayed the same, which in
> git-speak means that it is the same object, ie that _is_ a rename as far
> as git is concerned), and then you create the "this is the data that
> changed" as a _second_ commit.

If a rename and a modification happen at the same time, you'll now have a
point in the history which has the modification but not the rename, which
will probably be completely broken. If a file is deleted and two identical
copies of the file are made at the same time, no inference of renaming can
be made. And sometimes people really do delete one file and make a new
different file with initially identical contents, and this will break that
case.

> But don't make it a new kind of commit. It's just a regular commit,
> dammit. No new abstractions.

You did just introduce a new abstraction, it just happens to be of the 'if
I say X I really mean Y' type, which is far more semantically weighty,
tricky to implement, and on top of that is just plain a gross hack.

> Some "higher level" thing can add its own rules _on_top_ of git rules.
> The same way we have normal applications having their _own_ rules on top
> of the kernel. You do abstraction in layers, but for this to work, the
> base you build on top of had better be damn solid, and not have any ugly
> special cases.

What you're advocating is unclear here, but if you're advocating that the
higher-level system store extra meta-data, not included in git, then that
means the higher-level tools won't be able to interoperate by pointing at
the same git store. And it won't get rid of the problems of storing
information which git doesn't currently, it just makes them be handled by
different code. You can't make these problems go away by getting angry at
them.

I for one am all in favor of blessing Cogito as the 'real' git interface,
with plans to write upgrade scripts which canonically change the current
git format into a new format when upgrades become necessary. There are
already several version control systems with appropriate back end systems
which aren't literally weekend hacks. But you currently seem to be
insisting that such an upgrade will never be necessary, even while
insisting that git will support functionality which it can't.

-Bram

