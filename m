Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFDEC433F8
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8F12076A
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU8GDJ4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGQKyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgGQKyr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CEBC08C5C0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so14174762wmh.4
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSQny+VB5OmGT1rDnmlDzAyNSVY+cVq5h1oUwbpvvfA=;
        b=IU8GDJ4bwCYeehmgM/Z3JkdExacIH5c611lwoHpW02RjdxE2wMXmgNQW3/7OoZhMp4
         4p89Kx5NtpPM/TAY6bbHihQusp42y4zI4/lD4Dr1XKUzRWWo/euFXamjPsnAkaMECBIC
         /MysWfZgtYA83zqwDbrpdKWBagBoz6Ply6LleVxpJSYIpylUwX/jBLe1K+ssRE5RvXtP
         95yPPCRVabqItjSetIoKcQMG3kbVFqmhcpAWksaHZfeUxaWqhFIaR6XpkuwmF7Vtjm7R
         tIxHxoYuxjYJFfLI7Gev2flfKO3ubl+vgNNM8DcbGOkRWyCsjy6qzCiabThobYFuxNik
         flCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSQny+VB5OmGT1rDnmlDzAyNSVY+cVq5h1oUwbpvvfA=;
        b=E4pPrvrIEyJid9u8WfyQDr40F56Q0KdlA07kHMdcVOupkuqakLOULv4Y6ZjCdfwZGM
         DOM30OaQIMWehBkwkoSdZVVGbOQphD5tKz8i8YCvMSHBZbE4vY0MEoA6pO2vEMsfVNdg
         +uA1l/0mPuFpgyHEe6uO/LIlTdRFYzwTzcmfRYw2frSn4UAgJCGfTpQtZi9z2UR/+qrM
         Jq6hXaGU2lPmJItc1icTXhsPIKPiFW6DHDYmZSual/hpfBsH/g27a/hN8hpzibm0GoRL
         E5iBwyEP5UYbQlo5647nc3+ldRFznaSl1YL/Absv9K9Nwdax4G6jNyy8C3lK/nkAoeYG
         Jadw==
X-Gm-Message-State: AOAM530pxU6TkCCI8L2kZ8Nzb4a4NLb9SQn2ka1Mnol5V3TfLAU/q76e
        jENML3rZUUCdwych9pWTeA1aCFw+
X-Google-Smtp-Source: ABdhPJyUUjQqEMj5Qoh8k6HZoaqjTRKqXF0SQFJR0byyatZ5orf+i6fxzoExXjQL9Tl7edqkj9a0Yw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr8406244wmc.135.1594983285526;
        Fri, 17 Jul 2020 03:54:45 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:45 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 11/13] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Fri, 17 Jul 2020 12:54:04 +0200
Message-Id: <20200717105406.82226-12-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
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
index 7369605e4c..370d344bbd 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -185,30 +185,6 @@ static int write_terms(const char *bad, const char *good)
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
@@ -929,7 +905,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -945,8 +920,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -987,9 +960,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

