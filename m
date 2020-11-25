Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E707EC2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786AF208DB
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtRSFzgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKYBqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKYBqg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 20:46:36 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89994C0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:46:36 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 141so634152qkh.18
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=p6fjcNVGMiHAT+nZTxcG+qkUNdCV4Yzb0YMXwXT3Vek=;
        b=FtRSFzgBY7QFNOUsJMIyT9XOJqtjV8XtLYDPfWkOql1YeTWWH+LwmnA5V6HQyYqOT2
         IbR7t0LxcO2sqRm9AxaAcwUEWtaQIhP0HBE7BXTwhIxtGdfxDzYLkFVQ8E2kQmRMHSDO
         fx65hTAGVkBuuEQs9JLMVsKdMt8QTZoWnFwS4MWVBFq3yAWUUQPDXgK/0J2NJUOCTkyP
         DxKC288qg03tNtlfda7IKucHGlTc8foantRxZowtnn7n4SWOqpyv+SKRId8Dts5+xN9I
         y3Nd4m2xkOkeCNfRBBEElrqO2wB3IMc4WJOOFqqsPl285Woyza7C5h7+IkyWUqZ+QxR7
         ZuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p6fjcNVGMiHAT+nZTxcG+qkUNdCV4Yzb0YMXwXT3Vek=;
        b=ua2yYRJlBaoV/ijSvO3hioBlwnqMp7Ptx4XhGv1v5PtIsL9O3t8sX3CiMwpGBBFSYm
         2lXnXknkfhdkF/kPu73Ex62VI4j5cTt2tA0vyFWr4rKmiU51nr9Fs5wz+ZoiD847L/O3
         3anqB+dx6dZbwYl+wUODOGifQbchLPaz8Ogkfu2Hr+0MOaJN9lFp4JVXkt1S3lbAlwcL
         XkivHGTtkmpTTj50zTBmOPMoUq0mfBf2dUYWV8uyvZXzlN3qcV9s2aFFuHHXA9XvIHWi
         N77UTStTBKY6mEQUpGBC+yjeYTGYkmgAwN/cic1eRrIHrSsU2cL6yGcubuTM1Jl6sXxQ
         Namw==
X-Gm-Message-State: AOAM533kmVjfkrRyI8W1Yge9VUerOdpDev/q5rMn5bCI6D796w6P9mqu
        SUA+cAIYW7LFLWekaZHr/O8+xqwlapTsWPsGIJ2d
X-Google-Smtp-Source: ABdhPJyKbq/ZoYnnLLlwsNNr9SoWhPMhKX5amBJa2lOpnQ8PGuMZpGFDpjs2os3ESWsu0vUDFRH3HyeGZvjXnkRUl5kO
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bbc5:: with SMTP id
 c5mr1237030ybk.373.1606268795779; Tue, 24 Nov 2020 17:46:35 -0800 (PST)
Date:   Tue, 24 Nov 2020 17:46:33 -0800
In-Reply-To: <5262daa3300114fbaccdbc7393882c5435f95f4f.1605649533.git.me@ttaylorr.com>
Message-Id: <20201125014633.951649-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <5262daa3300114fbaccdbc7393882c5435f95f4f.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 18/24] pack-bitmap-write: build fewer intermediate bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've reviewed the commit message already [1]; now let's look at the code.

[1] https://lore.kernel.org/git/20201124060738.762751-1-jonathantanmy@google.com/

>  struct bb_commit {
>  	struct commit_list *reverse_edges;
> +	struct bitmap *commit_mask;
>  	struct bitmap *bitmap;
> -	unsigned selected:1;
> +	unsigned selected:1,
> +		 maximal:1;

The code itself probably should contain comments about the algorithm,
but I'm not sure of the best way to do it. (E.g. I would say that
"maximal" should be "When iteration in bitmap_builder_init() reaches
this bb_commit, this is true iff none of its descendants has or will
ever have the exact same commit_mask" - but then when do we explain why
the commit_mask matters?)

>  	unsigned idx; /* within selected array */
>  };
>  
> @@ -198,7 +200,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
>  {
>  	struct rev_info revs;
>  	struct commit *commit;
> -	unsigned int i;
> +	unsigned int i, num_maximal;
>  
>  	memset(bb, 0, sizeof(*bb));
>  	init_bb_data(&bb->data);
> @@ -210,27 +212,85 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
>  	for (i = 0; i < writer->selected_nr; i++) {
>  		struct commit *c = writer->selected[i].commit;
>  		struct bb_commit *ent = bb_data_at(&bb->data, c);
> +
>  		ent->selected = 1;
> +		ent->maximal = 1;
>  		ent->idx = i;
> +
> +		ent->commit_mask = bitmap_new();
> +		bitmap_set(ent->commit_mask, i);
> +
>  		add_pending_object(&revs, &c->object, "");
>  	}
> +	num_maximal = writer->selected_nr;
>  
>  	if (prepare_revision_walk(&revs))
>  		die("revision walk setup failed");
>  
>  	while ((commit = get_revision(&revs))) {
>  		struct commit_list *p;
> +		struct bb_commit *c_ent;
>  
>  		parse_commit_or_die(commit);
>  
> -		ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
> -		bb->commits[bb->commits_nr++] = commit;
> +		c_ent = bb_data_at(&bb->data, commit);
> +
> +		if (c_ent->maximal) {
> +			if (!c_ent->selected) {
> +				bitmap_set(c_ent->commit_mask, num_maximal);
> +				num_maximal++;
> +			}
> +
> +			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
> +			bb->commits[bb->commits_nr++] = commit;

So the order of bit assignments in the commit_mask and the order of
commits in bb->commits are not the same. In the commit_mask, bits are
first assigned for selected commits and then the rest for commits we
discover to be maximal. But in bb->commits, the order follows the
topologically-sorted iteration. This is fine, but might be worth a
comment (to add to the already big comment burden...)

> +		}
>  
>  		for (p = commit->parents; p; p = p->next) {
> -			struct bb_commit *ent = bb_data_at(&bb->data, p->item);
> -			commit_list_insert(commit, &ent->reverse_edges);
> +			struct bb_commit *p_ent = bb_data_at(&bb->data, p->item);
> +			int c_not_p, p_not_c;
> +
> +			if (!p_ent->commit_mask) {
> +				p_ent->commit_mask = bitmap_new();
> +				c_not_p = 1;
> +				p_not_c = 0;
> +			} else {
> +				c_not_p = bitmap_diff_nonzero(c_ent->commit_mask, p_ent->commit_mask);
> +				p_not_c = bitmap_diff_nonzero(p_ent->commit_mask, c_ent->commit_mask);
> +			}
> +
> +			if (!c_not_p)
> +				continue;
> +
> +			bitmap_or(p_ent->commit_mask, c_ent->commit_mask);
> +
> +			if (p_not_c)
> +				p_ent->maximal = 1;
> +			else {
> +				p_ent->maximal = 0;
> +				free_commit_list(p_ent->reverse_edges);
> +				p_ent->reverse_edges = NULL;
> +			}
> +
> +			if (c_ent->maximal) {
> +				commit_list_insert(commit, &p_ent->reverse_edges);
> +			} else {
> +				struct commit_list *cc = c_ent->reverse_edges;
> +
> +				for (; cc; cc = cc->next) {
> +					if (!commit_list_contains(cc->item, p_ent->reverse_edges))
> +						commit_list_insert(cc->item, &p_ent->reverse_edges);
> +				}
> +			}
>  		}
> +
> +		bitmap_free(c_ent->commit_mask);
> +		c_ent->commit_mask = NULL;
>  	}
> +
> +	trace2_data_intmax("pack-bitmap-write", the_repository,
> +			   "num_selected_commits", writer->selected_nr);
> +	trace2_data_intmax("pack-bitmap-write", the_repository,
> +			   "num_maximal_commits", num_maximal);
>  }

The rest looks like a faithful implementation of the algorithm.

Now let's look at the tests.

> +# To ensure the logic for "maximal commits" is exercised, make
> +# the repository a bit more complicated.
> +#
> +#    other                         master
> +#      *                             *
> +# (99 commits)                  (99 commits)
> +#      *                             *
> +#      |\                           /|
> +#      | * octo-other  octo-master * |
> +#      |/|\_________  ____________/|\|
> +#      | \          \/  __________/  |
> +#      |  | ________/\ /             |
> +#      *  |/          * merge-right  *
> +#      | _|__________/ \____________ |
> +#      |/ |                         \|
> +# (l1) *  * merge-left               * (r1)
> +#      | / \________________________ |
> +#      |/                           \|
> +# (l2) *                             * (r2)
> +#       \____________...____________ |

What does the ... represent? If a certain number of commits, it would be
clearer to write that there.

> +#                                   \|
> +#                                    * (base)

OK - some of the crosses are unclear, but from the bitmask given below,
I know where the lines should go.

> +#
> +# The important part for the maximal commit algorithm is how
> +# the bitmasks are extended. Assuming starting bit positions
> +# for master (bit 0) and other (bit 1), and some flexibility
> +# in the order that merge bases are visited, the bitmasks at
> +# the end should be:
> +#
> +#      master: 1       (maximal, selected)
> +#       other: 01      (maximal, selected)
> +# octo-master: 1
> +#  octo-other: 01
> +# merge-right: 111     (maximal)
> +#        (l1): 111
> +#        (r1): 111
> +#  merge-left: 1101    (maximal)
> +#        (l2): 11111   (maximal)
> +#        (r2): 111101  (maximal)
> +#      (base): 1111111 (maximal)

This makes sense. (l1) and (r1) are not maximal because everything that
can reach merge-right can also reach them.

[snip]

>  test_expect_success 'full repack creates bitmaps' '
> -	git repack -ad &&
> +	GIT_TRACE2_EVENT_NESTING=4 GIT_TRACE2_EVENT="$(pwd)/trace" \
> +		git repack -ad &&
>  	ls .git/objects/pack/ | grep bitmap >output &&
> -	test_line_count = 1 output
> +	test_line_count = 1 output &&
> +	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
> +	grep "\"key\":\"num_maximal_commits\",\"value\":\"111\"" trace

From the diagram and bit masks, I see that the important number for
"maximal" is 7. Could this test be run twice - one without the crosses
and one with, and we can verify that the difference between the maximal
commits is 7? As it is, this 111 number is hard to verify.
