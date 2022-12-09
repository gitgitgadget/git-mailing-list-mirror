Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC02C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 14:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLIOh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLIOhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 09:37:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB87389F5
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 06:37:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n20so12045505ejh.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 06:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcsd1y6YxQ5Ns94sT6ilF3f9+Tmd5TY4JU8NNLeEJ2c=;
        b=M0QVQwUfGbCsdDUGkkxKWKSmuJ8wUcruxGA6c2qtdCbiv+iH6XWJUddg/BUiZOABnS
         HhgGwChYJecZQb0tlKxBUXwcrWqiCHuhbHk+0PE9OGX9mTnVUVcqvpYYAHW5EHh3szmK
         AXhjB08mdJzQsPCgNpDRh9KTBsM0jWDPjoZLqEnhqti/qpq1+fhCKsav5VK8lbtRBvah
         Ehfo11lYv9A30hCLP6VtKu3dRHSn0nqy1cFXCh0WnQjJqIr8f1U9eXYno+2a+8lur83Z
         KMJqYFlyVrHlx/TGwzSqKLG1UIDqOJQGCri+RdFQHQNWA7kZRH+XFw+mEHEd90RtjUgb
         mRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qcsd1y6YxQ5Ns94sT6ilF3f9+Tmd5TY4JU8NNLeEJ2c=;
        b=nlON+C68a7GaLJR0isutjC1TwgIIE+Ys4AIx9F6FPW0nHApQENzSl9jAABTQyTIDrW
         rr/DF25M4aegcYlvYElBKqZGttiBSEjZgqHDzcbQlE/CRHJexZR77PiYStoCTjiTI89S
         ugi7u0wHVz1IlWK2cCW5JT0FBBopofFafz8CnpVzlkRN7F9g9hrcVdrJn/bZyewRggYQ
         7zA1wUFUnXl4I+Innihq5vFBR0MNpisiYp0FSr0rNM5MVCg2owfYMJvNpppeKW3Kz9dM
         3LCnni+XXpJthAgpsJPkEJRSdZyTd2KBlThUg6LjB9hs855UKkOt3KWptbb3P/KTXk9W
         maag==
X-Gm-Message-State: ANoB5pmP8yhMyW4SxctTW4oUmi4dTIhB9v68nk0up9NiKDC8bBaa8b/H
        QlthyMqHtJAqnOJ5dtGl//zEbt64IA0=
X-Google-Smtp-Source: AA0mqf4v4Kn7utXvNC6tm+0LHbG5hW5TdO0d2iu+kipJf81UbTcz9ZUpjiEmFwwEBZShWsipV8vR1w==
X-Received: by 2002:a17:907:c20d:b0:7ad:9c82:6f56 with SMTP id ti13-20020a170907c20d00b007ad9c826f56mr5931135ejc.35.1670596639796;
        Fri, 09 Dec 2022 06:37:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ku6-20020a170907788600b00780982d77d1sm616543ejc.154.2022.12.09.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:37:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3eV4-0058pY-1a;
        Fri, 09 Dec 2022 15:37:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v3 3/4] object-file: emit corruption errors when detected
Date:   Fri, 09 Dec 2022 15:19:44 +0100
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670532905.git.jonathantanmy@google.com>
 <7c9ed861e7431352df864c8d2c3bec7dee6e3905.1670532905.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <7c9ed861e7431352df864c8d2c3bec7dee6e3905.1670532905.git.jonathantanmy@google.com>
Message-ID: <221209.86y1rg63tt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Jonathan Tan wrote:

> Instead of relying on errno being preserved across function calls, teach
> do_oid_object_info_extended() to itself report object corruption when
> it first detects it. There are 3 types of corruption being detected:
>  - when a replacement object is missing
>  - when a loose object is corrupt
>  - when a packed object is corrupt and the object cannot be read
>    in another way
>
> Note that in the RHS of this patch's diff, a check for ENOENT that was
> introduced in 3ba7a06552 (A loose object is not corrupt if it cannot
> be read due to EMFILE, 2010-10-28) is also removed. The purpose of this
> check is to avoid a false report of corruption if the errno contains
> something like EMFILE (or anything that is not ENOENT), in which case
> a more generic report is presented. Because, as of this patch, we no
> longer rely on such a heuristic to determine corruption, but surface
> the error message at the point when we read something that we did not
> expect, this check is no longer necessary.
>
> Besides being more resilient, this also prepares for a future patch in
> which an indirect caller of do_oid_object_info_extended() will need
> such functionality.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  object-file.c  | 48 ++++++++++++++++++++++--------------------------
>  object-store.h |  3 +++
>  2 files changed, 25 insertions(+), 26 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index d99d05839f..f166065f32 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1433,6 +1433,7 @@ static int loose_object_info(struct repository *r,
>  {
>  	int status = 0;
>  	unsigned long mapsize;
> +	const char *path = NULL;

I think the NULL assignment here should either go, or it's incomplete.

Below you chechk the return value of "map", so let's either trust it to
populate "path" if it's returning success (which it does), *or* not
trust it, init this to NULL, and below add....

>  	void *map;
>  	git_zstream stream;
>  	char hdr[MAX_HEADER_LEN];
> @@ -1464,7 +1465,7 @@ static int loose_object_info(struct repository *r,
>  		return 0;
>  	}
>  
> -	map = map_loose_object(r, oid, &mapsize);
> +	map = map_loose_object_1(r, oid, &mapsize, &path);
>  	if (!map)
>  		return -1;

....

	if (!path)
		BUG("map_loose_object_1 should have given us a path");

But I don't think it's good to just hide the potential difference
between the two, especially as....

> @@ -1502,6 +1503,10 @@ static int loose_object_info(struct repository *r,
>  		break;
>  	}
>  
> +	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
> +		die(_("loose object %s (stored in %s) is corrupt"),
> +		    oid_to_hex(oid), path);

...I think this is leftover from a previous round (or maybe not, I
didn't check) where we did a free(path), but here we'd end up
segfaulting (not on glibc, but some platforms) if we have a NULL path.

So init-ing it didn't help us, but just helps to hide that potential
(and much worse) bug.

I think this change should also remove the existing "const char *path"
in this function from the "if"'d scope omitted in this context.

The C compiler won't care, but to the human reader it's easier to reason
about not shadowing the variable now, for as it turns out no reason, as
they're effectively independent.

>  	git_inflate_end(&stream);
>  cleanup:
>  	munmap(map, mapsize);
> @@ -1611,6 +1616,15 @@ static int do_oid_object_info_extended(struct repository *r,
>  			continue;
>  		}
>  
> +		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
> +			const struct packed_git *p;

Nit: add an extra \n here, between decls and code.

> -	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
> +	if (oid_object_info_extended(r, oid, &oi,
> +				     die_if_corrupt ? OBJECT_INFO_DIE_IF_CORRUPT : 0)
> +	    < 0)
>  		return NULL;
>  	return content;
>  }

This is a very odd coding style/wrapping, to not even end up with a line
shorter than 79 characters. You can instead do:

	if (oid_object_info_extended(r, oid, &oi, die_if_corrupt
				     ? OBJECT_INFO_DIE_IF_CORRUPT : 0) < 0)

Which is in line with our usual style, and does wrap before 79 characters...

> diff --git a/object-store.h b/object-store.h
> index b1ec0bde82..98c1d67946 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -445,6 +445,9 @@ struct object_info {
>   */
>  #define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
>  
> +/* Die if object corruption (not just an object being missing) was detected. */
> +#define OBJECT_INFO_DIE_IF_CORRUPT 32

Personally I wouldn't mind a short cleanup step in this series to change
these to 1<<0, 1<<1 etc., as we do for almost everything els.

I.e. in an earlier step you removed the "16", and changed that "32" to
"16", now we're adding a "32" again.

I also notice that you didn't just add a "4" here, which is an existing
gap, which turns out to be a leftover bit from your 9c8a294a1ae
(sha1-file: remove OBJECT_INFO_SKIP_CACHED, 2020-01-02) ~2 years ago :)

Maybe it's too much, and we could do it later, but something like this
as a first step:

diff --git a/object-file.c b/object-file.c
index 26290554bb4..48eff3850f5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1534,7 +1534,8 @@ int fetch_if_missing = 1;
 
 static int do_oid_object_info_extended(struct repository *r,
 				       const struct object_id *oid,
-				       struct object_info *oi, unsigned flags)
+				       struct object_info *oi,
+				       enum object_info_flags flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct cached_object *co;
@@ -1633,7 +1634,7 @@ static int do_oid_object_info_extended(struct repository *r,
 }
 
 int oid_object_info_extended(struct repository *r, const struct object_id *oid,
-			     struct object_info *oi, unsigned flags)
+			     struct object_info *oi, enum object_info_flags flags)
 {
 	int ret;
 	obj_read_lock();
diff --git a/object-store.h b/object-store.h
index 1be57abaf10..a20e00395b9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -428,28 +428,31 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT { 0 }
 
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Allow reading from a loose object file of unknown/bogus type */
-#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
-/* Do not check loose object */
-#define OBJECT_INFO_IGNORE_LOOSE 16
-/*
- * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero).
- */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 32
-/*
- * This is meant for bulk prefetching of missing blobs in a partial
- * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
- */
-#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
+enum object_info_flags {
+	/* Invoke lookup_replace_object() on the given hash */
+	OBJECT_INFO_LOOKUP_REPLACE = 1<<0,
+	/* Allow reading from a loose object file of unknown/bogus type */
+	OBJECT_INFO_ALLOW_UNKNOWN_TYPE = 1<<1,
+	/* Do not retry packed storage after checking packed and loose storage */
+	OBJECT_INFO_QUICK = 1<<2,
+	/* Do not check loose object */
+	OBJECT_INFO_IGNORE_LOOSE = 1<<3,
+	/*
+	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+	 * nonzero).
+	 */
+	OBJECT_INFO_SKIP_FETCH_OBJECT = 1<<4,
+	/*
+	 * This is meant for bulk prefetching of missing blobs in a partial
+	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
+	 */
+	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
+};
 
 int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
-			     struct object_info *, unsigned flags);
+			     struct object_info *,
+			     enum object_info_flags flags);
 
 /*
  * Iterate over the files in the loose-object parts of the object

