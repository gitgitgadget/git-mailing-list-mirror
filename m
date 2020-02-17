Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F9C7619D
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6B20725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uL43RjiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgBQIlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:39 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52901 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgBQIlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:36 -0500
Received: by mail-wm1-f50.google.com with SMTP id p9so16207902wmc.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGh/PeU+AQvaO9QY4M69ACJAKEc+HVLem5sH/24iHkc=;
        b=uL43RjiFigT0HU5r2eGzrZ5af7Q4HF9oaFVcOoW3ITXFmrENNpbm7b+NwjDAsQamO4
         /41HNEjgIIxCE4e1CWSQ/V5d7BbVIglj4B0/noANMmRgCV6dCU3d4jBVY3JBCNqdDW2L
         gQO6kaPYa0m98BxczCnCKkQSWosaPUth9UYDGK6sDkIfnVnwpNaR4xgIk7izrKcsO2+D
         u5ONgGUjQintZ5y81X7BgbhRwn5JoRoqeQgrr8XiUuj2BHiXv/DIXw17H4u337yh1u6l
         BOt+ERozFe0hkv+gh16sgUVAuoLT30gA3CeFlAu2rqwiGMe7jPdM8WrBOiX9xrCF0iWS
         UjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGh/PeU+AQvaO9QY4M69ACJAKEc+HVLem5sH/24iHkc=;
        b=COCMt8vgLPdSWrcCkxkHercaluZaIZDyrpJ2N/3okZtY30uVBLye2AzTxAVKmJSd8f
         Yy8SY56JKS6t7cqRXWzaceQK6xnvac8bNxpADawcRSxA2XXiN+LpbCGFKBvSGDxPiYCA
         kRSdF3qO2Ea3GbbEMksyWmQSl8JhazXTZJZueUVezvjoeHrmT5XwiAmJiqDinxL7lqYU
         38d7pHB29x+/GsOuiBuZlPxnEeGmxk86Dnz/QEIMOIIic9IjmHshDMuhazRGxt/eCs3T
         LZHIrUFJvIMCgUnj89YM2/MFrHhKZLMC/FlRy+L+Upz3/xVJPOjShf0bmQhug8of0Lvh
         SmOQ==
X-Gm-Message-State: APjAAAV4Ixh3nv1o+miq4hhkXRpmLh8/z+hNbzxSuDyxvr0OVjlZewjq
        vv3OMoJfZuqOTraswSpvXvM9nfxA
X-Google-Smtp-Source: APXvYqzpecKZWjJ6odWUaoG9tSHU8FBeSkbirTupB5eEXt0sT6oWHslJrlaBwYShP9tjkmr5/2ugng==
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr20935254wmi.124.1581928893263;
        Mon, 17 Feb 2020 00:41:33 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:32 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 12/12] bisect: libify `bisect_next_all`
Date:   Mon, 17 Feb 2020 09:40:39 +0100
Message-Id: <20200217084039.78215-13-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh, it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

All the functions calling `bisect_next_all()` are already able to
handle return values from it.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 29 +++++++++++++++++++----------
 bisect.h | 10 ++++++++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index 837332a428..9154f810f7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -976,10 +976,10 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 }
 
 /*
- * We use the convention that exiting with an exit code 10 means that
+ * We use the convention that return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10) means
  * the bisection process finished successfully.
- * In this case the calling shell script should exit 0.
- *
+ * In this case the calling function or command should not turn a
+ * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND return code into an error or a non zero exit code.
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
@@ -1010,23 +1010,25 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 
 	if (!revs.commits) {
 		/*
-		 * We should exit here only if the "bad"
+		 * We should return error here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
 		res = error_if_skipped_commits(tried, NULL);
 		if (res < 0)
-			exit(-res);
+			return res;
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
 		       term_bad);
-		exit(1);
+
+		return BISECT_FAILED;
 	}
 
 	if (!all) {
 		fprintf(stderr, _("No testable commit found.\n"
 			"Maybe you started with bad path parameters?\n"));
-		exit(4);
+
+		return BISECT_NO_TESTABLE_COMMIT;
 	}
 
 	bisect_rev = &revs.commits->item->object.oid;
@@ -1034,12 +1036,19 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	if (oideq(bisect_rev, current_bad_oid)) {
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
-			exit(-res);
+			return res;
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
+
 		show_diff_tree(r, prefix, revs.commits->item);
-		/* This means the bisection process succeeded. */
-		exit(10);
+		/*
+		 * This means the bisection process succeeded.
+		 * Using BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10)
+		 * so that the call chain can simply check
+		 * for negative return values for early returns up
+		 * until the cmd_bisect__helper() caller.
+		 */
+		return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
 	}
 
 	nr = all - reaches - 1;
diff --git a/bisect.h b/bisect.h
index 0d9758179f..8bad8d8391 100644
--- a/bisect.h
+++ b/bisect.h
@@ -39,16 +39,22 @@ struct rev_list_info {
  * BISECT_FAILED error code: default error code.
  * BISECT_ONLY_SKIPPED_LEFT error code: only skipped
  * commits left to be tested.
+ * BISECT_MERGE_BASE_CHECK error code: merge base check failed.
+ * BISECT_NO_TESTABLE_COMMIT error code: no testable commit found.
+ * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND early success code:
+ * first term_bad commit found.
  * BISECT_INTERNAL_SUCCESS_MERGE_BASE early success
  * code: found merge base that should be tested.
- * Early success code BISECT_INTERNAL_SUCCESS_MERGE_BASE
- * should be only an internal code.
+ * Early success codes BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND and
+ * BISECT_INTERNAL_SUCCESS_MERGE_BASE should be only internal codes.
  */
 enum bisect_error {
 	BISECT_OK = 0,
 	BISECT_FAILED = -1,
 	BISECT_ONLY_SKIPPED_LEFT = -2,
 	BISECT_MERGE_BASE_CHECK = -3,
+	BISECT_NO_TESTABLE_COMMIT = -4,
+	BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND = -10,
 	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
 };
 
-- 
2.25.0

