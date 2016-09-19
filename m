Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A09A2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759722AbcISNJR (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:09:17 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:47285 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756331AbcISNJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:09:16 -0400
Received: (qmail 31420 invoked from network); 19 Sep 2016 13:09:13 -0000
Received: (qmail 29027 invoked from network); 19 Sep 2016 13:09:11 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 19 Sep 2016 13:09:06 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 1/6] i18n: commit: mark message for translation
Date:   Mon, 19 Sep 2016 13:08:16 +0000
Message-Id: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark message commit_utf8_warn for translation.

Update tests to reflect changes.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 commit.c               | 8 ++++----
 t/t3900-i18n-commit.sh | 8 ++++----
 t/t3901-i18n-patch.sh  | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/commit.c b/commit.c
index ba6dee3..8eb1707 100644
--- a/commit.c
+++ b/commit.c
@@ -1511,9 +1511,9 @@ static int verify_utf8(struct strbuf *buf)
 }
 
 static const char commit_utf8_warn[] =
-"Warning: commit message did not conform to UTF-8.\n"
-"You may want to amend it after fixing the message, or set the config\n"
-"variable i18n.commitencoding to the encoding your project uses.\n";
+N_("Warning: commit message did not conform to UTF-8.\n"
+   "You may want to amend it after fixing the message, or set the config\n"
+   "variable i18n.commitencoding to the encoding your project uses.\n");
 
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const unsigned char *tree,
@@ -1566,7 +1566,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 
 	/* And check the encoding */
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
-		fprintf(stderr, commit_utf8_warn);
+		fprintf(stderr, _(commit_utf8_warn));
 
 	if (sign_commit && do_sign_commit(&buffer, sign_commit))
 		return -1;
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 4bf1dbe..3b94283 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -45,7 +45,7 @@ test_expect_success 'UTF-8 invalid characters refused' '
 	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	grep "did not conform" "$HOME"/stderr
+	test_i18ngrep "did not conform" "$HOME"/stderr
 '
 
 test_expect_success 'UTF-8 overlong sequences rejected' '
@@ -55,7 +55,7 @@ test_expect_success 'UTF-8 overlong sequences rejected' '
 	printf "\340\202\251ommit message\n\nThis is not a space:\300\240\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	grep "did not conform" "$HOME"/stderr
+	test_i18ngrep "did not conform" "$HOME"/stderr
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
@@ -64,7 +64,7 @@ test_expect_success 'UTF-8 non-characters refused' '
 	printf "Commit message\n\nNon-character:\364\217\277\276\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	grep "did not conform" "$HOME"/stderr
+	test_i18ngrep "did not conform" "$HOME"/stderr
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
@@ -73,7 +73,7 @@ test_expect_success 'UTF-8 non-characters refused' '
 	printf "Commit message\n\nNon-character:\357\267\220\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	grep "did not conform" "$HOME"/stderr
+	test_i18ngrep "did not conform" "$HOME"/stderr
 '
 
 for H in ISO8859-1 eucJP ISO-2022-JP
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 509084e..f663d56 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -295,7 +295,7 @@ test_expect_success 'am --no-utf8 (U/L)' '
 
 	# commit-tree will warn that the commit message does not contain valid UTF-8
 	# as mailinfo did not convert it
-	grep "did not conform" err &&
+	test_i18ngrep "did not conform" err &&
 
 	check_encoding 2
 '
-- 
2.7.4

