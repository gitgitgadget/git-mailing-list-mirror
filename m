Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62184C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4AD22BEF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbhAWVfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:35:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50297 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbhAWVfj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:35:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA96511A039;
        Sat, 23 Jan 2021 16:34:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sZcmkd/6YfBF
        J7PRhFB4qR9gw2g=; b=OynIovJ6EI/I/8lqLhui1wKP86g2lYVrIQvS4b/wbpWW
        5dg74trp7MzYioaQQQO5zmFiEFWX6/27AzJRXv6ttVm6wBplz22NtvbudsOJ63NE
        UqiVumtgyh5EbvlFQJwmuXgITi0wlH7rxHeal+JyyqHaE/5RTPVwZg8cOEp299s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LTZyhc
        JP05OIJzfBKhjOXjXdQCnmOdTouRo2NkYeR7Mt5mKUHrjmQH7sVrleNB6a1Sukra
        RmSjP5OYHIeA9BvulDlIHUWs/bWRnIrbkmqMmmUKCBUwRTIVGMteeTGmekJ5OfV/
        QGNOaykIOP6EcgW/9VM9lZLnHOe0FnJOHCC3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D47C111A038;
        Sat, 23 Jan 2021 16:34:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 279FD11A036;
        Sat, 23 Jan 2021 16:34:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 01/10] cache-tree tests: refactor for modern test style
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
        <20210123130046.21975-2-avarab@gmail.com>
Date:   Sat, 23 Jan 2021 13:34:51 -0800
In-Reply-To: <20210123130046.21975-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 23 Jan 2021 14:00:37 +0100")
Message-ID: <xmqqtur72v7o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D44CF810-5DC2-11EB-96B9-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 5a633690bf..45e1cc82ed 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -10,7 +10,8 @@ cache-tree extension.
>  cmp_cache_tree () {
>  	test-tool dump-cache-tree | sed -e '/#(ref)/d' >actual &&
>  	sed "s/$OID_REGEX/SHA/" <actual >filtered &&
> -	test_cmp "$1" filtered
> +	test_cmp "$1" filtered &&
> +	rm filtered
>  }

OK.  Cleaning after itself is good, and not cleaning when there is
an error is probably a bit more helpful to those who debug, but I
think test_cmp would give them enough to work on.  A failure to
remove filtered at the end CAN mistakenly make the caller to think
that the expected output was not obtained, though.

> @@ -83,18 +84,6 @@ test_expect_success 'git-add in subdir invalidates c=
ache-tree' '
>  	test_invalid_cache_tree
>  '
> =20
> -cat >before <<\EOF
> -SHA  (3 entries, 2 subtrees)
> -SHA dir1/ (1 entries, 0 subtrees)
> -SHA dir2/ (1 entries, 0 subtrees)
> -EOF
> -
> -cat >expect <<\EOF
> -invalid                                   (2 subtrees)
> -invalid                                  dir1/ (0 subtrees)
> -SHA dir2/ (1 entries, 0 subtrees)
> -EOF
> -
>  test_expect_success 'git-add in subdir does not invalidate sibling cac=
he-tree' '
>  	git tag no-children &&
>  	test_when_finished "git reset --hard no-children; git read-tree HEAD"=
 &&
> @@ -102,9 +91,20 @@ test_expect_success 'git-add in subdir does not inv=
alidate sibling cache-tree' '
>  	test_commit dir1/a &&
>  	test_commit dir2/b &&
>  	echo "I changed this file" >dir1/a &&
> +	test_when_finished "rm before" &&
> +	cat >before <<-\EOF &&
> +	SHA  (3 entries, 2 subtrees)
> +	SHA dir1/ (1 entries, 0 subtrees)
> +	SHA dir2/ (1 entries, 0 subtrees)
> +	EOF
>  	cmp_cache_tree before &&
>  	echo "I changed this file" >dir1/a &&
>  	git add dir1/a &&
> +	cat >expect <<-\EOF &&
> +	invalid                                   (2 subtrees)
> +	invalid                                  dir1/ (0 subtrees)
> +	SHA dir2/ (1 entries, 0 subtrees)
> +	EOF
>  	cmp_cache_tree expect
>  '

Why remove only 'before' and not 'expect' in when-finished handler?
