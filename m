Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32199C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50C62080A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 20:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C969Q7cH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbgJZUpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:45:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64351 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389197AbgJZUpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 16:45:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6532C91A28;
        Mon, 26 Oct 2020 16:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vF3rWmQkcI+6ETus28bwoh1LkxQ=; b=C969Q7
        cHDY/raFL8c34IuWBLAhWSBfmIwmU3ZTr6+sDsCel6lpVUN6rjSZICJ5tENtdEIc
        sPkhLXNaSQASXRNne8m07/DgSvvEXZ5zSIjxgm5MWxgSIcQQF4pXNN17sd+j9Miu
        iw1E7QD1BhjoXR5s+36ul/s9JH3h0t+E2CHC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AVMTKp/jszZIIvgf0eEXA1fBGkzZ2B4U
        L8AKiMnwKiTR2KlmM3PHuThVSQ2s440MF4AYW74ruB8lTm/6hteU3ZWUyxINwHS1
        1REAHGi2H6JAk+A0sTX+AY/XStNkotMQ3Fj5mAiMsqSuztG8MBav1Q0Z9gl0wWOS
        rP0i0XT1BoQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D5C091A27;
        Mon, 26 Oct 2020 16:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1CD491A25;
        Mon, 26 Oct 2020 16:45:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>
Subject: Re: [PATCH v2 1/4] merge-ort: barebones API of new merge strategy
 with empty implementation
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
        <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
        <b9e73975eab1f349be678779ff57155feb4c3501.1603731448.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 13:45:24 -0700
In-Reply-To: <b9e73975eab1f349be678779ff57155feb4c3501.1603731448.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Mon, 26 Oct 2020
        16:57:25 +0000")
Message-ID: <xmqqa6w8emxn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C4ABA9E-17CC-11EB-A36E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> + *   git merge [-s recursive]
> + *
> + * with
> + *
> + *   git merge -s ort
> + *
> + * Note: git's parser allows the space between '-s' and its argument to be
> + * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
> + * "cale", "peedy", or "ins" instead of "ort"?)

One thing that is quite unpleasant is "git grep ort" gives us too
many hits already, and it will be hard to locate ort related changes
with "git log --grep=ort", as the name is too short to serve as an
effective way to limit the search.

> diff --git a/merge-ort.h b/merge-ort.h
> new file mode 100644
> index 0000000000..47d30cf538
> --- /dev/null
> +++ b/merge-ort.h
> @@ -0,0 +1,49 @@
> +#ifndef MERGE_ORT_H
> +#define MERGE_ORT_H
> +
> +#include "merge-recursive.h"
> +
> +struct commit;
> +struct tree;
> +
> +struct merge_result {
> +	/* whether the merge is clean */
> +	int clean;
> +
> +	/* Result of merge.  If !clean, represents what would go in worktree */
> +	struct tree *tree;

Curious.  Because there is no way for "struct tree" to hold an
in-core pointer to a "struct blob" (iow, for a blob to be in a
"struct tree", it has to have been assigned an object name), unless
we are using the "pretend" mechanism, which has its own downsides,
we are committed to create a throw-away blob objects with conflict
markers in them, and write them to the object store.

If we were writing a new merge machinery from scratch, I would have
preferred a truly in-core implementation that does not have to write
out to the object store but if this makes the implementation simpler,
perhaps it is a small enough price to pay.

> +	/*
> +	 * Additional metadata used by merge_switch_to_result() or future calls
> +	 * to merge_inmemory_*().  Not for external use.
> +	 */
> +	void *priv;
> +	unsigned ate;

I'd prefer to see this named not so cute.  Will we hang random
variations of things, or would this be better to be made into a
pointer to union, with an enum that tells us which kind it is in
use?

> +};


> +/* rename-detecting three-way merge with recursive ancestor consolidation. */
> +void merge_inmemory_recursive(struct merge_options *opt,
> +			      struct commit_list *merge_bases,
> +			      struct commit *side1,
> +			      struct commit *side2,
> +			      struct merge_result *result);

I've seen "incore" spelled as a squashed-into-a-single-word, but not
"in_memory".

> +/* rename-detecting three-way merge, no recursion. */
> +void merge_inmemory_nonrecursive(struct merge_options *opt,
> +				 struct tree *merge_base,
> +				 struct tree *side1,
> +				 struct tree *side2,
> +				 struct merge_result *result);
> +
> +/* Update the working tree and index from head to result after inmemory merge */
> +void merge_switch_to_result(struct merge_options *opt,
> +			    struct tree *head,
> +			    struct merge_result *result,
> +			    int update_worktree_and_index,
> +			    int display_update_msgs);

To those who have known how our merge works, a natural expectation
for an "in-core" merge is that when the "in-core" merge finishes,
the index would hold the higher stages for the conflicted paths, and
cleanly merged paths would have the result at stage 0, and there is
an extra thing that we haven't had that represents what the working
tree files for conflicted paths should look like (historically we
wrote out the conflicted result to the working tree files---being
in-core operation we cannot afford to), so that (1) cleanly merged
paths can be externalized by writing from their stage 0 entries and
(2) contents with conflicts can be externalized by that "extra
thing".

But this helper says "working tree and index" are both updated, so
the "in-core" merge it expects must have not just the working tree
result (in result->tree, as the comment in the structure says) but
also how the higher stages of the index should look like somewhere
in the result structure.  How the latter is done is not at all clear
at this point in the mock-up.  Leaving it opaque is fine, but the
function, and the result structure, deserve clarification to avoid
confusing readers by highlighting how it is different from the
traditional ways (e.g. "we don't touch the index at all---instead we
store that in the priv/ate fields", if that is what is going on).

Thanks.
