Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8823C1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeH0XY3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:24:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40124 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0XY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:24:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so80973wme.5
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=2b0bUDdVkNcZ4RI8KdC3XkFRFSTeXPh3Ve+TETnydYo=;
        b=PF6kamzaCKZQbBYhLV/lPAElDQj/nysPzz++/w0qxjP+ewZ3qKsP/nH8WNiXkcuwYR
         Sdvvx4CQzlwZBeROSsYNgNA+Ei98fquDllxT2CNjnZRVuMeQZhjmPDWKzHxNh1Z5UDiK
         514jPJs334+YH9tETTBY2cxWm3io4kfBI46zVeLf79T31Zw7Bk4FIemORthAWPegWtVt
         XHIeIzqwIOHl2AZTKrealuFEBuOEVfSVrrpa45PS95rVo1k7C492bIGwrwuQPajnk0LU
         8PKEzYCpQa7yLZ/nLAvU9VO5LnfNop9RhS4QBfcsMtgsRwUKPVDxYMCq9aHJuwnBxaAe
         VY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=2b0bUDdVkNcZ4RI8KdC3XkFRFSTeXPh3Ve+TETnydYo=;
        b=uKBy/XIEICjHc43RNJwaLJ5hbVs0oFyC/yno0amWLatpg3GkXWMuKi4jBb9szW41pV
         qBN5TuHeWUdN3qFM9m1oLXqwPZlKPblyfJmJy3DBfK0xS/oVO5uC3jPuaRI+P4mjQidk
         e+7V47zR0xFRS3u8Pf65fLjuI77y/R+xfaLEbxxECfKj91pxMju6umiEfw6cqaYa5f3a
         CUXP0kHhpTqxvYvWqPxwIfut/Hx6HzL3ciDRczPYKCd4zSptwFM0kpqmW7drQt6iJbco
         CyyPGgma9N18DWNMxqBuSwin7YAil1kLR8sS3Dh4CkdEzg8cgYEszFwlMF1Cfmi54L4l
         UTkQ==
X-Gm-Message-State: APzg51BXXj+QFaHxtXXHCl4WFVi5VD71iEYY0HXLjJgsQyczycCmHRx5
        uaRPyuVYuWgIa+fRkNb97BG8fp3S
X-Google-Smtp-Source: ANB0VdbPOI8eI0xWJLOGZqET54sOCIBC7HNYZIEdgsRAuT7q/lukCK1EODTyvhV3twYGxpVO9OeOxw==
X-Received: by 2002:a1c:f11a:: with SMTP id p26-v6mr6665699wmh.92.1535398588953;
        Mon, 27 Aug 2018 12:36:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m68-v6sm71567wmb.10.2018.08.27.12.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:36:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, peartben@gmail.com
Subject: Re: [PATCH] read-cache.c: optimize reading index format v4
References: <20180824155734.GA6170@duynguyen.home>
        <20180825064458.28484-1-pclouds@gmail.com>
Date:   Mon, 27 Aug 2018 12:36:27 -0700
Message-ID: <xmqqwosbiouc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Running "test-tool read-cache 100" on webkit.git (275k files), reading
> v2 only takes 4.226 seconds, while v4 takes 5.711 seconds, 35% more
> time. The patch reduces read time on v4 to 4.319 seconds.

Nice.

> PS. I notice that v4 does not pad to align entries at 4 byte boundary
> like v2/v3. This could cause a slight slow down on x86 and segfault on
> some other platforms.

Care to elaborate?  

Long time ago, we used to mmap and read directly from the index file
contents, requiring either an unaligned read or padded entries.  But
that was eons ago and we first read and convert from on-disk using
get_be32() etc. to in-core structure, so I am not sure what you mean
by "segfault" here.

> @@ -1782,28 +1735,61 @@ static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
>  		extended_flags = get_be16(&ondisk2->flags2) << 16;
>  		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
>  		if (extended_flags & ~CE_EXTENDED_FLAGS)
> -			die("Unknown index entry format %08x", extended_flags);
> +			die(_("unknown index entry format %08x"), extended_flags);

Do this as a separate preparation patch that is not controversial
and can sail through without waiting for the rest of this patch.

In other words, don't slip in unreleted changes.

> -	if (!previous_name) {
> -		/* v3 and earlier */
> -		if (len == CE_NAMEMASK)
> -			len = strlen(name);
> -		ce = cache_entry_from_ondisk(mem_pool, ondisk, flags, name, len);
> +	/*
> +	 * Adjacent cache entries tend to share the leading paths, so it makes
> +	 * sense to only store the differences in later entries.  In the v4
> +	 * on-disk format of the index, each on-disk cache entry stores the
> +	 * number of bytes to be stripped from the end of the previous name,
> +	 * and the bytes to append to the result, to come up with its name.
> +	 */
> +	if (previous_ce) {
> +		const unsigned char *cp = (const unsigned char *)name;
>  
> -		*ent_size = ondisk_ce_size(ce);
> -	} else {
> -		unsigned long consumed;
> -		consumed = expand_name_field(previous_name, name);
> -		ce = cache_entry_from_ondisk(mem_pool, ondisk, flags,
> -					     previous_name->buf,
> -					     previous_name->len);
> +		strip_len = decode_varint(&cp);
> +		if (previous_ce->ce_namelen < strip_len)
> +			die(_("malformed name field in the index, path '%s'"),
> +			    previous_ce->name);

The message is misleading; the previous is not the problematic one,
but the one that comes after it is.  Perhaps s/, path/, near path/
or something.

> +		name = (const char *)cp;
> +	}
>  
> -		*ent_size = (name - ((char *)ondisk)) + consumed;
> +	if (len == CE_NAMEMASK) {
> +		len = strlen(name);
> +		if (previous_ce)
> +			len += previous_ce->ce_namelen - strip_len;

Nicely done.  If the result fits in that 12-bit truncated name, then
it is full so we do not need to adjust for strip.  Otherwise, we
know the length of this name is the sum of the part that is shared
with the previous one and the part that is unique to this one.

> +	}
> +
> +	ce = mem_pool__ce_alloc(mem_pool, len);
> +	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
> +	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
> +	ce->ce_stat_data.sd_ctime.nsec = get_be32(&ondisk->ctime.nsec);
> +	ce->ce_stat_data.sd_mtime.nsec = get_be32(&ondisk->mtime.nsec);
> +	ce->ce_stat_data.sd_dev   = get_be32(&ondisk->dev);
> +	ce->ce_stat_data.sd_ino   = get_be32(&ondisk->ino);
> +	ce->ce_mode  = get_be32(&ondisk->mode);
> +	ce->ce_stat_data.sd_uid   = get_be32(&ondisk->uid);
> +	ce->ce_stat_data.sd_gid   = get_be32(&ondisk->gid);
> +	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
> +	ce->ce_flags = flags & ~CE_NAMEMASK;
> +	ce->ce_namelen = len;
> +	ce->index = 0;
> +	hashcpy(ce->oid.hash, ondisk->sha1);

Again, nice.  Now two callsites (both in this function) that call
cache_entry_from_ondisk() with slightly different parameters are
unified, there is no strong reason to have it as a single caller
helper function.

> @@ -1898,7 +1884,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	struct cache_header *hdr;
>  	void *mmap;
>  	size_t mmap_size;
> -	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +	const struct cache_entry *previous_ce = NULL;
> +	struct cache_entry *dummy_entry = NULL;
>  
>  	if (istate->initialized)
>  		return istate->cache_nr;
> @@ -1936,11 +1923,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	istate->initialized = 1;
>  
>  	if (istate->version == 4) {
> -		previous_name = &previous_name_buf;
> +		previous_ce = dummy_entry = make_empty_transient_cache_entry(0);

I do like the idea of passing the previous ce around to tell the
next one what the previous name was, but I would have preferred to
see this done a bit more cleanly without requiring us to support "a
dummy entry with name whose length is 0"; a real cache entry never
has zero-length name, and our code may want to enforce it as a
sanity check.

I think we can just call create_from_disk() with NULL set to
previous_ce in the first round; of course, the logic to assign the
one we just created to previous_ce must check istate->version,
instead of "is previous_ce NULL?" (which is an indirect way to check
the same thing used in this patch).

Other than that, looks quite nice.

