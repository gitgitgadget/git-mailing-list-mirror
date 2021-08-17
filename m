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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF2C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3344861076
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhHQIQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbhHQIQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:16:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6915C061796
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so10172899wrn.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps8XQ6/tfGW20fP6zT9xStDCFQFc67Jxvuu8zJ63dDs=;
        b=ds/kEgkBAOQpyx3d/84Mns4z5WX3RSHc9nni3FOW+BzehA6LRaSG52BsMUARTWbcES
         DJRGxqtu2v3Iqe2Zm8xP6vxBGyI6tdzH1UGoxMkD8uY2vvWqVpeuy2JVTrtKbcUrTZbN
         S6CxwwXUvLnxhh8cu/jWgUZDh/APoezfU+DrAOpETABeqyz2Fx8IMmLrf8d3hLtIhGpV
         Y3GRffpRZElUYnsd+UyDFhTsxP0G2/GekuIOFLsheSGcMklz/RtH88r6jQB5NFdcyVyg
         lFIYcwCLNyrKQ23PIlvEhivujMZLKSqp/wFxC/PbmAi4HPwlSvjsZgM60I7/GPVOk6l0
         NS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps8XQ6/tfGW20fP6zT9xStDCFQFc67Jxvuu8zJ63dDs=;
        b=EYDOLvumA6MGjHm+Oj60uqXtbDHv7zMNb5JFolmZY6LiwaR5TBcy8Upar0HNFWaa+L
         PMjVIEb8Mouh8KJ+FeMfsT9IA8ZtM8Siv6X8Eyhnjbwj0kuQP25cSez9rIFZJNluUuEr
         sHR7rxhvETHkFWXXWnLTHIPnKvdFJbueAUF1cDGvgccPfI2+nsrDsOCHvD2fSa6gAsha
         jldtHyAJnpluX6cGMnNZ8ue108cPsDYG2Inf6TFHuAzWlOR35W7b1wAZalUNM/VhWexs
         dFL9oUqYI3Yz3/t4+pM+at/0Pb+KtX9xZh+d+YWwbZqMUnOUKIZpzN0LYRvQRlpp2tjB
         NyJA==
X-Gm-Message-State: AOAM533fhpm5zrCMREn4dNLURSPT+4I7LGkr4M/zyDFOfiQ3+ytcDnf2
        aCJNJOu/685B586E888xZzgg+i2NAhc=
X-Google-Smtp-Source: ABdhPJyQjihlQTedpRGx0a1K9SoP8mfhamv9BhKfTDNr+fIGYQSnqV2Wm8G3HmCiYtriB7PAILCZ5Q==
X-Received: by 2002:adf:f047:: with SMTP id t7mr2448311wro.337.1629188157425;
        Tue, 17 Aug 2021 01:15:57 -0700 (PDT)
Received: from localhost.localdomain ([178.237.233.111])
        by smtp.gmail.com with ESMTPSA id l21sm1256238wmh.31.2021.08.17.01.15.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 01:15:57 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 6/6] bisect--helper: retire `--bisect-next-check` subcommand
Date:   Tue, 17 Aug 2021 10:14:58 +0200
Message-Id: <20210817081458.53136-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817081458.53136-1-mirucam@gmail.com>
References: <20210817081458.53136-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After reimplementation of `git bisect run` in C,
`--bisect-next-check` subcommand is not needed anymore.

Let's remove it from options list and code.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 852e0a30fb..d749747639 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
@@ -1200,12 +1199,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case BISECT_NEXT_CHECK:
-		if (argc != 2 && argc != 3)
-			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-		set_terms(&terms, argv[1], argv[0]);
-		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
-		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
-- 
2.29.2

