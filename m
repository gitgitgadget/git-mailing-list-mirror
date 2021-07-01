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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320CCC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148B36145C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhGALcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhGALcc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 07:32:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F12C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 04:30:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id yy20so9825859ejb.6
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 04:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CBtLCH1Kv12O+Btt/FSTO9bfL8zNOonNJbQNfITOes0=;
        b=PRmOfT1WKwxJkMUelf1vJVgTgfm8TY2vVZF5ouSmbBTYB9DjtpvFSce10NpX+O9dhH
         vwomZ0RPaUFKbb/c30796UInZEKsB/Ip+bz/Pw0mGxTyvGMYTDhxaIYo0Kz6Xp0SBaV+
         80EEcwJSc0XCFXgJ0ES7kicoSZ3Npn852CGhmvxw/cuK0k6sNlrtyEFFiJ7l9KglX1sJ
         5iyrbziCqeC+Tqf4PjXgC41vBnn+mQdn+1lp9xsyRFLsgJrf6K9RYPY8rNKspDgss5Sp
         kADcPPPQ0v7V3yhMhW5RZiaH1r+HUlqkkonN5c2AgvL7l9qtD/vli532igL7AwO+Hbgk
         c0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CBtLCH1Kv12O+Btt/FSTO9bfL8zNOonNJbQNfITOes0=;
        b=k1ZWXkFCV5J1duVFCqrrCtwTatv3qSI2nvWDA1GOeJI58SLZa67WCJwUkNolzElySX
         Cqsz77/LoqDVfJQ6kMUgJMZ81OmZvgDRf4QtfRjMs6NQ41q+usBgqyQ0JD+ty5ZPFPOY
         JGOqZpeLmOE5sxeWhbIVUdPNk6hP7umBWjy2qIrOLtvjV5Wn7jK+CoA87MXTe0LXGOyH
         vbxF4cvEhNRr7bbKcX3SNZUczFkC4c3WrBMywvqoHQEDvAj5bz5xB3osw3F+1LV8YyY/
         3X+IUUd9vX7fLktJH0r5CxNgeF0drGXSfDnlJsBOS1RWYRRp+HJOwGqNksANMMJmfVzN
         canA==
X-Gm-Message-State: AOAM530JpJiV7KZb/W5UAnjJJzR6hYWpDz58YcGVECNQTT4IuqjTPcjZ
        gtmuSr6mFnBmF386i/CJfH+PSMrPdPTD7A==
X-Google-Smtp-Source: ABdhPJxIULw5pm5rrh4p+usRohmcPlRHK+lwaRedy4CNLrRTDcEZYOkm1mqQffuPGxVw9g9mqPGfDw==
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr39993366ejb.233.1625138998809;
        Thu, 01 Jul 2021 04:29:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h19sm12526528edt.87.2021.07.01.04.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 04:29:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 2/8] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
Date:   Thu, 01 Jul 2021 13:13:50 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <cbe09a48036c0befafa0f26f72d188dc765f5b7b.1623329869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <cbe09a48036c0befafa0f26f72d188dc765f5b7b.1623329869.git.gitgitgadget@gmail.com>
Message-ID: <87k0mae0ga.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> refs/files-backend.c::lock_ref_oid_basic() tries to signal how it failed
> to its callers using errno.
>
> It is safe to stop setting errno here, because the callers of this
> file-scope static function are
>
> * files_copy_or_rename_ref()
> * files_create_symref()
> * files_reflog_expire()
>
> None of them looks at errno after seeing a negative return from
> lock_ref_oid_basic() to make any decision, and no caller of these three
> functions looks at errno after they signal a failure by returning a
> negative value. In particular,
>
> * files_copy_or_rename_ref() - here, calls are followed by error()
> (which performs I/O) or write_ref_to_lockfile() (which calls
> parse_object() which may perform I/O)
>
> * files_create_symref() - here, calls are followed by error() or
> create_symref_locked() (which performs I/O and does not inspect
> errno)
>
> * files_reflog_expire() - here, calls are followed by error() or
> refs_reflog_exists() (which calls a function in a vtable that is not
> documented to use and/or preserve errno)
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs/files-backend.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

This all looks good and well justified after the last commit (where we
even mentioned refs_verify_refname_available() explicitly), but...

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 677b7e4cdd2d..6aa0f5c41dd3 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -910,7 +910,6 @@ static int create_reflock(const char *path, void *cb)
>  
>  /*
>   * Locks a ref returning the lock on success and NULL on failure.
> - * On failure errno is set to something meaningful.
>   */
>  static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  					   const char *refname,
> @@ -922,7 +921,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  {
>  	struct strbuf ref_file = STRBUF_INIT;
>  	struct ref_lock *lock;
> -	int last_errno = 0;
>  	int mustexist = (old_oid && !is_null_oid(old_oid));
>  	int resolve_flags = RESOLVE_REF_NO_RECURSE;
>  	int resolved;
> @@ -949,7 +947,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  		 * to remain.
>  		 */
>  		if (remove_empty_directories(&ref_file)) {
> -			last_errno = errno;
>  			if (!refs_verify_refname_available(
>  					    &refs->base,
>  					    refname, extras, skip, err))
> @@ -962,7 +959,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  						     &lock->old_oid, type);
>  	}
>  	if (!resolved) {
> -		last_errno = errno;
> +		int last_errno = errno;
>  		if (last_errno != ENOTDIR ||
>  		    !refs_verify_refname_available(&refs->base, refname,
>  						   extras, skip, err))

...this particular change gives me some pause, because all the rest is
about squirreling away our own errno for our own caller (which it turns
out, we didn't need).

But in this case we're only guarding against
refs_verify_refname_available() possibly clobbering the errno we just
got on !resolved in refs_verify_refname_available().

So instead I'd expect either this on top:
	
	diff --git a/refs/files-backend.c b/refs/files-backend.c
	index 6aa0f5c41dd..28aa4932529 100644
	--- a/refs/files-backend.c
	+++ b/refs/files-backend.c
	@@ -959,12 +959,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
	 						     &lock->old_oid, type);
	 	}
	 	if (!resolved) {
	-		int last_errno = errno;
	-		if (last_errno != ENOTDIR ||
	+		if (errno != ENOTDIR ||
	 		    !refs_verify_refname_available(&refs->base, refname,
	 						   extras, skip, err))
	 			strbuf_addf(err, "unable to resolve reference '%s': %s",
	-				    refname, strerror(last_errno));
	+				    refname, strerror(errno));
	 
	 		goto error_return;
	 	}

Or, if we are actually worried about the errno being reset as we report
it:
	
	diff --git a/refs/files-backend.c b/refs/files-backend.c
	index 6aa0f5c41dd..8ee6af61f1a 100644
	--- a/refs/files-backend.c
	+++ b/refs/files-backend.c
	@@ -960,11 +960,20 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
	 	}
	 	if (!resolved) {
	 		int last_errno = errno;
	+		errno = 0;
	 		if (last_errno != ENOTDIR ||
	 		    !refs_verify_refname_available(&refs->base, refname,
	-						   extras, skip, err))
	-			strbuf_addf(err, "unable to resolve reference '%s': %s",
	-				    refname, strerror(last_errno));
	+						   extras, skip, err)) {
	+			if (errno)
	+				strbuf_addf(err, "unable to resolve reference '%s': '%s', "
	+					    "also got '%s when reporting the error!",
	+					    refname, strerror(last_errno),
	+					    strerror(errno));
	+			else
	+				strbuf_addf(err, "unable to resolve reference '%s': %s",
	+					    refname, strerror(errno));
	+
	+		}
	 
	 		goto error_return;
	 	}

I think in the end it doesn't matter much, we hit our primary error, so
we're only potentially losing another error on our way out the door.

It's more about clarity, the "last_errno" pattern signals "I'm about to
call something that'll reset the errno I care about", but it's not clear
if that's actually the case here, or if this is just leftover
boilerplate.

In any case running the tests with my second hunk with just a:

	if (errno)
		BUG("lost it?");
	else
		...

Passes all our tests. I don't think it should be the scope of this
series to give this code 100% test coverage, but (looking ahead) there's
no mention of /test/ anywhere in the commit messages/comments.

I think even if we keep your "last_errno" as-is here it would be useful
to at least say something like:

	/*
	 * Just paranoia, we probably won't lose errno in
	 * refs_verify_refname_available().
	 */
	int last_errno = errno;
	...
