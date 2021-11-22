Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B748C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 13:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhKVNHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhKVNHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 08:07:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F46C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 05:04:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y13so76385727edd.13
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 05:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nZ5XZ4yuaeC8QDEwbaPVUXCJ2GAWUvXltW4kh4vstyo=;
        b=LZtUgsTJAbW78twurXqoYNjyVYsZ2nnmGXabiGAxySDa77gyNu2Y8ffdwFU8w5rdXN
         0g+hGVTv5npMp4QrubDmrYqr8V2vwQr7COfi92vm9vC/gt4yzng6I0Rp72smDemOFv5y
         uHgMbX3remNB9Ymg53kA1nXOUTJIHy5ChypKVO3HGCEpWtSXviw6AgOCs4dNHO2AqR4G
         /M0PZU5IgLrHbJg3MXs45d9dkfadX7dISy9dWI8ZVPdZ3FmNKtjZSFVQpt6PclgCpbGK
         RSISd8zBMk5cAfpMf5Fx488aNIDWv1fo2fdM+XxkzGXeFWHQGbfZHmvAxNKM5Mj+MLSr
         jZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nZ5XZ4yuaeC8QDEwbaPVUXCJ2GAWUvXltW4kh4vstyo=;
        b=2FIfYX09QgRRVhRAORs6tWDbED0VtF0ToCawv6bX6mMxb18PTE5Lz3vhXCoQD0vKzt
         2rrBLIaMYNh1LptkLXCRABejS0r0KhdSFm4lcuTE1B9nzR4ttC9nMVTKcm/SlZurITDH
         23+nnSbY9bPX4Gmyor1cXzzp+owabMzDbupmdwAHYiJjnOGzbw+ig8Rax3SUtXQIdiTY
         5IuWixlxqWs91UPS6aTYnM0767mAahhryUyiZiNPrVunSjNzdHL8yyoH9Yb5ip/ltVRe
         RwiLvv7yBfncyLRaAIkuq/RPS5U8qdO0gDWTSW9qJufXYNfO34HsJf7tKASAKc2zB1pJ
         WM9Q==
X-Gm-Message-State: AOAM532sf/DPLSz4RgSAvRdbjxjPANNSb5NFqpTkOOKX6Q984ridHW7G
        qYCqBDBEixJIX6RZyQFD2OI=
X-Google-Smtp-Source: ABdhPJxEgJt2Ej+wD9LvleOBvSkm0h600VFflDbABsq2vABmzA4T2mBQosxuT2hfQwD3sGqF71vFpQ==
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr40784363ejm.444.1637586248468;
        Mon, 22 Nov 2021 05:04:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e19sm3999079edu.47.2021.11.22.05.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 05:04:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mp8zO-0011cl-NJ;
        Mon, 22 Nov 2021 14:04:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3] fetch-pack: parameterize message containing 'ready'
 keyword
Date:   Mon, 22 Nov 2021 14:02:40 +0100
References: <20211122123415.464783-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211122123415.464783-1-bagasdotme@gmail.com>
Message-ID: <211122.86tug4z6ih.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Bagas Sanjaya wrote:

> The protocol keyword 'ready' isn't meant for translation. Pass it as
> parameter instead of spell it in die() message (and potentially confuse
> translators).
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v2 [1]:
>    - Add missing closing single quote after the parameter (suggested by
>      Eric)
>    - Remove stray 'no' at the second message (suggested by =C3=86var)
>
>  [1]:
> https://lore.kernel.org/git/20211118103424.6464-1-bagasdotme@gmail.com/T/=
#u
>
>  fetch-pack.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index a9604f35a3..62d6313708 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1410,9 +1410,13 @@ static int process_ack(struct fetch_negotiator *ne=
gotiator,
>  	 * otherwise.
>  	 */
>  	if (*received_ready && reader->status !=3D PACKET_READ_DELIM)
> -		die(_("expected packfile to be sent after 'ready'"));
> +		/* TRANSLATORS: The parameter will be 'ready', a protocol
> +		 * keyword */
> +		die(_("expected packfile to be sent after '%s'"), "ready");
>  	if (!*received_ready && reader->status !=3D PACKET_READ_FLUSH)
> -		die(_("expected no other sections to be sent after no 'ready'"));
> +		/* TRANSLATORS: The parameter will be 'ready', a protocol
> +		 * keyword */
> +		die(_("expected no other sections to be sent after '%s'"), "ready");
>=20=20
>  	return 0;
>  }
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc

This looks good to me & ready to go. Thanks for sticking with this
across various nits/small isues for all 3x iterations.

The TRANSLATORS comments being added here don't use our usual style, but
I'd be happy just to leave this be & take it as-is without a re-roll,
don't know about Junio...
