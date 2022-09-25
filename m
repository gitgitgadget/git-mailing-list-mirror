Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A24C04A95
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 08:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiIYIZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Sep 2022 04:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIYIZm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 04:25:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABE522B23
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 01:25:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n10so5912338wrw.12
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=e9YERkoU5LYuswe8b9CV+nURapWo5Nnhb2i03AwWP38=;
        b=NmZFtxx6oW/6BRn7mwlahNr2dMvj4yRLTnS3I+FuUw7Gp7l5Dy5i+Bl1pHrnx8z222
         mVyQZc8/xFpaOwCDy8O9EydivqHSqhVvD12wgGxCQCDVVD1OnCxBX+nEJ/beyFVtGJyN
         EWnR4+jMENmNM46SsYUyTSNV1OiOt3yLv5QXJbotH3ihQWfK8gM5zpKSFUsVb1JcD7JN
         U2m0VOf4nDSVm28Oz2vWnoHZw4chnnrohESCnEmZc35d/VPy1lVajYfeKsK0PLHbpc9n
         Loj8BLAUIyuzHtq0EXaRlPSweLfDNvLOFhhbNIcHUrPIxCTUDzLefqD6pWhroYTRhydz
         eulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=e9YERkoU5LYuswe8b9CV+nURapWo5Nnhb2i03AwWP38=;
        b=lkcgN4AUE0mnN5SKP1x6VsdfqWjCJvfer5vvRJgXRZZ/s14kF5IFxTlqpzm9yMp3Eu
         8ODOUspDVPdPMBSLtkjOU5ctslqgJw8JvWuJmBOQDYDqV2SKdyJpbRB3inBM8vuU+kh5
         MeGAtLuf9ZKpvMO9VwrOauJRAZaHXfWwP61SPQnf2sm6sD04d5kVo18Gem04g33qqzF2
         ojC59WIvjnG7+ppxQY+gBCYKu5SQstuS7VIdjYob9JbUSsLBcmXWKLtgTR+ISjs8mrwG
         ozUyjYnbb7gVSeZRfTMdBW4/RoPSTaph4FWU+qSSNz0nXGnEnGZOfXfLz4eqd9vuGpqp
         uytA==
X-Gm-Message-State: ACrzQf3uaDxska4sjMeTd5p7jlKzqc09Fx9oGYugWThjZmLRZRSXPZnx
        ZmMjRSI+dNBsplr2RuZLWf+TnIP1ZvqBCA==
X-Google-Smtp-Source: AMsMyM5zudkBv6jlrkaacHcy7rQ6ItNari0+CchuHKfQ7Ivv0RLlppqTekEXcwaUkCGuo3YgpWR/3g==
X-Received: by 2002:a5d:5963:0:b0:22a:47ed:f98f with SMTP id e35-20020a5d5963000000b0022a47edf98fmr9903532wri.155.1664094329706;
        Sun, 25 Sep 2022 01:25:29 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b003b33943ce5esm8362125wmq.32.2022.09.25.01.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 01:25:29 -0700 (PDT)
Message-ID: <bb3a2470-7ff5-e4a6-040a-96e0e3833978@gmail.com>
Date:   Sun, 25 Sep 2022 09:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
Content-Language: en-GB-large
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 23/09/2022 20:43, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> The process for reading the index into memory from disk is to first read its
> contents into a single memory-mapped file buffer (type 'char *'), then
> sequentially convert each on-disk index entry into a corresponding incore
> 'cache_entry'. To access the contents of the on-disk entry for processing, a
> moving pointer within the memory-mapped file is cast to type 'struct
> ondisk_cache_entry *'.
> 
> In index v4, the entries in the on-disk index file are written *without*
> aligning their first byte to a 4-byte boundary; entries are a variable
> length (depending on the entry name and whether or not extended flags are
> used). As a result, casting the 'char *' buffer pointer to 'struct
> ondisk_cache_entry *' then accessing its contents in a 'SANITIZE=undefined'
> build can trigger the following error:
> 
>    read-cache.c:1886:46: runtime error: member access within misaligned
>    address <address> for type 'struct ondisk_cache_entry', which requires 4
>    byte alignment
> 
> Avoid this error by reading fields directly from the 'char *' buffer, using
> the 'offsetof' individual fields in 'struct ondisk_cache_entry'.

I was confused as to why this was safe as it means we're still reading 
the individual fields from unaligned addresses. The reason it is safe is 
that we use get_bexx() to read the fields and those functions handle 
unaligned access. I wonder if it is worth adding a note to clarify that 
if you re-roll.

Best Wishes

Phillip
> 
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>      read-cache: avoid misaligned reads in index v4
>      
>      This fixes the bug reported in [1], where unaligned index entries in the
>      memory-mapped index file triggered a 'SANITIZE=undefined' error due to
>      casting to & accessing unaligned data a 4 byte-aligned 'struct
>      ondisk_cache_entry *' type.
>      
>      In addition to the originally-reported 't9210-scalar.sh' now passing in
>      a 'SANITIZE=undefined' build, I did some light testing by first writing
>      a v4 index with a released version of Git (v2.37), then running some
>      index-modifying operations ('git status', 'git add') with this patch's
>      changes, then again running 'git status' with the stable version. I
>      didn't see anything out of the ordinary but, considering how critical
>      "reading the index" is, I'd very much appreciate some extra-thorough
>      reviews on this patch. :)
>      
>      Thanks!
>      
>       * Victoria
>      
>      [1]
>      https://lore.kernel.org/git/YywzNTzd72tox8Z+@coredump.intra.peff.net/
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1366%2Fvdye%2Fbugfix%2Findex-v4-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1366/vdye/bugfix/index-v4-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1366
> 
>   read-cache.c | 42 +++++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index b09128b1884..d16eb979060 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1875,7 +1875,7 @@ static int read_index_extension(struct index_state *istate,
>   
>   static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>   					    unsigned int version,
> -					    struct ondisk_cache_entry *ondisk,
> +					    const char *ondisk,
>   					    unsigned long *ent_size,
>   					    const struct cache_entry *previous_ce)
>   {
> @@ -1883,7 +1883,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>   	size_t len;
>   	const char *name;
>   	const unsigned hashsz = the_hash_algo->rawsz;
> -	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
> +	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
>   	unsigned int flags;
>   	size_t copy_len = 0;
>   	/*
> @@ -1901,15 +1901,15 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>   
>   	if (flags & CE_EXTENDED) {
>   		int extended_flags;
> -		extended_flags = get_be16(flagsp + 1) << 16;
> +		extended_flags = get_be16(flagsp + sizeof(uint16_t)) << 16;
>   		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
>   		if (extended_flags & ~CE_EXTENDED_FLAGS)
>   			die(_("unknown index entry format 0x%08x"), extended_flags);
>   		flags |= extended_flags;
> -		name = (const char *)(flagsp + 2);
> +		name = (const char *)(flagsp + 2 * sizeof(uint16_t));
>   	}
>   	else
> -		name = (const char *)(flagsp + 1);
> +		name = (const char *)(flagsp + sizeof(uint16_t));
>   
>   	if (expand_name_field) {
>   		const unsigned char *cp = (const unsigned char *)name;
> @@ -1935,20 +1935,24 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>   
>   	ce = mem_pool__ce_alloc(ce_mem_pool, len);
>   
> -	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
> -	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
> -	ce->ce_stat_data.sd_ctime.nsec = get_be32(&ondisk->ctime.nsec);
> -	ce->ce_stat_data.sd_mtime.nsec = get_be32(&ondisk->mtime.nsec);
> -	ce->ce_stat_data.sd_dev   = get_be32(&ondisk->dev);
> -	ce->ce_stat_data.sd_ino   = get_be32(&ondisk->ino);
> -	ce->ce_mode  = get_be32(&ondisk->mode);
> -	ce->ce_stat_data.sd_uid   = get_be32(&ondisk->uid);
> -	ce->ce_stat_data.sd_gid   = get_be32(&ondisk->gid);
> -	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
> +	ce->ce_stat_data.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
> +							+ offsetof(struct cache_time, sec));
> +	ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
> +							+ offsetof(struct cache_time, sec));
> +	ce->ce_stat_data.sd_ctime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
> +							 + offsetof(struct cache_time, nsec));
> +	ce->ce_stat_data.sd_mtime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
> +							 + offsetof(struct cache_time, nsec));
> +	ce->ce_stat_data.sd_dev   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, dev));
> +	ce->ce_stat_data.sd_ino   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ino));
> +	ce->ce_mode  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mode));
> +	ce->ce_stat_data.sd_uid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, uid));
> +	ce->ce_stat_data.sd_gid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, gid));
> +	ce->ce_stat_data.sd_size  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, size));
>   	ce->ce_flags = flags & ~CE_NAMEMASK;
>   	ce->ce_namelen = len;
>   	ce->index = 0;
> -	oidread(&ce->oid, ondisk->data);
> +	oidread(&ce->oid, (const unsigned char *)ondisk + offsetof(struct ondisk_cache_entry, data));
>   
>   	if (expand_name_field) {
>   		if (copy_len)
> @@ -2117,12 +2121,12 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
>   	unsigned long src_offset = start_offset;
>   
>   	for (i = offset; i < offset + nr; i++) {
> -		struct ondisk_cache_entry *disk_ce;
>   		struct cache_entry *ce;
>   		unsigned long consumed;
>   
> -		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
> -		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
> +		ce = create_from_disk(ce_mem_pool, istate->version,
> +				      mmap + src_offset,
> +				      &consumed, previous_ce);
>   		set_index_entry(istate, i, ce);
>   
>   		src_offset += consumed;
> 
> base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
