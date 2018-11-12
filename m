Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8CC1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 03:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeKLNXd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 08:23:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54590 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLNXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 08:23:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 780A7109DF9;
        Sun, 11 Nov 2018 22:32:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fewCMxaOiruN
        bBIlzXckkOfF2bc=; b=IA23gSXw2V7J7cW+0x01jGF8q0IKwmBECGPI0sH5+fR9
        GxxiFm3KA5IveIOki5FEsen8RuF/mWSb0sx5DNBEa2tWpPEtREYBW27eCEkbfZz5
        i4NLtbDmb6eZkNgX31r+zHQgPF2xsUveYcf/rJgL3Lk6v6kOMe08rNU9Zi1jxZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LjPdqo
        cv5Dfpn4Q5OC645uiQL8YFfiaMXECJRjbRdJK7TDCRqqeJ7vUjH0vCJ9l0jsb7b4
        wp4N+0nMO/yBUUz1iHo6Mp8XOLfXmNzqdZWbJBl38c4rzbq1U5EqOpKN5ewAWe8o
        OdoJeMoZ58hDjhpLD0+P4dJO0KwouOSeVRB5s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71248109DF8;
        Sun, 11 Nov 2018 22:32:19 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0AEC109DF7;
        Sun, 11 Nov 2018 22:32:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephen & Linda Smith <ischis2@cox.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 3/3] range-diff: make diff option behavior (e.g. --stat) consistent
References: <20181107122202.1813-3-avarab@gmail.com>
        <20181109101803.3038-4-avarab@gmail.com>
Date:   Mon, 12 Nov 2018 12:32:17 +0900
In-Reply-To: <20181109101803.3038-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 9 Nov 2018 10:18:03 +0000")
Message-ID: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8ED885F8-E62B-11E8-BDBD-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index ab44e085d5..9352f65280 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -140,37 +140,15 @@ test_expect_success 'changed commit with --stat d=
iff option' '
>  	1:  4de457d =3D 1:  a4b3333 s/5/A/
>  	     a =3D> b | 0
>  	     1 file changed, 0 insertions(+), 0 deletions(-)
> -	$four_spaces

This removes all references to four_spaces=3D" " assigned at the very
beginning of this test piece, so that assignment should also go, no?

>  	2:  fccce22 =3D 2:  f51d370 s/4/A/
>  	     a =3D> b | 0
>  	     1 file changed, 0 insertions(+), 0 deletions(-)
> -	$four_spaces
>  	3:  147e64e ! 3:  0559556 s/11/B/
>  	     a =3D> b | 0
>  	     1 file changed, 0 insertions(+), 0 deletions(-)
> -	$four_spaces
> -	    @@ -10,7 +10,7 @@
> -	      9
> -	      10
> -	     -11
> -	    -+B
> -	    ++BB
> -	      12
> -	      13
> -	      14
>  	4:  a63e992 ! 4:  d966c5c s/12/B/
>  	     a =3D> b | 0
>  	     1 file changed, 0 insertions(+), 0 deletions(-)
> -	$four_spaces
> -	    @@ -8,7 +8,7 @@
> -	     @@
> -	      9
> -	      10
> -	    - B
> -	    + BB
> -	     -12
> -	     +B
> -	      13
>  	EOF
>  	test_cmp expected actual
>  '
