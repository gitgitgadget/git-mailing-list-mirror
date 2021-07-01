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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D71DC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D8E6145F
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhGAL5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbhGAL5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 07:57:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96332C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 04:55:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t3so8022904edc.7
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=igeEEwu2+Fi0tZOgaGVN9hwWgI7MBah7fYlzJI2GBYA=;
        b=OLWl/sY9bqLLqLgtPZF9OoE4YHL0nSmOYnqw5+5Po3mu0kmLrbwSE2h2FXvRMvoLCZ
         ev+98NEzCNnDrr6uZVt+YDU+MQsHGtMPAn/sxm1BUEdbZPRsN2ZzOzqHP+FbS7VL46eA
         beJfRtAgRpbwPoYoJoz6nesBhbu/KJoM8PxyDxe4sPJmpCEHDi9rQguoVgFl4zYucqn6
         zJMyAbuwAGIo0xxmA8mekzUnSlW/cBvoAaVhp0e/wq344fcJ15lXSRhDOK7tvHxiLDpS
         1u/4zeDrOTK6mfuhY86WkKiS+eVvex0vBzOtp4NuQ6NwhD2wFfqUsOUJ9s9YnHjHUOCZ
         ZEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=igeEEwu2+Fi0tZOgaGVN9hwWgI7MBah7fYlzJI2GBYA=;
        b=cWkPESMiKYf/xpUWNsMO3S5iavVOT+RfPBbnW4TLXJPM+pXkpqES6VDkG6A3uZfq3m
         YKQNcbpUaRtrp0m5d8WtQm+s7mlXN/sO9+VEPcGBwf7OyDO6S1VnWzAJNOvRUXdfh6Bb
         bQ7ptUTPOJZIIz0GqxFSAbPPdi7Nsj39vHU/n+IhspQ25W/JXCaEyaFZfL78T7CwRN1i
         2J/wko8VkKAIYYYhdrDjONMfcffX8vCwrw3L2jj3dhr0E2QBfLMp+bxxB5eBnyx6/Qzp
         5Jk19A4q7VFtxHNifcJQcV3aPPEX3eF7nzawIeEOv2IiV4aAnC1pIyf+q737Uwe5LQpz
         oNmg==
X-Gm-Message-State: AOAM533F5UF++e78gz60+UFxObRhO7D21etxiPOhduplZc6WXNBUFK15
        3oa4uep1YW7nEcx3opf+kYcUW+ynIEPj5A==
X-Google-Smtp-Source: ABdhPJxaCk6qfdCBb3t+RQkhXP8Zz1d8J+EDUXDkMXgbSwluE4GJcjnGhv4YN+UTYGSL6HrzuYtY8A==
X-Received: by 2002:a05:6402:120b:: with SMTP id c11mr53946867edw.209.1625140521676;
        Thu, 01 Jul 2021 04:55:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jx12sm2072961ejb.9.2021.07.01.04.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 04:55:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 3/8] refs: make errno output explicit for
 read_raw_ref_fn
Date:   Thu, 01 Jul 2021 13:34:15 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <3e2831e59c8e4cb8aef416a41b55083887b4559c.1623329869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <3e2831e59c8e4cb8aef416a41b55083887b4559c.1623329869.git.gitgitgadget@gmail.com>
Message-ID: <87h7hedz9z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> read_raw_ref_fn needs to supply a credible errno for a number of cases. These
> are primarily:
>
> 1) The files backend calls read_raw_ref from lock_raw_ref, and uses the
> resulting error codes to create/remove directories as needed.
>
> 2) ENOENT should be translated in a zero OID, optionally with REF_ISBROKEN set,
> returning the last successfully resolved symref. This is necessary so
> read_raw_ref("HEAD") on an empty repo returns refs/heads/main (or the default branch
> du-jour), and we know on which branch to create the first commit.
>
> Make this information flow explicit by adding a failure_errno to the signature
> of read_raw_ref. All errnos from the files backend are still propagated
> unchanged, even though inspection suggests only ENOTDIR, EISDIR and ENOENT are
> relevant.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs.c                |  8 ++++++--
>  refs/debug.c          |  4 ++--
>  refs/files-backend.c  | 24 ++++++++++++------------
>  refs/packed-backend.c |  8 ++++----
>  refs/refs-internal.h  | 17 +++++++++--------
>  5 files changed, 33 insertions(+), 28 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 8c9490235ea6..bebe3f584da7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1675,13 +1675,17 @@ int refs_read_raw_ref(struct ref_store *ref_store,
>  		      const char *refname, struct object_id *oid,
>  		      struct strbuf *referent, unsigned int *type)
>  {
> +	int result, failure;

Style nit: Different variables should be on different lines, except
where they're the same, so "int i, j", not "int ret, i". Perhaps "ret"
and "errno" are similar enough, but I'd split them, just my 0.02.

Also nit: s/failure/failure_errno/, just like the function signature.

>  	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
>  		return refs_read_special_head(ref_store, refname, oid, referent,
>  					      type);
>  	}
>  
> -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> -					   type);
> +	failure = 0;
> +	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> +					     type, &failure);
> +	errno = failure;
> +	return result;
>  }

Is there some subtlety here where this isn't equivalent to the more
simple/straightforward:

	diff --git a/refs.c b/refs.c
	index bebe3f584da..49ab7555de9 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -1675,17 +1675,14 @@ int refs_read_raw_ref(struct ref_store *ref_store,
	 		      const char *refname, struct object_id *oid,
	 		      struct strbuf *referent, unsigned int *type)
	 {
	-	int result, failure;
	 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
	 		return refs_read_special_head(ref_store, refname, oid, referent,
	 					      type);
	 	}
	 
	-	failure = 0;
	-	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
	-					     type, &failure);
	-	errno = failure;
	-	return result;
	+	errno = 0;
	+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
	+					     type, &errno);
	 }
	 
	 /* This function needs to return a meaningful errno on failure */

In that case adding the "failure_errno" to the signature won't be needed
either, but I'm assuming we're heading towards some reftable end-state
where that makes more sense.

I can only imagine a case where we think files_read_raw_ref() would
encounter a new errno after it assigned to *failure_errno, which is just
a couple of strbuf_release() calls.

if that is a case we're worried about then like in my comment on 2/8
shouldn't we be explicitly checking for such a lost/different errno?
I.e. something like (should probably be less fatal than BUG(...):
		
	diff --git a/refs.c b/refs.c
	index bebe3f584da..9584ddae392 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -1675,16 +1675,22 @@ int refs_read_raw_ref(struct ref_store *ref_store,
	 		      const char *refname, struct object_id *oid,
	 		      struct strbuf *referent, unsigned int *type)
	 {
	-	int result, failure;
	+	int result, failure_errno = 0;
	+
	 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
	 		return refs_read_special_head(ref_store, refname, oid, referent,
	 					      type);
	 	}
	 
	-	failure = 0;
	+	errno = 0;
	 	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
	-					     type, &failure);
	-	errno = failure;
	+					     type, &failure_errno);
	+	if (errno)
	+		BUG("Got another errno from read_raw_ref()?: %s, failure errno: %s",
	+		    strerror(errno),
	+		    strerror(failure_errno));
	+	else
	+		errno = failure_errno;
	 	return result;
	 }
	 
	diff --git a/refs/files-backend.c b/refs/files-backend.c
	index 8f969c8f711..57cfdf738da 100644
	--- a/refs/files-backend.c
	+++ b/refs/files-backend.c
	@@ -458,8 +458,10 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
	 	ret = parse_loose_ref_contents(buf, oid, referent, type);
	 
	 out:
	-	if (failure_errno)
	+	if (failure_errno) {
	 		*failure_errno = errno;
	+		errno = 0;
	+	}
	 	strbuf_release(&sb_path);
	 	strbuf_release(&sb_contents);
	 	return ret;
	diff --git a/refs/packed-backend.c b/refs/packed-backend.c
	index a457f18e93c..4bcb4777f0f 100644
	--- a/refs/packed-backend.c
	+++ b/refs/packed-backend.c
	@@ -740,6 +740,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
	 	if (!rec) {
	 		/* refname is not a packed reference. */
	 		*failure_errno = ENOENT;
	+		errno = 0;
	 		return -1;
	 	}

Which also passes all our tests, and the packed_read_raw_ref() suggests
how you may have come up with the current pattern.
> [...]
> - * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
> - * and return -1. If the ref exists but is neither a symbolic ref nor
> - * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
> - * (errno should not be ENOENT) If there is another error reading the
> - * ref, set errno appropriately and return -1.
> + * Return 0 on success. If the ref doesn't exist, set failure_errno to ENOENT
> + * and return -1. If the ref exists but is neither a symbolic ref nor an object
> + * ID, it is broken; set REF_ISBROKEN in type, and return -1 (failure_errno
> + * should not be ENOENT). The files backend may return EISDIR (if the ref name
> + * is a directory) and ENOTDIR (if a ref prefix is not a directory). If there is
> + * another error reading the ref, set failure_errno appropriately and return -1.
>   *

This documentation is a bit confusing in light of the above comments. I
assume that "set failure_errno appropriately" here means that it will do
it, but it's really worded like it's suggesting that you should do it,
and does the "another error" suggest that a caller may need to deal with
an arbitrary errno, not just the ENOENT|EISDIR|ENOTDIR?
