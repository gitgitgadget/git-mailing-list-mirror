From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 07/10] Use 'remote-tracking branch' in generated merge messages
Date: Thu, 28 Oct 2010 20:21:54 +0200
Message-ID: <1288290117-6734-8-git-send-email-Matthieu.Moy@imag.fr>
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
	id 1PBX8g-0005id-Vb
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761185Ab0J1SXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:23:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42946 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761113Ab0J1SX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:23:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9SI83at011676
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 20:08:03 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7g-0003jg-FU; Thu, 28 Oct 2010 20:22:48 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7g-0001lv-D3; Thu, 28 Oct 2010 20:22:48 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 Oct 2010 20:08:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9SI83at011676
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288894085.58218@WMv1C7KuoOToAJPKJPhpMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160195>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/fmt-merge-msg.c           |    6 +++---
 builtin/merge.c                   |    2 +-
 t/t1507-rev-parse-upstream.sh     |    2 +-
 t/t3409-rebase-preserve-merges.sh |    2 +-
 t/t7608-merge-messages.sh         |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 78c7774..5189b16 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -100,8 +100,8 @@ static int handle_line(char *line)
 		origin = line;
 		string_list_append(&src_data->tag, origin + 4);
 		src_data->head_status |= 2;
-	} else if (!prefixcmp(line, "remote branch ")) {
-		origin = line + 14;
+	} else if (!prefixcmp(line, "remote-tracking branch ")) {
+		origin = line + strlen("remote-tracking branch ");
 		string_list_append(&src_data->r_branch, origin);
 		src_data->head_status |= 2;
 	} else {
@@ -233,7 +233,7 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		if (src_data->r_branch.nr) {
 			strbuf_addstr(out, subsep);
 			subsep = ", ";
-			print_joined("remote branch ", "remote branches ",
+			print_joined("remote-tracking branch ", "remote-tracking branches ",
 					&src_data->r_branch, out);
 		}
 		if (src_data->tag.nr) {
diff --git a/builtin/merge.c b/builtin/merge.c
index 10f091b..9ec13f1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -403,7 +403,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 			goto cleanup;
 		}
 		if (!prefixcmp(found_ref, "refs/remotes/")) {
-			strbuf_addf(msg, "%s\t\tremote branch '%s' of .\n",
+			strbuf_addf(msg, "%s\t\tremote-tracking branch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 8c8dfda..a455551 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -85,7 +85,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
 	git show -s --pretty=format:%s >actual &&
-	echo "Merge remote branch ${sq}origin/side${sq}" >expect &&
+	echo "Merge remote-tracking branch ${sq}origin/side${sq}" >expect &&
 	test_cmp expect actual
 )
 '
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 74161a4..19341e5 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -72,7 +72,7 @@ test_expect_success 'rebase -p fakes interactive rebase' '
 	git fetch &&
 	git rebase -p origin/topic &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote branch " | wc -l)
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
 	)
 '
 
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 1c71296..9225fa6 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -54,7 +54,7 @@ test_expect_success 'remote-tracking branch' '
 	git checkout master &&
 	test_commit master-5 &&
 	git merge origin/master &&
-	check_oneline "Merge remote branch Qorigin/masterQ"
+	check_oneline "Merge remote-tracking branch Qorigin/masterQ"
 '
 
 test_done
-- 
1.7.3.2.183.g2e7b0
