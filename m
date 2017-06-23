Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288801FA14
	for <e@80x24.org>; Fri, 23 Jun 2017 20:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbdFWUj6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:39:58 -0400
Received: from mout.web.de ([212.227.15.14]:63852 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755002AbdFWUj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:39:58 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzrwh-1dtb9U3uHD-01534U; Fri, 23
 Jun 2017 22:39:40 +0200
Subject: Re: [PATCH] xdiff: trim common tail with -U0 after diff
To:     Daniel Hahler <git@thequod.de>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170623103612.4694-1-git@thequod.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fa350688-1831-f979-b984-3b6d54e32b8c@web.de>
Date:   Fri, 23 Jun 2017 22:39:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170623103612.4694-1-git@thequod.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:PAux/f8Os1M6RaPsnOWwWuHdOKvj43kJK36AoWVB+WmbsI8SlAJ
 e4RTPwS8AFWRt01IGULnvtz/Fqalju2XQCWtdWwU/yzMZvwFv64S6W6C+pQl06/ME1/Kr6u
 BkO2fj9rnvwmtsostVTXs9O0rVoPsjA25nTfb8CU2lpLnr2jFP92zrIcbNuISJkZbkzyln2
 nvxWAslWZgb7smKVz+9fA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jrDvEGiW+zk=:alfds58RYJXNv4PbHpizkr
 tn0rcAjgdUx3xNNs7VIsSBd0vzwywcOrmCo/nrsdfQLKfGzyUBSVGmyzcTpeI9YQvgywtyvxl
 cxfqFmASNnjOlEErApNA+As6W1nbanAgjx9STV37i4kohsE1xk0L0uAHhmS2qmWwMx0m96u95
 pgziWMnB8tTDICNU0jvmuhhRuiUv51uXXOfBPzivp3+8S0mxIg7VRtIUx7K7VExCwi+Cze83Y
 V4uVIgaDAzSrNC/y+wEhK7wYGRY+fruoajCOW7xAkn9UBdXpuE3XHzO10CuKhoAaM+IK7OWUs
 8r7a2Iu9lylxyi4QeA4bC34il8yF/ow9drXjSoUob83BBs1j6gaOldl0Dd/WQhjg7nQAWp3OH
 EVP6kBTCAcRnF8L/rs1/3gG9eu18kC7aMpBgl46x1UU96Z0bDWCfSnNsyZvIqmUxDU11ubSsD
 snmH+601WRQYupo73wagGJWE+RCf6HTzgV0bXM7w+CmCEgF6qnAloRBZsIuH/ln9JtbzecF3w
 yK4lMwQdC8xXkrnC7RhMq+1xxQWeZ+nL0FTuIaEIZ2hFvDJmiBsVNd+2eHvvjcmth82Ikrn4l
 dB2zvSubYdQSPYbBIlqnSQz/BcPnT/SbstWTdU0JxsW3HoPpsrFlXWcYa3XlZ2vNsiLZvxxoa
 U7vBDWo32FvUWrbPH45tvhu99Q12gGSPEkZlyJddp8PUPCkGwKzmqIidb/soGTfdgqAmmqIJf
 wMxLH4unUlHzoUBezQrRUMOP4hp3XpfJs1X9jBeSyaKUfFiL51kBKQkr5NLTAMwqA59IjMUDu
 65nTvPq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.2017 um 12:36 schrieb Daniel Hahler:
> When -U0 is used, trim_common_tail should be called after `xdl_diff`, so
> that `--indent-heuristic` (and other diff processing) works as expected.
> 
> It also removes the check for `!(xecfg->flags & XDL_EMIT_FUNCCONTEXT)`
> added in e0876bca4, which does not appear to be necessary anymore after
> moving the trimming down.
> 
> This only adds a test to t4061-diff-indent.sh, but should also have one for
> normal (i.e. non-experimental) diff mode probably?!
> 
> Ref: https://github.com/tomtom/quickfixsigns_vim/issues/74#issue-237900460
> ---
>   t/t4061-diff-indent.sh | 15 +++++++++++++++
>   xdiff-interface.c      |  7 ++++---
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
> index 2affd7a10..df3151393 100755
> --- a/t/t4061-diff-indent.sh
> +++ b/t/t4061-diff-indent.sh
> @@ -116,6 +116,16 @@ test_expect_success 'prepare' '
>   	 4
>   	EOF
>   
> +	cat <<-\EOF >spaces-compacted-U0-expect &&
> +	diff --git a/spaces.txt b/spaces.txt
> +	--- a/spaces.txt
> +	+++ b/spaces.txt
> +	@@ -4,0 +5,3 @@ a
> +	+b
> +	+a
> +	+
> +	EOF
> +
>   	tr "_" " " <<-\EOF >functions-expect &&
>   	diff --git a/functions.c b/functions.c
>   	--- a/functions.c
> @@ -184,6 +194,11 @@ test_expect_success 'diff: --indent-heuristic with --histogram' '
>   	compare_diff spaces-compacted-expect out-compacted4
>   '
>   
> +test_expect_success 'diff: --indent-heuristic with -U0' '
> +	git diff -U0 --indent-heuristic old new -- spaces.txt >out-compacted5 &&
> +	compare_diff spaces-compacted-U0-expect out-compacted5
> +'
> +
>   test_expect_success 'diff: ugly functions' '
>   	git diff --no-indent-heuristic old new -- functions.c >out &&
>   	compare_diff functions-expect out

The changed test script passes just fine for me even without your change
to xdiff-interface.c, which is odd.  Do you have another way to
demonstrate the unexpected behavior?  And can someone replicate the
failure?

René
