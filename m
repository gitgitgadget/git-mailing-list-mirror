Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB67C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9896F60ED6
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbhHEHUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbhHEHUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:20:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984DEC06179E
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:20:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l19so6782137pjz.0
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+6OCMo+DlGa2QWoBAGf75KRxMzKVKH6/dy+1rWuxBU=;
        b=BGmcfAtzdJWICbC9IrGyAExp1EODVK5J6uFLNn6oadhz82fU0MWGQGAUq7eYGifHpD
         PqMN61lvoU3l4lyhy+yOaYDSxUU229JkqHqcTsqnK+XYUzpkyzogCfN5V9l8mWv8DT3s
         o0RF0LTbBHV17dJjQ08hb1HkgoaG4hq1Ogh4IJ6dcG0wAFHwid4vjQJzePp1UBiGBTr1
         ANysse5IGIx0xZlpxooKc5q8wGEeIuq7kQtl+TeQXT47zxmosxG0l+SkxqElvlYffil9
         Gr8rnbazbGzRlB5DSawCdiud8RYozkHRslWjBdUE6+SjImNqsAiUuzefE0ugyWVXjQ8u
         AkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+6OCMo+DlGa2QWoBAGf75KRxMzKVKH6/dy+1rWuxBU=;
        b=X9S32YQq4693Y+o4nqk6GHv4x4SV0XIzZ2NHXlKaV/Eo5Vh+diIPRi4TjXAtKouas5
         Swymv5YFRSkqLabljfn4zbSbFCQY8WL2w3l7S8iIOmXJ2uqddc3ySmGrZxvzfufkpft+
         oZaU2o6QBnCt3Al+oBJNzqOp92MHiCFB0Js/ufvWUHMYz2ufNSz4bTTUgkldniRTRVlH
         oJC53YJ1jBZS6nhaaAGuIpsZsuRmdZpQoT4G/XnWVnxozPWz12Ua/bxY1pVBMVd2jnGf
         ntVCz9LkipqC2Pjcf1hyomqwmoAj8n73SbqCkYIvHd9Zf7sz2uXLJpPyNhlChQ2X85js
         gAcQ==
X-Gm-Message-State: AOAM532M4s/7/A43UdvYK0cS+l+cOeSj1FQyH++Ao4ALh9FvGDl5myCT
        +og+hPRkLFBO0A3DUXmtm8Tx8sdLFSNNqzxo
X-Google-Smtp-Source: ABdhPJydPDAMdBx9Prd+WaqF1aBqr3m9WRiqa73uuqlW7D32/KDdn+uy6+a/QudFmUjAVd5lRjyUWQ==
X-Received: by 2002:a17:902:8ec2:b029:12c:dc6d:4e31 with SMTP id x2-20020a1709028ec2b029012cdc6d4e31mr2785896plo.80.1628148013037;
        Thu, 05 Aug 2021 00:20:13 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.20.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:20:12 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 8/8] submodule--helper: remove resolve-relative-url subcommand
Date:   Thu,  5 Aug 2021 12:49:17 +0530
Message-Id: <20210805071917.29500-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell subcommand `resolve-relative-url` is no longer required, as
its last caller has been removed when it was converted to C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index da83e8e2a5..514891a22f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -223,25 +223,6 @@ static char *compute_submodule_clone_url(const char *rel_url, const char *up_pat
 	return relurl;
 }
 
-static int resolve_relative_url(int argc, const char **argv, const char *prefix)
-{
-	const char *up_path = NULL;
-	char *res;
-	const char *url;
-
-	if (argc != 2 && argc != 3)
-		die("resolve-relative-url only accepts one or two arguments");
-
-	url = argv[1];
-	if (argc == 3)
-		up_path = argv[2];
-
-	res = compute_submodule_clone_url(url, up_path, 1);
-	puts(res);
-	free(res);
-	return 0;
-}
-
 static int resolve_relative_url_test(int argc, const char **argv, const char *prefix)
 {
 	char *remoteurl, *res;
@@ -3115,7 +3096,6 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

