From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] Add `commit.signoff` configuration variable.
Date: Wed, 13 Jan 2010 16:36:44 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001131635510.16395@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 04:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUu8X-0003ln-GJ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 04:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab0AMDnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 22:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063Ab0AMDnI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 22:43:08 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:58935 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754025Ab0AMDnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 22:43:08 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 290454009E
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 16:43:04 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136764>

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 Documentation/config.txt     |    4 ++++
 Documentation/git-commit.txt |    2 +-
 builtin-commit.c             |    4 ++++
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 23a965e..dd261cf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -712,6 +712,10 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they always
 	take precedence over this setting. Defaults to false.
 
+commit.signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.
+
 commit.template::
 	Specify a file to use as the template for new commit messages.
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c97c151..5a977b6 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -114,7 +114,7 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message. This overrides the `commit.signoff` configuration variable.
 
 -n::
 --no-verify::
diff --git a/builtin-commit.c b/builtin-commit.c
index 3dfcd77..db90e7a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1093,6 +1093,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
+	if (!strcmp(k, "commit.signoff")) {
+		signoff = git_config_bool(k, v);
+		return 0;
+	}
 
 	return git_status_config(k, v, s);
 }
-- 
1.6.4
