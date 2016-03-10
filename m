From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/1] Introduce a way to create a branch and worktree at the
 same time
Date: Thu, 10 Mar 2016 12:34:10 +0100 (CET)
Message-ID: <cover.1457609615.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:34:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adyrV-0000MS-C2
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 12:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbcCJLeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 06:34:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:52339 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932738AbcCJLeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 06:34:21 -0500
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LyVcA-1ZkWPN3VVG-015tRN; Thu, 10 Mar 2016 12:34:11
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:r+EQnjzw9rNLCi8/CXqZ7Tii4nWRXNcM82t5e02CTVULFWKvuUZ
 OlFWv+teeE0oFQLxuXV/KoeMIlcjAWa4CpZ8ZwP6mJQMD1pRYDnO5XAJ6VScfcFz7GgdtE9
 AhPJ0Td37aOwnET4Dk31mceUNTOqJj2/7rNzTzTeq/94ztpDb03v99oj5+M0c8gluaFm2rs
 CLQANnKN12pKkB/aYNK8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:26Y7Wzrf32U=:60sVWfUYqtjnZEQ8tsb7MK
 GamFrB16R4l4Qary66MoRnDhD459BTVAwAeGBR2rZs29BoWh4Mp/VnB5N6cdJ6WJwLp6T1Z5O
 /uOxF6oLOoMbpSqk841/6p84Y1A63Pk/RBn0tpSFJK2mPHoQemJz8fQIPXep8K5vc/5bkFJQv
 xoOchX5s0dzWAlKhNM5vOyDb05DjmbscNSbfc13G6KkP/EgAEo/x6BvIf99GOp9M/81il9V4L
 BY4RbxAYycwzA88XU7KTUK+yqYDSxk0jvQMO7I/hL6LBZoKaM3YlrGg+0JW5qHOTq4g+nGMOi
 vsHInXwsbc6xmREoYVLKeaiGfag0OXNlxXa4ZNyncfTsnDuA5X+KnTbzy+tGx27dw7hb9fGEZ
 gxjQcWE19O3hO+6h9p1HxxyeMH9xa5YB03zygB7j+1DHdZt9x174wr3uxiRd9J/LDdd0ImpYH
 pYVqNMehbS04Cnu6wP5L3W7QP1qBAu4/NxGLspXeqs2+JHsmvFIb9Z5Zqew4vUuSIyBlD2Jde
 eVq3+pGnw4H1/RptKbnc1mhwnJOVxJfWuY3pJfMkPeS9l1yqB6DGDtHDpBftOz57sII07oQ+6
 HhsOS69BUc5tOpTUCoySQll45Xe6indtFWNXviiysEVjmUo9jAv8wYnm2/+FJiTe6YOL509Ke
 3fCoURraJAhWkdgOv+42qmfs3d+zXyOgShWjhzKgyAxHTjW9JcR/mU2ENWujlfAwqrR7Ad82h
 Zv9pIrVRtxZ9ScgUIkSlmTc54xoWWjh6+OB6AfDtw7J7Pv50+3hVpdtj9u8/oaMhb3KKXZT0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288614>

The invention of the `git worktree` command changed this developer's
working style dramatically. Rather than switching between branches all
the time, topic branches are created and checked out in newly-added
worktrees, to be reworked and refined until the topic branch is either
merged into `master` or abandoned.

It gets rather tiresome, and also typo-prone, to call "git branch xyz
upstream/master && git worktree add xyz xyz" all the time. Hence this
proposal: "git branch -w xyz upstream/master" to do the same.

The plan is to also support "git branch -d -w xyz" once the `git
worktree` command learned a `remove` (or `delete`) subcommand.

One possible improvement would be to add "/xyz/" to the parent
repository's .git/info/exclude, but this developer hesitates to
introduce that feature without the "delete" counterpart: those exclude
entries would likely go stale very quickly. Besides, there might be a
plan in the working to exclude worktrees automagically?


Johannes Schindelin (1):
  branch: allow conveniently adding new worktrees for new branches

 Documentation/git-branch.txt |  5 +++--
 builtin/branch.c             | 27 +++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.7.2.windows.1.8.g47d64e6.dirty
