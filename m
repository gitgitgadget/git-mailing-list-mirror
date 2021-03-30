Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A20FC433E6
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1284619D1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhC3PEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhC3PEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA758C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id f5so5516185ilr.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rW7H6IZO+GEGW1/HLiB7yGIpc3CLRlYYI8aYoAjVwcs=;
        b=SLizrfkh/CvsAocLNd42rpjnUP269zBx+0cUlTb/ciuLPtoZBsTK0n4A5HqkTFtxds
         +aLWlhh1pr01yrHFM528dDR5+w2bR6CE8s0hq1GcUau/TsPVA4o1iM/N1xEQ4glrTdUK
         TS3RDgexJ2D0TIENEm8xkB+0NOKOFYdOtCrz5tN4L/gTBeux2+pe9IoiVOBOrP6af6fx
         ErLKR4TQNOPVpkzU0jLO/T7tjSxi5dfdns2nVkTypGWOkxRVgpwmohGtlIpSPJ4k0Moy
         NU2HF9BU6NtDbB536jYCCYI/Ztd+vy7MPLfhylhoJvFK6+KnqRjQE8gJc0g7GVj5SbEu
         wnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rW7H6IZO+GEGW1/HLiB7yGIpc3CLRlYYI8aYoAjVwcs=;
        b=kZginBZaxpTPniAzhRaO7oAzCwXxNsW2ny6GVQ9HYhn/Hda1Hj9axGLnLv9GTceiJy
         YlSIplgk98rc/z2BW2uC0AKB/0Ug16rhY9Cbu7VevAmcz7+citKMOV4LY9oBfXSzgBwP
         qVtn3IKustw9ns9zV9r+CIWhB6ZXwhrDCly/efZ6K2oP9u2EjxdAsGqz6WCyd7GvOUOl
         7xGTr9YZCu5kPsnpUJjrhcjR/fZ+Ehl8nvL+DF7fBA3kgb/YfdNAsr77Z4e6WRqN1XXv
         nTySaSZk9H5QNP4sktEjKJ3/LNliGTXJXyveEeirmClkAtbfJ+PH6Sl1fBm0WQQny8oL
         gi0A==
X-Gm-Message-State: AOAM533GdTgtPZDQZ++1j14RESFvSojXCx9jx+9QM4rlr4N9aEb8qll9
        myYtO+QI4s6g8sy7LPZkXtcQweOxE/H5Bg==
X-Google-Smtp-Source: ABdhPJxAarrl82ynir4uCT0QDODAuGgA76cuzdrbIzF94U8TboZGCs5X5U+QMGMWky6MTAr6A9FvEQ==
X-Received: by 2002:a05:6e02:152:: with SMTP id j18mr25650745ilr.302.1617116643163;
        Tue, 30 Mar 2021 08:04:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id q12sm11675206ilm.63.2021.03.30.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:02 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 05/16] builtin/multi-pack-index.c: don't enter bogus
 cmd_mode
Message-ID: <d817920e2a66d6509d39e645a7c1975af090f05e.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
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
index a78640c061..b590c4fc88 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -63,6 +63,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_write_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -77,6 +79,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_verify_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -91,6 +95,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_expire_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -112,6 +118,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 
 	options = add_common_options(builtin_multi_pack_index_repack_options);
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_multi_pack_index_repack_usage,
@@ -147,8 +155,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		usage_with_options(builtin_multi_pack_index_usage,
 				   builtin_multi_pack_index_options);
 
-	trace2_cmd_mode(argv[0]);
-
 	if (!strcmp(argv[0], "repack"))
 		return cmd_multi_pack_index_repack(argc, argv);
 	else if (!strcmp(argv[0], "write"))
-- 
2.30.0.667.g81c0cbc6fd

