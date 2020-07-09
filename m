Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C037C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 13:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C7A206DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 13:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YvXDnNoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGINsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:48:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56461 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgGINsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 09:48:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 464DC7EA33;
        Thu,  9 Jul 2020 09:48:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KbmkymbuPF9hUEM8+aDpiekShNQ=; b=YvXDnN
        oN7h/ShJKU5Ahx5Z49AhAbDXhs0a+H/UNzbFPdBrqmYyNIKbLHCz2e8G1u6ktr35
        LElaVghVuw9s5ZM3McHZOiQKJSFE8Xn0pfJdZvByLO4qmz2NaCyGTJfeUODVdIDy
        KxQvKHPZ9yHBD1zjWYIbzL6KoFbTsMDsX+bOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vpnB/4bPAJ84F6QGtodZuSf5tzbPWnqY
        ms0G/sVz5m4XkcapJzTHtMduA/ni93SP7ZeENs6rW3m7dreYgxxcU+QYcG83rsil
        f0HNznodZ8lmCfIcfhpcORujf+dPqKTrOjf7qrTRbiiKI9liIu1LutYAAls0GM6G
        YJsWXVP7NI8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34A147EA32;
        Thu,  9 Jul 2020 09:48:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A7147EA31;
        Thu,  9 Jul 2020 09:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/4] ref-filter: add support for %(contents:size)
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-5-chriscool@tuxfamily.org>
        <xmqqk0zf3y8s.fsf@gitster.c.googlers.com>
        <xmqqtuyhzgro.fsf@gitster.c.googlers.com>
        <CAP8UFD2tUUgwjhkizihhqHc0LUYN_gS=wZCtXroLVtT3kMyqLw@mail.gmail.com>
Date:   Thu, 09 Jul 2020 06:47:59 -0700
In-Reply-To: <CAP8UFD2tUUgwjhkizihhqHc0LUYN_gS=wZCtXroLVtT3kMyqLw@mail.gmail.com>
        (Christian Couder's message of "Thu, 9 Jul 2020 10:10:29 +0200")
Message-ID: <xmqq4kqgzto0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDA03B72-C1EA-11EA-8AE9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Yeah, I have been working on that and will send a new patch series soon.
> The current test_atom() change looks like this:
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 371e45e5ad..e514d98574 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -52,6 +52,26 @@ test_atom() {
>                 sanitize_pgp <actual >actual.clean &&
>                 test_cmp expected actual.clean
>         "
> +       # Automatically test "contents:size" atom after testing "contents"
> +       if test "$2" = "contents"
> +       then
> +               case "$1" in
> +               refs/tags/signed-*)
> +                       # We cannot use $3 as it expects sanitize_pgp to run
> +                       git cat-file tag $ref | tail -n +6 | \
> +                               wc -c | sed -e 's/^ *//' >expected ;;
> +               refs/mytrees/*)
> +                       echo >expected ;;
> +               refs/myblobs/*)
> +                       echo >expected ;;
> +               *)
> +                       printf '%s' "$3" | wc -c | sed -e 's/^ *//' >expected ;;
> +               esac
> +               test_expect_${4:-success} $PREREQ "basic atom: $1 $2:size" "
> +                       git for-each-ref --format='%($2:size)' $ref >actual &&
> +                       test_cmp expected actual
> +               "
> +       fi
>  }
>
> I am wondering if it's worth adding a preparatory patch to introduce
> an helper function like the following in test-lib-functions.sh:
>
> +# test_byte_count outputs the number of bytes in files or stdin
> +#
> +# It is like wc -c but without portability issues, as on macOS and
> +# possibly other platforms leading whitespaces are emitted before the
> +# number.
> +
> +test_byte_count () {
> +       wc -c "$@" | sed -e 's/^ *//'
> +}
>
> Not sure about the name of this helper function as it works
> differently than test_line_count().

Yeah, if I were writing it, I'd call it "sane_wc_c" or something.

But more importantly, I think the invocation of "|sed" is overkill.
If I were writing it, I would go more like...

	if test $2 = contents
	then
		case "$1" in 
		...)
			expect=$(git cat-file ... | wc -c)
			;;
		refs/mytrees/* | refs/myblobs/*)
			expect=0
			;;
		*)
			expect=$(printf ... | wc -c)
			;;
		esac

		# leave $expect unquoted to lose possible leading whitespaces
	        echo $expect >expect
		test_expect_success "..." '
			...
			test_cmp expect actual
		'
	fi

