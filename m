From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 17:41:53 -0700
Message-ID: <7vfyezqlny.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
	<17668.2019.732961.855446@cargo.ozlabs.ibm.com>
	<20060911000306.GA28927@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 02:41:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMZrU-0006hK-9v
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 02:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWIKAlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 20:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWIKAlK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 20:41:10 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65159 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964856AbWIKAlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 20:41:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911004108.YKTJ13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 Sep 2006 20:41:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Logz1V0041kojtg0000000
	Sun, 10 Sep 2006 20:40:59 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060911000306.GA28927@spearce.org> (Shawn Pearce's message of
	"Sun, 10 Sep 2006 20:03:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26824>

Shawn Pearce <spearce@spearce.org> writes:

> I've been thinking about implementing ref storage within a Git tree
> object.  Just store the commit/tag/object IDs in a tree (or graph
> of trees) with a mode of '0'.  Anchor that under '.git/refs-tree'.
> Any edit of a ref would "lock" .git/refs-tree, create a new tree
> containing the update, then replace .git/refs-tree.
>
> But it would put additional stress on the objects directory by
> creating a lot of trees which would never get pulled into pack
> files and thus would need to be pruned away on a regular basis.

I do not see any advantage of making such a phoney object at
all, but I do agree that the current one file per ref can be
less than optimal when your repository has tons of tags or
refs.

We've designed the ref interface well enough so that only very
narrow core functions know the implementation (and properly
written Porcelain would access refs via update-ref and
symbolic-ref interfaces), so the impact of changing the
one-file-per-ref implementation to something based on a single
simple databasy file (e.g. gdbm, bdb, sqlite, ...) would be
reasonably limited.
