Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC80C19F2C
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiHCQpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbiHCQpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:45:43 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434651ADB0
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659545126;
        bh=8giDOTmhzyTBijoiyeggvUZao25F9ub3An8IpzKiVsU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fbrWYSC6pVsXOK5zCgTXIGpOJSUcCevobx8GZ3TDJ/M524FdrJoYFqxZrCY0+8V2a
         8ZAS848Fhgv64Odyn1SdHzlYBmysWMxobwvo9cntaiK40AuuzaQzQpme2EqyJxL3bR
         xivl7f45Ml15aAJnKrsHBAhtWd9ejwEPyaN8FXBQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.148.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzit-1o21lH0Vmb-00Hu5Y; Wed, 03
 Aug 2022 18:45:26 +0200
Message-ID: <a9953278-b15f-fd76-17b0-e949c7937992@web.de>
Date:   Wed, 3 Aug 2022 18:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as non-blocking
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net>
 <YulFTSTbVaTwuQtt@coredump.intra.peff.net> <xmqq5yjahb8u.fsf@gitster.g>
 <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXUjnNFrS7okOi3bcIftJQXxX2/CkVL38jPPGqA7+mNu6mKvUeO
 KsVxnWZtRY2OdrbbLgQDJaqjOhMkYJzYQtzPJxt5HTXmomESsTnqMqhET9eBBPkl+hlmAQq
 a3YmxbKgV7ulUkURuk6qQe0SjwWkK/WaxM5Sdg4Tx6VV0Rqch7utcaVpknOwWASZwnRZ8JL
 OeOk4OVLXb/BiAVlf5iLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fGw7GxXncdM=:zSRFT0d666n6zvmrc+Y2EX
 fTSsSSsx55iEMLAzO3N72wJqayJeFZLVUp6Oi1Rb6jQ5iFK4Jay7ej9/kYLy6buqhsw4m66E2
 xOTQXjTVyOqOYAikAQaEyIIuU9P0QKmRmKVMZbsr3ut2vg1qqeiXzBds/FCcK4OGxbjz8S2CH
 fW14ncFF33EvVeSDTbZRcOxU8XK26ts9245LuFj/NS2F/yvImil55j83GggNTTgjcQpd09Mrf
 rJSf1syQVJxvQw3wTSDQoA9SPWugNQxnTpa/fpgMkzS42WRGeMUExpiyXy6RQTPJppg1eFlUv
 gmdOhD+PCfNHwh7M+LSjEEYQqTthG5GLEMf2zQeNZ02I3r5MKwTDvn+rcppG8+u0dyj8344bt
 HFJAWRJAEASTsvjYMmDW0iI4+Hm/K8rjeUxFD9OdsRei03mNeEBdjQYiCK4Xg6hOyAmbroKAW
 QmxbU+/9Lw0C5r9qFuS55HpUuBdg4fbRzzLlCdagXEvnRCqbPNLf4Gzhn7+hb3ypucdSwSR7L
 h9SsclmuCrLqs3IG9wmwXShokFBeFFriPtCrEoYG6TeZraVk58ZtvIouRxXDFesWg/gcUG1Sn
 O4hkVTUYv7eMrVd6Xdor9BKSpNcoSXk5aTncmst53u117DCq83PhycN8IwPfUxK6v1tnRR4uZ
 8kzDuNHA9v3d03A0MEfK5uxP9BTCorxOW0SW9M5fFe3IFaJI+xFvJfajBQOLyJ8Hr4qN380Fm
 fvi7aJ9Dw3vssbKMgueWV0ujtmiDV0riBIQiCXy2+uEDtAoLfb/30HuGVvcBzFTOFzUBkXpjC
 ESihV2zed65B9r2aKFsk9JKUej0CSHpOXH2sRNE0nGkdT2YT0yCH1p/ajVu0XnyFT+qAf93S0
 DznpUtn2ck0AgK9ectSTP/kFEpmv8GUKh8t1+mW3fznxOPeGYNMpkvW+9Y1PmQtwLxHV2kNmd
 14g4x6Wde+svL7ZApT131PZheQtXVL7mDnwBpWio63AwD0dy+dLgppYgZypDOs9FdbIe200Wm
 6t+eSxQVjSZ3G4J65ijaigqbFtTzxckWfuhM2jS58tFsEPH7lopi2ACrSIvu83B9YG/8+wcvd
 lObQ3d2FUFRv1QFDYcIEjj50W4QE3zP2ZjC
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.08.22 um 05:53 schrieb Jeff King:
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index b354fb39de..01d6ce9c83 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -766,6 +766,20 @@ test_expect_success 'detect bogus diffFilter output=
' '
>  	force_color test_must_fail git add -p <y
>  '
>
> +test_expect_success 'handle very large filtered diff' '
> +	git reset --hard &&
> +	# The specific number here is not important, but it must
> +	# be large enough that the output of "git diff --color"
> +	# fills up the pipe buffer. 10,000 results in ~200k of
> +	# colored output.
> +	test_seq 10000 >test &&
> +	false &&

Isn't this test going to end here, reporting failure before it even gets
to the interesting part?

> +	test_config interactive.diffFilter cat &&
> +	printf y >y &&
> +	force_color git add -p >output 2>&1 <y &&
> +	git diff-files --exit-code -- test
> +'
> +
>  test_expect_success 'diff.algorithm is passed to `git diff-files`' '
>  	git reset --hard &&
>

