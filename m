Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FC1C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5968206CB
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k7fznEbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgJFTLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:11:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59568 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFTLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 15:11:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2BD8E4253;
        Tue,  6 Oct 2020 15:11:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UzZISOmddlLX
        aApzkFnhZfi6Hko=; b=k7fznEbGoIErPoUilCjDQyMlvI7m4qnuHYhgMnMwEftN
        pDUW9yGoiJ4Dkb6/EXJ+DDvYm1O0LjFlhzq1YlQ7K8MwOV5J4ovygidAk/fpfnMp
        kL5nK1Kf8jRpb7fqtu1Hvob2zrMxZi0v1kgHqutn8ghn+Sw7xYn+g7vPsohQLJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rHssXI
        qwUY4j2InSfj5yTumlNKycfwQVVwi37BPP3jRFW7ci2Nb4nVPMcg+cW1cnT5G7Gq
        xhYYDDI64IAHtN+oaENAFKLz362WB2uD06VUzx17OdzZj6h73EGiZcQH/kedsS3j
        faSESJxSBU7xw2T8jL36+IOENp/mNHBOF1QTs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC6D9E4251;
        Tue,  6 Oct 2020 15:11:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3328DE424F;
        Tue,  6 Oct 2020 15:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5534: split stdout and stderr redirection
References: <20201006150818.15698-1-congdanhqx@gmail.com>
Date:   Tue, 06 Oct 2020 12:11:00 -0700
In-Reply-To: <20201006150818.15698-1-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Tue, 6 Oct 2020 22:08:18 +0700")
Message-ID: <xmqqft6r5fwb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ACD31B72-0807-11EB-9E0D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On atomic pushing failure with GnuPG, we expect a very specific output
> in stdout due to `--porcelain` switch.
>
> On such failure, we also write down some helpful hint into stderr
> in order to help user understand what happens and how to continue from
> those failures.
>
> On a lot of system, those hint (in stderr) will be flushed first,
> then those messages in stdout will be flushed. In such systems, the
> current test code is fine as is.
>
> However, we don't have such guarantee, (at least) there're some real
> systems that writes those stream interleaved. On such systems, we may
> see the stderr stream written in the middle of stdout stream.
>
> Let's split those stream redirection. By splitting those stream,
> the output stream will contain exactly what we want to compare,
> thus, saving us a "sed" invocation.

Makes sense.

> While we're at it, change the `test_i18ncmp` to `test_cmp` because we
> will never translate those messages (because of `--porcelain`).

Good thinking.  It would make sure that we will catch when we
accidentally mark messages meant for --porcelain with the
gettext-poison tests.

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  Arguably, I would say it's OK to change the:
>  =09
>  	test_i18ngrep ! "gpg failed to sign"
>
>  to:
>
>  	! grep "gpg failed to sign"
>
>  since the latter will be correct even if GIT_TEST_GETTEXT_POISON=3Dtru=
e

Is it because we haven't managed to translate this particular
message, or is it because we should never ever translate it perhaps
because the message is meant for machine consumption?  If the
latter, yes, I agree with the reasoning, but I do not see a reason
why this message should never be translated.

>  t/t5534-push-signed.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 7e928aff66..af0385fb89 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -282,10 +282,9 @@ test_expect_success GPG 'failed atomic push does n=
ot execute GPG' '
>  	EOF
>  	test_must_fail env PATH=3D"$TRASH_DIRECTORY:$PATH" git push \
>  			--signed --atomic --porcelain \
> -			dst noop ff noff >out 2>&1 &&
> +			dst noop ff noff >out 2>err &&
> =20
> -	test_i18ngrep ! "gpg failed to sign" out &&
> -	sed -n -e "/^To dst/,$ p" out >actual &&
> +	test_i18ngrep ! "gpg failed to sign" err &&
>  	cat >expect <<-EOF &&
>  	To dst
>  	=3D	refs/heads/noop:refs/heads/noop	[up to date]
> @@ -293,7 +292,7 @@ test_expect_success GPG 'failed atomic push does no=
t execute GPG' '
>  	!	refs/heads/noff:refs/heads/noff	[rejected] (non-fast-forward)
>  	Done
>  	EOF
> -	test_i18ncmp expect actual
> +	test_cmp expect out
>  '
> =20
>  test_done
