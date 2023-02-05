Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A682C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 21:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBEV3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 16:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBEV3k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 16:29:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0F13D59
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 13:29:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id me3so29146833ejb.7
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 13:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVEfNmol5Uh1w5AoeqSc/Z4/bE44i4qY2Wsj8eb76mI=;
        b=KRHlyBJaTSTb7dVKhlHJElX6oiBOTsFA9+txyjjKIqnJm7J02zzjlxK7zFxKqyW2lO
         ev8YZNyyITiuQEuHOWQ+paylH6iar8kFExktmQ0HySbUYTmsuHoeXLPsph2crpoQtWOy
         grpr6TqFK50umARG5BuvaazF3FV0RUg2I3lARvVK3dgjaGDpiM4uYBJN7O4xtKC4ylW2
         0zcfDkk4I+UWHydKhKUGjGjk9yyT8YAmyw2g8bYHOPmkk4HLiDUJoR1BF9+uCvVcaqMm
         zbcNYbJoEfQVT3OhlblquIBesc44r/Z9L+7WK5xVrlID20TRWHzcGqIGj1U02D51nZfz
         90ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVEfNmol5Uh1w5AoeqSc/Z4/bE44i4qY2Wsj8eb76mI=;
        b=a9RA/5kRqx+wSeD+6NTHbp24KtiLyvgxdWNTA0j1vq9uZ31VoOB10wF8wMZjU8ENn4
         BxCvURzQK1/tzGJTb7gzDmOMic8r2t1rzFg3YjV5M4K6SFF83ibX1gwl1ihZZ6CSnW/V
         XTlL72zfpU/rtH8q07DG/p5gLmGCkgqWN+jspfYTDV7LEaBgYLrv5Bo8r8cmZhQaoFlB
         g0BKUCrP9GNF+/9q+hYgn3XB89fCkqTUJwrgPScHQrI3XtDgvjLaFySoCOALnmxrU2SG
         QZINMAy/c7wKIAbp/XZDbmjPClUlLv4vZ0RF7ZXsUslzEkxsGICgLOld7k6w0MQgFgks
         IEHg==
X-Gm-Message-State: AO0yUKUwUxEComF5C8JcSr5YM4UrAmk1kY1IIOwKG33PbeWdnXQij5Go
        wMvu9EGk3qFDS4oixf/Pnjo=
X-Google-Smtp-Source: AK7set+u0XCoRhhcdYQ/mijQxo+217PSzDIt0SfdsV9E29fUsYcK8E6xxgAGV3GyF8w6BeW8TWkz+A==
X-Received: by 2002:a17:907:9851:b0:872:45d3:dcfa with SMTP id jj17-20020a170907985100b0087245d3dcfamr17586028ejc.42.1675632578225;
        Sun, 05 Feb 2023 13:29:38 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906049100b00871f66bf354sm4515127eja.204.2023.02.05.13.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:29:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pOmZt-0007Dc-09;
        Sun, 05 Feb 2023 22:29:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
Date:   Sun, 05 Feb 2023 22:12:25 +0100
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
Message-ID: <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 04 2023, Ren=C3=A9 Scharfe wrote:

> Use size_t to store the original length of the strbuf tree_len, as
> that's the correct type.
>
> Don't double the allocated size of the strbuf when adding a subdirectory
> name.  Only extend it to fit that name and a slash.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  cache-tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 9af457f47c..35f7617164 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -760,7 +760,7 @@ static void prime_cache_tree_rec(struct repository *r,
>  	struct tree_desc desc;
>  	struct name_entry entry;
>  	int cnt;
> -	int base_path_len =3D tree_path->len;
> +	size_t base_path_len =3D tree_path->len;
>
>  	oidcpy(&it->oid, &tree->object.oid);
>
> @@ -785,7 +785,7 @@ static void prime_cache_tree_rec(struct repository *r,
>  			 */
>  			if (r->index->sparse_index) {
>  				strbuf_setlen(tree_path, base_path_len);
> -				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
> +				strbuf_grow(tree_path, entry.pathlen + 1);
>  				strbuf_add(tree_path, entry.path, entry.pathlen);
>  				strbuf_addch(tree_path, '/');
>  			}

The size_t conversion is trivially correct.

But what do you mean with "don't double the[...]"? Do you mean that this
manages to evade growing these to 24 etc?

One wonders if (even for this index-related code) we really need such
careful management of growth, and could instead do with:

	strbuf_setlen(tree_path, base_path_len);
	strbuf_add(tree_path, entry.path, entry.pathlen);
	strbuf_addch(tree_path, '/');

Or even just:

	strbuf_addf(tree_path, "%*.s/", (int)entry.pathlen, entry.path);

As e.g. the t1092 test that runs this codepath shows we're looping
through the index entires here and will (in that case) handle names & a
"tree_path" like (these are the entry.path values):

	""
	"before"

Which here are turned into:

	"before/"

But both before & after your change we'll grow the "alloc" to 24, which
isn't surprising, as both the string length of (sans slash) 6 and 7 plus
1 for "\0" is rounde up to 24 with the standard growth pattern.

So I think if we're doing a "while-at-it" fixing of the off-by-one here
we might be better of asking whether it's needed at all, and whether
this case can't just be left to the growth smartness of the
strbuf+ALLOC_GROW() API instead.
