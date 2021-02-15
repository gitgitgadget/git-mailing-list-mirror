Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BCC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B7B64DF0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBOVCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBOVCW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:02:22 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF70C0613D6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:41 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id q85so7604401qke.8
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWKQAPQYWkmrYzu/165SRPVqylKwo41lj7IqdytbI/E=;
        b=gqVBjixVZoA7qFSxjeWYgtBmGobSkLWkQCH0h7UQOq33iVFJ3dur6NCQEkAmtam9Wy
         WYD6g0IwMhhHQpDfcVoQkHDzow2EiFeIwE90WamuWr0ccP3UmI3GKI1NwKFocY7sYDf/
         4uojnvkCoEDAxhfAKsCmtn3ggEC6zHk7p5rxk/fdiFrcQeogfjyUc8tDczI5GEF9pyTR
         sCaY6iej/2pqk9mo/pTdKkGY3vIdfiRnBZ20vhx0EzZM9flIfs2QN1Vw+pT1R02dbWsx
         wa/xPWsLegqCXvwjpHPgBIHkecxMRAN+ubaOs9Z0KzuLf4N33LE9cW8B6QYB/c0AbXXh
         vb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWKQAPQYWkmrYzu/165SRPVqylKwo41lj7IqdytbI/E=;
        b=JbtiGvIj05ndUUUBFsEjsgqpghP2uyi2zzegOE4gyMHlXgG0hVXzdzDM7gbtxPNX44
         kVBG1OrXBaUCqdPaPSJTXI7LGjepcdQuid/vmtCdGKh/hAQG6UQ4Qq/YfgqtAEXI/Ppx
         EpoXWRaejk8f8ej7twtCsNDGBjS5Od+JZ86Y5rMt13WX4JUA6/XhI2uC+3t3VKt4hojZ
         Z0ICF6QFhDCYxvgbHjlqrne33x1EuBHNOltvh5Lae/JVkJBfm/zWwZlW7BgGoM0+Ra7c
         XhD9WtTDPBD31idbs4yO/5gQ1K/nvlu+Ert5qvLUc+y5zEXYltQierYlAPKda3ooQWBp
         FOMQ==
X-Gm-Message-State: AOAM532KPpCrUHGuuttl8TNnylJ+wykvNxagwldJ2G2ymqEAXjkjnhpq
        G6atY6ePn8HIVtRudPSaI6xH8QXPumf7HP4E
X-Google-Smtp-Source: ABdhPJxr6VGbfYoaZYRAD87srR978/5VPD53JYCbnfI2kNHoSQ9sGwEWc1xJGfIFuJs6Y1BeEsg6kg==
X-Received: by 2002:a37:5d2:: with SMTP id 201mr7283310qkf.263.1613422900865;
        Mon, 15 Feb 2021 13:01:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id o17sm12155343qtl.47.2021.02.15.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:01:40 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:01:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: [PATCH v2 1/4] builtin/multi-pack-index.c: inline 'flags' with
 options
Message-ID: <15c5acf3e03337f9b04b4c99591fb54dc4546771.1613422804.git.me@ttaylorr.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613422804.git.me@ttaylorr.com>
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

