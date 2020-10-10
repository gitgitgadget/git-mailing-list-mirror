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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A84C433E7
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBAB20760
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnVkaCTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbgJJW4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgJJTvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:51:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C2C05BD18
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so12460461wmh.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ow+AP6QkVF3SaDeNeaXjVuBTnDhi9wPFPl7+V6ytus=;
        b=NnVkaCTsgR6+f08b6QYbWiN2QuX9Pf3OkVypZn1C1BjPX7m3Q7ik9fOw7epW4cc4Pv
         x4kloEuKMUizavaaRg/a50Zoy7iOOGJGIDtn4oHLMKpU601ZHUvyz+ZCUS6H3nTkuRo0
         rOSLKwAxHHJr62v0nzOb43kFM2StOs0IVDMb9SY1rx+7+2IwVU8zrB7BZCrv/tyCSzj9
         Zc5RXbb+gtBqKYyI6vnScjyvvs6Lk7mLT1rQdPXu1HImeoJehSKqvev+16K8Knm4fTvW
         7KivT6a7l8dFT1auONv3fahlj+RIe3OMrZI5GD273thyo6NZ58WhIIiBOetTbjWGMZeO
         QbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ow+AP6QkVF3SaDeNeaXjVuBTnDhi9wPFPl7+V6ytus=;
        b=s874nda4taKqgW1BgUZ5Fw/3qI2S9AaTZkSZQdJom8aUpFX0CFdflp6MGUIyXdGnix
         5CrON/rHJPbzOi9vN/OOkY4GwJqqLXPMnO4KawpYFE74E0otAroHQYoeVwBpmpjMHt2d
         ek80LfSyxHmKXkLdJwPk6+eq/Fl7AQgAlAaIpTnaiXGGo645e46KmYZFdgUaupaJNIeI
         9LDuunumkc6aafShDt9c4EvcAtbcocAIk2ELTThSHRGPlrbAEGeUfb3can0G2tdwQI+q
         48pu3L2TaIizsM/jd7jg9lT8T7Gt/SIKqIypMipJbQvTd6hM4AnC0yu+Lcs7I+wyAXUH
         BG1g==
X-Gm-Message-State: AOAM532BGcAyMkcszHpJH4UCmWnXWJ3OvFDGgl/WY0Je9qAiW8vHTsJo
        MBbTRFi67JGjxsglei0MaD0X+O0inXc=
X-Google-Smtp-Source: ABdhPJyPmctwu9brNJDyhKClAG3AcrwfM6Gb9FbsJJeX+8y6oDaa76hVK8nSLMRIyQW2WRn4orrCEA==
X-Received: by 2002:a05:600c:2902:: with SMTP id i2mr2843643wmd.31.1602338935562;
        Sat, 10 Oct 2020 07:08:55 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.08.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:08:54 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 2/7] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Sat, 10 Oct 2020 16:07:38 +0200
Message-Id: <20201010140743.580-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201010140743.580-1-mirucam@gmail.com>
References: <20201010140743.580-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-clean-state` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_clean_state()` is directly called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8adad68268..fbb9046737 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -861,7 +860,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -879,8 +877,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -922,10 +918,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case BISECT_CLEAN_STATE:
-		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
-- 
2.25.0

