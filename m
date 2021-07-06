Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A197C07E99
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 00:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447CC60238
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 00:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhGFAun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 20:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGFAum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 20:50:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A4C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 17:48:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nd37so31372719ejc.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HmjZte1QfJ7gv7N1ZAzdjGv/0WNpDbkOGCAq4JOybjw=;
        b=qCQYkQnGmLojhYVuuYh3FkxEFkxpbkIvQRmyQFvoQOTEXkVY0XkyCfPerylqZ+fNk9
         czNAd35zzXnf31LGqzgQKWlzFqHxE+4CvbXdqn6rF90uf6YANSEshb5agpm5FX9Qhhm1
         V59c2/mudmP58nlh8EOhfsVnuLb2SduqyS5bna9dp1IvjKgmiLCwSFvtGRoKez6T0uE6
         N2wjF33+O8uqL1vh1sGA34NsXxcsb1gzej5T4rhswvpd4ibv1xx0ArNotws9HtKRFOkZ
         tK5ra/FlGTTBf1ArtUCoaF5jJZSCZ9QpwbNfwSZtFrJJZq8Z7Y/HIcfK1FxqC7WzVI0L
         5slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HmjZte1QfJ7gv7N1ZAzdjGv/0WNpDbkOGCAq4JOybjw=;
        b=IEYGDp7Mzc3IWEg4mjOidnGuI865cnksW98/KW8QoeoUsQIRGZyUbKLhF2/seH1Cab
         MEx/WVNjijBo/mTcIglFfgrkMsHtnaMW3Pn3aCteV4YGQmuXeFFuFnx6ly6/dgUxGDQV
         dFu7D0Z/eW3vOOeCKt2sZQMjzYKActvnKlSWiYwNzMiPaZOdpmpbebLUpbzh9G7smE9b
         3KWpNHME3k5y/7aEooziXnOcwRMOXIujNksNupmLWHZK16VTvEVjS7cIaYXQCiXK2pyO
         WQorWjtBuKHjxEgQpJgS5eweIUlQR2TTE4NQGHjioYq17N9gNYJ8dTUKkyrTokzMBTtp
         XFNw==
X-Gm-Message-State: AOAM531IG2ZhfKvbRIRvgytgFQMACxeTiYxs364YcgoC+rj7zvabSxWU
        LvtcMAeblkajxx4EwHkuumFNaizJpOM=
X-Google-Smtp-Source: ABdhPJzpHDi93neqfSdmv2RVBgXbU6H957ISCL5Vbslv1IVxMYzGwo0NDia7uIZbKtVlQTGp+jVEcw==
X-Received: by 2002:a17:907:7285:: with SMTP id dt5mr11807187ejc.215.1625532481168;
        Mon, 05 Jul 2021 17:48:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j22sm4982977eje.123.2021.07.05.17.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:48:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/5] refs: cleanup errno sideband ref related functions
Date:   Tue, 06 Jul 2021 02:38:49 +0200
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
Message-ID: <87v95o5ku8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> v5

v3?

>  * address =C3=86var's comment; punt on clearing errno.
> [...]
>=20=20=20=20=20=20=20
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>           Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>      +    Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>

FWIW per Documentation/SubmittingPatches:
=20=20=20=20
    . `Reviewed-by:`, unlike the other tags, can only be offered by the
      reviewer and means that she is completely satisfied that the patch
      is ready for application.  It is usually offered only after a
      detailed review.

It's not that I'm hard to please, but I can honestly say that I don't
quite understand some parts of what you're gonig for, so that trailer is
probably premature :)

>        ## refs/files-backend.c ##
>       @@ refs/files-backend.c: static int create_reflock(const char *path=
, void *cb)
>      @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(=
struct files_re
>       -		last_errno =3D errno;
>       +		int last_errno =3D errno;
>        		if (last_errno !=3D ENOTDIR ||
>      - 		    !refs_verify_refname_available(&refs->base, refname,
>      - 						   extras, skip, err))
>      +-		    !refs_verify_refname_available(&refs->base, refname,
>      +-						   extras, skip, err))
>      ++		    /* in case of D/F conflict, try to generate a better error
>      ++		     * message. If that fails, fall back to strerror(ENOTDIR).
>      ++		     */
>      ++		    !refs_verify_refname_available(&refs->base, refname, extras,
>      ++						   skip, err))
>      + 			strbuf_addf(err, "unable to resolve reference '%s': %s",
>      + 				    refname, strerror(last_errno));
>      +=20
>       @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic=
(struct files_ref_store *refs,
>        	if (is_null_oid(&lock->old_oid) &&
>        	    refs_verify_refname_available(refs->packed_ref_store, refname,
>  3:  3e2831e59c8 ! 3:  b017caf54ba refs: make errno output explicit for r=
ead_raw_ref_fn
>      @@ Metadata
>        ## Commit message ##
>           refs: make errno output explicit for read_raw_ref_fn
>=20=20=20=20=20=20=20
>      +    This makes it explicit how alternative ref backends should repo=
rt errors in
>      +    read_raw_ref_fn.
>      +
>           read_raw_ref_fn needs to supply a credible errno for a number o=
f cases. These
>           are primarily:
>=20=20=20=20=20=20=20
>      @@ Commit message
>=20=20=20=20=20=20=20
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>           Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>      +    Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com>
>=20=20=20=20=20=20=20
>        ## refs.c ##
>       @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
>        		      const char *refname, struct object_id *oid,
>        		      struct strbuf *referent, unsigned int *type)
>        {
>      -+	int result, failure;
>      ++	int result;
>      ++	int failure_errno;
>        	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEA=
D")) {
>        		return refs_read_special_head(ref_store, refname, oid, referent,
>        					      type);
>      @@ refs.c: int refs_read_raw_ref(struct ref_store *ref_store,
>=20=20=20=20=20=20=20=20
>       -	return ref_store->be->read_raw_ref(ref_store, refname, oid, refer=
ent,
>       -					   type);
>      -+	failure =3D 0;
>      ++	failure_errno =3D 0;
>       +	result =3D ref_store->be->read_raw_ref(ref_store, refname, oid, r=
eferent,
>      -+					     type, &failure);
>      -+	errno =3D failure;
>      ++					     type, &failure_errno);
>      ++	if (failure_errno)
>      ++		errno =3D failure_errno;
>       +	return result;
>        }

To rephrase my comment on the v2 to hopefully better get at the
point/question I had.

It wasn't that I don't get why you wouldn't save/restore errno in
general.

It's that the pattern of doing so seems backwards to me. I.e. surely the
goal here should be to one function at a time, and from the bottom-up,
figure out where we rely on "errno" and convert that to a
"failure_errno".

Instead not even files_read_raw_ref() resets "errno =3D 0" at the end, so
the errno /there/ can propagate upwards, and in this v3 we're not clearing =
it at all.

I'm all for clearing it as mentioned in another mail, surely that should
be the point of this whole thing, i.e. to refactor this part of the API
so that we're assured that nothing upstream of us relies on errno & prep
things for reftable (which won't set it at all, except to fake it).

Having dug a bit further, it seems what you're doing, whether it's
intentional or not, is relying on the parse_loose_ref_contents() setting
EINVAL, but you clobber your *failure_errno with it whether it returned
-1 or not.

Seemingly to make that logic work in files_read_raw_ref() you, after
getting an errno, assigned it "errno", instead of to a
saved_errno". Thus requiring an inverse of the pattern where you need a
"saved_errno" dance to save away an errno you explicitly don't care
about (because you didn't save the one you wanted earlier).

I think something like the following diff on top, this whole dance was
only needed because you didn't pass the failure_errno down to
refs_read_special_head() and parse_loose_ref_contents().

diff --git a/refs.c b/refs.c
index 25d80e544d0..eca7310e7a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1653,7 +1653,8 @@ int for_each_fullref_in_prefixes(const char *namespac=
e,
=20
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
-				  struct strbuf *referent, unsigned int *type)
+				  struct strbuf *referent, unsigned int *type,
+				  int *failure_errno)
 {
 	struct strbuf full_path =3D STRBUF_INIT;
 	struct strbuf content =3D STRBUF_INIT;
@@ -1663,7 +1664,8 @@ static int refs_read_special_head(struct ref_store *r=
ef_store,
 	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
 		goto done;
=20
-	result =3D parse_loose_ref_contents(content.buf, oid, referent, type);
+	result =3D parse_loose_ref_contents(content.buf, oid, referent, type,
+					  failure_errno);
=20
 done:
 	strbuf_release(&full_path);
@@ -1683,7 +1685,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, co=
nst char *refname,
=20
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
-					      type);
+					      type, failure_errno);
 	}
=20
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8506c8b3bde..823325cc97f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -381,11 +381,12 @@ static int files_read_raw_ref(struct ref_store *ref_s=
tore, const char *refname,
 		goto out;
=20
 	if (lstat(path, &st) < 0) {
-		if (errno !=3D ENOENT)
+		*failure_errno =3D errno;
+		if (*failure_errno !=3D ENOENT)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
 				      referent, type, NULL)) {
-			errno =3D ENOENT;
+			*failure_errno =3D ENOENT;
 			goto out;
 		}
 		ret =3D 0;
@@ -396,7 +397,8 @@ static int files_read_raw_ref(struct ref_store *ref_sto=
re, const char *refname,
 	if (S_ISLNK(st.st_mode)) {
 		strbuf_reset(&sb_contents);
 		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
-			if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
+			*failure_errno =3D errno;
+			if (*failure_errno =3D=3D ENOENT || *failure_errno =3D=3D EINVAL)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
@@ -425,7 +427,7 @@ static int files_read_raw_ref(struct ref_store *ref_sto=
re, const char *refname,
 		 */
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
 				      referent, type, NULL)) {
-			errno =3D EISDIR;
+			*failure_errno =3D errno =3D EISDIR;
 			goto out;
 		}
 		ret =3D 0;
@@ -438,7 +440,7 @@ static int files_read_raw_ref(struct ref_store *ref_sto=
re, const char *refname,
 	 */
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno =3D=3D ENOENT && !S_ISLNK(st.st_mode))
+		if (*failure_errno =3D=3D ENOENT && !S_ISLNK(st.st_mode))
 			/* inconsistent with lstat; retry */
 			goto stat_ref;
 		else
@@ -446,26 +448,25 @@ static int files_read_raw_ref(struct ref_store *ref_s=
tore, const char *refname,
 	}
 	strbuf_reset(&sb_contents);
 	if (strbuf_read(&sb_contents, fd, 256) < 0) {
-		int save_errno =3D errno;
 		close(fd);
-		errno =3D save_errno;
 		goto out;
 	}
 	close(fd);
 	strbuf_rtrim(&sb_contents);
 	buf =3D sb_contents.buf;
=20
-	ret =3D parse_loose_ref_contents(buf, oid, referent, type);
+	ret =3D parse_loose_ref_contents(buf, oid, referent, type, failure_errno);
=20
 out:
-	*failure_errno =3D errno;
+	errno =3D 0; /* saved in *failure_errno */
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
 	return ret;
 }
=20
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
-			     struct strbuf *referent, unsigned int *type)
+			     struct strbuf *referent, unsigned int *type,
+			     int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -484,7 +485,7 @@ int parse_loose_ref_contents(const char *buf, struct ob=
ject_id *oid,
 	if (parse_oid_hex(buf, oid, &p) ||
 	    (*p !=3D '\0' && !isspace(*p))) {
 		*type |=3D REF_ISBROKEN;
-		errno =3D EINVAL;
+		*failure_errno =3D EINVAL;
 		return -1;
 	}
 	return 0;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c52a64b081b..530999f50df 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -700,7 +700,8 @@ struct ref_store {
  * Parse contents of a loose ref file.
  */
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
-			     struct strbuf *referent, unsigned int *type);
+			     struct strbuf *referent, unsigned int *type,
+			     int *failure_errno);
=20
 /*
  * Fill in the generic part of refs and add it to our collection of
