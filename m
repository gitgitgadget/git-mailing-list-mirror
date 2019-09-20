Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06171F463
	for <e@80x24.org>; Fri, 20 Sep 2019 21:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfITVtK (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 17:49:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52297 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfITVtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 17:49:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5214E8F681;
        Fri, 20 Sep 2019 17:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dNOysWL4y7c3
        X9siQ1NilWFWHUk=; b=Ly05RGbWVPq1goFZgBj5glWSJpmHkKfWgU0Ox4Yz+tSo
        QrCJmkfc7q16esqaFAAAnLpQOOmwIjDRRhNH8D3BnRh4sEBU8cUv7ZROJIEIA981
        NRtMLYIpblHSz6FYLPxTC5X8YhHJMn8cfYqR6vQKo6XVzOypIfsUQL+8WXyvEa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FuFvCi
        Xy12c2Rz/xXKd5F8YCStciTD0+p3QOKhFElGIHNVf+iXInzYRjlVv0c/6CE5Dyq4
        jCC2QILVXh0pUOf8Ejc3gqVl0RIgGScCuGELon6DF94og6bnIwsCUXcP3aD6Txc9
        uZQ13cXC4NVVm5jaq5Gn28cTBFjUiE4Riz8nw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A1798F680;
        Fri, 20 Sep 2019 17:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75A5C8F67F;
        Fri, 20 Sep 2019 17:49:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/15] t6120-describe: modernize the 'check_describe' helper
References: <20190919214712.7348-1-szeder.dev@gmail.com>
        <20190919214712.7348-3-szeder.dev@gmail.com>
Date:   Fri, 20 Sep 2019 14:49:04 -0700
In-Reply-To: <20190919214712.7348-3-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 19 Sep 2019 23:46:57 +0200")
Message-ID: <xmqqr24askof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78179186-DBF0-11E9-A0C6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The 'check_describe' helper function runs 'git describe' outside of
> 'test_expect_success' blocks, with extra hand-rolled code to record
> and examine its exit code.
>
> Update this helper and move the 'git decribe' invocation inside the
> 'test_expect_success' block.

Thanks for a fix.  This makes quite a lot of sense.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t6120-describe.sh | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 0bf7e0c8bc..07e6793e84 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -14,14 +14,12 @@ test_description=3D'test describe'
>  check_describe () {
>  	expect=3D"$1"
>  	shift
> -	R=3D$(git describe "$@" 2>err.actual)
> -	S=3D$?
> -	cat err.actual >&3
> -	test_expect_success "describe $*" '
> -	test $S =3D 0 &&
> +	describe_opts=3D"$@"
> +	test_expect_success "describe $describe_opts" '
> +	R=3D$(git describe $describe_opts 2>err.actual) &&
>  	case "$R" in
>  	$expect)	echo happy ;;
> -	*)	echo "Oops - $R is not $expect";
> +	*)	echo "Oops - $R is not $expect" &&
>  		false ;;
>  	esac
>  	'
