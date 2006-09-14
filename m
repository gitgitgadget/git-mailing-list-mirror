From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 2/2] Handle invalid argc gently
Date: Thu, 14 Sep 2006 05:04:09 +0400
Message-ID: <20060914010409.GB20593@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 03:04:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNfeK-0004X4-Vm
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 03:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWINBEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 21:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWINBEM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 21:04:12 -0400
Received: from mh.altlinux.org ([217.16.24.5]:32450 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1751300AbWINBEK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 21:04:10 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id 865A12F3000D; Thu, 14 Sep 2006 05:04:09 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 9C65517103; Thu, 14 Sep 2006 05:04:09 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26968>

describe, git: Handle argc==0 case the same way as argc==1.
merge-tree: Refuse excessive arguments.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 describe.c   |    2 +-
 git.c        |    2 +-
 merge-tree.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/describe.c b/describe.c
index 5ed052d..2172e8f 100644
--- a/describe.c
+++ b/describe.c
@@ -163,7 +163,7 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 
-	if (i == argc)
+	if (i >= argc)
 		describe("HEAD", 1);
 	else
 		while (i < argc) {
diff --git a/git.c b/git.c
index 47c85e1..8c182a5 100644
--- a/git.c
+++ b/git.c
@@ -294,7 +294,7 @@ static void handle_internal_command(int 
 
 int main(int argc, const char **argv, char **envp)
 {
-	const char *cmd = argv[0];
+	const char *cmd = argv[0] ? argv[0] : "git-help";
 	char *slash = strrchr(cmd, '/');
 	const char *exec_path = NULL;
 	int done_alias = 0;
diff --git a/merge-tree.c b/merge-tree.c
index c154dcf..692ede0 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -337,7 +337,7 @@ int main(int argc, char **argv)
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc < 4)
+	if (argc != 4)
 		usage(merge_tree_usage);
 
 	setup_git_directory();


-- 
ldv
