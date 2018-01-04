Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17F61F404
	for <e@80x24.org>; Thu,  4 Jan 2018 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeADSkr (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 13:40:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51201 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeADSkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 13:40:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35F61CA152;
        Thu,  4 Jan 2018 13:40:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k5eb41XJxGJC
        QOdYIfjn5uIRYEw=; b=X6Vsykp/L1dLWt5pBNal2RdmA8Vie+XhIGXot2OMpfEX
        znQKZj9q74o8GvQUy8yoPTG9FkD18/mkcH9M99dN6d+9ZsHK4h0AJNKJoTSlY91M
        LnEKP4bwmYQRtx/8oGK5aR61trVvh8lci9Hz3EMNfxSzA//bqWq8RLsjQk+uq0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WS293w
        Pb6tQ46EomkSWzv8S3YT+eQEBwrgcEAlsT8Y82sYklCWcMOpl3mAs1e4ohIXEJ1o
        4iwcEyPifXxih2+LRVyIX0pzPlsDKmvkHQB7JtWAr6ieGOuN9ZRejIcumZeSru0d
        Y4KEoV7b6vZOnEQl+e/TtZlC4BYdOdnRrr0nQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DD91CA150;
        Thu,  4 Jan 2018 13:40:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2125CA14F;
        Thu,  4 Jan 2018 13:40:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] perf: amend the grep tests to test grep.threads
References: <20171229225903.19688-1-avarab@gmail.com>
Date:   Thu, 04 Jan 2018 10:40:44 -0800
In-Reply-To: <20171229225903.19688-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 29 Dec 2017 22:59:03 +0000")
Message-ID: <xmqqinchfowj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C683B916-F17E-11E7-A4C9-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Ever since 5b594f457a ("Threaded grep", 2010-01-25) the number of
> threads git-grep uses under PTHREADS has been hardcoded to 8, but
> there's no performance test to check whether this is an optimal
> setting.
>
> Amend the existing tests for the grep engines to support a mode where
> this can be tested, e.g.:
>
>     GIT_PERF_GREP_THREADS=3D'1 8 16' GIT_PERF_LARGE_REPO=3D~/g/linux ./=
run p782*
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> This looks less scary under diff -w.
>
>  t/perf/p7820-grep-engines.sh       | 52 ++++++++++++++++++++++++++++--=
-----
>  t/perf/p7821-grep-engines-fixed.sh | 55 ++++++++++++++++++++++++++++++=
--------
>  2 files changed, 86 insertions(+), 21 deletions(-)
>
> diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.s=
h
> index 62aba19e76..8b09c5bf32 100755
> --- a/t/perf/p7820-grep-engines.sh
> +++ b/t/perf/p7820-grep-engines.sh
> @@ -12,6 +12,9 @@ e.g. GIT_PERF_7820_GREP_OPTS=3D' -i'. Some options to=
 try:
> ...
> +		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>  		then
> -			test_cmp out.basic out.perl
> +			test_perf $prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'"=
 "
> +				git -c grep.patternType=3D$engine grep$GIT_PERF_7820_GREP_OPTS -- =
'$pattern' >'out.$engine' || :
> +			"
> +		else
> +			for threads in $GIT_PERF_GREP_THREADS
> +			do
> +				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '=
$pattern' with $threads threads" "

Is it guaranteed that $prereq is not empty at this point? =20

Judging by the way the other side uses "test_perf $prereq ..."
without quotes around it, I suspect you do expect it to be empty in
some cases.  It means you expect test_have_prereq is prepared to
skip an empty prerequisite in a prereq list, but I do not recall
writing that helper in such a way, so...

	PTHREADS${prereq:+,}$prereq

or something along that line, perhaps?

> diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-eng=
ines-fixed.sh
> index c7ef1e198f..61e41b82cf 100755
> --- a/t/perf/p7821-grep-engines-fixed.sh
> +++ b/t/perf/p7821-grep-engines-fixed.sh
> @@ -6,6 +6,9 @@ Set GIT_PERF_7821_GREP_OPTS in the environment to pass =
options to
> ...
>  for pattern in 'int' 'uncommon' '=C3=A6'
>  do
>  	for engine in fixed basic extended perl
> @@ -23,19 +31,44 @@ do
> ...
> +		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>  		then
> -			test_cmp out.fixed out.perl
> +			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
> +				git -c grep.patternType=3D$engine grep$GIT_PERF_7821_GREP_OPTS $pa=
ttern >'out.$engine' || :
> +			"
> +		else
> +			for threads in $GIT_PERF_GREP_THREADS
> +			do
> +				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $=
pattern with $threads threads" "
> +					git -c grep.patternType=3D$engine -c grep.threads=3D$threads grep=
$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
> +				"
> +			done

Same here, which means these two scripts share somewhat large body
of text and makes me wonder if it is worth refactoring it to ease
future updates to them.

Thanks.
