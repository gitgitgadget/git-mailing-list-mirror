Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A961F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbcIHUEK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:04:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54461 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752115AbcIHUEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:04:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F16B23B015;
        Thu,  8 Sep 2016 16:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BlhwD7HtmHQD
        fZd5t4V36p0bIYg=; b=wTmRJNwywiHS3Idew/0b6Cv+ulC8SESjN299gOxd9w/i
        EsNH1h+msirWVDseXqWD+k3JX5A0fNT0xNX9EhhpT0mI3D2zdQ+Eo2d95Mg8LR/D
        gpOoHHeuSDXuRnyABeBF264l2wyIq3PE427p8LaiTAqkqqIWuMpYxRRQvpBsL4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DYBUIL
        rOJseLNT0naCwVrIX3AayC/UbP1CuoqoMC3/thOR5hNt8/lNooKW1K1EbbIoT7lq
        G4OtJt+hXvZRHTSv4IFqpngIypmsnLR9GUYaCsGdb/7xoa3pa9DkxxbxLlH6TAD2
        MswZkwvQ5DwwP2nrYAZB3BhYDzFYK2bMzha6k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E99343B011;
        Thu,  8 Sep 2016 16:04:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77ED13B00F;
        Thu,  8 Sep 2016 16:04:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] checkout: fix ambiguity check in subdir
References: <20160822123502.3521-1-pclouds@gmail.com>
        <20160907111941.2342-1-pclouds@gmail.com>
        <20160907111941.2342-4-pclouds@gmail.com>
Date:   Thu, 08 Sep 2016 13:04:05 -0700
In-Reply-To: <20160907111941.2342-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 7 Sep 2016 18:19:41 +0700")
Message-ID: <xmqq37lagnuy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 66505AC8-75FF-11E6-9AAC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The two functions in parse_branchname_arg(), verify_non_filename and
> check_filename, need correct prefix in order to reconstruct the paths
> and check for their existence. With NULL prefix, they just check paths
> at top dir instead.

Good eyes.  Will queue.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  builtin/checkout.c            |  4 ++--
>  t/t2010-checkout-ambiguous.sh |  9 +++++++++
>  t/t2024-checkout-dwim.sh      | 12 ++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 1f71d06..53c7284 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -985,7 +985,7 @@ static int parse_branchname_arg(int argc, const cha=
r **argv,
>  		int recover_with_dwim =3D dwim_new_local_branch_ok;
> =20
>  		if (!has_dash_dash &&
> -		    (check_filename(NULL, arg) || !no_wildcard(arg)))
> +		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
>  			recover_with_dwim =3D 0;
>  		/*
>  		 * Accept "git checkout foo" and "git checkout foo --"
> @@ -1046,7 +1046,7 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
>  		 * it would be extremely annoying.
>  		 */
>  		if (argc)
> -			verify_non_filename(NULL, arg);
> +			verify_non_filename(opts->prefix, arg);
>  	} else {
>  		argcount++;
>  		argv++;
> diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous=
.sh
> index e76e84a..2e47fe0 100755
> --- a/t/t2010-checkout-ambiguous.sh
> +++ b/t/t2010-checkout-ambiguous.sh
> @@ -41,6 +41,15 @@ test_expect_success 'check ambiguity' '
>  	test_must_fail git checkout world all
>  '
> =20
> +test_expect_success 'check ambiguity in subdir' '
> +	mkdir sub &&
> +	# not ambiguous because sub/world does not exist
> +	git -C sub checkout world ../all &&
> +	echo hello >sub/world &&
> +	# ambiguous because sub/world does exist
> +	test_must_fail git -C sub checkout world ../all
> +'
> +
>  test_expect_success 'disambiguate checking out from a tree-ish' '
>  	echo bye > world &&
>  	git checkout world -- world &&
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index 468a000..3e5ac81 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -174,6 +174,18 @@ test_expect_success 'checkout of branch with a fil=
e having the same name fails'
>  	test_branch master
>  '
> =20
> +test_expect_success 'checkout of branch with a file in subdir having t=
he same name fails' '
> +	git checkout -B master &&
> +	test_might_fail git branch -D spam &&
> +
> +	>spam &&
> +	mkdir sub &&
> +	mv spam sub/spam &&
> +	test_must_fail git -C sub checkout spam &&
> +	test_must_fail git rev-parse --verify refs/heads/spam &&
> +	test_branch master
> +'
> +
>  test_expect_success 'checkout <branch> -- succeeds, even if a file wit=
h the same name exists' '
>  	git checkout -B master &&
>  	test_might_fail git branch -D spam &&
