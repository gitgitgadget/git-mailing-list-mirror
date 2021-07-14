Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13DC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C69613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhGNTcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNTcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:32:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A62C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:29:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nd37so5136336ejc.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/uX3dIaCD38na07Dq+WAZjVm9u4GrY/EdLmvlfzSGI4=;
        b=iYRagjxzESjaxu7aIXtdQwuyTGXRHSwyZCkF6w8DvaO404Sil8xJnkE7iB1NosCpR3
         /R6sNscWnaGd/pghc7hmq1NL9wjIbxnecjJLCDFc5ojEidGVtp9gTvAdrrMnB+UTXHjA
         Fy5Etwz6S+AoO8up8pLz5QaqibsDOj7zSACFRb1D8gPjChpoo8zCzaBZcKLDx89DlyDc
         xauG+Ijg1z/zT7ThH51nERHVviyWe3e/HHCZxrBMEYRW7JxbqsGU8hc9UqNxcM8B5j4f
         VKqnO8GV0WKSGAN5kCgTS+jtLWboEKuKiTtBUyV0Si5jVB2DOmeOEabGVcpH0fK3Shbb
         YTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/uX3dIaCD38na07Dq+WAZjVm9u4GrY/EdLmvlfzSGI4=;
        b=ZO+8bFaMLNzlKcHdnifRoPn9FnErR9VseZE7HXYPXhAgP9ARPqr4FsQ7zPVSTAOmUM
         mbf4vIVZqHiEQQQgh3+XLRa0zJvHYQyTEtqDnm3ANzCpl7nrw1c495XFayrdW1XugmwL
         HmiYg8Xpug/xsFko5XnOuM/Htdo6c9ev7I4ZNLW5j0+FPxvXd/LlbGaZ/eP3YACvuqcg
         RWGMXUcQgvUwt6B4XDS8n56y2lJESetyHQJBQjpG0CgO0HcmMWHY/mR9KTcTbTMhhFyv
         u0VBKaR3ysq6KcxaOVqwjNlrQMGj5MHRshLn3R0ZsBb1NRGG8116oX3U+wcAvV7uPTTO
         KQvA==
X-Gm-Message-State: AOAM530ZFVzq1UnLnAKibeJgVN+WS58GIHHnJhwhzENJbcDgMDZHh+iK
        8k8J+dR4Yogha8IO2k9fsSw=
X-Google-Smtp-Source: ABdhPJyhzRObNgOlyIQjfSzN8QiaQCJUJHyP41xoliuUpyNpBWpOdPKJ+UMUuzV94HiNUXuwY3cm0w==
X-Received: by 2002:a17:906:6c8f:: with SMTP id s15mr14229061ejr.498.1626290960719;
        Wed, 14 Jul 2021 12:29:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id eg5sm1459658edb.38.2021.07.14.12.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:29:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Date:   Wed, 14 Jul 2021 21:07:41 +0200
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
Message-ID: <871r801yp6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Jeff King wrote:

> On Wed, Jul 14, 2021 at 01:17:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Since a1c1d8170d (refs_resolve_ref_unsafe: handle d/f conflicts for
>> writes, 2017-10-06) we don't, because our our callstack will look
>> something like:
>>=20
>>     files_copy_or_rename_ref() -> lock_ref_oid_basic() -> refs_resolve_r=
ef_unsafe()
>>=20
>> And then the refs_resolve_ref_unsafe() call here will in turn (in the
>> code added in a1c1d8170d) do the equivalent of this (via a call to
>> refs_read_raw_ref()):
>>=20
>> 	/* Via refs_read_raw_ref() */
>> 	fd =3D open(path, O_RDONLY);
>> 	if (fd < 0)
>> 		/* get errno =3D=3D EISDIR */
>> 	/* later, in refs_resolve_ref_unsafe() */
>> 	if ([...] && errno !=3D EISDIR)
>> 		return NULL;
>> 	[...]
>> 	/* returns the refs/heads/foo to the caller, even though it's a directo=
ry */
>> 	return refname;
>
> Isn't that pseudo-code missing a conditional that's there in the real
> code? In refs_resolve_ref_unsafe(), I see:
>
>        if (refs_read_raw_ref(refs, refname,
>                              oid, &sb_refname, &read_flags)) {
>                *flags |=3D read_flags;
>
>                /* In reading mode, refs must eventually resolve */
>                if (resolve_flags & RESOLVE_REF_READING)
>                        return NULL;
>
>                /*
>                 * Otherwise a missing ref is OK. But the files backend
>                 * may show errors besides ENOENT if there are
>                 * similarly-named refs.
>                 */
>                if (errno !=3D ENOENT &&
>                    errno !=3D EISDIR &&
>                    errno !=3D ENOTDIR)
>                        return NULL;
>
> So if RESOLVE_REF_READING is set, we can return NULL immediately, with
> errno set to EISDIR. Which contradicts this:

I opted (perhaps unwisely) to elide that since as you note above we
don't take that path in relation to the removed code. I.e. I'm
describing the relevant codepath we take nowadays given the code & its
callers.

But will reword etc., thanks.

>> I.e. even though we got an "errno =3D=3D EISDIR" we won't take this
>> branch, since in cases of EISDIR "resolved" is always
>> non-NULL. I.e. we pretend at this point as though everything's OK and
>> there is no "foo" directory.
>
> So when is RESOLVE_REF_READING set? The resolve_flags parameter is
> passed in by the caller. In lock_ref_oid_basic(), it comes from this:
>
>     int mustexist =3D (old_oid && !is_null_oid(old_oid));
>     [...]
>     if (mustexist)
>             resolve_flags |=3D RESOLVE_REF_READING;
>
> So do any callers pass in old_oid? Surprisingly few. It used to be
> called from other locking functions, but these days it looks like it is
> only files_reflog_expire().

In general (and not being too familiar with this area) and per:

    7521cc4611 (refs.c: make delete_ref use a transaction, 2014-04-30)
    92b1551b1d (refs: resolve symbolic refs first, 2016-04-25)
    029cdb4ab2 (refs.c: make prune_ref use a transaction to delete the ref,=
 2014-04-30)

And:

    https://lore.kernel.org/git/20140902205841.GA18279@google.com/=20=20=20=
=20

I wonder if these remaining cases can be migrated over to lock_raw_ref()
or the transaction API, as many other similar callers have been already.

But that's a bigger change, I won't be doing that now, just wondering if
these are some #leftoverbits or if there's a good reason they were left.

> I'm not sure if this case is important or not. If we're expecting the
> ref to exist, then an in-the-way directory is going to mean failure
> either way. It could still exist within the packed-refs file, but then
> refs_read_raw_ref() would not return failure.
>
> So...I think it's fine? But the argument in your commit message seems to
> have missed this case entirely.

Perhaps more succinctly: If we have a directory in the way, it's going
to be impossible for the "old_oid" condition to be satisfied in any case
in the file backend.

Even if we still had a caller that did "care" about that what could they
hope to get from an "old_oid=3D<some-OID>" for a lock on "foo/bar" where
"foo" is an empty directory?

Except of course for the case where it's not a directory but packed, but
as you noted that's handled in another case.

Perhaps it's informative that the below diff-on-top also passes all
tests, i.e. that we have largely the same
"refs_read_raw_ref(refs->packed_ref_store" copy/pasted in
files_read_raw_ref() in two adjacent places, we're just changing what
errno we pass upwards.

It thoroughly tramples on Han-Wen's series, and it's easier to deal with
(if at all) once his lands, just thought it might be interesting:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7e4963fd07..4a97cd48d9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -356,6 +356,8 @@ static int files_read_raw_ref(struct ref_store *ref_sto=
re,
 	int ret =3D -1;
 	int save_errno;
 	int remaining_retries =3D 3;
+	int lstat_bad_or_not_file =3D 0;
+	int lstat_errno =3D 0;
=20
 	*type =3D 0;
 	strbuf_reset(&sb_path);
@@ -382,11 +384,28 @@ static int files_read_raw_ref(struct ref_store *ref_s=
tore,
 		goto out;
=20
 	if (lstat(path, &st) < 0) {
-		if (errno !=3D ENOENT)
+		lstat_bad_or_not_file =3D 1;
+		lstat_errno =3D errno;
+	} else if (S_ISDIR(st.st_mode)) {
+		/*
+		 * Maybe it's an empty directory, maybe it's not, in
+		 * either case this ref does not exist in the files
+		 * backend (but may be packet), later code will handle
+		 * the "create and maybe remove_empty_directories()"
+		 * case if needed, or die otherwise.
+		 */
+		lstat_bad_or_not_file =3D 1;
+	}
+
+	if (lstat_bad_or_not_file) {
+		if (lstat_errno && lstat_errno !=3D ENOENT)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname,
 				      oid, referent, type)) {
-			errno =3D ENOENT;
+			if (lstat_errno)
+				errno =3D ENOENT;
+			else
+				errno =3D EISDIR;
 			goto out;
 		}
 		ret =3D 0;
@@ -417,22 +436,6 @@ static int files_read_raw_ref(struct ref_store *ref_st=
ore,
 		 */
 	}
=20
-	/* Is it a directory? */
-	if (S_ISDIR(st.st_mode)) {
-		/*
-		 * Even though there is a directory where the loose
-		 * ref is supposed to be, there could still be a
-		 * packed ref:
-		 */
-		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      oid, referent, type)) {
-			errno =3D EISDIR;
-			goto out;
-		}
-		ret =3D 0;
-		goto out;
-	}
-
 	/*
 	 * Anything else, just open it and try to use it as
 	 * a ref
