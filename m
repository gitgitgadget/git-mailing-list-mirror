Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90CAC433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AA120825
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uu/D6L2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgG1UX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:23:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63500 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgG1UX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:23:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EA1278129;
        Tue, 28 Jul 2020 16:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ITCtcssD9AXULYYsrad2Wt1C1b4=; b=uu/D6L
        2IX+3/3F0jxQhr+bmv1LKlUKbLtVuo/10kP+LqABEglzKzhb5mzAwQ16+KncP+ef
        xHKuSfq3fRYnPerS/9HlujfO0G7adLcTKSQ2V+PtE463Ay4eFRSaHxJ3bULrB2Hi
        lI/BHTUUKGLVRMpS+LaCBDu188fbfiibNrqoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=niFmZPVTqEIKz5ayDBXVP9K9ktt3KfgM
        79UTY7OFdRx3bMhu5O0IhHQpE3ZNycqtbo7D3hlMf8fQsrRsjOkJBHgrVs0JquOQ
        T/rD412TuZOue4dEjdGHPmcw2mSpU5MB9PFYg/p6t0mummQ8ROW43L2Tcdh1vjxa
        8TAa4zbNe04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6529878128;
        Tue, 28 Jul 2020 16:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E520C78127;
        Tue, 28 Jul 2020 16:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aaron Lipman via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Aaron Lipman <alipman88@gmail.com>
Subject: Re: [PATCH 1/3] rev-list: allow bisect and first-parent flags
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
        <25263842832eeb09769b55cec025978b5f361eca.1595951056.git.gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 13:23:54 -0700
In-Reply-To: <25263842832eeb09769b55cec025978b5f361eca.1595951056.git.gitgitgadget@gmail.com>
        (Aaron Lipman via GitGitGadget's message of "Tue, 28 Jul 2020 15:44:14
        +0000")
Message-ID: <xmqq4kpre6cl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42420AC6-D110-11EA-BE54-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aaron Lipman via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aaron Lipman <alipman88@gmail.com>
>
> Add first_parent_only parameter to find_bisection(), removing the
> barrier that prevented combining the --bisect and --first-parent flags
> when using git rev-list
>
> Signed-off-by: Aaron Lipman <alipman88@gmail.com>
> Based-on-patch-by: Tiago Botelho <tiagonbotelho@hotmail.com>

In chronological order, please.

> diff --git a/bisect.c b/bisect.c
> index d5e830410f..762f68c8e9 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -37,7 +37,7 @@ static const char *term_good;
>   * We care just barely enough to avoid recursing for
>   * non-merge entries.
>   */
> -static int count_distance(struct commit_list *entry)
> +static int count_distance(struct commit_list *entry, int first_parent_only)
>  {
>  	int nr = 0;
>  
> @@ -52,10 +52,10 @@ static int count_distance(struct commit_list *entry)
>  		commit->object.flags |= COUNTED;
>  		p = commit->parents;
>  		entry = p;
> -		if (p) {
> +		if (p && !first_parent_only) {
>  			p = p->next;
>  			while (p) {
> -				nr += count_distance(p);
> +				nr += count_distance(p, first_parent_only);
>  				p = p->next;
>  			}
>  		}

If you are running a first-parent-only bisection, by default, each
commit in the "goodness not yet known" region is treated as a single
parent commit for the purpose of bisection.  As do_find_bisection()
avoids the cost of calling stupid-and-expensive count_distance() by
treating such a single-strand-of-pearls specially, wouldn't it be a
BUG() if this funtion is called under first_parent_only mode in the
first place?

> @@ -88,15 +88,16 @@ static inline void weight_set(struct commit_list *elem, int weight)
>  	**commit_weight_at(&commit_weight, elem->item) = weight;
>  }


> -static int count_interesting_parents(struct commit *commit)
> +static int count_interesting_parents(struct commit *commit, int first_parent_only)
>  {
>  	struct commit_list *p;
>  	int count;
>  
>  	for (count = 0, p = commit->parents; p; p = p->next) {
> -		if (p->item->object.flags & UNINTERESTING)
> -			continue;
> -		count++;
> +		if (!(p->item->object.flags & UNINTERESTING))
> +			count++;
> +		if (first_parent_only)
> +			break;
>  	}
>  	return count;
>  }

Any merge will be checked for interesting-ness of its first parent;
there is either zero or one interesting parent and no other case
under first-parent-only.  OK.

> @@ -259,7 +260,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>   */
>  static struct commit_list *do_find_bisection(struct commit_list *list,
>  					     int nr, int *weights,
> -					     int find_all)
> +					     int find_all, int first_parent_only)
>  {
>  	int n, counted;
>  	struct commit_list *p;
> @@ -271,7 +272,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		unsigned flags = commit->object.flags;
>  
>  		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
> -		switch (count_interesting_parents(commit)) {
> +		switch (count_interesting_parents(commit, first_parent_only)) {
>  		case 0:
>  			if (!(flags & TREESAME)) {
>  				weight_set(p, 1);
> @@ -314,7 +315,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			continue;
>  		if (weight(p) != -2)
>  			continue;

If count-interesting-parents can never be 2 or more, you will never
see weight(p) == -2 (see the switch statement in the previous hunk).

So it your first-parent-only mode allowed this continue not to
trigger, you have a BUG(), I think.

> -		weight_set(p, count_distance(p));
> +		weight_set(p, count_distance(p, first_parent_only));

Hence, you do not need to touch count_distance() at all, no?

> @@ -330,13 +331,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  			struct commit_list *q;
>  			unsigned flags = p->item->object.flags;
>  
> +			/* if commit p has already been weighted, continue. */
>  			if (0 <= weight(p))
>  				continue;
> +
> +			/*
> +			 * otherwise, find the first interesting
> +			 * already-weighted parent of p and store as q.
> +			 */

Unnecessary changes above.

>  			for (q = p->item->parents; q; q = q->next) {
> -				if (q->item->object.flags & UNINTERESTING)
> -					continue;
> -				if (0 <= weight(q))
> +				if (!(q->item->object.flags & UNINTERESTING) && 0 <= weight(q)) {
> +					break;

Overlong line.  Fold it after "&&", like this:

				if (!(q->item->object.flags & UNINTERESTING) &&
				    0 <= weight(q)) {

What is this change about?

Ah, if the first parent is uninteresting, we do not want to
continue, but with the original loop, we may go on and check
q->next.  We just want to break out of the loop instead.

I strongly suspect that

			for (q = p->item->parents;
			     q;
			     q = first_parent_only ? NULL : q->next) {

without any change inside the loop is much easier to reason about.
We follow exactly the same logic as the usual case.  We just pretend
that all commits have only one single parent which is the first one.

Thanks.
