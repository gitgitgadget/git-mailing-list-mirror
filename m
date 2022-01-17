Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4695CC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiAQIEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:04:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37559 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235438AbiAQIEF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:04:05 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 156AC5C0058;
        Mon, 17 Jan 2022 03:04:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 17 Jan 2022 03:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=t0ujKn0rObT8zD5K6T8xTit4KhZ
        2mbcWGzvmdcVmdMg=; b=PeJ+R0Rlc8sfek2k0tIxFDKclUP54lZ1uzti+xxLNiu
        b0rn7NKU14drynVJjxd6+tmu/QdhR9960y5UgFuwMqqiaSN7tlc+nGGRBMOuQu7X
        8i3plhHLhHzmi2uU4BuMs8O7AoI5XKY3/a0VK7DSjzahX5iuRgz2NXFWiW5H62vM
        kl42JtGVH76iGMaATedqRRI1tYP2EaJnrbvgQvz6qWSc61qgxEXIaq/9TVCIvGrA
        j+7D7D2E9NrNYtKcP+E7xA/vUsEmCimYlfeqCaR//0Mt7TSFCYhn8C8mY15eZccd
        89j76r7zJWR8ddqDWo2VXr9ADB1M05XUJ7Wx3axx7oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=t0ujKn
        0rObT8zD5K6T8xTit4KhZ2mbcWGzvmdcVmdMg=; b=hE5Bryqn7FU367ZKi04hrM
        rdpmNGjoXreYgJE4ghIQiRg8qVl2nr2u1mL8BXXpHJqbdmdpxiUfEzIqDZrrZHVX
        Du4WABZlJv3swP5wToZHcACX7ODWeOdaOystdwu+rq3PJv3gg/X40MIdBL+Jne6e
        P/TBkZs3oRizQQIdvQsaQ2R6XFgr56TBhbffAM3XZPavZZDIfdhmJe4OODQw4Oh8
        TTTuskO3lhQ8cGjvr8CRZOge7DiC4rce7xFbWI98BvyhtGdS9rqlymSN70iGiuby
        Ier9/I9pr+JRMTrvUl/h0docpmeWVL8QA+aSrYqDrSZLaUy6/Kw3VVYpsrU7/gDQ
        ==
X-ME-Sender: <xms:9CLlYZ_knVQfC6yQ8fbuq5XLMDG6u8s1ki-oPadz2lfc4IyS19W8Hg>
    <xme:9CLlYdtNK88qx_xJLkzg1jLzEFw3QK4j5JntDUPiS_MS7ycT6ij3ysSGsahgM_vnJ
    Tzjm_CuSYGjf2mTeA>
X-ME-Received: <xmr:9CLlYXBAp8T4P6VQh9C110pWz4sx3M3cHJNSVwwJEAmUOng6UeaZB1wgXc-hlcvIM9hGMK79GD4dr6DhvP-xkjSNkvbnTpdUG8XocCfMpup1JWocupKRAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:9CLlYdd7PsuQCvSpa3mBq3AOfKjKENpdt6P5cF6eiD5bpjY6mP6SuA>
    <xmx:9CLlYeOoVYVDxK3vHOLrHtDq9koQSf-I36uj3vYcvhpq-gxr20JqBw>
    <xmx:9CLlYfl2X8d28NS0TdKqoeHJlefT5llKbvksMh_aVC-2RDs52Naenw>
    <xmx:9SLlYbrE4PgqJse6Lo5VKfJkBpqOSAoAu-emWu2s7Bqi6gqlH2TnSA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:04:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 730cfa60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:04:01 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:03:59 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 3/6] refs: allow skipping the reference-transaction
 hook
Message-ID: <YeUi77PE6MBwTBVQ@ncase>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <be826bae3b564fe003778ea10cb2e06fc753c21d.1642054003.git.ps@pks.im>
 <220113.86zgnzu48q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2IEE++10Y/envS5"
Content-Disposition: inline
In-Reply-To: <220113.86zgnzu48q.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--n2IEE++10Y/envS5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 02:34:41PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Thu, Jan 13 2022, Patrick Steinhardt wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > The reference-transaction hook is executing whenever we prepare, commit
> > or abort a reference transaction. While this is mostly intentional, in
> > case of the files backend we're leaking the implementation detail that
> > the store is in fact a composite store with one loose and one packed
> > backend to the caller. So while we want to execute the hook for all
> > logical updates, executing it for such implementation details is
> > unexpected.
> >
> > Prepare for a fix by adding a new flag which allows to skip execution of
> > the hook.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs.c | 3 +++
> >  refs.h | 5 +++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/refs.c b/refs.c
> > index 7415864b62..526bf5ed97 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2084,6 +2084,9 @@ static int run_transaction_hook(struct ref_transa=
ction *transaction,
> >  	const char *hook;
> >  	int ret =3D 0, i;
> > =20
> > +	if (transaction->flags & REF_TRANSACTION_SKIP_HOOK)
> > +		return 0;
> > +
> >  	hook =3D find_hook("reference-transaction");
> >  	if (!hook)
> >  		return ret;
> > diff --git a/refs.h b/refs.h
> > index 31f7bf9642..d4056f9fe2 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -568,6 +568,11 @@ enum action_on_err {
> >  	UPDATE_REFS_QUIET_ON_ERR
> >  };
> > =20
> > +/*
> > + * Skip executing the reference-transaction hook.
> > + */
> > +#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
> > +
> >  /*
> >   * Begin a reference transaction.  The reference transaction must
> >   * be freed by calling ref_transaction_free().
>=20
> This isn't needed in refs.h, so let's put it in refs-internal.h where
> e.g. "enum ref_transaction_state" now lives:

On the other hand we got the flags parameter in the function just two
lines later. A reader would thus wonder "which flags?!" if we didn't
carry the definition of flags nearby and would have to go search the
codebase for the set of supported flags.

>     diff --git a/refs.h b/refs.h
>     index d4056f9fe26..31f7bf96424 100644
>     --- a/refs.h
>     +++ b/refs.h
>     @@ -568,11 +568,6 @@ enum action_on_err {
>             UPDATE_REFS_QUIET_ON_ERR
>      };
>     =20
>     -/*
>     - * Skip executing the reference-transaction hook.
>     - */
>     -#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
>     -
>      /*
>       * Begin a reference transaction.  The reference transaction must
>       * be freed by calling ref_transaction_free().
>     diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>     index a0af63f162f..87da39243f7 100644
>     --- a/refs/refs-internal.h
>     +++ b/refs/refs-internal.h
>     @@ -201,6 +201,11 @@ enum ref_transaction_state {
>             REF_TRANSACTION_CLOSED   =3D 2
>      };
>     =20
>     +/*
>     + * Skip executing the reference-transaction hook.
>     + */
>     +#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
>     +
>      /*
>       * Data structure for holding a reference transaction, which can
>       * consist of checks and updates to multiple references, carried out
>=20
> A bit more odd is that this series ends up with a
> ref_transaction_begin() that doesn't correspond to its ref_store_*()
> parent, i.e. the others pass the ref store for you, but now we omit the
> flags too.
>=20
> I see why you did that, to avoid tweaking every existing
> ref_transaction_begin() caller.
>=20
> But isn't something like the below a better approach? We can introduce a
> refs-internal.h-only flag enum, and then just have a new
> ref_store_transaction_begin_no_hook() called from these new
> files-backend.c users.
>=20
> The diff on top is a bit verbose, but the exposed API is cleaner
> (presumably no "public" user should be allowed to skip the hook), and
> the overall diff if this is squashed in is smaller.

While the diff does look sensible it makes me wonder how maintainable it
is in the future. If we ever were to accept another flag then we might
have to duplicate your `ref_store_transaction_begin_no_hook()` to also
carry flags, or add `ref_store_transaciton_begin_another_option()` to
stay consistent.

So for now I tend to prefer the current version given that it feels more
extensible going forward. But I'm happy to change it if others agree
with you.

Patrick

> diff --git a/refs.c b/refs.c
> index 526bf5ed97a..ffaf34e9710 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -800,7 +800,7 @@ int refs_delete_ref(struct ref_store *refs, const cha=
r *msg,
>  	struct ref_transaction *transaction;
>  	struct strbuf err =3D STRBUF_INIT;
> =20
> -	transaction =3D ref_store_transaction_begin(refs, 0, &err);
> +	transaction =3D ref_store_transaction_begin(refs, &err);
>  	if (!transaction ||
>  	    ref_transaction_delete(transaction, refname, old_oid,
>  				   flags, msg, &err) ||
> @@ -1004,22 +1004,36 @@ int read_ref_at(struct ref_store *refs, const cha=
r *refname,
>  	return 1;
>  }
> =20
> -struct ref_transaction *ref_store_transaction_begin(struct ref_store *re=
fs,
> -						    unsigned int flags,
> -						    struct strbuf *err)
> +static struct ref_transaction *ref_store_transaction_begin_1(struct ref_=
store *refs,
> +							     unsigned int no_hook,
> +							     struct strbuf *err)
>  {
>  	struct ref_transaction *tr;
>  	assert(err);
> =20
>  	CALLOC_ARRAY(tr, 1);
>  	tr->ref_store =3D refs;
> -	tr->flags =3D flags;
> +	if (no_hook)
> +		tr->flags &=3D REF_TRANSACTION_SKIP_HOOK;
>  	return tr;
>  }
> =20
>  struct ref_transaction *ref_transaction_begin(struct strbuf *err)
>  {
> -	return ref_store_transaction_begin(get_main_ref_store(the_repository), =
0, err);
> +	return ref_store_transaction_begin_1(get_main_ref_store(the_repository),
> +					     0, err);
> +}
> +
> +struct ref_transaction *ref_store_transaction_begin(struct ref_store *re=
fs,
> +						    struct strbuf *err)
> +{
> +	return ref_store_transaction_begin_1(refs, 0, err);
> +}
> +
> +struct ref_transaction *ref_store_transaction_begin_no_hook(struct ref_s=
tore *refs,
> +							    struct strbuf *err)
> +{
> +	return ref_store_transaction_begin_1(refs, 1, err);
>  }
> =20
>  void ref_transaction_free(struct ref_transaction *transaction)
> @@ -1158,7 +1172,7 @@ int refs_update_ref(struct ref_store *refs, const c=
har *msg,
>  	struct strbuf err =3D STRBUF_INIT;
>  	int ret =3D 0;
> =20
> -	t =3D ref_store_transaction_begin(refs, 0, &err);
> +	t =3D ref_store_transaction_begin(refs, &err);
>  	if (!t ||
>  	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
>  				   &err) ||
> diff --git a/refs.h b/refs.h
> index 31f7bf96424..3663e0347ff 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -573,8 +573,9 @@ enum action_on_err {
>   * be freed by calling ref_transaction_free().
>   */
>  struct ref_transaction *ref_store_transaction_begin(struct ref_store *re=
fs,
> -						    unsigned int flags,
>  						    struct strbuf *err);
> +struct ref_transaction *ref_store_transaction_begin_no_hook(struct ref_s=
tore *refs,
> +							    struct strbuf *err);
>  struct ref_transaction *ref_transaction_begin(struct strbuf *err);
> =20
>  /*
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9a20cb8fa89..f85c8f3a692 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1121,8 +1121,7 @@ static void prune_ref(struct files_ref_store *refs,=
 struct ref_to_prune *r)
>  	if (check_refname_format(r->name, 0))
>  		return;
> =20
> -	transaction =3D ref_store_transaction_begin(&refs->base,
> -						  REF_TRANSACTION_SKIP_HOOK, &err);
> +	transaction =3D ref_store_transaction_begin_no_hook(&refs->base, &err);
>  	if (!transaction)
>  		goto cleanup;
>  	ref_transaction_add_update(
> @@ -1193,8 +1192,7 @@ static int files_pack_refs(struct ref_store *ref_st=
ore, unsigned int flags)
>  	struct strbuf err =3D STRBUF_INIT;
>  	struct ref_transaction *transaction;
> =20
> -	transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
> -						  REF_TRANSACTION_SKIP_HOOK, &err);
> +	transaction =3D ref_store_transaction_begin_no_hook(refs->packed_ref_st=
ore, &err);
>  	if (!transaction)
>  		return -1;
> =20
> @@ -1261,8 +1259,7 @@ static int files_delete_refs(struct ref_store *ref_=
store, const char *msg,
>  	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
>  		goto error;
> =20
> -	transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
> -						  REF_TRANSACTION_SKIP_HOOK, &err);
> +	transaction =3D ref_store_transaction_begin_no_hook(refs->packed_ref_st=
ore, &err);
>  	if (!transaction)
>  		goto error;
> =20
> @@ -2775,9 +2772,8 @@ static int files_transaction_prepare(struct ref_sto=
re *ref_store,
>  			 * packed-refs if it exists there.
>  			 */
>  			if (!packed_transaction) {
> -				packed_transaction =3D ref_store_transaction_begin(
> -						refs->packed_ref_store,
> -						REF_TRANSACTION_SKIP_HOOK, err);
> +				packed_transaction =3D ref_store_transaction_begin_no_hook(
> +						refs->packed_ref_store, err);
>  				if (!packed_transaction) {
>  					ret =3D TRANSACTION_GENERIC_ERROR;
>  					goto cleanup;
> @@ -3048,8 +3044,7 @@ static int files_initial_transaction_commit(struct =
ref_store *ref_store,
>  				 &affected_refnames))
>  		BUG("initial ref transaction called with existing refs");
> =20
> -	packed_transaction =3D ref_store_transaction_begin(refs->packed_ref_sto=
re,
> -							 REF_TRANSACTION_SKIP_HOOK, err);
> +	packed_transaction =3D ref_store_transaction_begin_no_hook(refs->packed=
_ref_store, err);
>  	if (!packed_transaction) {
>  		ret =3D TRANSACTION_GENERIC_ERROR;
>  		goto cleanup;
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index cfebcd0b46e..e97d67f9321 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1535,7 +1535,7 @@ static int packed_delete_refs(struct ref_store *ref=
_store, const char *msg,
>  	 * updates into a single transaction.
>  	 */
> =20
> -	transaction =3D ref_store_transaction_begin(ref_store, 0, &err);
> +	transaction =3D ref_store_transaction_begin(ref_store, &err);
>  	if (!transaction)
>  		return -1;
> =20
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 87da39243f7..8ff9e0e6e3a 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -204,7 +204,9 @@ enum ref_transaction_state {
>  /*
>   * Skip executing the reference-transaction hook.
>   */
> -#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
> +enum ref_transaction_flags {
> +	REF_TRANSACTION_SKIP_HOOK =3D 1 << 0,
> +};
> =20
>  /*
>   * Data structure for holding a reference transaction, which can
> @@ -218,7 +220,7 @@ struct ref_transaction {
>  	size_t nr;
>  	enum ref_transaction_state state;
>  	void *backend_data;
> -	unsigned int flags;
> +	enum ref_transaction_flags flags;
>  };
> =20
>  /*
> diff --git a/sequencer.c b/sequencer.c
> index 61edd39d7a4..6abd72160cc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3588,7 +3588,7 @@ static int do_label(struct repository *r, const cha=
r *name, int len)
>  	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
>  	strbuf_addf(&msg, "rebase (label) '%.*s'", len, name);
> =20
> -	transaction =3D ref_store_transaction_begin(refs, 0, &err);
> +	transaction =3D ref_store_transaction_begin(refs, &err);
>  	if (!transaction) {
>  		error("%s", err.buf);
>  		ret =3D -1;

--n2IEE++10Y/envS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlIu4ACgkQVbJhu7ck
PpQXGA//dSdiHn2pdycsKJFZjPhNCAHxTHFGH1jMo4df8QgE6GjI1v7rN+Vt0JTq
ms3sEGNiAc2jR2l0KsZbeUHgyUE4Co/GTpgyhJXhb+EutH38l8Rzar11tw+FWCMF
0/hIiM4eACBIT8WH6aV46n3lQuMqaDOeQyVf025rRMaqK+0YyQ+EfYAjV3QaDc8R
mbc+cJFcYmlPIzW7hkey65lqv0q3bBbeH+zbDwbAIIEZ8cLsnIWujw8UpHlBKlkd
0V8/6LnYjomu27U6geI2SQkBBk8KJnW9rAVGFolrzkYgJjWmFaV6P8f89H+g4Nrh
3oAV2yXAzpmFoTQHDWABMWkKWh/xnwM1W7EJ9bUUAUhc1LKz/Yo7aCL+yTEHS8LB
9LQMakBtPUYM4x2aAFRpfpOLxfe3zKFnJRE7iRV/nc13vAGa6DCyhe6o2VJg1bjq
VU0dZE8GYzldtZQ/bNot9jiWBLyVzSRfbN9a0xu/CUeeJERe7Zqt2o6ttMZ/1d5n
lL83Hjr65kGtxEf1dEExD6dw9DKwBSy8FupP+oATHXcTO72y0TiBLg8If4jFzIsY
A+HCZeMaAN00R0MGiSlvhfav4eVAJWX+iRHPKckkYGFlBidn530Kl9PDT8fxPA/x
1prOW1auz3dfQsokFaobvu9PehdWutZZJ/kjx36VcG0hQLuM7WQ=
=Cf9Z
-----END PGP SIGNATURE-----

--n2IEE++10Y/envS5--
