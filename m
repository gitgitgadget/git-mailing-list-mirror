Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E811C636CE
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8E76100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357293AbhGSSW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 14:22:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58328 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382839AbhGSRm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:42:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0ED5DE851;
        Mon, 19 Jul 2021 14:23:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8krGajJrhirnoF4YuPSkwK3B6j9vH24M/CY2+u
        7Bogw=; b=CmR+KxQ7cyUJZB8cVZM0ezpMSnNox4Ms1UlEUEbr8s7qpAaLh21+Xu
        Rx+D13ZtxJ9GxEnZZsxdgwX/sMteCXE6t/IdvtjjFO+kE62eRLI7PYFd993azQc4
        0ftLzLI5oxeKk+Gqyqs6Bg34TLc3Lt5hHXlbohtUv8zWIyu+EszfU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 960F8DE850;
        Mon, 19 Jul 2021 14:23:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1470BDE84D;
        Mon, 19 Jul 2021 14:23:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/9] t7601: add relative precedence tests for merge and
 rebase flags/options
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 11:23:34 -0700
In-Reply-To: <6cb771297f5f7d5bb0c6734bcb3fe6d3b8bb4c88.1626536508.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 17 Jul 2021
        15:41:39 +0000")
Message-ID: <xmqq35samac9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DF3B23E-E8BE-11EB-8BE0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_does_rebase() {

Style: missing SP before ().

> +	git reset --hard c2 &&
> +	git "$@" . c1 &&

OK.

It is clear, from the "." (this repository), that this is designed
to test nothing but "git pull", and it is somewhat unfortunate that
we cannot spell out 'git pull' here (instead we ask the callers to
always pass 'pull' subcommand from the command line), but that is
understandable, as the primary reason we lack 'pull' from this
command line is because we expect to pass one-shot configuration to
the command via "-c pull.rebase=X".

> +	# Check that we actually did a rebase
> +	git rev-list --count HEAD >actual &&
> +	git rev-list --merges --count HEAD >>actual &&
> +	test_write_lines 3 0 >expect &&

The answer is 3 and zero.  OK.  The point of having this helper is
not because we want to do "pull --rebase" of different histories on
top of different base, but because we want to ensure that with
different configuration and command line options, the same "pull"
will result in the same flattening rebase.  So it is not a problem
at all that these numbers are hardcoded (it might make it less
fragile to count only commits above c2, but it probably would not
matter).

> +	test_cmp expect actual &&
> +	rm actual expect
> +}

OK.

> +test_does_merge_noff() {
> +	git reset --hard c0 &&
> +	git "$@" . c1 &&
> +	# Check that we actually did a merge
> +	git rev-list --count HEAD >actual &&
> +	git rev-list --merges --count HEAD >>actual &&
> +	test_write_lines 3 1 >expect &&
> +	test_cmp expect actual &&
> +	rm actual expect
> +}
> +
> +test_does_merge_ff() {
> +	git reset --hard c0 &&
> +	git "$@" . c1 &&
> +	# Check that we actually did a merge
> +	git rev-list --count HEAD >actual &&
> +	git rev-list --merges --count HEAD >>actual &&
> +	test_write_lines 2 0 >expect &&
> +	test_cmp expect actual &&
> +	rm actual expect
> +}
> +
> +test_does_need_full_merge() {
> +	git reset --hard c2 &&
> +	git "$@" . c1 &&
> +	# Check that we actually did a merge
> +	git rev-list --count HEAD >actual &&
> +	git rev-list --merges --count HEAD >>actual &&
> +	test_write_lines 4 1 >expect &&
> +	test_cmp expect actual &&
> +	rm actual expect
> +}
> +
> +test_attempts_fast_forward() {
> +	git reset --hard c2 &&
> +	test_must_fail git "$@" . c1 2>err &&
> +	test_i18ngrep "Not possible to fast-forward, aborting" err
> +}

The same reasoning says these test_does_X helpers make sense.  I am
not sure about the name does_need_full_merge though---what does it
want to ensure is not very clear to me.  Is it named that way because
you found "test_does_merge" (when contrasted to "test_does_merge_ff")
sounds too weak?

> +#
> +# Rule 1: --ff-only takes precedence over --[no-]rebase
> +# (Corollary: pull.ff=only overrides pull.rebase)
> +#
> +test_expect_failure '--ff-only takes precedence over --rebase' '
> +	test_attempts_fast_forward pull --rebase --ff-only
> +'
> +
> +test_expect_failure '--ff-only takes precedence over --rebase even if first' '
> +	test_attempts_fast_forward pull --ff-only --rebase
> +'
> +
> +test_expect_success '--ff-only takes precedence over --no-rebase' '
> +	test_attempts_fast_forward pull --ff-only --no-rebase
> +'
> +
> +test_expect_failure 'pull.ff=only overrides pull.rebase=true' '
> +	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
> +'
> +
> +test_expect_success 'pull.ff=only overrides pull.rebase=false' '
> +	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=false pull
> +'

OK.  These all ensure that when the history does not fast-forward,
the command will fail when --ff-only tells us to allow only
fast-forward.  I am not sure "takes precedence" is a meaningful
label, though.  It is more like "ff-only means ff-only and fails
when the upstream history is not a descendant, no matter how the
possible integration is set to be performed".

> +# Rule 2: --rebase=[!false] takes precedence over --no-ff and --ff
> +# (Corollary: pull.rebase=!false overrides pull.ff=!only)
> +test_expect_success '--rebase takes precedence over --no-ff' '
> +	test_does_rebase pull --rebase --no-ff
> +'
> +
> +test_expect_success '--rebase takes precedence over --ff' '
> +	test_does_rebase pull --rebase --ff
> +'
> +
> +test_expect_success 'pull.rebase=true takes precedence over pull.ff=false' '
> +	test_does_rebase -c pull.rebase=true -c pull.ff=false pull
> +'
> +
> +test_expect_success 'pull.rebase=true takes precedence over pull.ff=true' '
> +	test_does_rebase -c pull.rebase=true -c pull.ff=true pull
> +'

Sounds sensible.  Again, I do not view this as precedence, though.
"--ff" is merely "if there is nothing else needs to be done, it is
OK to fast-forward to their history", so with --rebase, it either
(1) gets ignored when we have something to be done, i.e. our own
development to replay on top of their history, or (2) becomes a
no-op as there truly isn't any development of our own.

And "--no-ff" is more or less a meaningless thing to say ("I do not
want to just fast-forward when I do not have anything meaningful to
add, I want an empty merge commit to mark where I was") in the
context of "--rebase".  Erroring out only when their histroy is
descendant of ours and "--no-ff" and "--rebase=<set>" are given
explicitly from the command line might make sense, but I do not
think of a sensible corrective action the end-user wants to do after
seeing such an error (after all, there was nothing to rebase on top
of their history), so I think ignoring is a more acceptable outcome
when we have nothing to replay.

Do we ensure that "pull --rebase --ff" fast-forwards when the
history truly fast-forwards?  test_does_rebase only and always
checks what happens when pulling c1 into c2 and nothing else, so I
do not think the above are testing that case.

IOW, I think "test_does_merge_ff pull --rebase --ff" wants to be
there somewhere?

> +# Rule 3: command line flags take precedence over config
> +test_expect_failure '--ff-only takes precedence over pull.rebase=true' '
> +	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
> +'
> +
> +test_expect_success '--ff-only takes precedence over pull.rebase=false' '
> +	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
> +'

Both are good.

> +test_expect_failure '--no-rebase overrides pull.ff=only' '
> +	test_does_need_full_merge -c pull.ff=only pull --no-rebase
> +'
> +
> +test_expect_success '--rebase takes precedence over pull.ff=only' '
> +	test_does_rebase -c pull.ff=only pull --rebase
> +'

OK.

> +test_expect_success '--rebase takes precedence over pull.ff=true' '
> +	test_does_rebase -c pull.ff=true pull --rebase
> +'
> +
> +test_expect_success '--rebase takes precedence over pull.ff=false' '
> +	test_does_rebase -c pull.ff=false pull --rebase
> +'
> +
> +test_expect_success '--rebase takes precedence over pull.ff unset' '
> +	test_does_rebase pull --rebase
> +'

These three are correct but again I do not see them as precedence
matter.

> +# Rule 4: --no-rebase heeds pull.ff=!only or explict --ff or --no-ff
> +
> +test_expect_success '--no-rebase works with --no-ff' '
> +	test_does_merge_noff pull --no-rebase --no-ff
> +'

OK.

> +test_expect_success '--no-rebase works with --ff' '
> +	test_does_merge_ff pull --no-rebase --ff
> +'

OK.

> +test_expect_success '--no-rebase does ff if pull.ff unset' '
> +	test_does_merge_ff pull --no-rebase
> +'

OK.

> +test_expect_success '--no-rebase heeds pull.ff=true' '
> +	test_does_merge_ff -c pull.ff=true pull --no-rebase
> +'

OK (pull.ff=true is the default anyway).

> +test_expect_success '--no-rebase heeds pull.ff=false' '
> +	test_does_merge_noff -c pull.ff=false pull --no-rebase
> +'

OK.

> +# Rule 5: pull.rebase=!false takes precedence over --no-ff and --ff
> +test_expect_success 'pull.rebase=true takes precedence over --no-ff' '
> +	test_does_rebase -c pull.rebase=true pull --no-ff
> +'

OK.  When we do have our own commits they do not have, there is no
point in letting --no-ff do anything special.  It would be sensible
to replay ours on top of theirs.


> +test_expect_success 'pull.rebase=true takes precedence over --ff' '
> +	test_does_rebase -c pull.rebase=true pull --ff
> +'

Again, I am not sure if this is "precedence" issue.  "ff" merely
means "fast-forwarding is allowed, when we do not have anything to
add to their history", and we do have our own work in the test
scenario test_does_rebase presents us, so rebasing would be quite
sensible.  Similarly

    test_does_need_full_merge -c pull.rebase=false pull --ff

would be true, right?

> +# End of precedence rules
> +
>  test_expect_success 'merge c1 with c2' '
>  	git reset --hard c1 &&
>  	test -f c0.c &&

The series of new tests makes me wonder if there is a good way to
ensure we covered full matrix, but I didn't see any that smelled
wrong.

Thanks.

