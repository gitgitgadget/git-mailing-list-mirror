Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969E6C4332F
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiCCRzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiCCRzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 12:55:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28354149B88
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 09:54:24 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id bh9-20020a056a02020900b0036c0d29eb3eso3129791pgb.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h8cQiicwp0eJX2yc4Qjq+qd1aO1N16x+kU9Im5SAszs=;
        b=Lyzuhyw8HUbe4BkANpB1fKpIa0HrYva6JQFoPWqb9X8ug+o/fUFFryIPux+AYs+JyK
         dNvkfr67m3ArTwppMTPK7oGrILuu/qW+w3EnImysCZUPxshgr0Pp+BFVrVFbSTsD/j93
         97ccAq2XgiBoaNgPGBucE4Gr51mEKgCBk9XBSzxlYaGj/GbdhM8PRO3UHlCaY1KHjDKa
         dxf8uL2ePWigwiBCdqVbeK2tpJpVS9rlHQdadXhyfbK6b0Pye2gy0z/gxP0X5EuZ1nqq
         eu/5kuAUI8Bq+IYwypD655OymZ0Ge4fO+lDP2NnRVzhmQei7ipCi12JFhCZBlpkDD4Ge
         TzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h8cQiicwp0eJX2yc4Qjq+qd1aO1N16x+kU9Im5SAszs=;
        b=D/u0go0f56bWnB8gHJmMWXctuxwveJLdhQ7wpDqQnHoSisMsS572EBNjiRDlJqI6np
         aVOY2C9ItkfDIgdAo0dmMcV0doUrto+4lws/jbQSXel7NMOjOaEcScJymUIaEGxqJ+ir
         Z8D2lToW2yrhQZMZ8YOZjNOoO/hk3rQ8t/72u2FhHitICMOMLxP7FSdqTytS71WMMGE0
         nLgUTvQ7yUO+B70BrDviZbBmy4VfnnSZryXbFgHPGggXVCrArjSp5JkffaGBXgVd+W/y
         T7OiDDcAJ8E57/SYoPlAMXPrZoP1kE/wHDZuTWK8EoesYypXPuJJ9i9itMCqM/4NYJln
         cQaA==
X-Gm-Message-State: AOAM5311084xpwwGItISxI8o3hHPlR2Uurv0XzjVP0x/6FfDLWLRuZ46
        5dTDN9pvRrUDjARTF5u47Dg3jKbFY73REw==
X-Google-Smtp-Source: ABdhPJx1fviNPUqLoyhUbvAH4+6xdDoASZSEEGDPTXdO+5TJxYKD9GhVBT99HtqOxWbEh1U1jkaOba1hLFhF6g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e750:b0:151:b4b5:c274 with SMTP
 id p16-20020a170902e75000b00151b4b5c274mr1614587plf.100.1646330062861; Thu,
 03 Mar 2022 09:54:22 -0800 (PST)
Date:   Thu, 03 Mar 2022 09:54:20 -0800
In-Reply-To: <1a9365c3bc5b810a60593612bfba97a8b0c1d657.1646166271.git.gitgitgadget@gmail.com>
Message-Id: <kl6lczj2exbn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com> <1a9365c3bc5b810a60593612bfba97a8b0c1d657.1646166271.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 6/8] read-tree: narrow scope of index expansion for '--prefix'
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
> +static void update_sparsity_for_prefix(const char *prefix,
> +				       struct index_state *istate)
> +{
> +	int prefix_len = strlen(prefix);
> +	struct strbuf ce_prefix = STRBUF_INIT;
> +
> +	if (!istate->sparse_index)
> +		return;
> +
> +	while (prefix_len > 0 && prefix[prefix_len - 1] == '/')
> +		prefix_len--;
> +
> +	if (prefix_len <= 0)
> +		BUG("Invalid prefix passed to update_sparsity_for_prefix");
> +
> +	strbuf_grow(&ce_prefix, prefix_len + 1);
> +	strbuf_add(&ce_prefix, prefix, prefix_len);
> +	strbuf_addch(&ce_prefix, '/');
> +
> +	/*
> +	 * If the prefix points to a sparse directory or a path inside a sparse
> +	 * directory, the index should be expanded. This is accomplished in one
> +	 * of two ways:
> +	 * - if the prefix is inside a sparse directory, it will be expanded by
> +	 *   the 'ensure_full_index(...)' call in 'index_name_pos(...)'.
> +	 * - if the prefix matches an existing sparse directory entry,
> +	 *   'index_name_pos(...)' will return its index position, triggering
> +	 *   the 'ensure_full_index(...)' below.
> +	 */
> +	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate) &&
> +	    index_name_pos(istate, ce_prefix.buf, ce_prefix.len) >= 0)
> +		ensure_full_index(istate);
> +
> +	strbuf_release(&ce_prefix);
> +}

Hm, I don't think I follow the rationale for having two different ways
of expanding the index:

- If the prefix is inside a sparse directory, we should expand the
  index.
- If the prefix matches a sparse directory entry, we should expand the
  index.

So it seems like distinguishing between the two cases with
index_name_pos(...) isn't necessary. I've attached a diff that does
exactly this, and it passes t1092-sparse-checkout-compatibility.sh as
far as I can tell. I've also amended the comment in a way that makes
more sense to me, but I'm not 100% sure if it's accurate.

I'm also a little averse to using a side effect of index_name_pos() to
achieve what we really want, so I'd prefer to get rid of the call if we
can :)

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

diff --git a/unpack-trees.c b/unpack-trees.c
index b876caca0d..5b07055605 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1749,17 +1749,11 @@ static void update_sparsity_for_prefix(const char *prefix,
 	strbuf_addch(&ce_prefix, '/');
 
 	/*
-	 * If the prefix points to a sparse directory or a path inside a sparse
-	 * directory, the index should be expanded. This is accomplished in one
-	 * of two ways:
-	 * - if the prefix is inside a sparse directory, it will be expanded by
-	 *   the 'ensure_full_index(...)' call in 'index_name_pos(...)'.
-	 * - if the prefix matches an existing sparse directory entry,
-	 *   'index_name_pos(...)' will return its index position, triggering
-	 *   the 'ensure_full_index(...)' below.
+	 * If the prefix points to a sparse directory or a path inside a
+	 * sparse directory (not within the sparse patterns), the index
+	 * should be expanded.
 	 */
-	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate) &&
-	    index_name_pos(istate, ce_prefix.buf, ce_prefix.len) >= 0)
+	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate))
 		ensure_full_index(istate);
 
 	strbuf_release(&ce_prefix);
