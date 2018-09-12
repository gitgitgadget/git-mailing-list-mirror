Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04071F404
	for <e@80x24.org>; Wed, 12 Sep 2018 20:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeIMBRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 21:17:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37877 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMBRq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 21:17:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so3752511wmc.2
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RskFp8B1+grqcT0Es8Le5StjJhmnSBiOy07y4gPgoD0=;
        b=pf7WWDePrJuO+UMykVAH7RUetC7Gq7OInHVWGGc2N1Y2zUySd0h/eO/sjPlYy3Xs4e
         YrWBt+vrp7p9iH5KqMkf8lOvWKs3me4Tw5MRxon7H934d9IVpAyoN+LJPoGmIk9+Y/jd
         A6QMTUSs0IfgTWdfMt/mBqRApUz76ndeLY7o2wGvXMSAbxvzu0Dhh7EvfBGFkPhve+xH
         BMhHZDKQzai9D6aghPo2fxGjSmlVl8GpFpwN8XQbUERBpoyX52zNqbJbBpd7Ef5Ttx5x
         eQrkLu3RQcE11xVpB8wTmAMfbZ4YZJzycSa7sUeteDBfoqGvtxaJ+sIi6fNfpDr4pg9F
         3gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RskFp8B1+grqcT0Es8Le5StjJhmnSBiOy07y4gPgoD0=;
        b=G1BLwARPYqpgYhAUSdcjE2cTIBHDG/D7g4A9IRLI5CpkIrkbfbftKLX6l76uvATYPf
         RNb6eGca7EX+GYzQ0FRn2u+utKz0Ddhxee+EDb3YUM0+fJcAEcfzlHM7pIdlwDqUVYsO
         7tCvR4u3I8UBPKO4C7HWalxc/8zUju6GAViptYtqYlvzo1sgsP5uu8RSiULNT4sxF5qZ
         S4S+OgnvEvQOXMu1TJY8Ame99p7ozvg3Z+i9yu1AtNQyVkdmkYtMvavmywO1Z2WZu/a0
         7YF6QA2NuN91uTnHIxaiE6IEvcnCW/QjLzU8XHGCwHHBLWgKcvQaHxill+F8mG/MRgTi
         lTOA==
X-Gm-Message-State: APzg51COiE1z9t4yicci1AFTSFHWR1MjvKXKb9eup/Mp8z2Jmt7XK+g1
        TjN/MtfcNpDMziltQ4+R8uw=
X-Google-Smtp-Source: ANB0VdYmzWoKPbD0ePE0t4EHJYkQfRZSVcQYTxXx+bb3+QVOwOPrrBaLLIhRNiWRqqSnlIl5DCvO5A==
X-Received: by 2002:a1c:9808:: with SMTP id a8-v6mr2791813wme.62.1536783095031;
        Wed, 12 Sep 2018 13:11:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 124-v6sm3869258wmk.20.2018.09.12.13.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 13:11:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, ryenus <ryenus@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] linear-assignment: fix potential out of bounds memory access
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
        <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
        <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
        <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
        <20180911163419.GB4865@hank.intra.tgummerer.com>
        <20180911172903.GC4865@hank.intra.tgummerer.com>
        <20180912190108.GE4865@hank.intra.tgummerer.com>
Date:   Wed, 12 Sep 2018 13:11:33 -0700
In-Reply-To: <20180912190108.GE4865@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Wed, 12 Sep 2018 20:01:08 +0100")
Message-ID: <xmqqy3c6jx1m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> > I'm looking into why that fails.  Also adding Dscho to Cc here as the
>> > author of this code.
>> 
>> The diff below seems to fix it.  Not submitting this as a proper
>> patch [...]
>
> I found the time to actually have a look at the paper, so here's a
> proper patch:
>
> I'm still not entirely sure what the initial code tried to do here,

It looks to me an attempt to optimize (instead of starting from a
value that is too big to be minimum, pick the first value and start
from there, and all the "found even smaller one, so let's replace"
later would work the same way) that went wrong (just that the "first
one" was written incorrectly), but it is not absolutely necessary to
find out why the code was written in a particular way that happened
to be buggy.

> but I think staying as close as possible to the original is probably
> our best option here, also for future readers of this code.

Thanks for digging.

> --- >8 ---
>
> Subject: [PATCH] linear-assignment: fix potential out of bounds memory access
>
> Currently the 'compute_assignment()' function can may read memory out
> of bounds, even if used correctly.  Namely this happens when we only
> have one column.  In that case we try to calculate the initial
> minimum cost using '!j1' as column in the reduction transfer code.
> That in turn causes us to try and get the cost from column 1 in the
> cost matrix, which does not exist, and thus results in an out of
> bounds memory read.

This nicely explains what goes wrong.

> Instead of trying to intialize the minimum cost from another column,
> just set it to INT_MAX.  This also matches what the example code in the
> original paper for the algorithm [1] does (it initializes the value to
> inf, for which INT_MAX is the closest match in C).

Yeah, if we really want to avoid INT_MAX we could use another "have
we found any value yet?" boolean variable, but the caller in
get_correspondences() does not even worry about integer overflows
when stuffing diffsize to the cost[] array, and the other possible
value that can go to cost[] array is COST_MAX that is mere 65k, so
it would be OK to use INT_MAX as sentinel here, I guess.

> Note that the test only fails under valgrind on Linux, but the same
> command has been reported to segfault on Mac OS.
>
> Also start from 0 in the loop, which matches what the example code in
> the original paper does as well.  Starting from 1 means we'd ignore
> the first column during the reduction transfer phase.  Note that in
> the original paper the loop does start from 1, but the implementation
> is in Pascal, where arrays are 1 indexed.
>
> [1]: Jonker, R., & Volgenant, A. (1987). A shortest augmenting path
>      algorithm for dense and sparse linear assignment
>      problems. Computing, 38(4), 325–340.
>
> Reported-by: ryenus <ryenus@gmail.com>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  linear-assignment.c   | 4 ++--
>  t/t3206-range-diff.sh | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/linear-assignment.c b/linear-assignment.c
> index 9b3e56e283..7700b80eeb 100644
> --- a/linear-assignment.c
> +++ b/linear-assignment.c
> @@ -51,8 +51,8 @@ void compute_assignment(int column_count, int row_count, int *cost,
>  		else if (j1 < -1)
>  			row2column[i] = -2 - j1;
>  		else {
> -			int min = COST(!j1, i) - v[!j1];
> -			for (j = 1; j < column_count; j++)
> +			int min = INT_MAX;
> +			for (j = 0; j < column_count; j++)
>  				if (j != j1 && min > COST(j, i) - v[j])
>  					min = COST(j, i) - v[j];
>  			v[j1] -= min;
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 2237c7f4af..fb4c13a84a 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'no commits on one side' '
> +	git commit --amend -m "new message" &&
> +	git range-diff master HEAD@{1} HEAD
> +'
> +
>  test_done
