Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A1C67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiJXUdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiJXUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:32:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B718F939
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:43:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q196so8467704iod.8
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/dL4sCAfbPzlbOiVTltJixLzyuh6c+CBRIy7LnDcjc=;
        b=HCPoauLyMmDhAQTWFTfgusu3FgrXSjBcCmGM/hAAr5VlKYMDYKwFJw5UnZu1EUyr4j
         AItvCqhjX9SnaN40oCwfxVMC9U0+wo3L2s/cA2ibwf5rYxWAlbyz5JDyObegwNXwppvy
         B7p35J4Yj+rCy+QjFP6ibt2jZOmdtLsarPdwZt+GcnGT1oF9wZDviI/Zbo8CtHj6juag
         6ist3oZTYPwO4Famvehr7KlNBmO9GEDt/TgLH3qFnSQoAnoaqmoWpmETWTipzvMh4tQP
         TzUJuXxi6DrqiMoK1sGqhq/g5CdjmRkGVWPcENBQOujYkLiDyR5nfYUouOdvJEr4k/dL
         udJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/dL4sCAfbPzlbOiVTltJixLzyuh6c+CBRIy7LnDcjc=;
        b=cx9S//Xmp91SOAzYyZVa3TCENF1LwdLDXCJiV70sPl43CWRdAgd8sQh0zciuPFj5qe
         WtoN0q3JevxCkpCMCUDJ9k2qplVsFGULAPVuI/gTfEsOPryKy5K3jzfgEGDLmGUKVAnV
         VCFXtPYE6KgvL72X0IkQhQqq8R/IAiS7UUUj0m9Y5ykTP5nmQ3GUwFtwu6uQ+hjtobPU
         BDWEYtQeo9Ms9Ey1JXFVK2YDat2iXC87TYJN0HAxCR8a5Bco8n5afI5rIuMWGsmOI825
         bvPpqU7D9v/CIXlPr7Rli2zaN/wGNvvzKCq9xdy9KWQJK43JbWzOO2P1uBYgBAOzzVBj
         T+uA==
X-Gm-Message-State: ACrzQf3G51C99FHC8KUh3mboTl7LsWjh5XO/H+bt9epq2brqr5daXax0
        Hn2ByytteDsAc36ZGj2sULokz3+DLVIWPdGk
X-Google-Smtp-Source: AMsMyM700ansgdCGOB4yx9k48ogGuwAk/7jehdYTXDqJ/sqcgga6Tt9ECs0nzQndfi4k1sfty5nVEg==
X-Received: by 2002:a05:6638:430f:b0:371:667:72a1 with SMTP id bt15-20020a056638430f00b00371066772a1mr6217328jab.74.1666636984682;
        Mon, 24 Oct 2022 11:43:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g13-20020a056e020d0d00b002eb1137a774sm222613ilj.59.2022.10.24.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:43:04 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:43:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/4] builtin/repack.c: pass "out" to `prepare_pack_objects`
Message-ID: <1dd4136f6199ac050cec5eb671c36ae05fbf3bdd.1666636974.git.me@ttaylorr.com>
References: <cover.1666636974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666636974.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`builtin/repack.c`'s `prepare_pack_objects()` is used to prepare a set
of arguments to a `pack-objects` process which will generate a desired
pack.

A future patch will add an `--expire-to` option which allows `git
repack` to write a cruft pack containing the pruned objects out to a
separate repository. Prepare for this by teaching that function to write
packs to an arbitrary location specified by the caller.

All existing callers of `prepare_pack_objects()` will pass `packtmp` for
`out`, retaining the existing behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..0a7bd57636 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -188,7 +188,8 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 }
 
 static void prepare_pack_objects(struct child_process *cmd,
-				 const struct pack_objects_args *args)
+				 const struct pack_objects_args *args,
+				 const char *out)
 {
 	strvec_push(&cmd->args, "pack-objects");
 	if (args->window)
@@ -211,7 +212,7 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--quiet");
 	if (delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
-	strvec_push(&cmd->args, packtmp);
+	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
 }
@@ -275,7 +276,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
 
-	prepare_pack_objects(&cmd, args);
+	prepare_pack_objects(&cmd, args, packtmp);
 	cmd.in = -1;
 
 	/*
@@ -673,7 +674,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	FILE *in, *out;
 	int ret;
 
-	prepare_pack_objects(&cmd, args);
+	prepare_pack_objects(&cmd, args, packtmp);
 
 	strvec_push(&cmd.args, "--cruft");
 	if (cruft_expiration)
@@ -861,7 +862,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	sigchain_push_common(remove_pack_on_signal);
 
-	prepare_pack_objects(&cmd, &po_args);
+	prepare_pack_objects(&cmd, &po_args, packtmp);
 
 	show_progress = !po_args.quiet && isatty(2);
 
-- 
2.38.0.16.g393fd4c6db

