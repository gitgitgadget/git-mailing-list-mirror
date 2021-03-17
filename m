Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF08C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656C964F01
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhCQNEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCQNDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:03:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E9DC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:03:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x21so2153019eds.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Bs4SBf4VvctB4k2yltOfRzkrd6MiEgwVSYlPQW3Et7s=;
        b=Ft/y429xCY7Z3nnlhazhwb4LQ++H8aVshb2PJFYXWHAspz141990Oz/klbyD1IA7my
         Qysst9MBDy8tSWKD9F9Q6VHQbUmn+QlhjZZX32ZU5kDGFv91kwceVa7m8fz5JHvfSYjs
         CBOkyQeI70b81c38C77rRv1XE67Zd6sT49yRKVKfe3sjbJUV4AYpOTm5m1nMyTyzCbyC
         o5hrozVqQ4V8JqCL24k//haTk4W4HwukFzz2VG7S4X/nBTEVYSXQ4t/Y9PCIXlg4h53r
         3KQCE0LXnTFkRtMuMkr3dz4tXd8Md/gct9AdOByD3M20+Ybfxcs2y/grAgLWwK/mJzUN
         4OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Bs4SBf4VvctB4k2yltOfRzkrd6MiEgwVSYlPQW3Et7s=;
        b=sa99QuDfTZfU6XUgDY4vnkf0jyQmRl0GqXRGWzbacUAhblupic9sulTpV12H5NbTHL
         NHL5hHKhHJ4F04UKzrNjqdecyzK0fjZ+tD8tblzMAEtQIt4b+Q6BSIW5LrrfF1a9bfAZ
         DKgGObNnphObswn+doLiXwgma6v4liP/kOkLSvS+pjAB2mLPljTxHfimQT0ZrB74eWad
         Re5UGiJpPENy60NeJnCQ46sSEVqp7JcnoOZgzz6thK0IST7JIKWvlmlf++khnJOSlTJM
         JS0fp1I8PKO4Lv4nqTmZKWkp6nC5VbQ1Y4SmcPGg20SKFXDT5GIJT+nPKLomF5FiUHfQ
         txWA==
X-Gm-Message-State: AOAM532Hm8GPEr33++kBdtv8+U2bEpCOvCGc7z8wNM7tjzCtBGqPNd2c
        qvMAaCzYeiHIzuvkK6Z8jYzjQpxBRHYueQ==
X-Google-Smtp-Source: ABdhPJybJHoP6oTZmHMnXAOGy3il50t167jeXROUL/TGl8Q+OrlzHofFT25geMoNzBPlv9HwJgP8GQ==
X-Received: by 2002:aa7:c1d8:: with SMTP id d24mr31839552edp.290.1615986226818;
        Wed, 17 Mar 2021 06:03:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gt37sm11107610ejc.12.2021.03.17.06.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:03:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 05/20] sparse-index: implement ensure_full_index()
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <99292cdbaae488101d1c247ab94dc4b3b04d0311.1615912983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <99292cdbaae488101d1c247ab94dc4b3b04d0311.1615912983.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 14:03:45 +0100
Message-ID: <87k0q6dj9q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> [...]
> +static int add_path_to_index(const struct object_id *oid,
> +			     struct strbuf *base, const char *path,
> +			     unsigned int mode, void *context)
> +{
> +	struct index_state *istate = (struct index_state *)context;
> +	struct cache_entry *ce;
> +	size_t len = base->len;
> +
> +	if (S_ISDIR(mode))
> +		return READ_TREE_RECURSIVE;
> +
> +	strbuf_addstr(base, path);
> +
> +	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
> +	ce->ce_flags |= CE_SKIP_WORKTREE;
> +	set_index_entry(istate, istate->cache_nr++, ce);
> +
> +	strbuf_setlen(base, len);
> +	return 0;
> +}
>  
>  void ensure_full_index(struct index_state *istate)
>  {
> -	/* intentionally left blank */
> +	int i;
> +	struct index_state *full;
> +	struct strbuf base = STRBUF_INIT;
> +
> +	if (!istate || !istate->sparse_index)
> +		return;
> +
> +	if (!istate->repo)
> +		istate->repo = the_repository;
> +
> +	trace2_region_enter("index", "ensure_full_index", istate->repo);
> +
> +	/* initialize basics of new index */
> +	full = xcalloc(1, sizeof(struct index_state));
> +	memcpy(full, istate, sizeof(struct index_state));
> +
> +	/* then change the necessary things */
> +	full->sparse_index = 0;
> +	full->cache_alloc = (3 * istate->cache_alloc) / 2;
> +	full->cache_nr = 0;
> +	ALLOC_ARRAY(full->cache, full->cache_alloc);
> +
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		struct cache_entry *ce = istate->cache[i];
> +		struct tree *tree;
> +		struct pathspec ps;
> +
> +		if (!S_ISSPARSEDIR(ce->ce_mode)) {
> +			set_index_entry(full, full->cache_nr++, ce);
> +			continue;
> +		}
> +		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
> +			warning(_("index entry is a directory, but not sparse (%08x)"),
> +				ce->ce_flags);
> +
> +		/* recursively walk into cd->name */
> +		tree = lookup_tree(istate->repo, &ce->oid);
> +
> +		memset(&ps, 0, sizeof(ps));
> +		ps.recursive = 1;
> +		ps.has_wildcard = 1;
> +		ps.max_depth = -1;
> +
> +		strbuf_setlen(&base, 0);
> +		strbuf_add(&base, ce->name, strlen(ce->name));
> +
> +		read_tree_at(istate->repo, tree, &base, &ps,
> +			     add_path_to_index, full);
> +
> +		/* free directory entries. full entries are re-used */
> +		discard_cache_entry(ce);
> +	}
> +
> +	/* Copy back into original index. */
> +	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
> +	istate->sparse_index = 0;
> +	free(istate->cache);
> +	istate->cache = full->cache;
> +	istate->cache_nr = full->cache_nr;
> +	istate->cache_alloc = full->cache_alloc;
> +
> +	strbuf_release(&base);
> +	free(full);
> +
> +	trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }

Not that I mind having added the read_tree_at() again, but just thinking
aloud here.

So we need this loop here because there's nothing like a read_tree_at()
that knows how to start at the non-tree root of the index, and then for
each directory there we're going to perform the equivalent of a
read_tree() there, but we need to set the base for add_path_to_index()
since we started at subdirs, not the root.

That's fine, but grepping around a bit I wonder if we shouldn't
eventually have some slightly fancier API that just works like
read_tree() but takes an optional "start at the index's root" instead.

Well, things that want that usually care about the index-specific bits,
whereas this "I just care about the tree for these" is more of a special
case I guess.
