Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB2C433E2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7052A619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhC3PEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhC3PDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:03:50 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E717C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id c17so14423974ilj.7
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1QN5HZPQsaalWIjksNlL+PaFtD+CqOWNvSTPU6BixXE=;
        b=GFl5fm1MQdX+S4CUQRTW4xAN+DnNGDAZIBHc2cHbLrigmjZgpieKZCH90H0Fwws1pk
         hU5ZapY69ihC27hOY15iKDNTADT2t9I0UibTSnhg3p8iVBTzLgmfRgSiijj0lm1wkHY0
         czXVBtGwUPd4sw9yZE+0w+TNkfUSXsjo/kiPp6ibUSecA/AgHyOyGUlv0HpCkyd+9Q26
         KFBSaBpNXA5R5ak4GH0fL+Tjoy82V0KSyj8aVzr32bjWHTjdEWY3cQFcMwyWQtRC+n3p
         Z399Bks2cHhLH4ehT4pyOKOsHw5HCDXCJYgC3h/yFg5aDEEONrYL0+w2xq0zcOb3Pzs7
         9HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1QN5HZPQsaalWIjksNlL+PaFtD+CqOWNvSTPU6BixXE=;
        b=emSoPrDDG8mcvKalb/6qehhu0eXClr+EMRlRqLpCeWmyvhVmuevO4B3gg6uesEaYXs
         y0VvEW37nKL5eWhp/AZ7ZrwyqN5bfKiZbEVsZb/1wsJIv3S7O3UQ+2RxPgvIS2Ux8OF0
         OxGECDu0FnjeM9xlVXNP8WwFXw6FxuZSc16vicwbc5COX9ufZGNhFZ6uTKOCIu+1Knhc
         yCmn8bW99m8knFeGu0JHF9m0Vv7tUjH6y/KThOuDf+FOWQOh2h/bGQGX454zfD19HZYU
         /WxLv4uQ7oXkmxuwwTi9V5PJbMIplAT2oam793s41FFBhqZayN5/hcvoetyrqXI30MsM
         7onQ==
X-Gm-Message-State: AOAM5327FpY1kw5j/JFZqEOCd82dTvH4X0Ud/qFHNeU1uXWGG5iRo5mT
        wLnHP8uYXThN7ZZlJIqkSyCIJHArbyhBhw==
X-Google-Smtp-Source: ABdhPJx5NSQDEyRg04nwAYFmyS4ICt1wLW7ZCtCAupQ3Lx98fZt/T+nPqqGob76S++ZNwAJl/uCCZA==
X-Received: by 2002:a05:6e02:1068:: with SMTP id q8mr11651363ilj.181.1617116629351;
        Tue, 30 Mar 2021 08:03:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id v17sm11169030ios.46.2021.03.30.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:03:48 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:03:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 01/16] builtin/multi-pack-index.c: inline 'flags' with
 options
Message-ID: <90e021725f3aa26355bb60c48da754af2e00f049.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subcommands of the 'git multi-pack-index' command (e.g., 'write',
'verify', etc.) will want to optionally change a set of shared flags
that are eventually passed to the MIDX libraries.

Right now, options and flags are handled separately. That's fine, since
the options structure is never passed around. But a future patch will
make it so that common options shared by all sub-commands are defined in
a common location. That means that "flags" would have to become a global
variable.

Group it with the options structure so that we reduce the number of
global variables we have overall.

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

