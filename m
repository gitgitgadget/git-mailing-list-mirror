Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11DBC67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJXUde (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiJXUc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:32:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF64EAC80
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:44:01 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h203so8498568iof.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D56Dz5U5vARygvly6YaT2A43Chkn0XLn0o/cFivL+KA=;
        b=ArCNDp8Oy6jHIo0BW4CkWzEGHuC3xYPDoZTVSlLy6sDBsaAE4zJUxslnSw042G26Gm
         c/V8VPfJ/HTR96pNKYYx3dhJWPffnGPMSwahRTUlpcIRFKAAVpO5HGYLbP9zO1ZPt1e1
         LEwDutm/4ngOa0kfWKSiSX7DF+zbvIeaUfpk1Wa3koM23EEphrj/A1I8/tlvL/ZsKQgc
         P0F/WI0GljRDeBC0NnXJN2XBTnDi/QMqPtWeD57oBT4zK0JYRSbMBiYVzTnK4eGuMJnv
         gypmAp93uSYEBAHCAc2LTLL/YVv2iuJf5+PoZ8h36dHx8HjuFF1fhIh8SGC43dFoNDpe
         3UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D56Dz5U5vARygvly6YaT2A43Chkn0XLn0o/cFivL+KA=;
        b=TIXxxeDqEMnhdMu2hgSFWk0hUo0CVeEykqj+SklpGfO+WOABg1h5aFiLsjCIUATuae
         D7WDrOEQdzPSoR+EqHx0qwp6cx9B4NvegPhbuIKVDUKOQVsb/0W+Cb5uBiYVQgwVHB3y
         4YsSFOFhUkGhPY5sO3/lwbPgEF+lsCMclcPyUFxRd07Ksii8RM4H9m9z24aClujE0GBw
         hQJ3u6DhzuvAJmhHSqeP7watcqFWiWF680IxG3vEg0CM3GvC8Px3UBurec/gPzHAo87o
         nqMyV7kcuI7neKRROeqZIrZ7w6NMqBq5PbBGDGafh4UUFjJ0wbsFN60XAZkgerMuQso0
         G54g==
X-Gm-Message-State: ACrzQf0L5RgNAgvkhsv70rqfgynN080AdDVDiScmgP12A/s4fOuODh1N
        oNk6pPY77dDM4gzcZ4CXRjyIGWbIalgxcLYB
X-Google-Smtp-Source: AMsMyM6Yqe4hEt4Zx9JYQ+XrdxDbSIozSfS6NEwLOgm1ShyhmMA96BzvLZXAUMLCGuNuuAn0vAUb4g==
X-Received: by 2002:a05:6602:2d83:b0:6bc:9e73:8fa7 with SMTP id k3-20020a0566022d8300b006bc9e738fa7mr20357157iow.94.1666636987936;
        Mon, 24 Oct 2022 11:43:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cn11-20020a0566383a0b00b0036368623574sm68352jab.169.2022.10.24.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:43:07 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:43:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/4] builtin/repack.c: pass "cruft_expiration" to
 `write_cruft_pack`
Message-ID: <7d731d8dd5ebe0570a5dd8a88b3dd3104a79592a.1666636974.git.me@ttaylorr.com>
References: <cover.1666636974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666636974.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`builtin/repack.c`'s `write_cruft_pack()` is used to generate the cruft
pack when `--cruft` is supplied. It uses a static variable
"cruft_expiration" which is filled in by option parsing.

A future patch will add an `--expire-to` option which allows `git
repack` to write a cruft pack containing the pruned objects out to a
separate repository. In order to implement this functionality, some
callers will have to pass a value for `cruft_expiration` different than
the one filled out by option parsing.

Prepare for this by teaching `write_cruft_pack` to take a
"cruft_expiration" parameter, instead of reading a single static
variable.

The (sole) existing caller of `write_cruft_pack()` will pass the value
for "cruft_expiration" filled in by option parsing, retaining existing
behavior. This means that we can make the variable local to
`cmd_repack()`, and eliminate the static declaration.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0a7bd57636..1184e8c257 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -32,7 +32,6 @@ static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
-static char *cruft_expiration;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [<options>]"),
@@ -664,6 +663,7 @@ static int write_midx_included_packs(struct string_list *include,
 
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *pack_prefix,
+			    const char *cruft_expiration,
 			    struct string_list *names,
 			    struct string_list *existing_packs,
 			    struct string_list *existing_kept_packs)
@@ -746,6 +746,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct pack_objects_args cruft_po_args = {NULL};
 	int geometric_factor = 0;
 	int write_midx = 0;
+	const char *cruft_expiration = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -985,7 +986,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
 
-		ret = write_cruft_pack(&cruft_po_args, pack_prefix, &names,
+		ret = write_cruft_pack(&cruft_po_args, pack_prefix,
+				       cruft_expiration, &names,
 				       &existing_nonkept_packs,
 				       &existing_kept_packs);
 		if (ret)
-- 
2.38.0.16.g393fd4c6db

