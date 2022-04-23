Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08924C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 04:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiDWE1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiDWE1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 00:27:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EACB77
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 21:24:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E8D01820DC;
        Sat, 23 Apr 2022 00:24:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=0Y58ft0HJcpi3SlYWvTRRytf9
        pvQovUZvwXb1f4/bvw=; b=RJgPENlsrINNQ509QgjdxitydLIdsq1GoWgLT+KQo
        QIrRxzUkVtas7ev98qPc883DQsODeQlEj0XIAUDaSO5kwHj6DG6qxUFlbCFGA/B3
        3zHm57T+g1gGDHTevDOiAEtL3/InwAqHijQDtaeWR0k+nJcvmqgKuejbrQiTN8yM
        ks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86F181820DB;
        Sat, 23 Apr 2022 00:24:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15F6B1820D9;
        Sat, 23 Apr 2022 00:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/6] run-command tests: test stdout of
 run_command_parallel()
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <patch-2.6-d9c9b158130-20220421T122108Z-avarab@gmail.com>
Date:   Fri, 22 Apr 2022 21:24:17 -0700
Message-ID: <xmqq1qxo4eby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3E46380C-C2BD-11EC-8B81-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the tests added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) to test stdout in
> addition to stderr. A subsequent commit will add additional related
> tests for a new feature, making it obvious how the output of the two
> compares on both stdout and stderr will make this easier to reason
> about.

OK.

The original cared only about the standard error stream, and it was
sensible to name the actual output there "actual" and the correct
output "expect" to be compared.

But now we care _both_ the standard output and the standard error
streams, so if we call one "out", wouldn't we want to call the other
one "err", I wonder?  If it makes sense, it still is OK if we are
not doing so inside this step or in the series, but then it would
make sense to leave ourselves a NEEDSWORK: note to do so later when
the tree is quiescent.

Other than that, this one is pretty much boringly OK, and boring is
good.




>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t0061-run-command.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index ee281909bc3..131fcfda90f 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -130,17 +130,20 @@ World
>  EOF
> =20
>  test_expect_success 'run_command runs in parallel with more jobs avail=
able than tasks' '
> -	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n=
\" Hello World" 2>actual &&
> +	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n=
\" Hello World" >out 2>actual &&
> +	test_must_be_empty out &&
>  	test_cmp expect actual
>  '
> =20
>  test_expect_success 'run_command runs in parallel with as many jobs as=
 tasks' '
> -	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n=
\" Hello World" 2>actual &&
> +	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n=
\" Hello World" >out 2>actual &&
> +	test_must_be_empty out &&
>  	test_cmp expect actual
>  '
> =20
>  test_expect_success 'run_command runs in parallel with more tasks than=
 jobs available' '
> -	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n=
\" Hello World" 2>actual &&
> +	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n=
\" Hello World" >out 2>actual &&
> +	test_must_be_empty out &&
>  	test_cmp expect actual
>  '
> =20
> @@ -154,7 +157,8 @@ asking for a quick stop
>  EOF
> =20
>  test_expect_success 'run_command is asked to abort gracefully' '
> -	test-tool run-command run-command-abort 3 false 2>actual &&
> +	test-tool run-command run-command-abort 3 false >out 2>actual &&
> +	test_must_be_empty out &&
>  	test_cmp expect actual
>  '
> =20
> @@ -163,7 +167,8 @@ no further jobs available
>  EOF
> =20
>  test_expect_success 'run_command outputs ' '
> -	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\=
" Hello World" 2>actual &&
> +	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\=
" Hello World" >out 2>actual &&
> +	test_must_be_empty out &&
>  	test_cmp expect actual
>  '
