Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023A71F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeKZRdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:33:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64179 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZRdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:33:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2E361128D9;
        Mon, 26 Nov 2018 01:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2EPeOCDUP8q/
        gV5R/P+4bpEdaGQ=; b=MKotgW2LE4D8/ojg8x6/SWpqDCAd8i7ygWbkIKkbLiij
        N2DUN2Syxf5fJvd2GhsRrvwewWgG1l8JKQ0ufgRpskQ0e469xc04Ws/0NC32O0F9
        qkpf8jXIS3rUmWl9zxNXqt1C6CeDESZ4rTifwQ9ha9Q5jl8ReHCtK17tlviBgbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Lh4YNP
        q3VtLjPPyvFQyXVEF5upHdy2NT3hZbAOMkutnibKQTXKKdkH4Da+62yiIOIQPJy3
        C7f7kNC4/bBJ7x6N7lMYyQfrufyh+35oCFqLJS7Rr9fuZz9VHJTVoXxzKpGXFLi4
        tACOoonlEu5lyb5RKa72s0uqpYujFRqjeK/40=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B9631128D8;
        Mon, 26 Nov 2018 01:40:11 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EA811128D7;
        Mon, 26 Nov 2018 01:40:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] t0301: remove trailing / for dir creation
References: <cover.1543143503.git.carenas@gmail.com>
        <fdf6f2ec6296cf48f5e5ac5edc5fe93adca77f32.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 15:40:10 +0900
In-Reply-To: <fdf6f2ec6296cf48f5e5ac5edc5fe93adca77f32.1543143503.git.carenas@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Nov
 2018 03:06:45
        -0800")
Message-ID: <xmqqpnusxrxx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F590F6A-F146-11E8-B68D-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> the semantics of how mkdir -p should work, specially when using -m are
> not standard and in this case NetBSD will assume that the permision
> should not be changed, breaking the test

This does not explain, except for the fuzzy "in this case", why we
want to lose trailing slash at all.  If what you wanted to say was

    On NetBSD, "mkdir -p -m $bits path/to/dir/" ignores the
    permission bits when creating the directory component 'dir', but
    without the trailing slash at the end of "dir/", it works as
    expected.

then that would be an understandable justification for the patch.
If you meant to say something else, then I couldn't read it from
what you wrote, so the log message needs updating to help future
readers.

> -p is technically not needed either, but will be cleared in a future
> patch eventhough it could be considered an alternative fix

I haven't seen the steps 3-7/7 yet, but if they remove "-p", then
"but" would be a strange thing to say here.  If they indeed do, then
perhaps:

    The '-p' option is not needed in thse cases, as we know $HOME/
    exists in the test environment and we are creating a new
    directory directly under it.  It will be removed in a future
    patch in the series.  Removing '-p' could be an alternative fix,
    as the command then works as expected even on NetBSD with the
    trailing slash after directory name.

On the other hand, if future changes make it necessary to create two
or more levels here, then

    At this point in the series, '-p' is not needed in thse cases,
    as we know $HOME/ exists in the test environment and we are
    creating .git-credential-cache directory directly under it.
    However, in later patches, we'll make it necessary for these
    'mkdir -p' to create two or more levels, so removing '-p' would
    be an alternative fix for this step, but would not work for the
    series as a whole.

would also make sense.  I simply do not have enough information yet
to tell which at this point in the series.

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/t0301-credential-cache.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index fd92533acf..9529c612af 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -77,9 +77,9 @@ test_expect_success "use custom XDG_CACHE_HOME even i=
f xdg socket exists" '
>  test_expect_success 'use user socket if user directory exists' '
>  	test_when_finished "
>  		git credential-cache exit &&
> -		rmdir \"\$HOME/.git-credential-cache/\"
> +		rmdir \"\$HOME/.git-credential-cache\"
>  	" &&
> -	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
> +	mkdir -p -m 700 "$HOME/.git-credential-cache" &&
>  	check approve cache <<-\EOF &&
>  	protocol=3Dhttps
>  	host=3Dexample.com
> @@ -92,10 +92,10 @@ test_expect_success 'use user socket if user direct=
ory exists' '
>  test_expect_success SYMLINKS 'use user socket if user directory is a s=
ymlink to a directory' '
>  	test_when_finished "
>  		git credential-cache exit &&
> -		rmdir \"\$HOME/dir/\" &&
> +		rmdir \"\$HOME/dir\" &&
>  		rm \"\$HOME/.git-credential-cache\"
>  	" &&
> -	mkdir -p -m 700 "$HOME/dir/" &&
> +	mkdir -p -m 700 "$HOME/dir" &&
>  	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
>  	check approve cache <<-\EOF &&
>  	protocol=3Dhttps
