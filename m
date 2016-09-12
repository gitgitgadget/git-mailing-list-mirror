Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4ACA20984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758072AbcILLim (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:38:42 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:55016 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757388AbcILLil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 07:38:41 -0400
Received: (qmail 31015 invoked from network); 12 Sep 2016 11:38:36 -0000
Received: (qmail 22793 invoked from network); 12 Sep 2016 11:31:46 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Sep 2016 11:31:41 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/14] i18n: receive-pack: mark messages for translation
Date:   Mon, 12 Sep 2016 11:29:59 +0000
Message-Id: <1473679802-31381-11-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages refuse_unconfigured_deny_msg and
refuse_unconfigured_deny_delete_current_msg for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/receive-pack.c | 58 ++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f1ce05c..896b16f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -781,47 +781,39 @@ static int is_ref_checked_out(const char *ref)
 	return !strcmp(head_name, ref);
 }
 
-static char *refuse_unconfigured_deny_msg[] = {
-	"By default, updating the current branch in a non-bare repository",
-	"is denied, because it will make the index and work tree inconsistent",
-	"with what you pushed, and will require 'git reset --hard' to match",
-	"the work tree to HEAD.",
-	"",
-	"You can set 'receive.denyCurrentBranch' configuration variable to",
-	"'ignore' or 'warn' in the remote repository to allow pushing into",
-	"its current branch; however, this is not recommended unless you",
-	"arranged to update its work tree to match what you pushed in some",
-	"other way.",
-	"",
-	"To squelch this message and still keep the default behaviour, set",
-	"'receive.denyCurrentBranch' configuration variable to 'refuse'."
-};
+static char *refuse_unconfigured_deny_msg =
+	N_("By default, updating the current branch in a non-bare repository\n"
+	   "is denied, because it will make the index and work tree inconsistent\n"
+	   "with what you pushed, and will require 'git reset --hard' to match\n"
+	   "the work tree to HEAD.\n"
+	   "\n"
+	   "You can set 'receive.denyCurrentBranch' configuration variable to\n"
+	   "'ignore' or 'warn' in the remote repository to allow pushing into\n"
+	   "its current branch; however, this is not recommended unless you\n"
+	   "arranged to update its work tree to match what you pushed in some\n"
+	   "other way.\n"
+	   "\n"
+	   "To squelch this message and still keep the default behaviour, set\n"
+	   "'receive.denyCurrentBranch' configuration variable to 'refuse'.");
 
 static void refuse_unconfigured_deny(void)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(refuse_unconfigured_deny_msg); i++)
-		rp_error("%s", refuse_unconfigured_deny_msg[i]);
+	rp_error("%s", _(refuse_unconfigured_deny_msg));
 }
 
-static char *refuse_unconfigured_deny_delete_current_msg[] = {
-	"By default, deleting the current branch is denied, because the next",
-	"'git clone' won't result in any file checked out, causing confusion.",
-	"",
-	"You can set 'receive.denyDeleteCurrent' configuration variable to",
-	"'warn' or 'ignore' in the remote repository to allow deleting the",
-	"current branch, with or without a warning message.",
-	"",
-	"To squelch this message, you can set it to 'refuse'."
-};
+static char *refuse_unconfigured_deny_delete_current_msg =
+	N_("By default, deleting the current branch is denied, because the next\n"
+	   "'git clone' won't result in any file checked out, causing confusion.\n"
+	   "\n"
+	   "You can set 'receive.denyDeleteCurrent' configuration variable to\n"
+	   "'warn' or 'ignore' in the remote repository to allow deleting the\n"
+	   "current branch, with or without a warning message.\n"
+	   "\n"
+	   "To squelch this message, you can set it to 'refuse'.");
 
 static void refuse_unconfigured_deny_delete_current(void)
 {
-	int i;
-	for (i = 0;
-	     i < ARRAY_SIZE(refuse_unconfigured_deny_delete_current_msg);
-	     i++)
-		rp_error("%s", refuse_unconfigured_deny_delete_current_msg[i]);
+	rp_error("%s", _(refuse_unconfigured_deny_delete_current_msg));
 }
 
 static int command_singleton_iterator(void *cb_data, unsigned char sha1[20]);
-- 
2.7.4

