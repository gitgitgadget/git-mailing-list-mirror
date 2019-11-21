Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15131C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA54820672
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 16:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYKKkeUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKUQhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:37:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36531 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUQhL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 11:37:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id n188so2545053wme.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 08:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=btYUm5aD5IrF4kxT56BN/tF2DhqNcn1WyQwoZBS7kFE=;
        b=VYKKkeUdoBbCfXYNftJfKLG7N5PNRF1Lp5DEVZktumVYqKWddL9D9GiQ0hwKvmNwnY
         qshsKznXSRNYIbO3iqwivb7I5PC6v8Z4NfkJN+/9ieuqeVi+9bk5eJtUjkMUgn/doZV+
         rBUuSm4NVSRHzKql35jp+jyUOnq5yySbLwXM0zDVULCqXxtHYVTfeQMFYU9+5gqJ+VoE
         /Ob8TWLuDZQ//TZlZIbp0X1qlxS7eaB7AtNCk7AErGeGok4DPhPgQBupiSRU7OHef7Pe
         nXMEdxmjhGA2d6NP1fdv/rEoHnarAKzJguoMElskg3P/9pPhUEMMl0i9/crWNtekttW3
         KcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=btYUm5aD5IrF4kxT56BN/tF2DhqNcn1WyQwoZBS7kFE=;
        b=DIs+pH70asOsXletPTgsIah677WS2ubBEKoNfU1DyXQDl2DOBnwi5PuGicmDMfk8gk
         sP3+1+3G8Iw9+kLdpKb5a0fZo3l7C+jFbKBVgcG74OwqyFZfuYWOs4vurfaH9Ol4XElM
         Y1mzKvUiqU/5gY5PLb+Xr74eZL0o+SkUxB0xF5D4SzXQVzixVx1a1rM8DchdwE5ZmQO+
         ixy1pDFLEYh8suX7PrvxDBK4TABH6mBUCNlwxFgWdGER4GdrAkKO43aUeJ/+/ypH24bA
         AkRvIusZi2o08ap00r654BFT8G6IQuSE2+THQbXT8IUFujVxRz2kKE2cBSTPUksFg3qh
         blxA==
X-Gm-Message-State: APjAAAUHE8FXk5VYg7F9gjbPzRL0WwBGBLJmus/hSvZTW45edzjUNoXY
        jIsWZCZ5Y4pHrpu/9OJOQEM=
X-Google-Smtp-Source: APXvYqyyTYXQ3tR25iyzomLSMzI1/G2kAkT/BbZKsnX247wqq8g0wHbFhxkIFPD9b3u61u5pmT4+cA==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr5703229wmj.101.1574354229858;
        Thu, 21 Nov 2019 08:37:09 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id h5sm4014948wrx.16.2019.11.21.08.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:37:08 -0800 (PST)
Date:   Thu, 21 Nov 2019 17:37:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
Message-ID: <20191121163706.GV23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191121114936.GR23183@szeder.dev>
 <147bf5a9-6ae5-23ea-a007-68b8046c94ea@gmail.com>
 <20191121152744.GU23183@szeder.dev>
 <72a54009-5801-c92a-f108-faf38ebbdd4b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72a54009-5801-c92a-f108-faf38ebbdd4b@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 10:36:10AM -0500, Derrick Stolee wrote:
> > But wait, I thought that only changes to files that are excluded from
> > the sparse-checkout are thrown away, but as it turns out it throws
> > away changes to files that are included in the sparse-checkout:

For completeness, 'git sparse-checkout disable' throws away staged
changes as well, as it, too, runs 'git read-tree -um HEAD' (or its
equivalent).

> Thanks for the additional details.
> 
> This series intended to make the existing sparse-checkout behavior
> more useful to users by not requiring manual edits of the sparse-checkout
> file followed by 'git read-tree' commands. However, there do appear
> to be some serious improvements that we can make in the future.
> 
> Keeping staged changes seems important, and we can address that in
> the near future.

I think that at least for now 'git sparse-checkout' should flat out
refuse to init/set/disable if the working tree is not clean (but still
allow 'list', as that's a read-only operation), like the patch below.
Yeah, that way it wouldn't work in cases that appear to be safe
(unstaged changes), but it would prevent the data loss until we
carefully consider the circumstances under which these operations can
be safely allowed.


  -- >8 --

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 76f65d8edd..4b05625c4c 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -12,6 +12,7 @@
 #include "lockfile.h"
 #include "resolve-undo.h"
 #include "unpack-trees.h"
+#include "wt-status.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout (init|list|set|disable) <options>"),
@@ -188,6 +189,10 @@ static int sparse_checkout_init(int argc, const char **argv)
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("initialize sparse-checkout"), NULL, 1, 0);
+
 	if (init_opts.cone_mode) {
 		mode = MODE_CONE_PATTERNS;
 		core_sparse_checkout_cone = 1;
@@ -386,6 +391,10 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("set up sparse-checkout"), NULL, 1, 0);
+
 	if (core_sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
 		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
@@ -437,6 +446,10 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("disable sparse-checkout"), NULL, 1, 0);
+
 	if (sc_set_config(MODE_ALL_PATTERNS))
 		die(_("failed to change config"));
 

