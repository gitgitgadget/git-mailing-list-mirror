Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5BC4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLGWVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLGWVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:21:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294C63D48
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:21:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kw15so13879360ejc.10
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJrN9mX49vxsBY9V4TNEuPnFJHClU1J2430kCDPX0Ew=;
        b=AxL6TfY/6QYf6lwO8fZNifoyKCT5wNrKffIApzsAs6CP/c5Kd5pYEbC4VwumzYqqWA
         eba4bBAjMUYdzKlbM4XT0GNDOlaIfzb/vU+BFUzlyc+QlHc9Qz1NgwxkpxUdenKKmZC2
         TeSzwCNo77VIjcFVYItw2oJSAR9ttEwcMs3kkECJccb1JhfO61mDE8Np/k9M2n0sGWo3
         DY7PDrx2eOccueV1GshwidQShZPTUcJl2lDerRGXTK+FWyliMiWG8E2Ko0bgf4yzCSiK
         N0+cC3ndw4LDullcnoSRe1t0GHRkB+L/hP31UwKQVi5CWsS3mhHLdSnPUZPl2aUrNhLa
         5kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJrN9mX49vxsBY9V4TNEuPnFJHClU1J2430kCDPX0Ew=;
        b=NL3MVFQQYLVonjcIO4pK16JntY8xd6AXk/oKDa2qif65V7XTJscPl8gNPKMejUWCnV
         TJL743iB9oJtYcCXlX78mRkE3F1ZG7R2YzpIueW9jADbhNZQDtK3J8Hrw1jSSLyybG0m
         /5MjLiisdgEPUbUU8pd+COpNEAAUxYKnP/NkMFr10kiB+bnb7TvukVEASolydqMQtUOu
         YkUk8QdOvv/9S0GNNgA6fC1qO1ScfNSq5kPj+oDDvZU2f8Ohy8b0UVyZJ6SU3oZgMj0+
         MlPHpwwliokMpYyawFw5NRhCDArxicdrg70WY8JXKz+SwnR2ciU3RuZVn+fwp604EtSu
         5P7A==
X-Gm-Message-State: ANoB5plACIurVY1krWCjYHxFV1fFQnzExrrdnI2ttdZ6TGlFh3iaBi+S
        epRnUE7IWqoQkPEQTnaacblkF8avHAFcBg==
X-Google-Smtp-Source: AA0mqf4N/isshqDD+6iycXJyAQGw/cv3thVfHqkvWfR+YPzLj+FzvfKXoXN/c9Xc7f/pbfJRARnUxw==
X-Received: by 2002:a17:907:2ace:b0:7c1:eb:b2a7 with SMTP id fm14-20020a1709072ace00b007c100ebb2a7mr621409ejc.13.1670451708153;
        Wed, 07 Dec 2022 14:21:48 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r23-20020a170906281700b007c0b9500129sm7402236ejc.68.2022.12.07.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:21:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p32nR-004cJD-0l;
        Wed, 07 Dec 2022 23:21:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/4] hashfile: allow skipping the hash function
Date:   Wed, 07 Dec 2022 23:13:15 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <40ee8dbaef06f8f4265d12436455279499d7ac01.1670433958.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <40ee8dbaef06f8f4265d12436455279499d7ac01.1670433958.git.gitgitgadget@gmail.com>
Message-ID: <221207.868rjiam86.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> However, hashing the file contents during write comes at a performance
> penalty. It's slower to hash the bytes on their way to the disk than
> without that step. This problem is made worse by the replacement of
> hardware-accelerated SHA1 computations with the software-based sha1dc
> computation.

More on that lack of HW accel later...

> This write cost is significant

Don't you mean hashing cost, or do we also do additional writes if we do
the hashing?

> , and the checksum capability is likely
> not worth that cost for such a short-lived file. The index is rewritten
> frequently and the only time the checksum is checked is during 'git
> fsck'. Thus, it would be helpful to allow a user to opt-out of the hash
> computation.

I didn't know that, and had assumed that we at least checked it on the
full read (and I found this bit of the commit message after writing the
last paragraphs here at the end, so maybe skipping this is fine...).

> [...]
> @@ -64,7 +65,12 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
>  	int fd;
>  
>  	hashflush(f);
> -	the_hash_algo->final_fn(f->buffer, &f->ctx);
> +
> +	if (f->skip_hash)
> +		memset(f->buffer, 0, the_hash_algo->rawsz);

Here you're hardcoding a new version of null_oid(), but we can use it
instead. Perhaps:
	
	diff --git a/csum-file.c b/csum-file.c
	index 3243473c3d7..b54c4f66cbb 100644
	--- a/csum-file.c
	+++ b/csum-file.c
	@@ -63,11 +63,12 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
	 		      enum fsync_component component, unsigned int flags)
	 {
	 	int fd;
	+	const struct object_id *const noid = null_oid();
	 
	 	hashflush(f);
	 
	 	if (f->skip_hash)
	-		memset(f->buffer, 0, the_hash_algo->rawsz);
	+		memcpy(f->buffer, noid, sizeof(*noid));
	 	else
	 		the_hash_algo->final_fn(f->buffer, &f->ctx);
	 
> @@ -153,6 +160,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
>  	f->tp = tp;
>  	f->name = name;
>  	f->do_crc = 0;
> +	f->skip_hash = 0;
>  	the_hash_algo->init_fn(&f->ctx);
>  
>  	f->buffer_len = buffer_len;

I think I pointed out in the RFC that we'd be much faster with
non-sha1collisiondetection, and that maybe this would get us partway to
the performance you desired (or maybe we'd think that was a more
acceptable trade-off, as it didn't make the format
backwards-incompatible).

But just from seeing "do_crc" here in the context, did you benchmark it
against that? How does it perform?

There's no place to put that in the index, but we *could* encode it in
the hash, just with a lot of leading zeros.

Maybe that would give us some/most of the performance benefits, with the
benefit of a checksum?

Or maybe not, but I think it's worth exploring & supporting a different
& faster SHA-1 implementation before making (even opt-in) backwards
incompatible format changes for performance reasons, and if even that's
too slow maybe crc32 would be sufficient (but not compatible), but still
safer?
