Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDBC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B001122D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgLUSYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgLUSYu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:24:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA7C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:24:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a6so10754672wmc.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6QF7F1Z+JqlJufBL11EO6a3iYF40ejzq1mLY460EEg=;
        b=nCKRiKI9o0vTHOweNu9Q10UD0T9rjE2MIcCytQ8ATunSSuvVwPST/qLJDaEh173eSr
         TxbLi50HWwt8s32LpKlnbxk85548b8/zDKocZWNydr7JCjFjqu0OLHJSRPp3V+G5lClX
         RuGZdBaCU++hcBCBrVAFqyVLMjukqGCfI0bM6cHWKt1Zz/M/6RE1VL2JmHXB7hNkZ6XW
         nkLjlvL/VcojrXcevsM/SVcegySUZrQnPf+T9WYiglzvj4NOQ5LtDAa/vPvuMLZ5mFUP
         sUv/+HpVwRWj4oyZaAyCcCmPNmC0ppTXE6dfSbMmW0dWhK7nJVfKLOBAmBDS7Dvwjjbi
         6qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6QF7F1Z+JqlJufBL11EO6a3iYF40ejzq1mLY460EEg=;
        b=eRLkhDju0OCE2kdZu+2I7s4jCga2lAPxCNBCEubnV7stt9K5apFogF11PRElhf9VGX
         aCuFgDYoGpYW79Dnc8SpaXCAVW9XrCAR2GO92rdL6oiBpPZ7FFH/xtADLrdmGzUqOm0d
         o0O1O/9eslEAK55s/dleJSGiHGvsMqoJiobH8JfOn+HBcaWBDrTklsmgtiDn8VgtaYk5
         WF2JT/BPxl5d06PcT5ozrKRv2Tg+QTx1qvr/ZFVEMSkx8OBJPDMrZsbaxZbC4ACunke+
         WKdTMfPc+t1M4lA1KVNNPZkhmJUnrP+257CdwU587GGiDqiw+NL9SSmeNvy0/tRuuPtT
         ZGzQ==
X-Gm-Message-State: AOAM530w7TvRD6NgtbM1ADC/vSqa2JN2U+C0luIlK0A2YW3CCCPoGlEl
        spK2IMxqvpZFBB0JNHbVgdh3FmYTgpZyWw==
X-Google-Smtp-Source: ABdhPJxl2zhjwT0+m/98ZMY2lackJtl8tfeqw/Ct5pbQHEfrOZscRWwlfTDP6y2amO/Ef3Bnk07ouA==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr17484023wmc.14.1608568174466;
        Mon, 21 Dec 2020 08:29:34 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:33 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 7/7] bisect--helper: retire `--check-and-set-terms` subcommand
Date:   Mon, 21 Dec 2020 17:27:43 +0100
Message-Id: <20201221162743.96056-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
References: <20201221162743.96056-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--check-and-set-terms` subcommand is no longer from the
git-bisect.sh shell script. Instead the function
`check_and_set_terms()` is called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1a6c75183a..eb2a46a4b4 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
@@ -1072,7 +1071,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
@@ -1087,8 +1085,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
-			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
@@ -1124,12 +1120,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case CHECK_AND_SET_TERMS:
-		if (argc != 3)
-			return error(_("--check-and-set-terms requires 3 arguments"));
-		set_terms(&terms, argv[2], argv[1]);
-		res = check_and_set_terms(&terms, argv[0]);
-		break;
 	case BISECT_NEXT_CHECK:
 		if (argc != 2 && argc != 3)
 			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-- 
2.29.2

