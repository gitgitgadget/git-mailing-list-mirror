Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1592B1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755140AbcJQNRe (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 09:17:34 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:34322 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754706AbcJQNQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 09:16:16 -0400
Received: (qmail 16835 invoked from network); 17 Oct 2016 13:16:15 -0000
Received: (qmail 12790 invoked from network); 17 Oct 2016 13:16:11 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Oct 2016 13:16:09 -0000
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
Subject: [PATCH 2/4] i18n: convert mark error messages for translation
Date:   Mon, 17 Oct 2016 13:15:27 +0000
Message-Id: <20161017131529.27856-2-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.459.g5fd885d
In-Reply-To: <20161017131529.27856-1-vascomalmeida@sapo.pt>
References: <20161017131529.27856-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark error messages about CRLF for translation.

Update test to reflect changes.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 convert.c       | 12 ++++++++----
 t/t0020-crlf.sh |  6 +++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index 077f5e6..0ad39b1 100644
--- a/convert.c
+++ b/convert.c
@@ -197,17 +197,21 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 		 * CRLFs would not be restored by checkout
 		 */
 		if (checksafe == SAFE_CRLF_WARN)
-			warning("CRLF will be replaced by LF in %s.\nThe file will have its original line endings in your working directory.", path);
+			warning(_("CRLF will be replaced by LF in %s.\n"
+				  "The file will have its original line"
+				  " endings in your working directory."), path);
 		else /* i.e. SAFE_CRLF_FAIL */
-			die("CRLF would be replaced by LF in %s.", path);
+			die(_("CRLF would be replaced by LF in %s."), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
 		 */
 		if (checksafe == SAFE_CRLF_WARN)
-			warning("LF will be replaced by CRLF in %s.\nThe file will have its original line endings in your working directory.", path);
+			warning(_("LF will be replaced by CRLF in %s.\n"
+				  "The file will have its original line"
+				  " endings in your working directory."), path);
 		else /* i.e. SAFE_CRLF_FAIL */
-			die("LF would be replaced by CRLF in %s", path);
+			die(_("LF would be replaced by CRLF in %s"), path);
 	}
 }
 
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index f94120a..71350e0 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -83,7 +83,11 @@ test_expect_success 'safecrlf: print warning only once' '
 	git add doublewarn &&
 	git commit -m "nowarn" &&
 	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >doublewarn &&
-	test $(git add doublewarn 2>&1 | grep "CRLF will be replaced by LF" | wc -l) = 1
+	git add doublewarn 2>err &&
+	if test_have_prereq C_LOCALE_OUTPUT
+	then
+		test $(grep "CRLF will be replaced by LF" err | wc -l) = 1
+	fi
 '
 
 
-- 
2.10.1.459.g5fd885d

