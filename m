Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD9C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45C82151B
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ec0wHqcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKYAxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKYAxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:53:48 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0446CC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:53:48 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id w88so620494qtd.4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7VqVGOJ+iyv4RIBLagFTsF2etf6D3oEm1Egty3ap7Uw=;
        b=ec0wHqcJ6JmIfV85hshW+Phw6NHR1GTxSsi3ELaxpH4AVJyFvmNIX9DKRt5ELDifX2
         sv0ltWUMtUDZQj4f6SETbkfJSuICJmpTFpXe+LYH+Rwbj/SXThRic5+QVQnqdvztDZHE
         nQpu1PSGOxhQMJjr21woHfHhQm/OaEI8eoD80ajsDqRzIiApshzinwY7G4vW5kPv71Oh
         7t+CbqyLGZPeG0wYzKBFknN7/XZrGvaevsB03dajY0YnB6f7RCrBQ98jO0SYWvjsO1sW
         VVKwcjlr9rX9GDLrrX8SzRhndmSUHvYTKHJSd0iKiv8ihFZu4PYfxZ0KqWaxj8uVv0Dv
         3jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7VqVGOJ+iyv4RIBLagFTsF2etf6D3oEm1Egty3ap7Uw=;
        b=MKiCEoivBosBPUMxH/WWAsyVuy+EaUdKTU8IYHlHdJJ5HuPODKTqWIdcX+sBITj8uT
         Fw1p7VIi5PuyLIOvlpigNLWryNAC7Ly/QZgXyrHEPlSQALCYgFG9ZEjFQYWtOxaqplon
         ojiUVqyU3aQasrKZWpekRJHOd/5CG0+eLHkhXkC0CMGciC0L3RAIrKLKFQaEJlGOD4/i
         mSUP7g3hwtEAtYpyFFdgrt6ttlJhV8FsMamypZbYeHOEtcTE7e7cEYruhLq6dtniPpZg
         fhoZ23g1SFe5PVn5882YbfROKbTyAie1EUgRYvJA02ik601aAkQZUqnS3PmHJkY2U6rv
         TQKg==
X-Gm-Message-State: AOAM533Ap14KJ0FtWRoYwHgqnfSdDG1tINdt27PJ29mY5wnmi9CimGJT
        YB3lGYChHmaI0oT3uh5/Sy69uoOyMWg5vWF+VB3a
X-Google-Smtp-Source: ABdhPJydY3noh0ONh4dZ514MuJLYRsEOWjpL11PbtCMsqIuuX4USCHo9I0O5FPUNb0IExKY1CZEtuK6ee6nQEM/1q4qK
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:4189:: with SMTP id
 o131mr1057491yba.95.1606265627105; Tue, 24 Nov 2020 16:53:47 -0800 (PST)
Date:   Tue, 24 Nov 2020 16:53:44 -0800
In-Reply-To: <c9512067293c082ad3082262e50dfd04f1bc1648.1605649533.git.me@ttaylorr.com>
Message-Id: <20201125005344.935924-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <c9512067293c082ad3082262e50dfd04f1bc1648.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 10/24] pack-bitmap-write: reimplement bitmap writing
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[snip commit message]

Thanks for the very clear commit message explaining the new algorithm.

> +struct bb_commit {
> +	struct commit_list *children;
> +	struct bitmap *bitmap;
> +	unsigned selected:1;
> +	unsigned idx; /* within selected array */
> +};
> +
> +define_commit_slab(bb_data, struct bb_commit);
> +
> +struct bitmap_builder {
> +	struct bb_data data;
> +	struct commit **commits;
> +	size_t commits_nr, commits_alloc;
> +};
> +
> +static void bitmap_builder_init(struct bitmap_builder *bb,
> +				struct bitmap_writer *writer)
>  {
>  	struct rev_info revs;
> +	struct commit *commit;
> +	unsigned int i;
> +
> +	memset(bb, 0, sizeof(*bb));
> +	init_bb_data(&bb->data);
> +
> +	reset_revision_walk();
> +	repo_init_revisions(writer->to_pack->repo, &revs, NULL);
> +	revs.topo_order = 1;
> +
> +	for (i = 0; i < writer->selected_nr; i++) {
> +		struct commit *c = writer->selected[i].commit;
> +		struct bb_commit *ent = bb_data_at(&bb->data, c);
> +		ent->selected = 1;
> +		ent->idx = i;
> +		add_pending_object(&revs, &c->object, "");
> +	}
> +
> +	if (prepare_revision_walk(&revs))
> +		die("revision walk setup failed");
> +
> +	while ((commit = get_revision(&revs))) {
> +		struct commit_list *p;
> +
> +		parse_commit_or_die(commit);
> +
> +		ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
> +		bb->commits[bb->commits_nr++] = commit;
> +
> +		for (p = commit->parents; p; p = p->next) {
> +			struct bb_commit *ent = bb_data_at(&bb->data, p->item);
> +			commit_list_insert(commit, &ent->children);
> +		}
> +	}
> +}

Looks straightforward.

> +static void bitmap_builder_clear(struct bitmap_builder *bb)
> +{
> +	clear_bb_data(&bb->data);
> +	free(bb->commits);
> +	bb->commits_nr = bb->commits_alloc = 0;
> +}

I was wondering why the commit list and the children in struct bb_commit
weren't cleared, but that's because they are cleared during the
algorithm. So this is fine.

> +static void fill_bitmap_tree(struct bitmap *bitmap,
> +			     struct tree *tree)
> +{
> +	uint32_t pos;
> +	struct tree_desc desc;
> +	struct name_entry entry;
> +
> +	/*
> +	 * If our bit is already set, then there is nothing to do. Both this
> +	 * tree and all of its children will be set.
> +	 */
> +	pos = find_object_pos(&tree->object.oid);
> +	if (bitmap_get(bitmap, pos))
> +		return;
> +	bitmap_set(bitmap, pos);
> +
> +	if (parse_tree(tree) < 0)
> +		die("unable to load tree object %s",
> +		    oid_to_hex(&tree->object.oid));
> +	init_tree_desc(&desc, tree->buffer, tree->size);
> +
> +	while (tree_entry(&desc, &entry)) {
> +		switch (object_type(entry.mode)) {
> +		case OBJ_TREE:
> +			fill_bitmap_tree(bitmap,
> +					 lookup_tree(the_repository, &entry.oid));
> +			break;
> +		case OBJ_BLOB:
> +			bitmap_set(bitmap, find_object_pos(&entry.oid));
> +			break;
> +		default:
> +			/* Gitlink, etc; not reachable */
> +			break;
> +		}
> +	}
> +
> +	free_tree_buffer(tree);
> +}

Looks straightforward.

> +static void fill_bitmap_commit(struct bb_commit *ent,
> +			       struct commit *commit)
> +{
> +	if (!ent->bitmap)
> +		ent->bitmap = bitmap_new();
> +
> +	/*
> +	 * mark ourselves, but do not bother with parents; their values
> +	 * will already have been propagated to us
> +	 */
> +	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
> +	fill_bitmap_tree(ent->bitmap, get_commit_tree(commit));
> +}

OK - when filling the bitmap for a commit, we only set the specific bit
for the commit itself, and all the bits for the commit's tree and the
tree's descendants. This is consistent with the explanation of the
algorithm in the commit message.

> +static void store_selected(struct bb_commit *ent, struct commit *commit)
> +{
> +	struct bitmapped_commit *stored = &writer.selected[ent->idx];
> +	khiter_t hash_pos;
> +	int hash_ret;
> +
> +	/*
> +	 * the "reuse bitmaps" phase may have stored something here, but
> +	 * our new algorithm doesn't use it. Drop it.
> +	 */
> +	if (stored->bitmap)
> +		ewah_free(stored->bitmap);

I tried to figure out how the "reuse bitmaps" phase stores things in
this field, but that led me down a rabbit hole that I didn't pursue.
But anyway, the new bitmap is correctly generated, so clearing the old
bitmap is safe (except, possibly, wasting time, but I see that in a
subsequent patch, existing bitmaps will be reused in a new wawy).

> +
> +	stored->bitmap = bitmap_to_ewah(ent->bitmap);
> +
> +	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
> +	if (hash_ret == 0)
> +		die("Duplicate entry when writing index: %s",
> +		    oid_to_hex(&commit->object.oid));
> +	kh_value(writer.bitmaps, hash_pos) = stored;
> +}
> +
> +void bitmap_writer_build(struct packing_data *to_pack)
> +{
> +	struct bitmap_builder bb;
> +	size_t i;
> +	int nr_stored = 0; /* for progress */
>  
>  	writer.bitmaps = kh_init_oid_map();
>  	writer.to_pack = to_pack;
>  
>  	if (writer.show_progress)
>  		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
> +	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
> +		the_repository);
> +
> +	bitmap_builder_init(&bb, &writer);
> +	for (i = bb.commits_nr; i > 0; i--) {
> +		struct commit *commit = bb.commits[i-1];
> +		struct bb_commit *ent = bb_data_at(&bb.data, commit);
> +		struct commit *child;
> +
> +		fill_bitmap_commit(ent, commit);
> +
> +		if (ent->selected) {
> +			store_selected(ent, commit);
> +			nr_stored++;
> +			display_progress(writer.progress, nr_stored);
> +		}
> +
> +		while ((child = pop_commit(&ent->children))) {

Here the children (specifically, the struct commit_list) are freed (one
by one).

> +			struct bb_commit *child_ent =
> +				bb_data_at(&bb.data, child);
> +
> +			if (child_ent->bitmap)
> +				bitmap_or(child_ent->bitmap, ent->bitmap);
> +			else
> +				child_ent->bitmap = bitmap_dup(ent->bitmap);
> +		}
> +		bitmap_free(ent->bitmap);
> +		ent->bitmap = NULL;

Here the bitmap is freed.

>  	}
> +	bitmap_builder_clear(&bb);
>  
>  	stop_progress(&writer.progress);
>  
>  	compute_xor_offsets();

Thanks - overall this looks straightforward.
