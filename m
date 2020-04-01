Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4BC2D0F0
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82DD20719
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sbe8Tnwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbgDARrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:47:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63436 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbgDARrV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 13:47:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95CC9BFB0C;
        Wed,  1 Apr 2020 13:47:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8IN21o8JrX0L
        jR/UEp8oib4dt/g=; b=Sbe8TnwqdcSTZ6AKW8IGfruzEXxxlmzXYqooHFYTuSpf
        cz2mxuC7uG+Z7w5QHRS/sreWChnfUMc2JUyp5fhXUWKVYR3dbxT7ALmVo5viv2cA
        0zo8zZhbtCVAAmZSbBc/WztF9owNaygRBjh7ahgH3GDY4dQi0Q2zdc2FPg5sPes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eP3j+y
        0DF4KZPRnKXqih43jW7fcZxF+KrUg3MZsVvxcMCBNv2dwb09uCOviWEouz1bxV/X
        PRlL3hH2YWHPQ0hsDmqiq8YRuTzAmzXGxaD87utyO/k8zZCkgb2viWYQnmsnlC9L
        v6sJo7thBy4YjuQnE2xdj7xE7fbgulbduRsfA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E2C7BFB0B;
        Wed,  1 Apr 2020 13:47:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CEE46BFB0A;
        Wed,  1 Apr 2020 13:47:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Dominic Chen <d.c.ddcc@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase.c: teach --no-gpg-sign to git-rebase
References: <81aea443-6978-93d7-c5d3-98dd731a1fd8@gmail.com>
        <20200331064456.GA15850@danh.dev>
Date:   Wed, 01 Apr 2020 10:47:15 -0700
In-Reply-To: <20200331064456.GA15850@danh.dev> (Danh Doan's message of "Tue,
        31 Mar 2020 13:44:56 +0700")
Message-ID: <xmqqv9mj5c9o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3D0E3EA-7440-11EA-A0AE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> From: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com>
> Subject: [PATCH] rebase.c: teach --no-gpg-sign to git-rebase
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
> index f7a6033607..54023cf3bb 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -358,6 +358,11 @@ See also INCOMPATIBLE OPTIONS below.
>  	defaults to the committer identity; if specified, it must be
>  	stuck to the option without a space.
> =20
> +--no-gpg-sign::
> +	Countermand `commit.gpgSign` configuration variable that is
> +	set to force each and every commit to be signed.
> +
> +

Two points. =20

 - There must be already an entry for '--gpg-sign'.  It would make
   more sense to make this addtion a part of its description.

 - The --no-<option> form is not just to override a configured
   default, but also to coumtermand an option given earlier on the
   command line.  In other words "rebase -S --no-gpg-sign" without
   any commit.gpgSign should work just fine.

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 27a07d4e78..a8cc5cfe0c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1593,6 +1593,9 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
> =20
>  	options.allow_empty_message =3D 1;
>  	git_config(rebase_config, &options);
> +	// options.gpg_sign_opt will be either "-S" or NULL
> +	// It'll be freed later, hence, no skip-prefix

Don't use //- comments.

> +	gpg_sign =3D options.gpg_sign_opt ? "" : NULL;

We've read configured commit.gpgSign in options.gpg_sign_opt; it is
either a freeable "-S" or NULL depending on its value.  We initialize
the local gpg_sign variable to either an unfreeable "" or NULL here.

Let's see how that local variable is later used here.  We know it is
given as the target variable to OPTION_STRING, which will overwrite
with the value given from the command line, so "" that is unfreeable
avoids an unnecessary leak.

 - If we did not have --gpg-sign, or --no-gpg-sign, then the local
   variable gpg_sign will stay to be either "" or NULL after
   parse_options() returns.

 - If we had --gpg-sign or --no-gpg-sign, we will have the value
   given from the last one of them on the command line in gpg_sign
   after parse_options() returns.



> @@ -1823,10 +1826,11 @@ int cmd_rebase(int argc, const char **argv, con=
st char *prefix)
>  	if (options.empty !=3D EMPTY_UNSPECIFIED)
>  		imply_merge(&options, "--empty");
> =20
> -	if (gpg_sign) {
> -		free(options.gpg_sign_opt);
> +	free(options.gpg_sign_opt);
> +	if (gpg_sign)
>  		options.gpg_sign_opt =3D xstrfmt("-S%s", gpg_sign);
> -	}
> +	else
> +		options.gpg_sign_opt =3D NULL;

Now we _always_ override options.gpg_sign_opt based on the value in
the local gpg_sign variable, so the *ONLY* time options.gpg_sign_opt
is used is immediately after git_config() returns to decide what
value to assign to gpg_sign we saw above.  I *think* it would be
much clearer to FREE_AND_NULL options.gpg_sign_out immediately after
we initialize gpg_sign above, instead of freeing it here.

Then you do not need the elese clause here, either.

This is a total tangent, but do we ever call cmd_rebase__interactive()
these days?  It does not seem to do the config thing, and assigns the
string taken from the command line to opts.gpg_sign_opt, which means
that it is an error to free the field in any codepath that can be
reached from there.

I suspect that after removing "rebase --preserve-merges", there is
nobody that calls "git rebase--interactive", and at that point the
function will be dead-code and can safely be removed.

Thanks.
