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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC45C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD766144E
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhGAMUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 08:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 08:20:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1FC061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 05:17:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so8163325eds.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pjTmhVd3KyXcgtoPeld0ve3XOtQN/oAy5WIc77WVJUA=;
        b=brdxUfc8IOxOcIO4z3kEBReNWskN7GQN0MiP6+aMR6No48AgY5ekMnVhvI/IyUDW2T
         0C0rwMGvOSM1DwibSGKageUpbB+PLdhFR/oi0V76WjvWE3L0tQe6UF3SFKFgpKb1nroA
         wcABBo7nJ1brTqQShbzy9CrBH5Wv/Bt84PD1lvSUo/f9o8iN1mXCpq9ARJNFTurBRCR+
         Pric+crIlznlrHqX9aHSU3J6VYVDlwuPvgNmfsXIF+uykXkPPieuLbZKEc0vnMdtJ3UZ
         +8dmWbEzgiT+xvhwkw7C01qWe+76oOi0Vcyc3d4oZNZ2wWJPRVJ9SJOlsGgokOJSYkBq
         GRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pjTmhVd3KyXcgtoPeld0ve3XOtQN/oAy5WIc77WVJUA=;
        b=HNvi39/vucmiqall0eRwNSMw+wxpdSb99xdggMBR+2ZHv0ubbv057Bj43sCyt0WwIe
         9HP3tULYpzuF+3mXWGtrXfaYyR6K08zGzomUEOV7/sey7Zeefdz1iF4ZNXl4jYG/pZIX
         nc9xUP/yB50AYvc+SQoOb9TFeVKqulpxSdvxS+VC9mUUGW00MxSxx+GsFQ9tp8dc2OHr
         LFsYTjFMCvcJ6tEPS5kW/83Xb31UijLE9azg2mN6tnUj6JVKJTtsF06AYOeEG3RSaMHU
         qnwq58gIw8Hf0Qzl5aC8AO2427ijaXzfUJxTdbPsqjDJnEmhMReHIcVZRu6UNVuQ/o80
         rDPg==
X-Gm-Message-State: AOAM532mt1sab0WW3oEGMh+WqfXE5EtNBPFrM541XMC9QGB7hOfqcgfW
        swNRp6IuFz5nbOPgo+Bjjz8FFJITGI8J2g==
X-Google-Smtp-Source: ABdhPJy2QVsbkwpmNw5z5HPWpj//Adqp/Iq0jimC2mPBkGEzmBNRxRtbnzxyiU89C2V6ruIYhIABNg==
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr52566505edu.51.1625141854350;
        Thu, 01 Jul 2021 05:17:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x21sm3995538eds.38.2021.07.01.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:17:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 6/8] refs: add failure_errno to refs_read_raw_ref()
 signature
Date:   Thu, 01 Jul 2021 14:06:37 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <2b346caf1aed265ca4787de4208375bd5cfb7bc7.1623329869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <2b346caf1aed265ca4787de4208375bd5cfb7bc7.1623329869.git.gitgitgadget@gmail.com>
Message-ID: <878s2qdy8y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This makes the errno output of refs_read_raw_ref explicit.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs.c                | 29 ++++++++++++++---------------
>  refs/files-backend.c  |  8 ++++----
>  refs/packed-backend.c | 10 ++++++----
>  refs/refs-internal.h  |  6 +++---
>  4 files changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 64e2d55adcfb..ed2dde1c0c6d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1671,21 +1671,19 @@ static int refs_read_special_head(struct ref_store *ref_store,
>  	return result;
>  }
>  
> -int refs_read_raw_ref(struct ref_store *ref_store,
> -		      const char *refname, struct object_id *oid,
> -		      struct strbuf *referent, unsigned int *type)
> +int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
> +		      struct object_id *oid, struct strbuf *referent,
> +		      unsigned int *type, int *failure_errno)
>  {
> -	int result, failure;
> +	if (failure_errno)
> +		*failure_errno = 0;
>  	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
>  		return refs_read_special_head(ref_store, refname, oid, referent,
>  					      type);
>  	}
>  
> -	failure = 0;
> -	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> -					     type, &failure);
> -	errno = failure;
> -	return result;
> +	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> +					   type, failure_errno);
>  }

Ah, so here we drop the whole intermediate step of having this function
not take a failure_errno itself. I think this would be better squashed
into that earlier change.

>  /* This function needs to return a meaningful errno on failure */
> @@ -1726,9 +1724,10 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  
>  	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
>  		unsigned int read_flags = 0;
> +		int read_failure = 0;

Let's call it failure_errno consistently if we end up keeping it.

> -		if (refs_read_raw_ref(refs, refname,
> -				      oid, &sb_refname, &read_flags)) {
> +		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
> +				      &read_flags, &read_failure)) {
>  			*flags |= read_flags;
>  
>  			/* In reading mode, refs must eventually resolve */
> @@ -1740,9 +1739,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  			 * may show errors besides ENOENT if there are
>  			 * similarly-named refs.
>  			 */
> -			if (errno != ENOENT &&
> -			    errno != EISDIR &&
> -			    errno != ENOTDIR)
> +			if (read_failure != ENOENT && read_failure != EISDIR &&
> +			    read_failure != ENOTDIR)
>  				return NULL;

But ditto my previous comments, this seems like a whole dance to avoid
reading errno directly in cases where doing so is actually OK. I.e. the
"last_errno" pattern is for things that encounter an errno, do some
other stuff (such as a printf) where they might get /another/ errno (or
reset it), but in this case we can just document "these will set errno
on failure".

>  			oidclr(oid);
> @@ -2254,7 +2252,8 @@ int refs_verify_refname_available(struct ref_store *refs,
>  		if (skip && string_list_has_string(skip, dirname.buf))
>  			continue;
>  
> -		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
> +		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
> +				       &type, NULL)) {
>  			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
>  				    dirname.buf, refname);
>  			goto cleanup;


And if we do care about errno at all, why would we not add it with a
strerror() here instead of explicitly ignoring it?

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5a430aabf623..01c9bd0dbf04 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -383,8 +383,8 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  	if (lstat(path, &st) < 0) {
>  		if (errno != ENOENT)
>  			goto out;
> -		if (refs_read_raw_ref(refs->packed_ref_store, refname,
> -				      oid, referent, type)) {
> +		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
> +				      referent, type, NULL)) {
>  			errno = ENOENT;
>  			goto out;
>  		}

In this case that seems to make sense, since we substitute our own
errno. Maybe I haven't read this all carefully enough, but why are we
not caring about the errno refs_read_raw_ref() might return here? Is it
because we might take the refs_read_special_head() codepath?

In any case, I for one would appreciate a comment/commit message note
about why we ignore the errno these "I'll give you an errno on failure"
functions return in some cases, but not others.

I think it's probably best to split those into another commit, i.e. do
the "we just ferry errno around differently now (if we'll do that at
all)" as one step, and "here we might get errno, but we like our own
better" as another.

> @@ -423,8 +423,8 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  		 * ref is supposed to be, there could still be a
>  		 * packed ref:
>  		 */
> -		if (refs_read_raw_ref(refs->packed_ref_store, refname,
> -				      oid, referent, type)) {
> +		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
> +				      referent, type, NULL)) {
>  			errno = EISDIR;
>  			goto out;

Ditto.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a457f18e93c8..03353ce48869 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -739,7 +739,8 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  
>  	if (!rec) {
>  		/* refname is not a packed reference. */
> -		*failure_errno = ENOENT;
> +		if (failure_errno)
> +			*failure_errno = ENOENT;
>  		return -1;
>  	}

FWIW I'd think it's better in terms of code readability to not do this,
and make callers who don't care about our errno explicitly provide a
throwaway variable to show that they're not caring, but I don't have the
full picture yet. I.e. make them do something like:

	int ret;
	int got_errno;
	ret = func(..., &got_errno);
	if (!ret) {
		if (!got_errno)
			BUG("error but no errno?");
		/* We don't care, use our own */
		got_errno = ENOSOMETHING
		...
