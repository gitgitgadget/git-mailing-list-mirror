Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F121F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbeGKOpp (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 10:45:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43982 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbeGKOpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 10:45:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id u11-v6so19386325eds.10
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Wvb63yOwmeT7a2QtViO6T/LcHCWzJAOHIo0e9d59iRk=;
        b=EhGTauYoh2ZGlwYwE++tR+XVb1uhW8RC1WJyKKcq0IIWNcjUdpqPGspjXOdtSq8D5V
         DhSRoriSRlGJd4In6ZXFLFHUxCFyZamcS9qDP6hZ3QBiZLhLlHqbj2ut1IDlTKdh009n
         uLkdidh1Vshob/79TvXMpZSUSDVysL+cDywk517yMzPCzCtz8X3PEc+Cffb5kQPXR1Fn
         +rQhI2KnNpUYuP/ZtHa8mh3U6iW7jqsR0LFYaVgb8oJZLbO5XqKoSfFPtKY88TxEob9M
         Sp6AV3xn1BNAlJeJpC22uFAJH7h80Tr9QmZ/GI5RgJQevJhPU3NcyLBTMnP1cpoWDXo9
         bvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Wvb63yOwmeT7a2QtViO6T/LcHCWzJAOHIo0e9d59iRk=;
        b=o/tAQmke3WA5ZyJtNzPG1darP9Oc7oYyPqexGepYvdLUelOgxbj99P2o+beWTiDagn
         IcUfmyk6YSqMo7mGCVPW9iXvq7mTnM5erSq6IbI33+Ou65lFs3XPG/QDQydcTGmPOIuF
         g6ATu/DKYKgK390NT1ugmkPLVFdOEzyjwOtEByxqEB2QkGQVjhpsLjedMcYrOg2NE/A2
         m0yMVsCUGfDG/DS/lDPTOu0DrgWaFQK7YL03QFVAG94Wsf1NB7EKaR3GJz579JRvb6Co
         k8MMRcPNRNtbecY1swr3gQMeeWsCV5FBlxf4y3e2qKLwH48I+cZNqrbagXYKpXyHtHgw
         2Fvg==
X-Gm-Message-State: APt69E3ueFqd2lwhlV8ja8LIgGQlaiVYvDIUabbf4jJVitleBMrgZPdw
        1WrKbmvs68laNXv8+OP8YBM=
X-Google-Smtp-Source: AAOMgpfJVgbp7sA0p66vujzgUY4iSnXDBwafzoSCpYhTidK/CiyBa+ZejUMllsmFQRZKyXAE+7QmQA==
X-Received: by 2002:a50:8818:: with SMTP id b24-v6mr32619084edb.274.1531320064240;
        Wed, 11 Jul 2018 07:41:04 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id z4-v6sm9307089edi.90.2018.07.11.07.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 07:41:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] has_uncommitted_changes(): fall back to empty tree
References: <87k1q2c9zq.fsf@evledraar.gmail.com> <20180711133402.GD23835@sigill.intra.peff.net> <20180711141406.GE23835@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180711141406.GE23835@sigill.intra.peff.net>
Date:   Wed, 11 Jul 2018 16:41:02 +0200
Message-ID: <87in5ldedd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 11 2018, Jeff King wrote:

> On Wed, Jul 11, 2018 at 09:34:02AM -0400, Jeff King wrote:
>
>> I do worry that other callers of run_diff_index() might have similar
>> problems, though. Grepping around, the other callers seem to fall into
>> one of three categories:
>>
>>  - they resolve the object themselves and put it in the pending list
>>    (and often fallback to the empty tree, which is more or less what the
>>    patch above is doing)
>>
>>  - they resolve the object themselves and avoid calling run_diff_index()
>>    if it's not valid
>>
>>  - they use setup_revisions(), which will barf on the broken object
>>
>> So I think this may be sufficient. We probably should also add an
>> assertion to run_diff_index(), since that's better than segfaulting.
>
> Here's a patch to do that. I tweaked it slightly from what I showed
> earlier to use the empty tree, which matches what other code (e.g.,
> git-diff) would do.
>
> -- >8 --
> Subject: has_uncommitted_changes(): fall back to empty tree
>
> If has_uncommitted_changes() can't resolve HEAD (e.g.,
> because it's unborn or corrupt), then we end up calling
> run_diff_index() with an empty revs.pending array. This
> causes a segfault, as run_diff_index() blindly looks at the
> first pending item.
>
> Fixing this raises a question of fault: should
> run_diff_index() handle this case, or is the caller wrong to
> pass an empty pending list?
>
> Looking at the other callers of run_diff_index(), they
> handle this in one of three ways:
>
>  - they resolve the object themselves, and avoid doing the
>    diff if it's not valid
>
>  - they resolve the object themselves, and fall back to the
>    empty tree
>
>  - they use setup_revisions(), which will die() if the
>    object isn't valid
>
> Since this is the only broken caller, that argues that the
> fix should go there. Falling back to the empty tree makes
> sense here, as we'd claim uncommitted changes if and only if
> the index is non-empty. This may be a little funny in the
> case of corruption (the corrupt HEAD probably _isn't_
> empty), but:
>
>   - we don't actually know the reason here that HEAD didn't
>     resolve (the much more likely case is that we have an
>     unborn HEAD, in which case the empty tree comparison is
>     the right thing)
>
>   - this matches how other code, like "git diff", behaves
>
> While we're thinking about it, let's add an assertion to
> run_diff_index(). It should always be passed a single
> object, and as this bug shows, it's easy to get it wrong
> (and an assertion is easier to hunt down than a segfault, or
> a quietly ignored extra tree).
>
> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff-lib.c      |  3 +++
>  t/t5520-pull.sh | 12 ++++++++++++
>  wt-status.c     | 10 ++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index a9f38eb5a3..732f684a49 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -520,6 +520,9 @@ int run_diff_index(struct rev_info *revs, int cached)
>  	struct object_array_entry *ent;
>  	uint64_t start = getnanotime();
>
> +	if (revs->pending.nr != 1)
> +		BUG("run_diff_index must be passed exactly one tree");
> +
>  	ent = revs->pending.objects;
>  	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
>  		exit(128);
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 59c4b778d3..68aa5f0340 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -618,6 +618,18 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
>  	)
>  '
>
> +test_expect_success 'pull --rebase fails on corrupt HEAD' '
> +	test_when_finished "rm -rf corrupt" &&
> +	git init corrupt &&
> +	(
> +		cd corrupt &&
> +		test_commit one &&
> +		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
> +		rm -f .git/objects/$obj &&
> +		test_must_fail git pull --rebase
> +	)
> +'
> +
>  test_expect_success 'setup for detecting upstreamed changes' '
>  	mkdir src &&
>  	(cd src &&
> diff --git a/wt-status.c b/wt-status.c
> index d1c05145a4..d89c41ba10 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2340,7 +2340,17 @@ int has_uncommitted_changes(int ignore_submodules)
>  	if (ignore_submodules)
>  		rev_info.diffopt.flags.ignore_submodules = 1;
>  	rev_info.diffopt.flags.quick = 1;
> +
>  	add_head_to_pending(&rev_info);
> +	if (!rev_info.pending.nr) {
> +		/*
> +		 * We have no head (or it's corrupt); use the empty tree,
> +		 * which will complain if the index is non-empty.
> +		 */
> +		struct tree *tree = lookup_tree(the_hash_algo->empty_tree);
> +		add_pending_object(&rev_info, &tree->object, "");
> +	}
> +
>  	diff_setup_done(&rev_info.diffopt);
>  	result = run_diff_index(&rev_info, 1);
>  	return diff_result_code(&rev_info.diffopt, result);

Thanks a lot. I've tested this and it looks good to me and fixes the
bug.

> [From upthread]: It took me a minute to reproduce this. It needs "pull
> --rebase" if you don't have that setup in your config.

Yeah, sorry about that. I tested without --rebase while simplifying the
testcase, but forgot that I have pull.rebase=true in my ~/.gitconfig, so
of course that didn't imply --no-rebase.
