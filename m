Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A0DC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93954611F2
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 11:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhGKLvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKLvX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 07:51:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D941C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 04:48:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i20so27376517ejw.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qFGDQkNV7xYlkZEzwRtEW7tTZiI7wEQqjlmi10cJmqE=;
        b=W0ZY6djttKc2FwZ1qjL9zeumBIj0TLvDHtw/gJaB5WRcUtruLQ+qg1Grl4Muo5R/5t
         L1H7q/LjMEtQjlOGLtfZiv3NCV0L2Mob8O4dsbgM0X7AsiZ5KHwdfB8bk+7lGazOeitk
         JLTOZ5NW+dP2hKpUEZunuNVOuGRzK8iCB4NqGV16tZVT9CCogfVt70+V/qa1DRnoJj6g
         YawmtuV+vkS82fO7rkh+TomOI53NPCaZFd7p8kfJ4dFkI3kC+XtUL/Inj0g/WZ7mqQCk
         3V4iSgb4OUMKGTFYYO2QTN23Aa9U05KoXLo1RRv+q31J5aYIhpoQfYScKPrh9+TjI9md
         s7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qFGDQkNV7xYlkZEzwRtEW7tTZiI7wEQqjlmi10cJmqE=;
        b=U9xJ0gmbnf7QmFDYwbZyP/RetO+M8Fd2C4tc6UUqzTkyRSwOOhfR0GPWGby0gSu0aP
         ABM/ReoCZg06971Osu++DOgfbSGH5uDxbwRHJWUZ7UM5p78Rwwq6A81JjkUSCfsKeYM9
         brl+MgCEIJmBPMcHuAvhKFboQkoLuxvymsPBownQmGA1bPJjxyOvq7sJSMWS/by8tiv1
         2857MnE8KAM4Stgsb2Qn9aDm4RoQVAv3/4iDk1T5qaujJG2pReTmagtt2/gdWd5tJ9S4
         HDfg4TBIMHeTCtcD72YE1lgmloTagNPpBnx19OldT2esIM1CrCBsPeuhRe3Lo1P8/l/z
         7+Yg==
X-Gm-Message-State: AOAM532CSyJYtg316MTKEAsVWzrcx+OeEQUxO+GyNu47CiM2NlnkQ6De
        iwkhic5HrbUs3jmazY0vyHgjqAqrYPiB9g==
X-Google-Smtp-Source: ABdhPJxtQjZ5Y+DOenkJlvcOxDwNNZx9kQD04KYNxqkEXkk8sVOTJwKKS3UY3MaMrb7dMEZg5+TBLw==
X-Received: by 2002:a17:906:c34b:: with SMTP id ci11mr22067200ejb.223.1626004113828;
        Sun, 11 Jul 2021 04:48:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u26sm4878826ejx.8.2021.07.11.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 04:48:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v5 2/6] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
Date:   Sun, 11 Jul 2021 13:38:48 +0200
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
 <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <95025080c16f535599826ed4f013845d712b0e8d.1625684869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <95025080c16f535599826ed4f013845d712b0e8d.1625684869.git.gitgitgadget@gmail.com>
Message-ID: <87lf6d3wbz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 07 2021, Han-Wen Nienhuys via GitGitGadget wrote:

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
> @@ -962,10 +959,13 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  						     &lock->old_oid, type);
>  	}
>  	if (!resolved) {
> -		last_errno = errno;
> +		int last_errno = errno;
>  		if (last_errno != ENOTDIR ||
> -		    !refs_verify_refname_available(&refs->base, refname,
> -						   extras, skip, err))
> +		    /* in case of D/F conflict, try to generate a better error
> +		     * message. If that fails, fall back to strerror(ENOTDIR).
> +		     */
> +		    !refs_verify_refname_available(&refs->base, refname, extras,
> +						   skip, err))
>  			strbuf_addf(err, "unable to resolve reference '%s': %s",
>  				    refname, strerror(last_errno));

I don't think it's some dealbreaker and we can move on, but just FWIW I
think what I mentioned ending in your
https://lore.kernel.org/git/CAFQ2z_NpyJQLuM70MhJ8K1h2v3QXFuAZRjN=SvSsjnukNRJ8pw@mail.gmail.com/
is still outstanding.

I.e. you added the comment, which is just says what the error emitting
looks like, that's all well & good.

But what I was pointing out that it didn't make sense to do any
"last_errno" here at all anymore. You pointed to 5b2d8d6f218
(lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts,
2015-05-11), we started setting "last_errno" there, but that was *not*
to avoid clobbering between the !resolved and the
strbuf_add(strerror(last_errno)) here, but rather to carry the
"last_errno" forward to the end of this lock_ref_oid_basic(), because
other things (after this hunk) might reset/clear errno.

Anyway, as noted there it doesn't actually matter, just reviewing &
looking if there's any loose ends, and for future source spelunking for
anyone reading this thread.

I.e. something like what I mentioned in
https://lore.kernel.org/git/87k0mae0ga.fsf@evledraar.gmail.com/ could be
squashed in, or better yet (probably) this:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 83ddfb3b627..f0ce0aac857 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -958,17 +958,15 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     refname, resolve_flags,
 						     &lock->old_oid, type);
 	}
-	if (!resolved) {
-		int last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    /* in case of D/F conflict, try to generate a better error
-		     * message. If that fails, fall back to strerror(ENOTDIR).
-		     */
-		    !refs_verify_refname_available(&refs->base, refname, extras,
-						   skip, err))
-			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
-
+	if (!resolved &&
+	    (errno != ENOTDIR ||
+	     /* in case of D/F conflict, try to generate a better error
+	      * message. If that fails, fall back to strerror(ENOTDIR).
+	      */
+	     !refs_verify_refname_available(&refs->base, refname, extras,
+					    skip, err))) {
+		strbuf_addf(err, "unable to resolve reference '%s': %s",
+			    refname, strerror(errno));
 		goto error_return;
 	}
 
