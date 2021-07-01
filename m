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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18493C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86086145F
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhGAMI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 08:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 08:08:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A6C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 05:05:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i20so9642159ejw.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sGKo3fRFdz3ofPR6kzg15kYq02pQAKMh9k3D+HYJuy0=;
        b=ufgB2E/yjX+IrIoZdKDy2vnkncLdYaqmQBhVU17Mn6d5d+c7gIv9aHG+Z8+0+U1NGG
         XdESyNidt1k+Q0xI9xiqF1lJ7yvWFbVnaNBhPNV9bp02+gfO4ZYPIu3iiufFyiJ7qdZY
         QVOVVEwGyVkp2VzE9zFY3GgA8cxI9JrgK+coudKT137y+WEkOGMIqrDQI6ATUg60kmQf
         uuUf3bgDsRcH1BzQ7hm5gv2nRbQI5XUTtOQ9SY/U90PnfGzqCqMiVrDr4bWOgipt6836
         GSl4ewkWNczINtSoNEJJWan6j/yGJZqXMwlq9Lj6C5aE27Bc1CB++3l53rvjEza7ndxa
         5KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sGKo3fRFdz3ofPR6kzg15kYq02pQAKMh9k3D+HYJuy0=;
        b=Ce3QCZ6ad/4rvGtaoOM5Cye7K4BGztCGUxSTQKXnY9GJ88WfC4EcayKgVm+wsV94Np
         9ozMpoMfCZtUCiNbalu6YdfwvA+VLITZ3XOa6PNuTPkrS+AqQhgoBQKlQL6C1jyuAIip
         g3V1nmg2jfWIwKXjA2L0RClFT1E1qCGZGe1noLeHsfcT8CW5uxOc8PMft5Y8L0SynYKV
         7EY/1EGqHErhNWzBpe1AfyFPlzth2g8DQfKGEj9KdSTbw3jnOaKEb3ls64b66Upvl+ia
         PZGePiYY0vIUJjBzIQYN6KI4gjP2+WXR3IuPijODbSU+5ARQeFStUw76GIL1sjAnqEoE
         mcQw==
X-Gm-Message-State: AOAM530sU/aC7tMzVKEWd55eysTL3GGqhtVzj2P+q6Gf7bGJmr65XNxR
        D7cCtoJ3VGpDlRbiRJl1B8+EyHxiIgETYg==
X-Google-Smtp-Source: ABdhPJzaCVVpm0WCjSwK4uH/OH/xl3smuzPAXxa2dY6yjyej3lXEydKuF03PEHKdfz0B1dbzFQHqdg==
X-Received: by 2002:a17:907:9841:: with SMTP id jj1mr40472026ejc.94.1625141153686;
        Thu, 01 Jul 2021 05:05:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ia26sm10658124ejc.73.2021.07.01.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:05:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 5/8] refs: use refs_resolve_ref_unsafe_with_errno()
 where needed
Date:   Thu, 01 Jul 2021 13:58:35 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <005ee8e6fb2a0f1a38801bed1dfe082999bfec14.1623329869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <005ee8e6fb2a0f1a38801bed1dfe082999bfec14.1623329869.git.gitgitgadget@gmail.com>
Message-ID: <87bl7mdysf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
> that needs error information to make logic decisions.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs/files-backend.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8f969c8f711f..5a430aabf623 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -924,6 +924,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  	int mustexist = (old_oid && !is_null_oid(old_oid));
>  	int resolve_flags = RESOLVE_REF_NO_RECURSE;
>  	int resolved;
> +	int resolve_errno = 0;
>  
>  	files_assert_main_repository(refs, "lock_ref_oid_basic");
>  	assert(err);
> @@ -936,10 +937,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
>  
>  	files_ref_path(refs, &ref_file, refname);
> -	resolved = !!refs_resolve_ref_unsafe(&refs->base,
> -					     refname, resolve_flags,
> -					     &lock->old_oid, type);
> -	if (!resolved && errno == EISDIR) {
> +	resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
> +							resolve_flags,
> +							&lock->old_oid, type,
> +							&resolve_errno);
> +	if (!resolved && resolve_errno == EISDIR) {
>  		/*
>  		 * we are trying to lock foo but we used to
>  		 * have foo/bar which now does not exist;
> @@ -959,12 +961,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  						     &lock->old_oid, type);
>  	}
>  	if (!resolved) {
> -		int last_errno = errno;
> -		if (last_errno != ENOTDIR ||
> -		    !refs_verify_refname_available(&refs->base, refname,
> -						   extras, skip, err))
> +		if (resolve_errno != ENOTDIR ||
> +		    !refs_verify_refname_available(&refs->base, refname, extras,
> +						   skip, err))
>  			strbuf_addf(err, "unable to resolve reference '%s': %s",
> -				    refname, strerror(last_errno));
> +				    refname, strerror(resolve_errno));
>  
>  		goto error_return;
>  	}

So, having read 4/8 and this I wonder why
refs_resolve_ref_unsafe_with_errno() is needed at all. It's just a
wrapper that sets errno to a variable you give it, but we could just
document that tha caller should check errno.

So far I haven't seen anything that suggests the below diff-on-top
wouldn't be OK (and all tests pass with it). It steps on the toes of
some of my earlier suggestions, but I'm doing these one-at-a-time.

In any case the comment I adjusted seems like something you should
adjust to. It looks like a TODO for having the sort of function you've
just implemented in refs_resolve_ref_unsafe_with_errno().

	diff --git a/refs.c b/refs.c
	index 64e2d55adcf..a07d852fcdc 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -1688,7 +1688,10 @@ int refs_read_raw_ref(struct ref_store *ref_store,
	 	return result;
	 }
	 
	-/* This function needs to return a meaningful errno on failure */
	+/*
	+ * This function clears errno at the beginning. If it fails the errno
	+ * will be meaningful.
	+ */
	 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
	 				    const char *refname,
	 				    int resolve_flags,
	@@ -1698,6 +1701,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
	 	struct object_id unused_oid;
	 	int unused_flags;
	 	int symref_count;
	+	errno = 0;
	 
	 	if (!oid)
	 		oid = &unused_oid;
	@@ -1781,18 +1785,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
	 	return NULL;
	 }
	 
	-const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
	-					       const char *refname,
	-					       int resolve_flags,
	-					       struct object_id *oid,
	-					       int *flags, int *failure_errno)
	-{
	-	const char *result = refs_resolve_ref_unsafe(refs, refname,
	-						     resolve_flags, oid, flags);
	-	*failure_errno = errno;
	-	return result;
	-}
	-
	 /* backend functions */
	 int refs_init_db(struct strbuf *err)
	 {
	diff --git a/refs/files-backend.c b/refs/files-backend.c
	index 5a430aabf62..5a400e55cbf 100644
	--- a/refs/files-backend.c
	+++ b/refs/files-backend.c
	@@ -924,7 +924,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
	 	int mustexist = (old_oid && !is_null_oid(old_oid));
	 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
	 	int resolved;
	-	int resolve_errno = 0;
	 
	 	files_assert_main_repository(refs, "lock_ref_oid_basic");
	 	assert(err);
	@@ -937,11 +936,10 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
	 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
	 
	 	files_ref_path(refs, &ref_file, refname);
	-	resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
	-							resolve_flags,
	-							&lock->old_oid, type,
	-							&resolve_errno);
	-	if (!resolved && resolve_errno == EISDIR) {
	+	resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
	+					     resolve_flags,
	+					     &lock->old_oid, type);
	+	if (!resolved && errno == EISDIR) {
	 		/*
	 		 * we are trying to lock foo but we used to
	 		 * have foo/bar which now does not exist;
	@@ -961,11 +959,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
	 						     &lock->old_oid, type);
	 	}
	 	if (!resolved) {
	-		if (resolve_errno != ENOTDIR ||
	+		if (errno != ENOTDIR ||
	 		    !refs_verify_refname_available(&refs->base, refname, extras,
	 						   skip, err))
	 			strbuf_addf(err, "unable to resolve reference '%s': %s",
	-				    refname, strerror(resolve_errno));
	+				    refname, strerror(errno));
	 
	 		goto error_return;
	 	}
	
