Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BA3C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C429F60FD7
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhHLT7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:59:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54745 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhHLT7t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 15:59:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 038DEDE303;
        Thu, 12 Aug 2021 15:59:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hPLK62UffQ6+
        WRJbCJnAzrwdSBHghJ7dwcYYVDzk734=; b=JqS+xmJSfSbkRlLP/B3KlhRbX2hM
        EI3T7Fhf8eyPDKEEOyVtQPjoS9z9yb4Ae7mlzOMP33+lgJXKFqScrVclfTVjOMEj
        JLrzMhRRRLgv5b0uAGZ/D0c00nJql4ga+fUlBDPaWUY3MZrfUQV+055gIys4DrFp
        MFXhVoItQn5VgcA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB213DE301;
        Thu, 12 Aug 2021 15:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A50DDE300;
        Thu, 12 Aug 2021 15:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] ci: use upload-artifacts v1 for dockerized jobs
References: <20210812065234.71399-1-carenas@gmail.com>
Date:   Thu, 12 Aug 2021 12:59:21 -0700
In-Reply-To: <20210812065234.71399-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 11 Aug 2021 23:52:34 -0700")
Message-ID: <xmqq7dgq304m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C98D0252-FBA7-11EB-86E1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> e9f79acb28 (ci: upgrade to using actions/{up,down}load-artifacts v2,
> 2021-06-23) changed all calls to that action from v1 to v2, but there
> is still an open bug[1] that affects all nodejs actions and prevents
> its use in 32-bit linux (as used by the Linux32 container)
>
> move all dockerized jobs to use v1 that was build in C# and therefore

"was build -> was built", I would think.

> doesn't have this problem which will otherwise manifest with confusing
> messages like:
>
>   /usr/bin/docker exec  0285adacc4536b7cd962079c46f85fa05a71e66d7905b5e=
4b9b1a0e8b305722a sh -c "cat /etc/*release | grep ^ID"
>   OCI runtime exec failed: exec failed: container_linux.go:380: startin=
g container process caused: no such file or directory: unknown
>
> [1] https://github.com/actions/runner/issues/1011
> ---

Not signed off.

>  .github/workflows/main.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 47876a4f02..9dd41a1742 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -258,7 +258,7 @@ jobs:
>          - jobname: linux-musl
>            image: alpine
>          - jobname: Linux32
> -          image: daald/ubuntu32:xenial
> +          image: i386/ubuntu:xenial

Intended or accidental?  At least it is not explained where this
change comes from in the proposed log message.

>      env:
>        jobname: ${{matrix.vector.jobname}}
>      runs-on: ubuntu-latest
> @@ -271,7 +271,7 @@ jobs:
>        if: failure()
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> -      uses: actions/upload-artifact@v2
> +      uses: actions/upload-artifact@v1

This one matches what the proposed log message says, switching from
@v2 to @v1.

>        with:
>          name: failed-tests-${{matrix.vector.jobname}}
>          path: ${{env.FAILED_TEST_ARTIFACTS}}
