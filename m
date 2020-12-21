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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6469DC43381
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332AD22D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgLUSVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLUSVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:21:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4201C061257
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:21:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 91so12047359wrj.7
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AN2/2LBOVeLGSx2IKzATLVFL5GwDYVgFjT8qBOFVWEk=;
        b=n+TibyreZcpvRCgGjN2QAhSVY3xr/QS8WsdbQ7mbS/hjLZkay/VmAbYNksGUEaA9V2
         9cIB56/TJLOivM1V4x31K3/a5ejDA/nv8aWddCkVKEJhb8A00c3xc47tM40cfftyp85X
         O17zaskfSb3mtBevCBUJPo6vMIXT72yb7ljTeE91m5FbaxRBEbp2XeD41+nhxPTtKMUV
         XyPA3xyGU2YqUC+fgwFqHKLn9zOaekN/5qHZuXIRmGFfju7ZqAUTmL+CWuLOmiAyGxJC
         /EaY3r5GTFg9YpmCn/TLFgqCKuqYzzQz3CJphpker6w06rdx/amLTIugnRufSn47wVzD
         yNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AN2/2LBOVeLGSx2IKzATLVFL5GwDYVgFjT8qBOFVWEk=;
        b=VKQ7VrYvFwCX5drPmPgL1apPLwMPMb9b2xMdXnYTFZJj3sHfuTXiuYkR3ATNXMHiTT
         uBPG4TrAGV9YvGFWSHa8BMxai4ikRrw0CStPFO9vIcE2AtRCe/f4cqtObHhaMC0dKpPB
         AwTaOV8ih8zvyYpY9Dk/D957423SWJ/ZIk9U8nWIOn0FmJ+KWqZFVsub8XZ0RTiF482P
         3yIVjCQmSaGgaUvZA+a52KARGYFb/hWWVSGTO0NcZeNxcABP2hUxhPSi1UhygYdgGnod
         C0Y2zfyipX3iVdkXnLIVzVos2rdojplNZFr90J69UaeB+j7Ip9vhKaZJGrlfMwsCFX6A
         lOEw==
X-Gm-Message-State: AOAM531tpg7c2nDWcmf1oeZPOYwxqq1iqdq7eGOcgScIMmVwLLkY4Vot
        fkSvHTa9d+v6j8npMvhobUOUk+TbciRL5w==
X-Google-Smtp-Source: ABdhPJy8aez7UpceM3vh9c8Qko5RCJLbhwvuAenSQ0h6KBGspROb7Yfz/eCkgVLgUlw1ORiLezBu6Q==
X-Received: by 2002:adf:dd92:: with SMTP id x18mr19566913wrl.311.1608568170654;
        Mon, 21 Dec 2020 08:29:30 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:29 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 3/7] bisect--helper: retire `--bisect-write` subcommand
Date:   Mon, 21 Dec 2020 17:27:39 +0100
Message-Id: <20201221162743.96056-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
References: <20201221162743.96056-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-write` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `bisect_write()`
is directly called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 92c783237d..896c54f869 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -1036,7 +1035,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -1052,8 +1050,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1090,11 +1086,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		return !!bisect_reset(argc ? argv[0] : NULL);
-	case BISECT_WRITE:
-		if (argc != 4 && argc != 5)
-			return error(_("--bisect-write requires either 4 or 5 arguments"));
-		set_terms(&terms, argv[3], argv[2]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.29.2

