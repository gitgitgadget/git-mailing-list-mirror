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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6864C433E7
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F46D2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7LEQ0tH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbgJJW42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbgJJTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:51:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF1C05BD1D
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n6so12901058wrm.13
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ry2Nic7X44QwUp8dpyBfKV/q50SF+ZOMBjTfmjN+KbI=;
        b=b7LEQ0tH9Ksf8d/Zk2MtWMGnRI13B/XJJOhXEJm0Q7FSeguzEko9F8OCJHAOP1Cxym
         hOhKEwo1AXX6VtmE1H9+QngTNO4navTza7H4NK7h2mykEvlGr9d4pfN4kP1YTyiF7ZAI
         NiPMxHpT0UuUA8IKGgVHCpzRe4fAcABOoZxhG3bbPvxdUY/1wOt+vu/OLIzDNChAWJsr
         J61gAe9HjvdRkHw3ky2YIUVyBvOJvfnPGAue173Gf5qiB1Ae1Dk3axGX3W2wse5lmZzR
         R/S3KwsvyQm8LgoLKBUvTHEWE9YUKMaDh4VKSsfVe6qhQUHDhg4dr3TwBfuxR16137t3
         M4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ry2Nic7X44QwUp8dpyBfKV/q50SF+ZOMBjTfmjN+KbI=;
        b=KEJyhlyz9jUq1TpjhEY3v7VjapCI5eOxPPjrwMaqQQgON6mdjzc3ORjo591Q9kT+TR
         jFndQOR48fohEmKgyEThHcG9EtzPZY7t49VB78tK8aib275njdAhrnP5agLVko7YUBNq
         OC60BaOkU0HD8rbePM5YgDjVj0gzgGqiCIkXm2N4OQlRBsV2+4RFJThRxnv6lKP0t1oB
         3+LIxWYybaemXyHNL2Cktxxny1CLV4mySpMgpDQnqUIfD3jhpun3jFeDcWOJk1rjXO9h
         8zdrixPqwdbcC/Tc5liSQDktBiOSJBSalmrCeveA+EVk8ybTwgfIGG5XXmd0GArWD9R9
         pYlA==
X-Gm-Message-State: AOAM531iWg/qPduhI1cSHyNfXqMqD9yzJwsYArYzDf6TqZrbzN1WX6ku
        vKsy58vbejevpE82TPIBvtCCpMSpqGY=
X-Google-Smtp-Source: ABdhPJxN4/hg9X93bpv470MspZFJfQelB7lAsGAjZ3giBfjtbD/FJiHcZjembQfaRb69q/4kx09d5A==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr18902399wro.291.1602338942563;
        Sat, 10 Oct 2020 07:09:02 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.09.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:09:02 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 7/7] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Sat, 10 Oct 2020 16:07:43 +0200
Message-Id: <20201010140743.580-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201010140743.580-1-mirucam@gmail.com>
References: <20201010140743.580-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-autostart` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_autostart()` is directly called from the C implementation.

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
index f90b3efdd1..ee65f97079 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,7 +29,6 @@ static const char * const git_bisect_helper_usage[] = {
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
@@ -935,8 +934,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -996,12 +993,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			return error(_("--bisect-autostart does not accept arguments"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.25.0

