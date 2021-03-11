Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11955C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF7364FF3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhCKREu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCKREk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:40 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F8CC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:39 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id v14so19535201ilj.11
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWKQAPQYWkmrYzu/165SRPVqylKwo41lj7IqdytbI/E=;
        b=vQnWt1VmJLAQnnlHKE3s5ICcJwh7wiQFZUXwcRxsM4dDhmLuVFgB8pAlIGeLGphMqT
         nDZQX3Z5nHm09VU1XPLSaHSHjn2GclOwXDhW4OnHX5gxCgtB190Lm1Ji1oMuKMILT04F
         TaJHcFIBQFEx6M8lAS21rLIZ0HtAsrVB7ODn7EifoK5Yqd4e2So1/TFcMTbGsTGs9ur6
         yGwZkRGjsAp5HWETmVUnV57nPDlPpeijmLaXdKGRuXfyKNJUU/HDUj1jzNA+jjBLzzs8
         I23nf+qjanSXSWhdC7q9DvIjBZO+Chou7o0tlBkwgE0vtaBxjGnL/6ipE7B58yOSzZuy
         /E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWKQAPQYWkmrYzu/165SRPVqylKwo41lj7IqdytbI/E=;
        b=SBQHuyZ/0slXX6MCopdqxl0GnimsOnrjMF+qbT00Sd+4GprbnAxSVDV/NJ/sREHVoO
         lCADdBw4ftJFYsQNDNsHEWiG9r8H5eOb2bCq5UZCeVXyNYdw6UcJHjflt0GyLPX6uxBQ
         lIMocFCmYddXIP2mzgZmC23VE+aLctxlfwPfV6l4cJy/0XQnnNOqnwwqlsbN9mUzBarH
         paX1IhQAoyZWAr0orS71WSjkH11ZKW+S/qVrrI9mOz8UNBLYjgAwpuI2N8vsDAFBmwsv
         iSXnlbAt2rdOJRdgPdXQpI8irG75Qex6bOzLOPf4M2WtXxspp5yoUx34wFhoWyP0R19D
         xYoQ==
X-Gm-Message-State: AOAM530mt41GTnhcIdQCseUSmVy/eygDOrFeEZ0Ca+UcsWqHFG774zGz
        uqopnznpKUdwb0LKNSeiq/+afnX6BfCEmA37
X-Google-Smtp-Source: ABdhPJxyag3CS84IOOrdiiRK195g2Kev1tB4re2LMwCMGWMp7edscR3cd1PLU5y1RcFobNnuAinjdA==
X-Received: by 2002:a05:6e02:1d85:: with SMTP id h5mr7971751ila.246.1615482279059;
        Thu, 11 Mar 2021 09:04:39 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id i12sm1586348ilk.46.2021.03.11.09.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:04:38 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:04:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 01/16] builtin/multi-pack-index.c: inline 'flags' with
 options
Message-ID: <43fc0ad276406ff77283613c45188e102a6dc515.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subcommands of the 'git multi-pack-index' command (e.g., 'write',
'verify', etc.) will want to optionally change a set of shared flags
that are eventually passed to the MIDX libraries.

Right now, options and flags are handled separately. Inline them into
the same structure so that sub-commands can more easily share the
'flags' data.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5bf88cd2a8..4a0ddb06c4 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -14,13 +14,12 @@ static struct opts_multi_pack_index {
 	const char *object_dir;
 	unsigned long batch_size;
 	int progress;
+	unsigned flags;
 } opts;
 
 int cmd_multi_pack_index(int argc, const char **argv,
 			 const char *prefix)
 {
-	unsigned flags = 0;
-
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
@@ -40,7 +39,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
 	if (opts.progress)
-		flags |= MIDX_PROGRESS;
+		opts.flags |= MIDX_PROGRESS;
 
 	if (argc == 0)
 		usage_with_options(builtin_multi_pack_index_usage,
@@ -55,16 +54,16 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	if (!strcmp(argv[0], "repack"))
 		return midx_repack(the_repository, opts.object_dir,
-			(size_t)opts.batch_size, flags);
+			(size_t)opts.batch_size, opts.flags);
 	if (opts.batch_size)
 		die(_("--batch-size option is only for 'repack' subcommand"));
 
 	if (!strcmp(argv[0], "write"))
-		return write_midx_file(opts.object_dir, flags);
+		return write_midx_file(opts.object_dir, opts.flags);
 	if (!strcmp(argv[0], "verify"))
-		return verify_midx_file(the_repository, opts.object_dir, flags);
+		return verify_midx_file(the_repository, opts.object_dir, opts.flags);
 	if (!strcmp(argv[0], "expire"))
-		return expire_midx_packs(the_repository, opts.object_dir, flags);
+		return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
 
 	die(_("unrecognized subcommand: %s"), argv[0]);
 }
-- 
2.30.0.667.g81c0cbc6fd

