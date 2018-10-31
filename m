Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 464EC1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 03:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeJaMcR (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 08:32:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38653 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJaMcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 08:32:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so14832336wrs.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+R9vjBKos9qMGa2vBI1uNb+7c6lTuuMFo2Oz1qzyV0w=;
        b=fVXgWf3CCQfppJkY/aL+0Snr7JzVpUfmJUDThwF7l0n4NGDQCmBaV8Am5D2xlh3LHl
         r1NCafMtz8FKaQmQaqAHmrgR3cKiop8KhnfsKJpQWMkMnSnhDpMFurEIe1dZ3xS5aLD4
         vMy2jAXk51HS+JfiF/nHhC6clyLEjD+q1qvFKVZ1L1kg/lXT/3r7AeZ4ZJ5irMRRYxI4
         hVoCOjCOrdljViJRfFoFTrcG2H7pdTEVtHun/83pHiHe7m6JP38Xeq4e9La7FcFTTp6v
         ZmfvbgaY67mo3rQD+iuJKNxucRmUV+kqd+JhzYn3gvjQpl8HWjfnCfSmvllpMJV6YDbe
         hAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+R9vjBKos9qMGa2vBI1uNb+7c6lTuuMFo2Oz1qzyV0w=;
        b=MI7Tgk//slbD4npjqIV3sw5gz50Q9BGU4EF5y+NIdbfoqUrQTG46TsdCGzaIu+lkp4
         8qJxpOQMW/C9RLwCxregt6aO33gOyk5biB+wjSsLO76L+ogzVahlcv6o4KO6pD4oQPq7
         4j9sryi853H9D+ikxzkORQ3jw3M1eIjY30wsmrkfW7QvSz2pckAwndrIalhZGufcwOEe
         Ey3nLTonzf/0x5Ap4dlDD3TWk7b132bsME/XVJx8kCvFXVgpxYJ+Q92sZv3Oyph6gfqZ
         y+K72sQttSNvbplrKdAhRWR92RBe85JkK4FiehIOEIha9Thqj4LDydfutYruGAQjtp4D
         oorg==
X-Gm-Message-State: AGRZ1gIx6pNhIDBUXc5zb6+e/h+TQcA6y15+D934z+cs25jIO+hoYRqK
        bmoAQ/sJG1wJbpY3sJIDGk4=
X-Google-Smtp-Source: AJdET5cIsVaD2Q4QcKq//ZgaXe2hs0fr81TGE2fL0OEt3n9tyPKKo5RJTtJWohut4zSDBcbk3FMuQw==
X-Received: by 2002:a5d:410d:: with SMTP id l13-v6mr1033519wrp.61.1540956962499;
        Tue, 30 Oct 2018 20:36:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t14-v6sm16406888wra.63.2018.10.30.20.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 20:36:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] commit-reach: implement get_reachable_subset
References: <pull.60.git.gitgitgadget@gmail.com>
        <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Oct 2018 12:35:59 +0900
In-Reply-To: <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 30 Oct 2018
        07:16:04 -0700 (PDT)")
Message-ID: <xmqqy3aeyehs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
> +					 struct commit **to, int nr_to,
> +					 int reachable_flag)

This is OR'ed into object.flags, and I somoehow expected to see it
as 'unsigned int', not a signed one.

> +{
> +	struct commit **item;
> +	struct commit *current;
> +	struct commit_list *found_commits = NULL;
> +	struct commit **to_last = to + nr_to;
> +	struct commit **from_last = from + nr_from;
> +	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
> +	int num_to_find = 0;
> +
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
> +
> +	for (item = to; item < to_last; item++) {
> +		struct commit *c = *item;
> +		
> +		parse_commit(c);
> +		if (c->generation < min_generation)
> +			min_generation = c->generation;
> +
> +		if (!(c->object.flags & PARENT1)) {
> +			c->object.flags |= PARENT1;
> +			num_to_find++;
> +		}
> +	}
> +
> +	for (item = from; item < from_last; item++) {
> +		struct commit *c = *item;
> +		if (!(c->object.flags & PARENT2)) {
> +			c->object.flags |= PARENT2;
> +			parse_commit(c);
> +
> +			prio_queue_put(&queue, *item);
> +		}
> +	}

OK, we marked "to" with PARENT1 and counted them in num_to_find
without dups.  We also marked "from" with PARENT2 and threw them in
the "queue" without dups.

Mental note: the caller must guarantee that everybody reachable from
"to" and "from" have PARENT1 and PARENT2 clear.  This might deserve
to be in the comment before the function.

> +	while (num_to_find && (current = prio_queue_get(&queue)) != NULL) {
> +		struct commit_list *parents;
> +
> +		if (current->object.flags & PARENT1) {
> +			current->object.flags &= ~PARENT1;
> +			current->object.flags |= reachable_flag;
> +			commit_list_insert(current, &found_commits);
> +			num_to_find--;

What is in "queue" are all reachable from "from" so we found this
object in the "to" set is reachable.  One down.

> +		}
> +
> +		for (parents = current->parents; parents; parents = parents->next) {
> +			struct commit *p = parents->item;
> +
> +			parse_commit(p);
> +
> +			if (p->generation < min_generation)
> +				continue;

Any commit reachable from "from" whose generation is too small
(i.e. old) can never reach any of "to", because all "to" are at
generation "min_generation" or greater.  Makes sense.

> +			if (p->object.flags & PARENT2)
> +				continue;

If the object is painted with PARENT2, we know we have it in queue
and traversing to find more of its ancestors.  Avoid recursing into
it twice.  Makes sense.

> +			p->object.flags |= PARENT2;
> +			prio_queue_put(&queue, p);

Otherwise, explore this parent.

> +		}
> +	}
> +
> +	clear_commit_marks_many(nr_to, to, PARENT1);

Among "to", the ones that were not found still have PARENT1.
Because we do not propagate this flag down the ancestry chain like
merge-base discovery, this only has to clear just one level.

> +	clear_commit_marks_many(nr_from, from, PARENT2);

And then we smudged everything that are reachable from "from"
with this flag.  In the worst case, i.e. when num_to_find is still
positive here, we would have painted all commits down to the root,
and we need to clear all of them.

> +	return found_commits;
> +}

OK, this all makes sense.  Unlike merge-base traversals, this does
not have to traverse from the "to" side at all, which makes it quite
simpler and straight-forward.

I do wonder if we can now reimplement in_merge_bases_many() in terms
of this helper, and if that gives us a better performance.  It asks
"is 'commit', i.e. a single 'to', an ancestor of, i.e. reachable
from, one of the 'references', i.e.  'from'"?

> diff --git a/commit-reach.h b/commit-reach.h
> index 7d313e297..43bd50a70 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -74,4 +74,14 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>  		       int commit_date_cutoff);
>  
> +
> +/*
> + * Return a list of commits containing the commits in the 'to' array
> + * that are reachable from at least one commit in the 'from' array.
> + * Also add the given 'flag' to each of the commits in the returned list.
> + */
> +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
> +					 struct commit **to, int nr_to,
> +					 int reachable_flag);
> +
>  #endif
