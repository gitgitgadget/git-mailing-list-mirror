Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48130C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01F564E90
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhBXTLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhBXTKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:10:13 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CF5C061786
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:33 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id w19so3219814qki.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=UgG6U4+vozWy4Dt23RPO7ruKy/fFCLCI2qlcwYXdFT/0f30Q1PBm8+4uN9+bGZMeNJ
         92KUWt4Q6P/GJR/AtOmEPV/Olm4J+B/aO5uT9+lgyjaysL9IzxuliC+u6efOJARCHXGW
         S/DmgzACoVxziD7NAwTnvWodgqH4kIl05uGU7H7GRC176CbI4iv1vy/6eWDK+9HtURxx
         Er+jfZVzwQH8ONeOCT6yL1lQZhTVDCYCfKVN0llazbTBNRBvZ+0SSmo0fhutarVPqvUu
         fvnFDpFripNDLDtGnNWnEnj9tlPt0T87OAJLSsG/dqDnth6GLA96sVydoK8ek/wuOfYK
         rfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=CIuwOcUiqDjjLT4lbgHGZP6WTe9lVHFbcNHjFwymRv03/f+F78OijgiXRGRYufAXbI
         hS+Le60uNJTq+MDOd+oWgomiDj5LQ2/q2BxBHmrO9jhQynmwNaH11ThzZAQoIMOwjxdF
         b6g5GfF4bL18U7VJUQ7A3cgrIdsZPYcxOMzXNaHMYbFdp7hjgaujEIONOZP3QbcbkK/M
         NFMaNAMNLkioa5kVhUy1TwivNyn4Un3aLQzfGyIXQpYwq14/3N3rgEetnC1SICIX9a/m
         wxTOmeE7MJcbA5aaFC6X0/GpDhrAMue24pAQUmK/u5BeHcHi9IJcU1ptnjkDjMhkSbad
         tsUw==
X-Gm-Message-State: AOAM531js8KV/0VH71DZ1fRsVp6iQklPmeSsARFWY/SmhpsGB7xW6SOb
        Y0UU5/83YrBXhSGA9wR1y24lYCyzTRG7g2eg
X-Google-Smtp-Source: ABdhPJyIFVM8WoANEl8KDoE1VlqjwTdz33Gn+rLMa5jqWt1Pbubw5Zbt5RrpB2av5qVU6tQd60MhSw==
X-Received: by 2002:a37:a5d0:: with SMTP id o199mr32416978qke.388.1614193772426;
        Wed, 24 Feb 2021 11:09:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id p10sm2187909qke.92.2021.02.24.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:09:31 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 02/15] builtin/multi-pack-index.c: don't handle 'progress'
 separately
Message-ID: <a4e107b1f8308b9e8e779e31fc27dcbc082ab545.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that there is a shared 'flags' member in the options structure,
there is no need to keep track of whether to force progress or not,
since ultimately the decision of whether or not to show a progress meter
is controlled by a bit in the flags member.

Manipulate that bit directly, and drop the now-unnecessary 'progress'
field while we're at it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 4a0ddb06c4..c70f020d8f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -13,7 +13,6 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	unsigned long batch_size;
-	int progress;
 	unsigned flags;
 } opts;
 
@@ -23,7 +22,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
+		OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
@@ -31,15 +30,14 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	git_config(git_default_config, NULL);
 
-	opts.progress = isatty(2);
+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage, 0);
 
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
-	if (opts.progress)
-		opts.flags |= MIDX_PROGRESS;
 
 	if (argc == 0)
 		usage_with_options(builtin_multi_pack_index_usage,
-- 
2.30.0.667.g81c0cbc6fd

