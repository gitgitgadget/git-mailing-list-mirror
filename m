From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/3] Allow --no-verify to bypass commit-msg hook
Date: Sat,  8 Dec 2007 12:38:07 +0100
Message-ID: <1197113889-16243-2-git-send-email-win@wincent.com>
References: <1197113889-16243-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, krh@redhat.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 12:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0y1L-0002Ln-Py
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbXLHLik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbXLHLik
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:38:40 -0500
Received: from wincent.com ([72.3.236.74]:34209 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbXLHLij (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:38:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB8BcAAA021147;
	Sat, 8 Dec 2007 05:38:13 -0600
X-Mailer: git-send-email 1.5.3.7.1115.gaa595
In-Reply-To: <1197113889-16243-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67543>

At the moment the --no-verify switch to "git commit" instructs it to
skip over the pre-commit hook. Here we teach "git commit --no-verify"
to skip over the commit-msg hook as well. This brings the behaviour
of builtin-commit back in line with git-commit.sh.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 2ec8223..df9377e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -791,7 +791,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die("could not read commit message");
 	}
-	if (run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
+	if (!no_verify &&
+	    run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
 		rollback_index_files();
 		exit(1);
 	}
-- 
1.5.3.7.1115.gaa595
