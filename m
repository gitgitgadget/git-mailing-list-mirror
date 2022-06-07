Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9301C433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 17:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiFGRCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbiFGRCd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 13:02:33 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A50224BE2
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 10:02:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s10-20020a170902a50a00b00162359521c9so9670083plq.23
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Jna3rds7V3gD0mpokmTQVQHGDIX1TtaMLQ5V9Q4oiyU=;
        b=JLagXrHpw+aQNizFZLlrfMStrNzeHrk+VELLb4SinmPzDv5SJezp969jncvZ2bqZFz
         0Jgt0n9iIbufWApZiwhsqBC+dEntWUC1rZbMahX5Y3iruW4yaKabgKPPQH78HBjq1kyz
         W4hsJn4SXTXbBTVtihV0b/BAzxag31w2ic3rrXsfrKQvRWh15+IZACm8U0QqCF4pp+xO
         NsqyK2DANDLaJeIHJW+NmOM+1EeBIIUGgZDtLFo1TRZvYrdK0C6MQPASHCTFRKMF4BQC
         AzQHWhTK7sPn6TlavUohmG0NeGwGcUQXRpA8TlGTKIztO488OtwfJgdLIjDwke7sqY95
         Lb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Jna3rds7V3gD0mpokmTQVQHGDIX1TtaMLQ5V9Q4oiyU=;
        b=eI/+2pa0cTr7d7m8DUYbcaq8viwO0/CIOqf0kJFqHdQMe2EaodWmiHizu4SaEfrvIR
         cSBBxX2eh6LpB1oVqKnwO1dCf1JBBkJBnUrEP4WzljRTHxVcoE362dCpsX5zCp6buVIv
         QzCl3qwYil1RgqEw318wPG0ymAY15d5tH8kkqMLgqVcvARlfUgntFlwq3/lIWrfad4Mi
         0VjhGZ+LeYKTHztTOykT2pbNaqRZF/UGQNNVToKM0QBVaRC3bS8l7swl9eDk9Pc02rmc
         IJdWNNktB9oOfyjQjkJ2qRwGaA0Z6Bmvh3SjpoJvaqq9YWXJsM5K+cPOV94bBRPZBhFT
         pHBQ==
X-Gm-Message-State: AOAM5308zEIdoWYEVF+mGeg6lcDlgombQxPjBWu1SfTykUcpTsoqwWHQ
        WnMG/kfVt1zVZWtvPkFmJIdL0onze3QKkg==
X-Google-Smtp-Source: ABdhPJyfnoi5UiseqNfFZtQzHCoUKxkri7f2PcH/c76NHp2xOWF1Q5+UA4OKBxuH3OBtwxgCDAvjB0I1mdqe4w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:fd0f:0:b0:3fa:5e0b:a434 with SMTP id
 d15-20020a63fd0f000000b003fa5e0ba434mr26257285pgh.493.1654621350738; Tue, 07
 Jun 2022 10:02:30 -0700 (PDT)
Date:   Tue, 07 Jun 2022 10:02:27 -0700
In-Reply-To: <patch-3.3-062fb3f454e-20220607T154520Z-avarab@gmail.com>
Message-Id: <kl6lv8tccspo.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com> <patch-3.3-062fb3f454e-20220607T154520Z-avarab@gmail.com>
Subject: Re: [PATCH 3/3] remote API: don't buggily FREE_AND_NULL(), free() instead
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for sending out this series :) I feel a little guilty leaving
behind this much junk. Coincidentally, I was already planning on
revisiting my previous work to clean up debt/mistakes, so this was a
good lesson in what to look out for.

The previous patches look good to me, and I have no comments on those.
I have a style question on this patch (more for my own learning than a
suggestion on this patch), but it also looks good to me.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In this case however we do not use the "struct remote", so the
> FREE_AND_NULL() pattern added in fd3cb0501e1 (remote: move static
> variables into per-repository struct, 2021-11-17) can be replaced with
> free().

Did you mean *reuse* the "struct remote"?

> The API was also odd in that remote_state_new() would xmalloc() for us,
> but the user had to free() it themselves, let's instead change the
> behavior to have the destructor free() what we malloc() in the
> constructer.
>
> In this case this appears to have been done for consistency with
> repo_clear(), let's instead have repo_clear() handle the NULL-ing of
> its "remote_state", and not attempt to reset the structure in remote.c

Yes, this was specifically for consistency reasons. We'll have to read
on to see whether or not this patch remains consistent with
repo_clear()...

>  static void add_merge(struct branch *branch, const char *name)
> @@ -2720,12 +2720,12 @@ void remote_state_clear(struct remote_state *remo=
te_state)
> =20
>  	for (i =3D 0; i < remote_state->remotes_nr; i++)
>  		remote_clear(remote_state->remotes[i]);
> -	FREE_AND_NULL(remote_state->remotes);
> -	remote_state->remotes_alloc =3D 0;
> -	remote_state->remotes_nr =3D 0;
> +	free(remote_state->remotes);
> =20
>  	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent)=
;
>  	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent=
);
> +
> +	free(remote_state);
>  }

Now that remote_state_clear() free()-s the "struct remote_state", should
we rename it to something like "remote_state_free()"? There's some
precedent for this in the other repo_clear() 'destructors'...

> diff --git a/remote.h b/remote.h
> index dd4402436f1..d91b2b29373 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -54,9 +54,17 @@ struct remote_state {
>  	int initialized;
>  };
> =20
> -void remote_state_clear(struct remote_state *remote_state);
> +/**
> + * xmalloc() a "struct remote_state" and initialize it. The resulting
> + * data should be free'd with remote_state_clear().
> + */
>  struct remote_state *remote_state_new(void);
> =20
> +/**
> + * free() the structure returned by remote_state_new().
> + */
> +void remote_state_clear(struct remote_state *remote_state);
> +
>  struct remote {
>  	struct hashmap_entry ent;
> =20
> diff --git a/repository.c b/repository.c
> index 5d166b692c8..0a6df6937e4 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -292,7 +292,7 @@ void repo_clear(struct repository *repo)
> =20
>  	if (repo->remote_state) {
>  		remote_state_clear(repo->remote_state);
> -		FREE_AND_NULL(repo->remote_state);
> +		repo->remote_state =3D NULL;
>  	}
> =20
>  	repo_clear_path_cache(&repo->cached_paths);

I suppose the question of whether or not to free() in the 'destructor'
depends on whether we expect the struct to be reusable? I don't expect
that "struct remote_state" needs to be reused, so free()-ing it is ok to
me.

The API is not _that_ odd though ;) As you noted, my initial use of
FREE_AND_NULL() is for consistency reasons with the rest of
repo_clear(), which looks like this:

	if (repo->config) {
		git_configset_clear(repo->config);
		FREE_AND_NULL(repo->config);
	}

	if (repo->submodule_cache) {
		submodule_cache_free(repo->submodule_cache);
		repo->submodule_cache =3D NULL;
	}

	if (repo->index) {
		discard_index(repo->index);
		if (repo->index !=3D &the_index)
			FREE_AND_NULL(repo->index);
	}

	if (repo->promisor_remote_config) {
		promisor_remote_clear(repo->promisor_remote_config);
		FREE_AND_NULL(repo->promisor_remote_config);
	}

	if (repo->remote_state) {
		remote_state_clear(repo->remote_state);
 -	FREE_AND_NULL(repo->remote_state);
 +	repo->remote_state =3D NULL;
	}

promisor_remote_clear(), discard_index(), and git_configset_clear()
don't free() the struct, so it makes sense for them to use
FREE_AND_NULL(). AFAICT, these structs are meant to be reused, so it
makes sense that we "clear" it without freeing the struct pointer
itself.

On the other hand, submodule_cache_free() _does_ free() the struct, and
so we just use "=3D NULL". I noticed that this uses the verb "free", and
not "clear".

So now that remote_state_clear() *does* free() the struct, it is
perfectly fine to use "=3D NULL" here as well, though it uses the verb
"clear".

I'm not sure if we have a style around clear/free. Feel free to ignore
if there isn't one.
