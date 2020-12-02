Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B91C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D4C206D5
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgLBH2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgLBH2x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 02:28:53 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89229C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 23:28:13 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id 9so622284plj.10
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 23:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ewjGzboILaZHRNkltdXCzO3DapiEBQ1qk6YFBa0KUuI=;
        b=pOQGHTg7X4Fwuy6Q4u87xif+K3k80BKtMNl1yfqeXVib7yZAcCaNNLCTmNVjHw/Ryr
         sgqnPSiO6cp1Q2MTCrzABTDp80YpJ1FVXxSki8SToQsBUESUbJ4xNvAn1+MaAqWP00TF
         Ycc+KlRg3xaRWQ8n2OQ03Z7o916y6kV0yIAkIYi7tXdHXaFi/PgjagfThM073EoYqN95
         p8NklkCQA+t4MKKroJraHNRUDeWL7ohkh4eXd7H4kri2P+JbKvcUgp57uQNaFywGH+R2
         AViD2JF0m0Qy1MKc2/1jYEPUBrjWk4gUi7b+TjwyoW6TjGoC3CHMumI2gS8slBxPXs6O
         qmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ewjGzboILaZHRNkltdXCzO3DapiEBQ1qk6YFBa0KUuI=;
        b=kH1IDGiNlTy04xxajfw2BW3vQwkaZgs2/Cu97JX3JcSUvKgjgpkDtvw5V+TjHBx5SB
         D04dNRcP2rKrtGMQ6vlaJxfv8BaYb7oQ5TzAhZRW0x516GWLuDhGhKcWqtASl8nSITr8
         9oBXbpP6NbeONodnfms4cysB+DJD2T1wCv4u9/o7prBqqeL4yFTTJil1ydd0FsT3ZttJ
         9t8IkEpeC6Mba6wMNiY+OeYWOpjN7//h+8DVXQx2PLusHup5JdEPIsIDRNMQgE++PcZ6
         lFtOUAx2J+3n1oh/MeXcGRHke67/r+wHbj5uSDjCMX8Ik9xaLvITD93DSDP+A8Mxbf0w
         AARQ==
X-Gm-Message-State: AOAM530qXCylldk8P1I5etTBt3Ciu2wXh8YOGHJDvXV8Y7GVMbeOuykg
        yKBQHWc1vjJ2qnQV09n12FkRIK3AvJmd4IaBCHur
X-Google-Smtp-Source: ABdhPJwI30fsPEW6+4QkkUGBdTbbIzCNnf+gPNyLMbVI8dXaDrdjHPT6NQ4pSs5bJ9SZtpF9cl65dSRSggktE+FIjksS
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9198:0:b029:18b:3835:3796 with
 SMTP id x24-20020aa791980000b029018b38353796mr1321308pfa.9.1606894093087;
 Tue, 01 Dec 2020 23:28:13 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:28:11 -0800
In-Reply-To: <4bf5e78a54dfdcbe13dd66ba4c5955a159ea181d.1605649533.git.me@ttaylorr.com>
Message-Id: <20201202072811.3474340-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <4bf5e78a54dfdcbe13dd66ba4c5955a159ea181d.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 22/24] pack-bitmap-write: use existing bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When constructing new bitmaps, we perform a commit and tree walk in
> fill_bitmap_commit() and fill_bitmap_tree(). This walk would benefit
> from using existing bitmaps when available. We must track the existing
> bitmaps and translate them into the new object order, but this is
> generally faster than parsing trees.

Makes sense.

> In fill_bitmap_commit(), we must reorder thing somewhat. The priority
> queue walks commits from newest-to-oldest, which means we correctly stop
> walking when reaching a commit with a bitmap. 

Makes sense.

> However, if we walk trees
> from top to bottom, then we might be parsing trees that are actually
> part of a re-used bitmap. 

Isn't the issue that we shouldn't walk trees at all before exhausting
our commit search, not the direction that we walk the trees in (top to
bottom or bottom to top or whatever)?

> To avoid over-walking trees, add them to a
> LIFO queue and walk them from bottom-to-top after exploring commits
> completely.

Just to clarify - would it work just as well with a FIFO queue (not LIFO
queue)? It seems to me that the most important part is doing this after
exploring commits completely.

> On git.git, this reduces a second immediate bitmap computation from 2.0s
> to 1.0s. On linux.git, we go from 32s to 22s. On chromium's fork
> network, we go from 227s to 198s.

Nice timings.

>  static void fill_bitmap_commit(struct bb_commit *ent,
>  			       struct commit *commit,
> -			       struct prio_queue *queue)
> +			       struct prio_queue *queue,
> +			       struct prio_queue *tree_queue,
> +			       struct bitmap_index *old_bitmap,
> +			       const uint32_t *mapping)
>  {
>  	if (!ent->bitmap)
>  		ent->bitmap = bitmap_new();
>  
> -	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
>  	prio_queue_put(queue, commit);
>  
>  	while (queue->nr) {
>  		struct commit_list *p;
>  		struct commit *c = prio_queue_get(queue);
>  
> +		/*
> +		 * If this commit has an old bitmap, then translate that
> +		 * bitmap and add its bits to this one. No need to walk
> +		 * parents or the tree for this commit.
> +		 */

This comment should be right before "if (old && ...", I think. Here, it
is a bit misleading. It leads me to think that "this commit has an old
bitmap" means old_bitmap != NULL, but it is actually old != NULL.

> +		if (old_bitmap && mapping) {

This is defensive in that if we somehow calculate old_bitmap without
mapping (or the other way around) (which is a bug), things just slow
down instead of breaking. I'm OK with this, but I still wanted to call
it out.

> +			struct ewah_bitmap *old;
> +
> +			old = bitmap_for_commit(old_bitmap, c);
> +			if (old && !rebuild_bitmap(mapping, old, ent->bitmap))
> +				continue;
> +		}
> +
> +		/*
> +		 * Mark ourselves and queue our tree. The commit
> +		 * walk ensures we cover all parents.
> +		 */
>  		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
> -		fill_bitmap_tree(ent->bitmap, get_commit_tree(c));
> +		prio_queue_put(tree_queue, get_commit_tree(c));
>  
>  		for (p = c->parents; p; p = p->next) {
>  			int pos = find_object_pos(&p->item->object.oid);

[snip]

> @@ -386,6 +408,9 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  	size_t i;
>  	int nr_stored = 0; /* for progress */
>  	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
> +	struct prio_queue tree_queue = { NULL };

NULL here does mean LIFO queue. OK.

> @@ -395,6 +420,12 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
>  		the_repository);
>  
> +	old_bitmap = prepare_bitmap_git(to_pack->repo);
> +	if (old_bitmap)
> +		mapping = create_bitmap_mapping(old_bitmap, to_pack);
> +	else
> +		mapping = NULL;

Here, we prepare the old_bitmap and mapping arguments. OK.
