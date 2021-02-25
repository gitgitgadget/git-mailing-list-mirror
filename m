Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF0AC433E6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6024664ED6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbhBYC6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:58:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59164 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhBYC6W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 21:58:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C93EF115841;
        Wed, 24 Feb 2021 21:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BdwGm8oyLzMf
        PGTzZad2Tjmk18c=; b=JMmLHLbqQD7Bax98EMlmwnFb6HJybaMzE/XVth8pzBx5
        VEuyL9wQqZHcD0vS56F1WzEB2mOlMsUr++0sepXVKe5t9TjqHNJbOW6b5z7rnXKs
        ofC8VqkVwLeiv/fCpqIXlwOtYs2Cofci6IGVg3H0eRzTY/H2xP2OU4v1iJCLn54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qRzVFD
        ivekD8otFN+MY5o7buDsywbJPYxGDe8+116LTLi19SjcJ2mTwisXVuw2osfLalEx
        2E+TSNRkvsd/iyEJNIMTXmly3/eUWglPM9Yj3TlA0fwNLJy9kX0VY9GZtwotrm3l
        apu9HyI48ZMC5gcxdQ8X7iMIqqCSRSeRAugtY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0352115840;
        Wed, 24 Feb 2021 21:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0DAC811583F;
        Wed, 24 Feb 2021 21:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 13/35] userdiff tests: factor out
 test_diff_funcname() logic
References: <20210215154427.32693-1-avarab@gmail.com>
        <20210224195129.4004-14-avarab@gmail.com>
Date:   Wed, 24 Feb 2021 18:57:36 -0800
In-Reply-To: <20210224195129.4004-14-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 24 Feb 2021 20:51:07 +0100")
Message-ID: <xmqq5z2gyhun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 37E60446-7715-11EB-952F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Factor out logic in test_diff_funcname() into two helper functions,
> these will be useful in a follow-up commit where we'll do this munging
> in more than one place.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t4018-diff-funcname.sh | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 2365f0e361e..8a8a7a99c88 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -75,6 +75,17 @@ test_expect_success 'setup hunk header tests' '
>  	git -C t4018 add .
>  '
> =20
> +do_change_me () {
> +	file=3D$1
> +	sed -e "s/ChangeMe/IWasChanged/" <"$file" >tmp &&
> +	mv tmp "$file"
> +}
> +
> +last_diff_context_line () {

What this helper computes looks more like header line for each and
every hunk, not just the last one, to me.  Misnamed?

> +	file=3D$1
> +	sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <$file

Style.

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.  Note that
   even though it is not required by POSIX to double-quote the
   redirection target in a variable (as shown above), our code does so
   because some versions of bash issue a warning without the quotes.

In any case, I wonder if this kind of clean-up should have been done
immediately before step 11/35, not after 11/35 started rewriting the
framework.  Any touch-up done after 11/35 risks smelling like "oops,
we found a better way to write it after we did the big rewrite".

> +}
> +
>  # check each individual file
>  for i in $(git -C t4018 ls-files)
>  do
> @@ -85,13 +96,12 @@ do
> =20
>  		# add test file to the index
>  		git add \"$i\" &&
> -		# place modified file in the worktree
> -		sed -e 's/ChangeMe/IWasChanged/' <\"t4018/$i.content\" >\"$i\"
> +		do_change_me \"$i\"
>  	"
> =20
>  	test_expect_success "hunk header: $i" "
>  		git diff -U1 $i >diff &&
> -		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
> +		last_diff_context_line diff >ctx &&
>  		test_cmp t4018/$i.header ctx
>  	"
>  done
