Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71414C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 12:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49048207D8
	for <git@archiver.kernel.org>; Tue, 19 May 2020 12:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArQhMLV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgESMLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgESMLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 08:11:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D23C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 05:11:18 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w22so10887097otp.5
        for <git@vger.kernel.org>; Tue, 19 May 2020 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I/rwtODCEzDaVFVGWCBbSaSrxCH/P/4t5c6zZsPSsd4=;
        b=ArQhMLV8fr+10u3seoRBiFtDRekZTb7cOPNbAdw21flqsa6ofSspDkQMHnQqZhVOON
         vhsv9GP1mc01wQReXPSoxo/SiKl0ti8x0XICwT5oSIdEZDPjHf3XtPFKuWY2UD+qv5+W
         Y4yuYRVjtbxde9mXLd4Yg8SOjAWkpqHlIdlWRUT7URV1D0rTL38yLGr32S7ZXVI/0wTE
         QJ7SENU/ib0I1z38XdESxwBi+4PYDr4vgaPHHC2F0HmlwZPkrqH2IPgJ3HDnOHMllJg9
         wQpQwjyedLcwcI2QnuZm0bje1XAKjD0wsp8ChJ2DmUyy3CZHN7BVcBT30AsInO+gqYM3
         QDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/rwtODCEzDaVFVGWCBbSaSrxCH/P/4t5c6zZsPSsd4=;
        b=m0ZJwqKfY3F+Ccjdoe8Qt1YDHGQkr8mtBSF+Obb9pp99EwTTq6oBZDV9cHaJ9xSQFw
         uMYWJMBD4+7afFTU10DzRuTnF4QxNt53Wwg45V70GsiSW/vpvIrl5Po3t4ii5Nvi9TXs
         vYlUJnpH5a6yypkghwuBqNXNtv5B8GgjWGM/NomHn/ti4TPXMYsILCCTm8RKxk2axw7M
         QCJfUKH0ryAbhu6Gz81gIf7tQaEgfgejKwyDXysbC1R6bsfM7M8rgTLjt1XYY9mtm4ST
         qqcoU0uZs5gi7UOncOXiMwnOnnX0PFMaItZWWGCWUCe6+nGzMpBYmRKOI3gBoFeiqMb9
         1dWA==
X-Gm-Message-State: AOAM530LLffY6yi2Nl9yGaiTy2B4bxAFKlFWvZDJ39sxpWqylQiKVDPX
        EeQ+poHGead6bZucJPI/nuU=
X-Google-Smtp-Source: ABdhPJyp6yjg9L0vkC/LkPrahlwdSMN+dvBn6kaC0Ayd9To9bxsUGihMJ5LTsh0Wb9gxydjjSbM+2Q==
X-Received: by 2002:a9d:8e7:: with SMTP id 94mr16262017otf.370.1589890277491;
        Tue, 19 May 2020 05:11:17 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w82sm3944292oig.45.2020.05.19.05.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:11:16 -0700 (PDT)
Subject: Re: Git Test Coverage Report (v2.27.0-rc0)
From:   Derrick Stolee <stolee@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <853759d3-97c3-241f-98e1-990883cd204e@gmail.com>
Date:   Tue, 19 May 2020 08:11:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2020 1:22 PM, Derrick Stolee wrote:
> Bugs tend to hide in uncovered
> code!

Immediately after sending the report, I regretted the ambiguity of
this sentence. Here are a couple things to point out:

* Just because code is uncovered does not mean it is more likely
  to contain a bug. It just means that code review is our only
  protection. This is completely acceptable for things like error
  conditions we never expect to show up. We also don't hold authors
  accountable for existing bugs when they do a mechanical refactor
  of existing, uncovered code.

* Just because code is _covered_ does not mean it is less likely
  to contain a bug. There are all sorts of reasons that coverage
  is not enough to "guarantee" correct behavior.

My process in this email is to check each commit's diff and
eliminate any lines that are obviously part of error conditions
(and there isn't a worry about a use-after-free for an error
message or something).

I've CC'd the authors for the commits that I think could use
a second look. Please evaluate the following:

 1. Is this code definitely correct?
 2. How difficult would it be to cover this with a test?

> brian m. carlson	13e7ed6a builtin/checkout: compute checkout metadata for checkouts
> builtin/checkout.c
> 13e7ed6a 625)        is_null_oid(&info->oid) ? &tree->object.oid :

This is part of the following hunk:

@@ -619,6 +620,11 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
        opts.verbose_update = o->show_progress;
        opts.src_index = &the_index;
        opts.dst_index = &the_index;
+       init_checkout_metadata(&opts.meta, info->refname,
+                              info->commit ? &info->commit->object.oid :
+                              is_null_oid(&info->oid) ? &tree->object.oid :
+                              &info->oid,
+                              NULL);
        parse_tree(tree);
        init_tree_desc(&tree_desc, tree->buffer, tree->size);
        switch (unpack_trees(1, &tree_desc, &opts)) {

The double-nested ternary definitely complicates the coverage here.
It also points out that all tests have `info->commit` a non-NULL.

This certainly looks safe, but I don't know.

> Denton Liu	be1bb600 sequencer: make apply_autostash() accept a path
> sequencer.c
> be1bb600 5203) apply_autostash(rebase_path_autostash());

This line is identical to four other lines inserted by the
same patch.

> Denton Liu	ce6521e4 Lib-ify fmt-merge-msg
> fmt-merge-msg.c

(This patch moves a bunch of old code, so we should not
fault the author for its coverage.)

> Derrick Stolee	0906ac2b blame: use changed-path Bloom filters
> blame.c
> 0906ac2b 1302) bd->alloc *= 2;
> 0906ac2b 1303) REALLOC_ARRAY(bd->keys, bd->alloc);
> 0906ac2b 2899) return;

This hunk is part of this method:

+static void add_bloom_key(struct blame_bloom_data *bd,
+                         const char *path)
+{
+       if (!bd)
+               return;
+
+       if (bd->nr >= bd->alloc) {
+               bd->alloc *= 2;
+               REALLOC_ARRAY(bd->keys, bd->alloc);
+       }
+
+       bd->keys[bd->nr] = xmalloc(sizeof(struct bloom_key));
+       fill_bloom_key(path, strlen(path), bd->keys[bd->nr], bd->settings);
+       bd->nr++;
+}

This is not being covered because the blame tests must not
be splitting the files across enough renames to trigger the
realloc. I don't think it is worth creating such a complicated
test.

> Derrick Stolee	c9f7a793 log-tree: make ref_filter_match() a helper method
> log-tree.c
> c9f7a793 94)     (!*rest || *rest == '/'))

This is moved code:

+               const char *rest;
+               if (skip_prefix(refname, item->string, &rest) &&
+                   (!*rest || *rest == '/'))
+                       matched = 1;

Since the "matched = 1;" line is covered, this must mean that
any tests we use have "!*rest" be true and the "*rest == '/'"
is not covered. 

> Elijah Newren	30e89c12 unpack-trees: pull sparse-checkout pattern reading into a new function
> unpack-trees.c
> 30e89c12 1556) o->skip_sparse_checkout = 1;

Error condition (when sparse-checkout fails to parse).

> Garima Singh	3d112755 commit-graph: examine commits by generation number
> commit-graph.c
> 3d112755 1307) QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);

While this is blamed to 3d112755, it's actually moved from d21ee7d11 (commit-graph:
examine changed-path objects in pack order, 2020-03-30) which introduced the sort.

The reason this isn't covered is because all changed-path tests use --reachable
and none use the default which scans pack-files.

> Garima Singh	ed591feb bloom.c: core Bloom filter implementation for changed paths.
> bloom.c
> ed591feb 266) for (i = 0; i < diff_queued_diff.nr; i++)
> ed591feb 267) diff_free_filepair(diff_queued_diff.queue[i]);
> ed591feb 268) filter->data = NULL;
> ed591feb 269) filter->len = 0;

This is the case when a commit has more than 512 changes. The plan is to
add a test after this 512 limit is adjustable by config. (Adding to my TODO
list [1])

[1] https://github.com/microsoft/git/issues/272

> Jeff King	d21ee7d1 commit-graph: examine changed-path objects in pack order
> commit-graph.c
> d21ee7d1 77) return; /* should never happen, but be lenient */
> d21ee7d1 82) static int commit_pos_cmp(const void *va, const void *vb)
> d21ee7d1 84) const struct commit *a = *(const struct commit **)va;
> d21ee7d1 85) const struct commit *b = *(const struct commit **)vb;
> d21ee7d1 86) return commit_pos_at(&commit_pos, a) -
> d21ee7d1 87)        commit_pos_at(&commit_pos, b);

These would be called by the QSORT mentioned earlier.

> Jonathan Tan	95acf11a diff: restrict when prefetching occurs
> diffcore-rename.c
> 95acf11a 137) static void prefetch(void *prefetch_options)
> 95acf11a 139) struct prefetch_options *options = prefetch_options;
> 95acf11a 141) struct oid_array to_fetch = OID_ARRAY_INIT;
> 95acf11a 143) for (i = 0; i < rename_dst_nr; i++) {
> 95acf11a 144) if (rename_dst[i].pair)
> 95acf11a 149) continue; /* already found exact match */
> 95acf11a 150) diff_add_if_missing(options->repo, &to_fetch,
> 95acf11a 151)     rename_dst[i].two);
> 95acf11a 153) for (i = 0; i < rename_src_nr; i++) {
> 95acf11a 154) if (options->skip_unmodified &&
> 95acf11a 155)     diff_unmodified_pair(rename_src[i].p))
> 95acf11a 160) continue;
> 95acf11a 161) diff_add_if_missing(options->repo, &to_fetch,
> 95acf11a 162)     rename_src[i].p->one);
> 95acf11a 164) promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
> 95acf11a 165) oid_array_clear(&to_fetch);
> 95acf11a 166) }

Odd that this static method is never called, even once.

The only reference is here:

+       struct prefetch_options prefetch_options = {r, skip_unmodified};
+
+       if (r == the_repository && has_promisor_remote()) {
+               dpf_options.missing_object_cb = prefetch;
+               dpf_options.missing_object_data = &prefetch_options;
+       }

but this block is definitely being called. Perhaps the prefetch
is never being called because we are never in a situation where there
are any missing objects?

> René Scharfe	9068cfb2 fsck: report non-consecutive duplicate names in trees
> fsck.c
> 9068cfb2 623) break;
> 9068cfb2 626) if (is_less_than_slash(*p)) {
> 9068cfb2 627) name_stack_push(candidates, f_name);
> 9068cfb2 628) break;
> 9068cfb2 630) }
 
These are different conditions in verify_ordered() to check the
special case of blobs and trees having the "same" name (but
sorted differently due to appending '/' to trees before sorting).

There is another name_stack_push() that _is_ covered. I wonder
what case would trigger this push?

Thanks,
-Stolee
