Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1818C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973F86101B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhIAU1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:27:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62567 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhIAU1p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 16:27:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CCDDE6AF0;
        Wed,  1 Sep 2021 16:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3l8KQdYJgjuaUTtAj8JFa1RWH8QZchF9hdUSdB
        yVsSc=; b=lV5CBSRcUZM+JTePa7p3E3xla2fUYlqORpCqRONbqpiC/M86Ycr2FA
        QOfEBaaoBSSIapcBTinnwOKyc62MfxO6h2wk0fFn7qiMg07/gPwyfIOAs1kGyCLZ
        xh34OXQmgq5cpcU/7cGonQHiVQk2gcF1lGMl/HX28ncaM8EM6JqsA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93F4EE6AEE;
        Wed,  1 Sep 2021 16:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21B6EE6AED;
        Wed,  1 Sep 2021 16:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 2/3] test-lib-functions: optionally keep HOME, TERM
 and SHELL in 'test_pause'
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
        <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
        <328b5d6e76f598590d24b35ec23b5fd854c6cf05.1630503102.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 13:26:45 -0700
In-Reply-To: <328b5d6e76f598590d24b35ec23b5fd854c6cf05.1630503102.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Wed, 01 Sep 2021
        13:31:41 +0000")
Message-ID: <xmqq7dg0oxdm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED89F21C-0B62-11EC-BEE2-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +# Usage: test_pause [options]
> +#   -t
> +#	Use your original TERM instead of test-lib.sh's "dumb".
> +#	This usually restores color output in the invoked shell.
> +#	WARNING: this can break test reproducibility.
> +#   -s
> +#	Invoke $SHELL instead of $TEST_SHELL_PATH
> +#	WARNING: this can break test reproducibility.
> +#   -h
> +#	Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
> +#	This allows you to use your regular shell environment and Git aliases.
> +#	WARNING: this can break test reproducibility.
> +#	CAUTION: this can overwrite files in your HOME.
> +#   -a
> +#	Shortcut for -t -s -h

As this is not end-user facing but facing our developer, I do not
deeply care, but I find the warnings in this help text problematic.

Because a new process instance of $PAUSE_SHELL is run, the options
you add when inserting test_pause does not affect what happens in
the tests after you exit the $PAUSE_SHELL [*], right?

Of course, you can modify the repository or the working tree files
used in the test in the $PAUSE_SHELL, and that can break "test
reproducibility"---if you run "git ls-files -s" and take its output
in a temporary file, a step later in the test that runs "git status"
will see an extra untracked file, for example, and such a change may
(or may not) unnecessarily break the tests.

But it is not anything new introduced by these options.  It is
inherent to test_pause itself.

If we want to add a warning to the help text here, I think it should
be written in such a way that it is clear that the warning applies
to any use of the test_pause helper, not just to the form with the
options.

Thanks.


[Footnote]

* If we had an alternative implementation of test_pause that does
  not use a separate $PAUSE_SHELL process, but instead like
  inserting a read-eval-print loop, that would be far more powerful
  and useful debugging aid.  You can not just stop the execution of
  the test, and observe the files in the test repository and the
  environment variables---you can also access shell variables and
  functions.

  Such a test_pause from another world would deserve a "if you touch
  anything, the damage is permanent" warning even more than the
  current one, because you can modify even a shell variable to
  affect the execution of the test after you leave the paused state.
