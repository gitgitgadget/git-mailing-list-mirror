From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] Make cvs2git create tags
Date: Wed, 1 Jun 2005 13:27:23 +0200
Message-ID: <20050601112723.GA18682@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 13:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdRLF-0000US-5C
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 13:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFAL1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 07:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFAL1o
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 07:27:44 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:40852 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261285AbVFAL1c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 07:27:32 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j51BROoX017282
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 13:27:29 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id C02C26FE9; Wed,  1 Jun 2005 13:27:23 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current version of cvs2git doesn't propagate tags.
Trivial patch below.

skimo
-- 
cvs2git: create tags

cvsps seems to put a space after the tag name, so we remove it first.

---
commit 713a66bd98e65237cff37e0dfa68573973a60468
tree 07c5104ebeb6f189dc11eee3263966735307cfac
parent 324a7234776aafdc594942f1e5ef8e0f6358c0a5
author Sven Verdoolaege <skimo@liacs.nl> Wed, 01 Jun 2005 13:15:06 +0200
committer Sven Verdoolaege <skimo@liacs.nl> Wed, 01 Jun 2005 13:15:06 +0200

 cvs2git.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cvs2git.c b/cvs2git.c
--- a/cvs2git.c
+++ b/cvs2git.c
@@ -115,6 +115,7 @@ static void commit(void)
 {
 	const char *cmit_parent = initial_commit ? "" : "-p HEAD";
 	const char *dst_branch;
+	char *space;
 	int i;
 
 	printf("tree=$(git-write-tree)\n");
@@ -147,6 +148,12 @@ static void commit(void)
 
 	printf("echo $commit > .git/refs/heads/'%s'\n", dst_branch);
 
+	space = strchr(tag, ' ');
+	if (space)
+		*space = 0;
+	if (strcmp(tag, "(none)"))
+		printf("echo $commit > .git/refs/tags/'%s'\n", tag);
+
 	printf("echo 'Committed (to %s):' ; cat .cmitmsg; echo\n", dst_branch);
 
 	*date = 0;
