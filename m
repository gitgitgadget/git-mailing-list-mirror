Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA681C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12F1613AB
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhE0RwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhE0RwR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:52:17 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC409C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:50:43 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id z2-20020a3765020000b02903a5f51b1c74so1054037qkb.7
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PvqzhPZTSkattjrVKnNz3j6VGVFL3YcrWbevHOUvVDk=;
        b=SmEatSt+CYoVczeBu51cV/iS+Qg3/gxIPvDKRq/v07awoW2MwIMNI2QB7hDfOktnFY
         8qI4TE4XQjKYm94a8lzokOZzIxfwfMuWlIZe/ACjdvIv27R9yk0R2av8MmvJRMFmrY1m
         ycyPd7Z+yeSr2PJ+2ltJPeSBXK/KxDvcPY2AEAgCIYju+JVBGxxZQV7U8rjZq0qiwO6q
         K195h0uKDGqVYtnw6dnbouvyam4kWFnD5AuJ2HWAAasnGV56Xj9EwdKt1EEY46PmJiDX
         XHEdGqTDj/FXF7l+2NTP7gNIfy5ss+6pU0wHv8pWttURq0+h4UvPc+QGCLsxmddRVSi2
         3TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PvqzhPZTSkattjrVKnNz3j6VGVFL3YcrWbevHOUvVDk=;
        b=WnoiW+eLYawmnmSNPWfN14M9lAH7gk8KTQNcda3M13xwRpvasjein8Ry3+Nd3S5e9a
         90i/Cc+JOp9UkfbRbWXe4wk4ET8gLrQn7ayF+YoDTJjvRUTODR6F46nODd94qu7u0fBH
         GR0I+yOx0AzHc2YHsStIT7U9OFj/+MKqXDevIt0bNjAM0VE8tLyEXxHPcDG/rbJzixcu
         dqBn71pUoPuQg3rKb9xvNeEhnenNnlXyNDnCefUGQlKD1nc/RKkE8EebmusD/9z4sHK/
         w3WQyoL3g02kB6i2LkX8KeZjmuuxQssLYvpp5EMFjCYkVbXZW4kOZoDdv2FigP5VWDgW
         cQjg==
X-Gm-Message-State: AOAM531ofSilkeG2ZBeifjcjC/yrEDqa96SRb5RW9GuK72/l+NMSamr4
        VkYHoj0qQxsJZR9IQaI6b4O2x/3YintS+omAjqB1
X-Google-Smtp-Source: ABdhPJysUIecJae/wldI3SI3uvNsKEWb5vHmvb8Q4Hvut+EFHW6myKL3xYqu97BfdRpx9n9ncu/GrJ/r2cfI7nAvPncy
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:c8b:: with SMTP id
 r11mr3008432qvr.52.1622137842948; Thu, 27 May 2021 10:50:42 -0700 (PDT)
Date:   Thu, 27 May 2021 10:50:39 -0700
In-Reply-To: <patch-11.17-ee28089219-20210520T111610Z-avarab@gmail.com>
Message-Id: <20210527175039.2672716-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-11.17-ee28089219-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH v3 11/17] object-file.c: stop dying in parse_loose_header()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        j6t@kdbg.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Start the libification of parse_loose_header() by making it return
> error codes and data instead of invoking die() by itself. For now
> we'll move the relevant die() call to loose_object_info() and
> read_loose_object() to keep this change smaller, but in subsequent
> commits we'll also libify those.
> 
> The reason this makes sense is that with the refactoring of
> parse_loose_header_extended() in an earlier commit the public
> interface for parse_loose_header() no longer just accepts a "unsigned
> long *sizep". Rather it accepts a "struct object_info *", that
> structure will be populated with information about the object.
> 
> It thus makes sense to further libify the interface so that it stops
> calling die() when it encounters OBJ_BAD, and instead rely on its
> callers to check the populated "oi->typep".
> 
> This also allows us to simplify away the
> unpack_loose_header_to_strbuf() function added in
> 46f034483eb (sha1_file: support reading from a loose object of unknown
> type, 2015-05-03). Its code was mostly copy/pasted between it and both
> of unpack_loose_header() and unpack_loose_short_header(). We now have
> a single unpack_loose_header() function which accepts an optional
> "struct strbuf *" instead.
> 
> I think the remaining unpack_loose_header() function could be further
> simplified, we're carrying some complexity just to be able to emit a
> garbage type longer than MAX_HEADER_LEN, we could alternatively just
> say "we found a garbage type <first 32 bytes>..." instead, but let's
> leave this in place for now.

Looking at the patch itself, this patch:
 1. Combines unpack_loose_header(), unpack_loose_short_header(), and
    unpack_loose_header_to_strbuf() into one function. It does different
    things depending on whether the struct strbuf * is provided.
 2. Updates parse_loose_header() to:
    a. never die upon invalid object type
    b. not accept a flags argument (which was used solely to control
       whether it died or not upon invalid object type)
 3. Updates the callers of these functions.

I think 2b should have been mentioned in the commit message. (And
overall I think that the commit message could be shorter, but what
information to include and exclude is a subjective matter, so I won't
concern myself so much about that.)

Also, I think that 1 should be split into its own commit. As it is, I'm
not even sure if it's a good idea - for me, it is confusing for a
function to consume or not consume more of the stream depending on
whether an argument is NULL or not.

>  	/*
>  	 * Check if entire header is unpacked in the first iteration.
>  	 */
>  	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
>  		return 0;
>  
> +	/*
> +	 * We have a header longer than MAX_HEADER_LEN. We abort early
> +	 * unless under we're running as e.g. "cat-file
> +	 * --allow-unknown-type".
> +	 */
> +	if (!header)
> +		return -1;

What do you mean by "unless under we're running as"? And how would we
know at this point that we're running as "cat-file --allow-unknown-type"
just by checking "header"?

> -	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
> -		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
> -			status = error(_("unable to unpack %s header with --allow-unknown-type"),
> -				       oid_to_hex(oid));
> -	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
> +
> +	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
> +				      allow_unknown ? &hdrbuf : NULL);
> +	if (hdr_ret < 0) {
>  		status = error(_("unable to unpack %s header"),
>  			       oid_to_hex(oid));
>  	}

This hunk would go into the split commit (for the unpack_loose_header()
refactoring) I suggested above.

> -
> -	if (status < 0) {
> -		/* Do nothing */
> -	} else if (hdrbuf.len) {
> -		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
> -			status = error(_("unable to parse %s header with --allow-unknown-type"),
> -				       oid_to_hex(oid));
> -	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
> +	if (!status && parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0) {
>  		status = error(_("unable to parse %s header"), oid_to_hex(oid));
>  	}
> +	if (!allow_unknown && *oi->typep < 0)
> +		die(_("invalid object type"));

I think this change doesn't need to be so big? The oi->typep check could
just go in the "else if" branch that happens if --allow-unknown-type is
not set.

> diff --git a/object-store.h b/object-store.h
> index d443964447..740edcac30 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -477,11 +477,30 @@ int for_each_object_in_pack(struct packed_git *p,
>  int for_each_packed_object(each_packed_object_fn, void *,
>  			   enum for_each_object_flags flags);
>  
> +/**
> + * unpack_loose_header() initializes the data stream needed to unpack
> + * a loose object header.
> + *
> + * Returns 0 on success. Returns negative values on error.
> + *
> + * It will only parse up to MAX_HEADER_LEN bytes unless an optional
> + * "hdrbuf" argument is non-NULL. This is intended for use with
> + * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
> + * reporting. The full header will be extracted to "hdrbuf" for use
> + * with parse_loose_header().
> + */
>  int unpack_loose_header(git_zstream *stream, unsigned char *map,
>  			unsigned long mapsize, void *buffer,
> +			unsigned long bufsiz, struct strbuf *hdrbuf);

Parsing up to MAX_HEADER_LEN only occasionally is confusing. Could we
always make it parse up to MAX_HEADER_LEN, and then put a truncated
header in hdrbuf if it is too big (and therefore invalid)?

> +/**
> + * parse_loose_header() parses the starting "<type> <len>\0" of an
> + * object. If it doesn't follow that format -1 is returned. To check
> + * the validity of the <type> populate the "typep" in the "struct
> + * object_info". It will be OBJ_BAD if the object type is unknown.
> + */
> +int parse_loose_header(const char *hdr, struct object_info *oi);

Also mention what happens if the size is invalid.
