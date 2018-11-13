Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1361F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 02:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeKMMZm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 07:25:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54521 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeKMMZm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 07:25:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D754C1F026;
        Mon, 12 Nov 2018 21:29:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7P1BvY28eH9vI3I4NwdnZKgkIuI=; b=HM4MEe
        RAsm6glY4tat0fEXpaWyX3nPG4jMRQA1yn7hkq0UPSsFdaUb97jFfS8JjI9DUjBg
        NNOmcJAnnkHCgl4ihYk/0cewaSdd8sD4mBRsRm3BYYc3rr0VuHCIO7Bk3/N2IrcB
        tRW9K53Jb6ifcNLYYmJuHmw5E6N+Nh49e75sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V/qrqqBBtJ9GTDGVNWWUiD/9KLGO7c9+
        jKC32uisPFhs3jzbXnJwtKgLeGPE3bZenqTcqt09Kk1CvHst0zMlnibUxPLpT54V
        ns6cMTtP4FE7AfsJ4c1IGrM35FqU3XR6VHWI6XmoUfqTnhxNHEcW2DkC4bjCKtWS
        70beidjDvqk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0AE11F025;
        Mon, 12 Nov 2018 21:29:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7DAC1F022;
        Mon, 12 Nov 2018 21:29:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] rebase -r: demonstrate bug with conflicting merges
References: <pull.75.git.gitgitgadget@gmail.com>
        <efdd3736a96f90a4ab52acaf2e5efbe3435bcb89.1542065154.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Nov 2018 11:29:38 +0900
In-Reply-To: <efdd3736a96f90a4ab52acaf2e5efbe3435bcb89.1542065154.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        15:25:57 -0800 (PST)")
Message-ID: <xmqqh8glyajx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F94B5E36-E6EB-11E8-A4C4-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When calling `merge` on a branch that has already been merged, that
> `merge` is skipped quietly, but currently a MERGE_HEAD file is being
> left behind and will then be grabbed by the next `pick` (that did
> not want to create a *merge* commit).
>
> Demonstrate this.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3430-rebase-merges.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

For a trivially small change/fix like this, it is OK and even
preferrable to make 1+2 a single step, as applying t/ part only to
try to see the breakage (or "am"ing everything and then "diff |
apply -R" the part outside t/ for the same purpose) is easy enough.

Because the patch 2 with your method ends up showing only the test
set-up part in the context by changing _failure to _success, without
showing what end-user visible breakage the step fixed, which usually
comes near the end of the added test piece.  A single patch that
gives tests that ought to succeed would not force the readers to
switch between patches 1 and 2 while reading the fix.

Of course, the above would not apply for a more involved case where
the actual fix to the code needs to span multiple patches.

Thanks.

> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index aa7bfc88ec..1f08a33687 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -396,4 +396,20 @@ test_expect_success 'with --autosquash and --exec' '
>  	grep "G: +G" actual
>  '
>  
> +test_expect_failure '--continue after resolving conflicts after a merge' '
> +	git checkout -b already-has-g E &&
> +	git cherry-pick E..G &&
> +	test_commit H2 &&
> +
> +	git checkout -b conflicts-in-merge H &&
> +	test_commit H2 H2.t conflicts H2-conflict &&
> +	test_must_fail git rebase -r already-has-g &&
> +	grep conflicts H2.t &&

Is this making sure that the above test_must_fail succeeded because
of a conflict and not due to any other failure?  I would have used
"ls-files -u H2.t" to see if the index is unmerged, which probably
is a more direct way to test what this is trying to test, but if we
are in the conflicted state, the one side of << == >> has this
string (the other has "H2" in it, presumably?), so in practice this
should be good enough.

> +	echo resolved >H2.t &&
> +	git add -u &&

and we resolve to continue.

> +	git rebase --continue &&
> +	test_must_fail git rev-parse --verify HEAD^2 &&

Even if we made an octopus by mistake, the above will catch it,
which is good.

> +	test_path_is_missing .git/MERGE_HEAD
> +'
> +
>  test_done

And from the proposed log message, I am reading that the last two
things (i.e. resulting tip is a child with a single parent and there
is no leftover MERGE_HEAD file) fail without the fix.  

This is enough material to convince me or anybody that the bug is
worth fixing.  Thanks for being careful noticing a glitch during
your real (and otherwise unrelated to the bug) work and following
through.
