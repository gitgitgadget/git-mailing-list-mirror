Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CF7C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6E42087D
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9UHQKrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgH1Ms5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgH1Mrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC48C06123A
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so1188511wrm.6
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPLJydSBHk0ZlwmYcmGusQ7CAHUxAOCrGBOXVO8QGOY=;
        b=N9UHQKrLmPiPUR+7Gx/mwybQdoYTepOCnVcM9xTvzqdipaMrKfC/Boj5ZWnosBx13q
         9qjsGxvbtVGpPv1dlNJzNSw2B/ZHIrgOR3Z/zFe5oJCFZQSBdL/aqSdNOWch4s0EyKoA
         jgHjTblobPa0+3K2Q5paDnvnC7S3b97u03S97wDcMv4VnKCv3LqzcsKHbFTNcMnYZinp
         EB4CVYVNuUgjiPNYkx1l+ewquDqySanNVVGgr8DgIFLNxMin3GQxZ6jYPdA0ETbFkXBB
         av9G0DPKuBAF2CLlZuwwKHwYKAm6PaKPUTsTkbP1ppolVzVI8y98FaDquPu72ytAtIgQ
         nIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPLJydSBHk0ZlwmYcmGusQ7CAHUxAOCrGBOXVO8QGOY=;
        b=EgEODPxATqp0bmhgK9NCSlbqaVxfBp8sCvEXKh/zyl5RBgic0FcE6S80aPdv/Cx6Tj
         PrWkeyFFCy7dOql+I5TAsuQmFMbrCPZGF+fKn/BCduBjkfimyPaP0Aj+JANKHMyhZeW7
         79T5KkZd2OvcnQXih14Wt+KbGEA2wW+ZJNsgcdbmJ4M3GuPl1Qkx+Vi8ujgbkosEaiM8
         2zSZJB3W/lJmjEYZ5ShmrFqYRrNsxeGMTsZ18iU2JMv9D4q9OFi0YyOPYor2V693rBTv
         gQ+He+Qt1nDgoEg9O3zw3dleH+Pqmtz++6yOfCCYA1temSTBe7cItNtwAIBkoAzHsSFB
         Sq5A==
X-Gm-Message-State: AOAM532Ood+J5eLxmwBBoYDp3mN2uMyTBTA+3ZlT9xdIBuwfrSqnoBDQ
        fcqqfNcSfmmp7UeKL02Vquo91D5YH6o=
X-Google-Smtp-Source: ABdhPJxsikyBZVXtxhtdtlCw73VXKGVqzq7K+3jNaWXozoVvno7ZN7poMpdYyj/FNDUDzBafq46aaA==
X-Received: by 2002:adf:81a3:: with SMTP id 32mr1409590wra.368.1598618843677;
        Fri, 28 Aug 2020 05:47:23 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:22 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 11/13] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Fri, 28 Aug 2020 14:46:15 +0200
Message-Id: <20200828124617.60618-12-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--check-expected-revs` subcommand is no longer used from the
git-bisect.sh shell script. Functions `check_expected_revs` and
`is_expected_revs` are also deleted.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6d2847dc9c..d795f2e5c7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -187,30 +187,6 @@ static int write_terms(const char *bad, const char *good)
 	return res;
 }
 
-static int is_expected_rev(const char *expected_hex)
-{
-	struct strbuf actual_hex = STRBUF_INIT;
-	int res = 0;
-	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
-		strbuf_trim(&actual_hex);
-		res = !strcmp(actual_hex.buf, expected_hex);
-	}
-	strbuf_release(&actual_hex);
-	return res;
-}
-
-static void check_expected_revs(const char **revs, int rev_nr)
-{
-	int i;
-
-	for (i = 0; i < rev_nr; i++) {
-		if (!is_expected_rev(revs[i])) {
-			unlink_or_warn(git_path_bisect_ancestors_ok());
-			unlink_or_warn(git_path_bisect_expected_rev());
-		}
-	}
-}
-
 static int bisect_reset(const char *commit)
 {
 	struct strbuf branch = STRBUF_INIT;
@@ -937,7 +913,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -953,8 +928,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -993,9 +966,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case CHECK_EXPECTED_REVS:
-		check_expected_revs(argv, argc);
-		return 0;
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
2.25.0

