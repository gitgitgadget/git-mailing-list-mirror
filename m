Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D6C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977B920772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rd+rgpdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCYRXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:23:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60152 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYRXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 13:23:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 621F759AA0;
        Wed, 25 Mar 2020 13:23:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bRs87v1wqDD22tjVd5+pJzFouqE=; b=Rd+rgp
        du3yL5RapWJ6oSnUHGwhgH7wEgPWafHJHmF5EDAnbvqwrJfi8egxR23qQGvQ5v+O
        8B9q9gjNN4g8YNGlHxVWJx/KeDS2VrrHMKr5R/rutwylNG66dqs03wHTP9tSNj7M
        xwrvxG3Is46cwz6ITBSP617cp7AWuhaZnaN20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E74MmsrSV9XP5rwmX9uCV8G1ZQFBHsxP
        MEKD8DtZdPwH5uwnr0dy5pf9RpIp9q3g/cDZjR+53k/dyMLqYVuyASl5MtM4LZQW
        gqvzWIWZDmjutAgTO2NIhdO/jrgW82xIMPVKs3Th3ywsgMK867JGqMs1DB0qk2SK
        irBP5XmhT7k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AD7D59A9F;
        Wed, 25 Mar 2020 13:23:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC54059A9E;
        Wed, 25 Mar 2020 13:23:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] tests: do not let lazy prereqs inside `test_expect_*` turn off tracing
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <0767c8b77c820cfc03bbc617da4dc9f20ba4a46a.1585114881.git.gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 10:23:10 -0700
In-Reply-To: <0767c8b77c820cfc03bbc617da4dc9f20ba4a46a.1585114881.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 25 Mar 2020
        05:41:20 +0000")
Message-ID: <xmqqwo78wdq9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D135E10-6EBD-11EA-BE34-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The `test_expect_*` functions use `test_eval_` and so does
> `test_run_lazy_prereq_`. If tracing is enabled via the `-x` option,
> `test_eval_` turns on tracing while evaluating the code block, and turns
> it off directly after it.
>
> This is unwanted for nested invocations.

Nice finding.

> As we will introduce just such a scenario with the GPG, GPGSM and
> RFC1991 prereqs, let's fix that by introducing a variable that keeps
> track of the current trace level: nested `test_eval_` calls will
> increment and then decrement the level, and only when it reaches 0, the
> tracing will _actually_ be turned off.

Doesn't this explanation urge us to reorder these patches?  It
sounds to me that it argues to have this step before 3/5.

Other than that, both the explanation and the code look correctly
done.  It looks to me that the surrounding code favors trailing "_"
instead of leading one for private names, so we might want to rename
the variable to $trace_level_ but that is minor.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0000-basic.sh | 13 +++++++++++++
>  t/test-lib.sh    |  6 ++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 3e440c078d5..b8597216200 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -833,6 +833,19 @@ then
>  	exit 1
>  fi
>  
> +test_expect_success 'lazy prereqs do not turn off tracing' "
> +	run_sub_test_lib_test lazy-prereq-and-tracing \
> +		'lazy prereqs and -x' -v -x <<-\\EOF &&
> +	test_lazy_prereq LAZY true
> +
> +	test_expect_success lazy 'test_have_prereq LAZY && echo trace'
> +
> +	test_done
> +	EOF
> +
> +	grep 'echo trace' lazy-prereq-and-tracing/err
> +"
> +
>  test_expect_success 'tests clean up even on failures' "
>  	run_sub_test_lib_test_err \
>  		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0ea1e5a05ed..dbf25348106 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -882,6 +882,7 @@ maybe_setup_valgrind () {
>  	fi
>  }
>  
> +_trace_level=0
>  want_trace () {
>  	test "$trace" = t && {
>  		test "$verbose" = t || test "$verbose_log" = t
> @@ -895,7 +896,7 @@ want_trace () {
>  test_eval_inner_ () {
>  	# Do not add anything extra (including LF) after '$*'
>  	eval "
> -		want_trace && set -x
> +		want_trace && _trace_level=$(($_trace_level+1)) && set -x
>  		$*"
>  }
>  
> @@ -926,7 +927,8 @@ test_eval_ () {
>  		test_eval_ret_=$?
>  		if want_trace
>  		then
> -			set +x
> +			test 1 = $_trace_level && set +x
> +			_trace_level=$(($_trace_level-1))
>  		fi
>  	} 2>/dev/null 4>&2
