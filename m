Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139CC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD942068F
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0fFUmah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgHaKwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgHaKvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7FDC06123B
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so4932886wmc.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHURdtxHIaMnZdalG8YCxuwDCoOMBsyowGCZ5kqBK7k=;
        b=t0fFUmah5DuMsFYR7CTR3RV1w4w4vAfc7OlJf2zXl5OMGHMth4TU8JPylj+/Q4ijF5
         NsXOAJ90rWKalr+WlSNtYN2EOsVk75O3y8zCo2imZmkyk9eE59xiOXnChPiyOlh92vmv
         uI9ladU1vA7jhRPQaplK7hyw/VxFviTs8YDOxKpLInVHZMhdW/pceCvogW4Cieekcq+B
         f2k/fQoFvmUDxweMkXNEYDP5IxjPQKJkPUaSiwM/YUnSE2dVcaVXO9/wkaMGXunmz1nD
         Ibo7gQCdlAk90EFLTCeuGj+iUB7SLUaEOpMn9A0EpywJTiTU24toXwQ27RU7H3UQgX/d
         c82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHURdtxHIaMnZdalG8YCxuwDCoOMBsyowGCZ5kqBK7k=;
        b=F5bbt2aUOCePUzW2eWZDQbwDTWShpj+ZLTSlzeXflpQwPObxFOcVN9BXBABlJ2scMp
         H65YK/Kxa7+qbl6rGOKqqLHZHMQ3t21EyrLBUWKr566UOVomeJKngg1SkMIW3rrV3uwn
         ZOmU1e2wWqLoDmXAJB5DRRMyYFEu7nvbAXI+TQHVxdp4oBCgkdoBCrWAfsyVb3OHOQ88
         CRjyO4oRZqGqR7wz37RAUzuZnT5rbAMjac8vpVA78RaoNw6j6jc1htDOIFL0NCpeHGKL
         tYEmBEgLeFuVINVXDfnbqvr6tA0iabADKYSnFz/118eknND45io4TiXJa0VBDKwmO1h1
         SfGQ==
X-Gm-Message-State: AOAM530LJnWiczEhi4aIE/0N1EtTFkBPvYIj4nDgiPly98cfAzuCxHXl
        vVtvNT/Fm+ADu1eIwcRChGq8T0sifD4=
X-Google-Smtp-Source: ABdhPJxMrbTkYqplYpsyHgMOhvG+EMxNHXcI2O/BHFxeIgV+zNz6B3JeC6FtzIqTus3phyznNxBkDA==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr852746wme.172.1598871081903;
        Mon, 31 Aug 2020 03:51:21 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:21 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 11/13] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Mon, 31 Aug 2020 12:50:41 +0200
Message-Id: <20200831105043.97665-12-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
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
index a976f4739c..da203c2091 100644
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
@@ -934,7 +910,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -950,8 +925,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -990,9 +963,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

