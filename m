Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A5C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE93206FB
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzEP93sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbgJONjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387712AbgJONjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:39:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1987C0613D2
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so3545220wre.4
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u47w77awamzb+L7raiUDc6pj21MyRrnxWiR2sNQL5LI=;
        b=IzEP93sNVIGT5kPcrxVtQ+hUtrnZ86SjkcOkjUQP35CclqeVaKLX9OQS1QMn8FpJPj
         5/uZTJvp6Q7GDsc1IzPhQ7vZCyg7127hg7IxU/nnRgFKt1p528oqJxMsrKbv1vGF/c5c
         Zvx0Prig/xI7byHaPU8lOdLV5KQMgbUg53+EPIM7aamBjYNcNQ3udkUCTKYnYM3B/IiP
         0PV+4MzBubhuaLoYeInAyFJkyasBA32x4K8oTy2F/FgOA7E7be4/ZWxA1Cx2AiJJDuMr
         pQ84A2APmslDpcd5rZJ10UPBX17/ieQEP7Q3m8zb0PJcH7Lhcc4wiu6MRLAJJ3FZCpbR
         OVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u47w77awamzb+L7raiUDc6pj21MyRrnxWiR2sNQL5LI=;
        b=Qs1ITpiv6KKebgpoDywuDoZnYmps8TmoN3xRSBehegfP9HjsqmmCFPrYP9yfBTQZk1
         dlR/aNrh1vuDgHvsMJH3dFPoeiEj01tC3pYmLoGbG6SMZ1+UTixC1qL9iUv9Ah9mVnlV
         A53YP+GRbBmpKrscfbtotRw38dZ0WOj9zNMQGSxzngwIUgrDBnPZTOAEfsQh0jEo1YiI
         /seRdheyVr8TLXUoP1+6phtKQkjFqZXQbbOvO7NK52wLPtgnCUVreXbQYcFVDkZfssl/
         uLehq5XGyWWKpTzKcFLnPNykDylYL7wB34z63OLt9NM5fEqS5iMaIedeK5eMBVkb/06G
         D0yQ==
X-Gm-Message-State: AOAM533MH40C5OS6Ow69cxuC+T6MFOdC2RWL88advFRRU87V8h+Gsuty
        99uBVYDsZPCjibCuM3B+ca/1h1Zf0/A=
X-Google-Smtp-Source: ABdhPJyztqvHjwFB0LXAjVwgm/kHU+jm2BWKVEqdklRWhE90Sa8oS4kM2+MP0xb4bgFt1f5877G8/g==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr4370623wrt.75.1602769139531;
        Thu, 15 Oct 2020 06:38:59 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id o4sm4709434wrv.8.2020.10.15.06.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:38:59 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v11 5/7] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Thu, 15 Oct 2020 15:38:36 +0200
Message-Id: <20201015133838.85524-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201015133838.85524-1-mirucam@gmail.com>
References: <20201015133838.85524-1-mirucam@gmail.com>
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
index 42b8352546..64a5752ce0 100644
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

