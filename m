Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF43C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C0A64E24
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhBXTLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbhBXTKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:10:09 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC89C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:29 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id h8so3278326qkk.6
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWKQAPQYWkmrYzu/165SRPVqylKwo41lj7IqdytbI/E=;
        b=1twOEUAEhSYuZsx4NN2ScPgjWw4aShsFeWPg/hTTvLcpE/4SKReJ2wVwnzwH+LF3xc
         yTBiYeP2fYzjyAG3vlh74xIbO+n3wMe5iHo69AcEOXQQ42QW++mkYOiOJzc6/xh0Speg
         CBDT5zonMJCc8QSNquR9v4GkBOxLSQD8vJEscf+Ekywxho7w1NGfMh4KKe5TJrUADnHz
         6YuMcGAgdr8ASiqkNAY2sKJmJ0CycdyZkVhyAho2M9zmyvMYFPVdJiqmxFFwn7OKx/cC
         y7q5EWVL+jibbM3ib8rphw6Ol3IJQSysYMwHI0moU00h6lpNtG/1iEeBLRK+aY2Rbydt
         u01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWKQAPQYWkmrYzu/165SRPVqylKwo41lj7IqdytbI/E=;
        b=BUjA6KuQgoGpfyQcIEjiqs4viCL2+4mypar72ZZD2SbaqhKw0dKsVozSMjtkZS5vT7
         KqDnsN9pJL4Fz3RCIRK9Sn4i3wJ01uUZIlex1i8OXlce3iYEKzs7e4LL0Aa1zGb2W7nH
         dr03GiSamTz9lFR6vD3i8ofmgMIN490BE11DY1DQ/iMGw/798VdALuPct+tSUupkO246
         RsgACij9wI1XUYwpxIykicCRmqHJtsSk+OBuRzmyEO1EGaxooxNRl5RPthHgXlcKsoO8
         aRkXU+gwEznBDHPJGwMT2xddhi8jxqD2f5ijIy1/aplFBfpmzllXLQvlxYnv0o4ni0yc
         sjZA==
X-Gm-Message-State: AOAM530uhYFLqYq+caCr2dcumOuPnJjCxaM9xHdyl7duVXWe/6Qe2utU
        kkfOYimcOUKI5DFrRr738oAmxhOcXwvmmZ9d
X-Google-Smtp-Source: ABdhPJyH9NTcIThwybz9vMkhCufEVcsB2PIchGSMlJAxnuhrC3J6LwzcLYYHf0J9YMVOuaz5pofs8g==
X-Received: by 2002:a37:9f86:: with SMTP id i128mr7403130qke.20.1614193768385;
        Wed, 24 Feb 2021 11:09:28 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id q73sm2146438qke.65.2021.02.24.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:09:28 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 01/15] builtin/multi-pack-index.c: inline 'flags' with
 options
Message-ID: <0527fa89a9a8a44df4d046f4efd04fd9fc23bb91.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
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

