Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA12C2D0A4
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713192075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiIUtyHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgJJW4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgJJTw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:52:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E534C05BD1B
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q5so12462568wmq.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIyb7pJOsAWnA5uhbu51zZFPPl3NYttft0D1Uusla58=;
        b=kiIUtyHz7QGbjryC5gqHZbDf5/7r0T9SB298f1/Wxvk2IGZXOPbpkSZa+gn2+vVqkH
         EKNdvoqapeP93dNdE5B2kRz+r0eiwt5p1peTdSwXyCwK0ZUpAFBcUAWN13yzpjGOnWe2
         WKQhgYeIvSyeggUvd/7NVJm6kN3AqhIxs0MaELGX8/Ad5qwJ0Ppu5NklHTZOSQgC2ERm
         4tZCH9U7wWp9MWFMID/d/8NU5VP7hP6yV0HNro2I1Z8KzBd1tR7hFE1TjBc0cxuou+RJ
         PpkNnq40Vo8bvu74WaHqMA3s1gOsVA7yVSBoCm6x86IEAThvZvVlvmgwxB5NVLiAGArJ
         tfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIyb7pJOsAWnA5uhbu51zZFPPl3NYttft0D1Uusla58=;
        b=CKol7MJmAaS9myWAn313wxsukytTTf22SgLaUDKu7MmWTNwHvEF3Dirf0vfBDe/K1w
         V5rKBxF5vqkob9zS2qou2wg2HIlMTnDByv0j66Vouc1CFOcS6M+t5U4JmMNzgoNrKaL5
         9u/dCYE88Mc0yzYI+csJQuXGtw+DNTrANd0oevRevhApST/qf6qYNngqG6oip1bDs0b+
         D8xIMdaAP1cCc+JVNFOX7k4u/GY/nl4yfpEQkOkJmytD5pTFUqez116CUSX8t2jZY4/w
         Td2acyq0ffvQOb67eTccKm4DTOlyK3GU952Vl0qw3cLLHhVj/vM7DiPM58TiW5p7/qNA
         zgeA==
X-Gm-Message-State: AOAM533CntPYgPCfjBo0LGn3RhHxXrxliDzEtjLsx9g55iOCMCKHrBRZ
        yw/SUUQ551mkyaSFv/iF84hfndoDg5s=
X-Google-Smtp-Source: ABdhPJxcO/rbm9reXgZGqLlYxEuTZoHPJwe6wtbGqAmfLDRYvi9ShB26I5dn8Rh6HoA+9/5qRGNjxA==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr2856283wmf.82.1602338939645;
        Sat, 10 Oct 2020 07:08:59 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:08:59 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 5/7] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Sat, 10 Oct 2020 16:07:41 +0200
Message-Id: <20201010140743.580-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201010140743.580-1-mirucam@gmail.com>
References: <20201010140743.580-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 66b5346e42..14a8f2b9df 100644
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
@@ -932,7 +908,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -948,8 +923,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -988,9 +961,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

