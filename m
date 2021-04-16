Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE142C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0C4611AC
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 15:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbhDPPFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245206AbhDPPFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 11:05:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E2C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 08:04:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mh2so21066332ejb.8
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Wz92JUae37unPinCLHHuguF0LD81Qz/leb2+6QDUovw=;
        b=GXSzMKA0nqin2b5oNAhsm4hhXcNDRl5CerdIXcNSrj7WwOdeC+bpgBEQoMQ4fC2Ulz
         Sn19JiBt0UWCNw9UWX7RElUTYF1nvsawoJscXnXYS8qU1C9HlEPhfBEwBycC7hjw8L2C
         PrYWLah8lSyXa3wZPkelKgZI1ktrfSJdBBOpWgIqWarfGAFuSpD3XbcdT/u7XrET/5D9
         QrQVJAtS6feZlx6tfxO+kZtf90HqF1uFgqncgTPyq65B6MluRfImdQwA51a3uyEZJkdb
         6RuYoik/e3eqa9F2V7Iv5LUyK1LuG1uZ2VKrD/YBYZXY3zmE+aZNK+Rk9ZmvjmJ8TyWr
         T1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Wz92JUae37unPinCLHHuguF0LD81Qz/leb2+6QDUovw=;
        b=hqbcXqY9uT7S+sVopGN/Kg5iSudvcaezWRWS6HkW2QvLqOPmmwUE52fiW0gPQuO5oQ
         zgp7KU1m+uXy6KcfPdztYcWALfYekqHLTAljPAp04+mF0Bx1pPTI7XqiVd5uhE2vu40A
         mKrnnJoVO7zeRbiTeTi/z/yMISHIc37mVsbtwfFghRXEQh4VlzgTGYKMgYscBFCJvLpS
         d/Xtq8DV52qyc3f/gEDxCSby+uCTVB7fJNWwYFOsw+sbuWrKJDpdmalsm6C7bkbutRjd
         S/kYPxwyMx7Ese7uOH+pnFnaxsdo5ZPfgHWJIJxsLDzxLrZhdoQmgd7LJnjipffhDTUe
         SWMw==
X-Gm-Message-State: AOAM532gRdp7D9qAontqcSCEhKhy4PcaNLYReSxm7t5uyNKr/11V1Vhl
        CnLhNgLxX5MkFTH4kPGdTKo=
X-Google-Smtp-Source: ABdhPJyWQIDZX9+erQzESUZORJUoJHDpHP9tBbP+gpbHBw5ZLpDXjuMBgbloJYcBYy54hcgvPMx/oA==
X-Received: by 2002:a17:906:a44b:: with SMTP id cb11mr8971418ejb.518.1618585493588;
        Fri, 16 Apr 2021 08:04:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b8sm5883583edu.41.2021.04.16.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:04:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] sha1-file: allow hashing objects literally with
 any algorithm
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210410152140.3525040-2-sandals@crustytoothpaste.net>
Date:   Fri, 16 Apr 2021 17:04:52 +0200
Message-ID: <87tuo6tgmj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, brian m. carlson wrote:

> In order to perform suitable testing with multiple algorithms and
> interoperability, we'll need the ability to hash an object with a given
> algorithm. Introduce this capability for now only for objects which are
> hashed literally by adding a function which does this and changing a
> static function to accept an algorithm pointer.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  object-file.c  | 16 ++++++++++++++--
>  object-store.h |  3 +++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 624af408cd..f5847ee20f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1957,6 +1957,15 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
>  int hash_object_file_literally(const void *buf, unsigned long len,
>  			       const char *type, struct object_id *oid,
>  			       unsigned flags)
> +{
> +	return hash_object_file_literally_algop(buf, len, type, oid, flags,
> +						the_hash_algo);
> +}
> +
> +int hash_object_file_literally_algop(const void *buf, unsigned long len,
> +				     const char *type, struct object_id *oid,
> +				     unsigned flags,
> +				     const struct git_hash_algo *algo)
>  {
>  	char *header;
>  	int hdrlen, status = 0;
> @@ -1964,11 +1973,14 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>  	/* type string, SP, %lu of the length plus NUL must fit this */
>  	hdrlen = strlen(type) + MAX_HEADER_LEN;
>  	header = xmalloc(hdrlen);
> -	write_object_file_prepare(the_hash_algo, buf, len, type, oid, header,
> -				  &hdrlen);
> +	write_object_file_prepare(algo, buf, len, type, oid, header, &hdrlen);
>  
>  	if (!(flags & HASH_WRITE_OBJECT))
>  		goto cleanup;
> +	if (algo->format_id != the_hash_algo->format_id) {
> +		status = -1;
> +		goto cleanup;
> +	}
>  	if (freshen_packed_object(oid) || freshen_loose_object(oid))
>  		goto cleanup;
>  	status = write_loose_object(oid, header, hdrlen, buf, len, 0);
> diff --git a/object-store.h b/object-store.h
> index ec32c23dcb..f95d03a7f5 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -221,6 +221,9 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>  			       const char *type, struct object_id *oid,
>  			       unsigned flags);
>  
> +int hash_object_file_literally_algop(const void *buf, unsigned long len,
> +				     const char *type, struct object_id *oid,
> +				     unsigned flags, const struct git_hash_algo *algo);
>  /*
>   * Add an object file to the in-memory object store, without writing it
>   * to disk.

We only have one user of hash_object_file_literally(),
builtin/hash-object.c, let's just change the signature of
hash_object_file_literally() instead of adding a new function. This
leaves the tree with no direct user of hash_object_file_literally().
