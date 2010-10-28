From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 06/10] Change incorrect "remote branch" to "remote tracking branch" in C code
Date: Thu, 28 Oct 2010 20:21:53 +0200
Message-ID: <1288290117-6734-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 28 20:23:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBX8h-0005id-G2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761224Ab0J1SXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:23:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49148 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761195Ab0J1SXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:23:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9SIGCWE011862
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 20:16:13 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7b-0003iF-Mi; Thu, 28 Oct 2010 20:22:43 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7b-0001ls-KH; Thu, 28 Oct 2010 20:22:43 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 Oct 2010 20:16:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9SIGCWE011862
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288894574.8742@TgBOQNSPVpaHIJl2CdklxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160196>

(Just like we did for documentation already)

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 branch.h                               |    2 +-
 builtin/fetch.c                        |    2 +-
 builtin/remote.c                       |    6 +++---
 contrib/examples/builtin-fetch--tool.c |    2 +-
 t/t5505-remote.sh                      |    8 +++++---
 t/t7608-merge-messages.sh              |    2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/branch.h b/branch.h
index eed817a..2004632 100644
--- a/branch.h
+++ b/branch.h
@@ -22,7 +22,7 @@ void create_branch(const char *head, const char *name, const char *start_name,
 void remove_branch_state(void);
 
 /*
- * Configure local branch "local" to merge remote branch "remote"
+ * Configure local branch "local" to merge remote-tracking branch "remote"
  * taken from origin "origin".
  */
 #define BRANCH_CONFIG_VERBOSE 01
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3b0b614..4243ef0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -359,7 +359,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			what = rm->name + 10;
 		}
 		else if (!prefixcmp(rm->name, "refs/remotes/")) {
-			kind = "remote branch";
+			kind = "remote-tracking branch";
 			what = rm->name + 13;
 		}
 		else {
diff --git a/builtin/remote.c b/builtin/remote.c
index e9a6e09..6a06282 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -507,7 +507,7 @@ static int add_branch_for_removal(const char *refname,
 			return 0;
 	}
 
-	/* don't delete non-remote refs */
+	/* don't delete non-remote-tracking refs */
 	if (prefixcmp(refname, "refs/remotes")) {
 		/* advise user how to delete local branches */
 		if (!prefixcmp(refname, "refs/heads/"))
@@ -791,9 +791,9 @@ static int rm(int argc, const char **argv)
 
 	if (skipped.nr) {
 		fprintf(stderr, skipped.nr == 1 ?
-			"Note: A non-remote branch was not removed; "
+			"Note: A branch outside the refs/remotes/ hierarchy was not removed;\n"
 			"to delete it, use:\n" :
-			"Note: Non-remote branches were not removed; "
+			"Note: Some branches outside the refs/remotes/ hierarchy were not removed;\n"
 			"to delete them, use:\n");
 		for (i = 0; i < skipped.nr; i++)
 			fprintf(stderr, "  git branch -d %s\n",
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index cd10dbc..3140e40 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -148,7 +148,7 @@ static int append_fetch_head(FILE *fp,
 		what = remote_name + 10;
 	}
 	else if (!strncmp(remote_name, "refs/remotes/", 13)) {
-		kind = "remote branch";
+		kind = "remote-tracking branch";
 		what = remote_name + 13;
 	}
 	else {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5d1c66e..d189add 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -107,16 +107,18 @@ test_expect_success 'remove remote' '
 )
 '
 
-test_expect_success 'remove remote protects non-remote branches' '
+test_expect_success 'remove remote protects local branches' '
 (
 	cd test &&
 	{ cat >expect1 <<EOF
-Note: A non-remote branch was not removed; to delete it, use:
+Note: A branch outside the refs/remotes/ hierarchy was not removed;
+to delete it, use:
   git branch -d master
 EOF
 	} &&
 	{ cat >expect2 <<EOF
-Note: Non-remote branches were not removed; to delete them, use:
+Note: Some branches outside the refs/remotes/ hierarchy were not removed;
+to delete them, use:
   git branch -d foobranch
   git branch -d master
 EOF
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 28d5679..1c71296 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -47,7 +47,7 @@ test_expect_success 'ambiguous tag' '
 	check_oneline "Merge commit QambiguousQ"
 '
 
-test_expect_success 'remote branch' '
+test_expect_success 'remote-tracking branch' '
 	git checkout -b remote master &&
 	test_commit remote-1 &&
 	git update-ref refs/remotes/origin/master remote &&
-- 
1.7.3.2.183.g2e7b0
