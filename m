Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8277C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 02:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973DC610A0
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 02:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhHBChM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 22:37:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58137 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHBChL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 22:37:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99F20CAAC8;
        Sun,  1 Aug 2021 22:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B9imO2jsQSXS
        5kNmCQvRXdfeyh2xpzcW/7RsE/AFML8=; b=mCKiM93Tm6NugetxafD88QhA6Mpp
        fjVUSgKRMB23JxL+i6KoE64STf9vwyfANxnQY8fPYflXF1gx/cqKmKXdtjuDRmRT
        JmHprAybfYCp8NDL0uZ5Or/9ncD5zjskHDGDZJVu6tMYoMPkDveoSBwi0ED40X55
        OGTS8uDsB4PH6nI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91A01CAAC6;
        Sun,  1 Aug 2021 22:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C33ECAAC3;
        Sun,  1 Aug 2021 22:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH] t7508: avoid non POSIX BRE
References: <20210801215300.53781-1-carenas@gmail.com>
Date:   Sun, 01 Aug 2021 19:37:01 -0700
In-Reply-To: <20210801215300.53781-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 1 Aug 2021 14:53:00 -0700")
Message-ID: <xmqqv94oy3le.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8472BEAC-F33A-11EB-9F18-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 24c30e0b6 (wt-status: tolerate dangling marks, 2020-09-01) adds a test
> that uses a BRE which breaks at least with OpenBSD's grep.
>
> switch to an ERE as it is done for similar checks and while at it, remo=
ve
> the now obsolete test_i18ngrep call.

Thanks, obviously correct.

I wonder if we can more automate detection of such a bug---it is
unfortunate that it has become very hard to avoid GNUisms as
everybody, even Windows folks, is more likely to be with GNU tools
than BSD tools X-<.

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t7508-status.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 2b72451ba3..05c6c02435 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -882,7 +882,7 @@ test_expect_success 'status shows detached HEAD pro=
perly after checking out non-
>  	git clone upstream downstream &&
>  	git -C downstream checkout @{u} &&
>  	git -C downstream status >actual &&
> -	test_i18ngrep "HEAD detached at [0-9a-f]\\+" actual
> +	grep -E "HEAD detached at [0-9a-f]+" actual
>  '
> =20
>  test_expect_success 'setup status submodule summary' '
