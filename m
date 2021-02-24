Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50037C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B4F64EC4
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhBXTM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhBXTLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:11:12 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F3C06178B
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:45 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f17so2271218qth.7
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eKdnafm5TaJHG3wh9UuBGQ6K2jl+EAntVsZyVYWA1wU=;
        b=cyWP9bb+I5HLCAksb3G1qnanogTq6u11TsmOejWuuqU6+oeXZJYD0U/ltXHPP3wACG
         yY2CbdgXj6ySLiUCNNcP9pmX05rBOp4GwZfvhzz5Ixy5zaOMHsZM7WXbRH2oqD6VwKyi
         dBhScbUYJsM4baJ6rSURsLmYlWh65FHMc4dbbzMieevh6rh6Ovx1rWMVmoze5hiHEr02
         tsXS73eiRwhQMegkPSnD9s5MmBKhufOfktjBS4eglrNpnmXjLeRJN+vGCvjxbyD4UzRM
         98U8XEriij9sCdWv2n2mzznpFfMhak8v3a6XjIFVMEr2ciU58HAFn7rywI6g0QVamb06
         NmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eKdnafm5TaJHG3wh9UuBGQ6K2jl+EAntVsZyVYWA1wU=;
        b=nRNt603eqccmvzgKUna6N6UWldDZIc6oK2glyWRTuTADiydwhEiQryV3WrYQEUeGGs
         i9dry/VNWefuW1yvx52VWVBMuYZgPJKBCjbD46hZAouRrNtecfeBUTr1XYjKGhoQinD4
         1q94Gts4a5YhGHoLfDZAVSTSleb8Qpg7JpMPbZDqgRi8DIhdpwa3SYJl+2OKQANgjFHU
         lgV5VD2cZ/Yc40USkPkLHSp8lFc85ZTqlj7cMPaer5yo/F0jZlBCLlrtTxiTOLl7z+PU
         nbwQ1Qio8ws4IJtmufYvJAe3W1gZah/VSh0g8i2oQuUhV0MkPffi05t63nAMTBUKvKsK
         wTOA==
X-Gm-Message-State: AOAM530fRiZ4OiphqIMZxlvDaFxOfsswIVUbo7OjIMfjbo3pOIWuDG3M
        RUU5yTIR5Z2wBmTBi+ihorsiJYYYleQzpta+
X-Google-Smtp-Source: ABdhPJxqsUBdOBaXzPcfCl6gC+nRvwjd9qVfKIT4popa6jNxSGI/GCFDySvgASuzS6UpCc/UHvskqA==
X-Received: by 2002:ac8:3734:: with SMTP id o49mr14334594qtb.376.1614193784478;
        Wed, 24 Feb 2021 11:09:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id k188sm1425001qkd.132.2021.02.24.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:09:44 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 05/15] builtin/multi-pack-index.c: don't enter bogus
 cmd_mode
Message-ID: <5daa2946d37b5662274f5565ec35ef4d169b55bf.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even before the recent refactoring, 'git multi-pack-index' calls
'trace2_cmd_mode()' before verifying that the sub-command is recognized.

Push this call down into the individual sub-commands so that we don't
enter a bogus command mode.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index caf0248a98..9fdfe168c2 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -65,6 +65,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_write_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -79,6 +81,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_verify_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -93,6 +97,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_expire_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -115,6 +121,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 	options = parse_options_dup(builtin_multi_pack_index_repack_options);
 	options = add_common_options(options);
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_multi_pack_index_repack_usage,
@@ -148,8 +156,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		usage_with_options(builtin_multi_pack_index_usage,
 				   builtin_multi_pack_index_options);
 
-	trace2_cmd_mode(argv[0]);
-
 	if (!strcmp(argv[0], "repack"))
 		return cmd_multi_pack_index_repack(argc, argv);
 	else if (!strcmp(argv[0], "write"))
-- 
2.30.0.667.g81c0cbc6fd

