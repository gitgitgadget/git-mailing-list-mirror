Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583A21101
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171871; cv=none; b=uxHE/Grk9uu619E4/e1wkpPOl8XHDgDbRERUcYrCpg+6Xm+V/YT9O1e0Azg3F6D7YM16nUnKzcQbLhSVPl+s10h/TNi1x+5wbE8Ltxv7Zx/QiDvhSwkLGeP0DYaFa5/Ny+xS+Ct+hVSAPH8YNtdWGFwP8w9Y2GqpRrlOlNHYg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171871; c=relaxed/simple;
	bh=e0srcivguc3htkqSWJ66b4OPl/Bm1JHeS33VwEctTgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipxVjVMkBnt7YHNyvsWXeqWeo3+Nh6nPgXlQpEu+KkBf1991uv6Bfd9IuH7eJcosp5JpnuWypUyF2NRlfVgUzABtYUWZQyUcEM4wsQdV8kROOvT+Jo7OjD9hJ9lpBfCsw8WF15QU+XU8fsvpepNyOruPZ1T81f3xOjPmhAcqIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w9tRD0Rm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w9tRD0Rm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3C052DFD4;
	Fri, 26 Apr 2024 18:51:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e0srcivguc3h
	tkqSWJ66b4OPl/Bm1JHeS33VwEctTgc=; b=w9tRD0RmDdExT+XzS3JCXg8OI3y9
	lwAsRWGT7uBQ88w5S5CuqjE4nLb9cVEqpwhPEb+0aNAzd/4fWliikwIVkRjLSKpz
	ZJ61pFB4t7hXLtnM7dA5RBqKTgdLloMqvLyNhrFwto1eMKqqMGH/eXvkyKcnmgOM
	ovrjcpHfC+QzYLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DBF7A2DFD3;
	Fri, 26 Apr 2024 18:51:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A49F2DFD2;
	Fri, 26 Apr 2024 18:51:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v4 3/7] update-ref: add support for 'symref-verify' command
In-Reply-To: <20240426152449.228860-4-knayak@gitlab.com> (Karthik Nayak's
	message of "Fri, 26 Apr 2024 17:24:45 +0200")
References: <20240423212818.574123-1-knayak@gitlab.com>
	<20240426152449.228860-1-knayak@gitlab.com>
	<20240426152449.228860-4-knayak@gitlab.com>
Date: Fri, 26 Apr 2024 15:51:06 -0700
Message-ID: <xmqq5xw37n6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 77D2CD6A-041F-11EF-BF36-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> In the previous commits, we added the required base for adding symref
> commands to the '--stdin' mode provided by 'git-update-ref(1)'. Using
> them, add a new 'symref-verify' command to verify symrefs.
>
> The 'symref-verify' command allows users to verify if a provided <ref>
> contains the provided <old-target> without changing the <ref>. If
> <old-target> is not provided, the command will verify that the <ref>
> doesn't exist. Since we're checking for symbolic refs, this command wil=
l
> only work with the 'no-deref' mode. This is because any dereferenced
> symbolic ref will point to an object and not a ref and the regular
> 'verify' command can be used in such situations.

All makes sense, but a na=C3=AFve reader may find it helpful if you
explained why having "verify" command is a good idea in the first
place ("I can just do 'git symoblic-ref' to read the current value,
and see if it is what I expect").  Presumably the value of "verify"
is that you can have it in a transaction and fail other operations
in the same transaction if the symref moved from what you expected
it to point at?

> Add and use `ref_update_is_null_new_value`, a helper function which is
> used to check if there is a new_value in a reference update. The new
> value could either be a symref target `new_target` or a OID `new_oid`.
> We also add tests to test the command in both the regular stdin mode an=
d
> also with the '-z' flag.

This looks out of place, primarily because the helper function is
*NOT* used in this step.  Without any actual user, and with the name
that says only what it checks without hinting why a caller may want
to check the condition it checks, it is hard to guess if it is a
good idea to have such a helper.

"If a ref_update object specifies no new-oid and no new-target, it
is not about updating but just validating" is how the callers are
expected to use it, then instead of is_null_new_value that says
what it checks, something like is_verify_only that says what the
caller may want to use it for would be a more friendly name for
readers and future developers.

> @@ -297,11 +320,47 @@ static void parse_cmd_verify(struct ref_transacti=
on *transaction,
>  		die("verify %s: extra input: %s", refname, next);
> =20
>  	if (ref_transaction_verify(transaction, refname, &old_oid,
> -				   update_flags, &err))
> +				   NULL, update_flags, &err))
> =20
>  	update_flags =3D default_flags;
>  	free(refname);
>  	strbuf_release(&err);
>  }

The only damage by this patch to parse_cmd_verify() is that
ref_transaction_verify() gained another parameter NULL, but with the
default "--diff-algorithm=3Dmyers" algorithm, it is very hard to see.

The "--patience" algorithm does a much beter job on this hunk.

And the following function is entirely new.

> +static void parse_cmd_symref_verify(struct ref_transaction *transactio=
n,
> +				    const char *next, const char *end)
> +{
> +	struct strbuf err =3D STRBUF_INIT;
> +	struct object_id old_oid;
> +	char *refname, *old_target;
> +
> +	if (!(update_flags & REF_NO_DEREF))
> +		die("symref-verify: cannot operate with deref mode");
> +
> +	refname =3D parse_refname(&next);
> +	if (!refname)
> +		die("symref-verify: missing <ref>");
> +
> +	/*
> +	 * old_ref is optional, but we want to differentiate between
> +	 * a NULL and zero value.
> +	 */
> +	old_target =3D parse_next_refname(&next);
> +	if (!old_target)
> +		old_oid =3D *null_oid();

In many existing code paths, we do not do structure assignment like
this. Instead we do

		oidcpy(&old_oid, null_oid());

We can see an existing example in a common context in a hunk for
refs.c in this patch.

> +	if (*next !=3D line_termination)
> +		die("symref-verify %s: extra input: %s", refname, next);
> +
> +	if (ref_transaction_verify(transaction, refname,
> +				   old_target ? NULL : &old_oid,
> +				   old_target, update_flags, &err))
> +		die("%s", err.buf);

Are static analyzers smart enough to notice that we will not be
using old_oid uninitialized here?  Just wondering.

Anyway.  This ensures ref_transaction_verify() gets either
old_target or old_oid, but never both at the same time.  The caller
to ref_transaction_verify() in the previous function passed NULL for
old_target but it always had a non-NULL old_oid so that is perfectly
fine.

> +	update_flags =3D default_flags;
> +	free(refname);
> +	free(old_target);
> +	strbuf_release(&err);
> +}

> diff --git a/refs.c b/refs.c
> index 060a31616d..0e1013b5ab 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1217,6 +1217,8 @@ void ref_transaction_free(struct ref_transaction =
*transaction)
> =20
>  	for (i =3D 0; i < transaction->nr; i++) {
>  		free(transaction->updates[i]->msg);
> +		free((void *)transaction->updates[i]->old_target);
> +		free((void *)transaction->updates[i]->new_target);
>  		free(transaction->updates[i]);
>  	}
>  	free(transaction->updates);
> @@ -1247,9 +1249,13 @@ struct ref_update *ref_transaction_add_update(
> =20
>  	update->flags =3D flags;
> =20
> -	if (flags & REF_HAVE_NEW)
> +	if (new_target)
> +		update->new_target =3D xstrdup(new_target);
> +	if (old_target)
> +		update->old_target =3D xstrdup(old_target);

Presumably "update" structure, when freshly initialized, has NULL in
both of these _target members?  Otherwise ref_transaction_free()
would get in trouble, so double checking.

> +	if (new_oid && flags & REF_HAVE_NEW)
>  		oidcpy(&update->new_oid, new_oid);
> -	if (flags & REF_HAVE_OLD)
> +	if (old_oid && flags & REF_HAVE_OLD)
>  		oidcpy(&update->old_oid, old_oid);

Since we can ask to work on a symbolic ref, new_oid / old_oid can be
NULL when REF_HAVE_NEW / REF_HAVE_OLD bit is on for _target members.

Makes me wonder if the code becomes easier to follow if the flag
bits are split into four (_NEW -> _NEW_OID + _NEW_TARGET), but let's
not worry about that for now.

> @@ -1286,6 +1292,7 @@ int ref_transaction_update(struct ref_transaction=
 *transaction,
>  	flags &=3D REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
> =20
>  	flags |=3D (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0=
);
> +	flags |=3D (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_O=
LD : 0);

> @@ -1325,14 +1332,17 @@ int ref_transaction_delete(struct ref_transacti=
on *transaction,
>  int ref_transaction_verify(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *old_oid,
> +			   const char *old_target,
>  			   unsigned int flags,
>  			   struct strbuf *err)
>  {
> -	if (!old_oid)
> -		BUG("verify called with old_oid set to NULL");
> +	if (!old_target && !old_oid)
> +		BUG("verify called with old_oid and old_target set to NULL");

Is it normal if you get _both_ set, or is it equally a BUG()?
The parse_*_verify() codepaths we saw earlier both made sure
only one of the two is non-NULL, and it is unclear what should
happen if both are non-NULL.

> +	if (old_target && !(flags & REF_NO_DEREF))
> +		BUG("verify cannot operate on symrefs with deref mode");
>  	return ref_transaction_update(transaction, refname,
>  				      NULL, old_oid,
> -				      NULL, NULL,
> +				      NULL, old_target,
>  				      flags, NULL, err);
>  }

So this queues an ref_update object whose .new_oid and .new_target
are NULL, and .old_oid and .old_target are what the caller gave us
to check.  The NULLs in .new* members hopefully do not mean "delete
this thing" ;-)

> @@ -2349,6 +2359,12 @@ static int run_transaction_hook(struct ref_trans=
action *transaction,
>  	for (i =3D 0; i < transaction->nr; i++) {
>  		struct ref_update *update =3D transaction->updates[i];
> =20
> +		/*
> +		 * Skip reference transaction for symbolic refs.
> +		 */
> +		if (update->new_target || update->old_target)
> +			continue;

Is that a final design, or will the hooks have a chance to interfere?

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 2420dac2aa..53197fa3af 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2425,6 +2425,37 @@ static const char *original_update_refname(struc=
t ref_update *update)
>  	return update->refname;
>  }
> =20
> +/*
> + * Check whether the REF_HAVE_OLD and old_target values stored in
> + * update are consistent with ref, which is the symbolic reference's
> + * current value. If everything is OK, return 0; otherwise, write an
> + * error message to err and return -1.
> + */
> +static int check_old_target(struct ref_update *update, char *ref,
> +			    struct strbuf *err)
> +{
> +	if (!(update->flags & REF_HAVE_OLD) ||
> +	    !strcmp(update->old_target, ref))
> +		return 0;

Earlier on the assignment side for "update" structure we saw above,
the guard was (old_target && flags & REF_HAVE_OLD), but here we
assume old_target is valid, which feels a bit asymmetric.

Yes, I can see that the caller does not call us when !old_target,
but still...  Perhaps

	if ((update->flags & REF_HAVE_OLD) && !update->old_target)
		BUG(...);

or something?  Or alternatively, perhaps !!update->old_target should
be the only thing we should check and ignore REF_HAVE_OLD bit?  I am
not sure, but it smells like that the non-NULL-ness of old_target is
the only thing that matters (if it is not NULL, very early in the
control flow somebody would have set REF_HAVE_OLD bit to flags, no?).

It brings me back to my earlier question.  Does REF_HAVE_OLD bit
serve a useful purpose in this code?

> +	if (!strcmp(update->old_target, ""))
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "reference already exists",
> +			    original_update_refname(update));
> +	else if (!strcmp(ref, ""))
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "reference is missing but expected %s",
> +			    original_update_refname(update),
> +			    update->old_target);

So... for old_target and ref, an empty string is a special value?
How?  Shouldn't that be documented in the comment before the
function?

> +	else
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "is at %s but expected %s",
> +			    original_update_refname(update),
> +			    ref, update->old_target);
> +
> +	return -1;
> +}
> +
>  /*
>   * Check whether the REF_HAVE_OLD and old_oid values stored in update
>   * are consistent with oid, which is the reference's current value. If
> @@ -2528,6 +2559,18 @@ static int lock_ref_for_update(struct files_ref_=
store *refs,
>  					ret =3D TRANSACTION_GENERIC_ERROR;
>  					goto out;
>  				}
> +			}
> +
> +			/*
> +			 * For symref verification, we need to check the reference value
> +			 * rather than the oid. If we're dealing with regular refs or we're
> +			 * verifying a dereferenced symref, we then check the oid.
> +			 */
> +			if (update->old_target) {
> +				if (check_old_target(update, referent.buf, err)) {
> +					ret =3D TRANSACTION_GENERIC_ERROR;
> +					goto out;
> +				}

We come here only when update->type has REF_ISSYMREF bit on (we
learned that value by calling lock_raw_ref()), and know referent.buf
has the current "target" value.  That is consumed as "ref" parameter
to check_old_target() we just saw.  OK.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 6104471199..a2474245aa 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -938,7 +938,26 @@ static int reftable_be_transaction_prepare(struct =
ref_store *ref_store,
>  		 * individual refs. But the error messages match what the files
>  		 * backend returns, which keeps our tests happy.
>  		 */
> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
> +		if ((u->flags & REF_HAVE_OLD) && u->old_target) {
> +			if (strcmp(referent.buf, u->old_target)) {
> +				if (!strcmp(u->old_target, ""))
> +					strbuf_addf(err, "verifying symref target: '%s': "
> +						    "provided target is empty",
> +						    original_update_refname(u));
> +				else if (!strcmp(referent.buf, ""))
> +					strbuf_addf(err, "verifying symref target: '%s': "
> +						    "reference is missing but expected %s",
> +						    original_update_refname(u),
> +						    u->old_target);
> +				else
> +					strbuf_addf(err, "verifying symref target: '%s': "
> +						    "is at %s but expected %s",
> +						    original_update_refname(u),
> +						    referent.buf, u->old_target);
> +				ret =3D -1;
> +				goto done;
> +			}

Again, the puzzling "empty string"s are handled here.

