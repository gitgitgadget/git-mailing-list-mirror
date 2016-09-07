Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5495C1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbcIGRuO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:50:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63952 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751965AbcIGRuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:50:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48BDB375D8;
        Wed,  7 Sep 2016 13:50:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gbvoFlFaugkT
        kYcGJ5voJ8mWcAg=; b=rpb9BjyqlI0AQs70qFgfDRXgHeQSmgOJrjJyqUZoFbwB
        OJsxD1V+oeONJGMjpKDcA6NaG/cMrc1DdY/Yo+g80EFZ+M/Nf85plyxp8ykpt456
        P18GsZTACkBshcIsl0LqGUlopS0t0tD01lmUskjUG/33IVZ8BDZWiwxGFb0ZAow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YgMpFa
        q3FSw+VNRGfeXuHr9De8D3ajkrvg9erjPeWBA274EHRtogtv6i+jTTO/7lx+FWYZ
        VVVWfX54SGVoVE5ph1v82xK1jQBdnLOLvwfE3YB25El0h/csuVCnK8azZUPDSMXe
        bV9K7vaZkQuSBDVvvFJk4lto2bODFz+e3bIZk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4043E375D7;
        Wed,  7 Sep 2016 13:50:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD071375D6;
        Wed,  7 Sep 2016 13:50:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Jeff King <peff@peff.net>, Aaron M Watson <watsona4@gmail.com>,
        Git <git@vger.kernel.org>, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] stash: allow ref of a stash by index
References: <1472944878.19860.4.camel@gmail.com>
        <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
        <CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com>
Date:   Wed, 07 Sep 2016 10:50:09 -0700
In-Reply-To: <CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com>
        (=?utf-8?Q?=22=C3=98ystein?= Walle"'s message of "Mon, 5 Sep 2016 23:46:34
 +0200")
Message-ID: <xmqqbmzzoazy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8647C514-7523-11E6-8C89-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> diff --git a/git-stash.sh b/git-stash.sh
> index 826af18..b026288 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -384,7 +384,7 @@ parse_flags_and_rev()
>      i_tree=3D
>      u_tree=3D
>
> -    REV=3D$(git rev-parse --no-flags --symbolic --sq "$@") || exit 1
> +    REV=3D$(git rev-parse --no-flags --symbolic --sq "$@" 2>/dev/null)
>
>      FLAGS=3D
>      for opt
> @@ -422,6 +422,15 @@ parse_flags_and_rev()
>          ;;
>      esac
>
> +    case "$1" in
> +        *[!0-9]*)
> +            :

OK, so you ignore anything that has a non-digit here, to ensure that...

> +        ;;
> +        *)
> +            set -- "${ref_stash}@{$1}"

... this one triggers only for a string $1 that consists solely of
digits.

> +        ;;
> +    esac

Makes sense.  I notice that both of the two existing case/esac
statements in this function indent case arms and their bodies one
level too deep, which you follwed with the above addition.  That may
be something we would want to fix in a follow-up patch.

>      REV=3D$(git rev-parse --symbolic --verify --quiet "$1") || {
>          reference=3D"$1"
>          die "$(eval_gettext "\$reference is not a valid reference")"

I agree with Peff that the change in error message he noticed is
probably an improvement ;-)

Want to do a final log message to make it a real patch?

Thanks.
