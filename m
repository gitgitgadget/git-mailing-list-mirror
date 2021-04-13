Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F279FC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 23:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7E661246
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 23:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348030AbhDMXTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 19:19:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56693 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMXS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 19:18:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35BD51113B6;
        Tue, 13 Apr 2021 19:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=79bZYuKTUrSC5N+HyBMapjOArdg=; b=DqjBOu6paGJX6xeJVQL7
        K7vN3au8ns9lewRI9bBzKplW3PuK5+7TOWOT+j1G1VK6VU+8D0KKflUpdJvRuj0t
        uqrOHv4faDRrN345Va11qoO9u+F+xgpB9XKFYyuEETsxhzw2NyH6JmdmQ+wqsNMo
        dnuVQ/lRBAmSRwzSjCU7rF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=cM150CiZKkclxanvLWRYgr25yelLCAbhyKAwsees7pBSZU
        /3mP6IaNf5d40GHe4/oYflsEwdDky+L6W/KlQ6Ja2scih16hrx6XcsYt6qyNmQsa
        F6F7kVrhrrFGoOJ/GI9JCJAPZ2ZnaxmRSTJP8Icu3CCMQnEOhXzJGRM0GzGaE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DBD01113B5;
        Tue, 13 Apr 2021 19:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 726F81113B4;
        Tue, 13 Apr 2021 19:18:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/5] diff-merges: introduce --diff-merges=on
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210413114118.25693-1-sorganov@gmail.com>
        <20210413114118.25693-2-sorganov@gmail.com>
Date:   Tue, 13 Apr 2021 16:18:32 -0700
Message-ID: <xmqqfsztkc3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9188D672-9CAE-11EB-98DA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Introduce the notion of default diff format for merges, and the option
> "on" to select it. The default format is "separate" and can't yet
> be changed, so effectively "on" is just a synonym for "separate"
> for now. Add corresponding test to t4013.
>
> This is in preparation for introducing log.diffMerges configuration
> option that will let --diff-merges=on to be configured to any
> supported format.

"on"---that's short-and-sweet and really nice, compared to the "default"
in the previous iteration.

Clever.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c           | 7 +++++++
>  t/t4013-diff-various.sh | 8 ++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index 146bb50316a6..ff227368bd46 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -2,6 +2,11 @@
>  
>  #include "revision.h"
>  
> +typedef void (*diff_merges_setup_func_t)(struct rev_info *);
> +static void set_separate(struct rev_info *revs);
> +
> +static diff_merges_setup_func_t set_to_default = set_separate;
> +
>  static void suppress(struct rev_info *revs)
>  {
>  	revs->separate_merges = 0;
> @@ -66,6 +71,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
>  		set_combined(revs);
>  	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
>  		set_dense_combined(revs);
> +	else if (!strcmp(optarg, "on"))
> +		set_to_default(revs);
>  	else
>  		die(_("unknown value for --diff-merges: %s"), optarg);
>  
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 6cca8b84a6bf..26a7b4d19d4d 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -452,6 +452,14 @@ diff-tree --stat --compact-summary initial mode
>  diff-tree -R --stat --compact-summary initial mode
>  EOF
>  
> +test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
> +	git log -p --diff-merges=separate master >result &&
> +	process_diffs result >expected &&
> +	git log -p --diff-merges=on master >result &&
> +	process_diffs result >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'log -S requires an argument' '
>  	test_must_fail git log -S
>  '
