Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D435C1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B9220736
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEswvFyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCLS2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:28:17 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37286 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgCLS2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:28:17 -0400
Received: by mail-qv1-f65.google.com with SMTP id l17so3139484qvu.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s1kDRZUSG32qlQIUaX/YTeUjCRs72Qz8N3j3WHIIZrQ=;
        b=cEswvFyoJ3ciHePdL02Z7wI1ikyYvhLVAmSiWLN32DT4Sow4p6yVfTWg8TadzD5kPz
         2mqrFKr7lDs7bUykPvhrizq2i0CPPqnaHsDUJZ8bFIlX4Pn9Ic+tzbPGVpGUzlYsEgI/
         fGnO99bCdtGpXv6f9ZrQTHatZMTBzvgXth4epoMOtfl3Ezu5CZALv1Uhb0/5iCKCn+Fg
         wjH6botkOO5W4UcocWdagbpBmApUVCHO7SinBmTpcp1BT7nseTxls5RTw9ie6b1bfLo8
         H52JjjlohyRCSNNkJQKKVkqX8LPyiNUOQ6C+lNJus0XJz6OG3HxHrhERCrmAA/kAQPUX
         OqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s1kDRZUSG32qlQIUaX/YTeUjCRs72Qz8N3j3WHIIZrQ=;
        b=SH7zcQmOmXaYLxVXZWw+pHURFybUPBpIdpddQxYT0NQYXDKMjnsvfK2HxtKzugtdRE
         wIZ8joQVxhb/c+fz+nwXke6L0f2vpxogvYHXoSIkr6z2wjHFbPmgZCBDxwi4qr0vUMTw
         OTFFBOsrGDQ/Vk4nwD1gL6NigRvvEyN3/71jjgKOsSb3sZL8o9btC0Nt9PWnSnm3ibVv
         mLMCMZIKdxB+8DV5ZJU90WJGrx6HvYHhM9/FR6+RTRxcyfcyjQa3U2AwofwRXj2zKiH8
         px/As4SOR5dI+2/CaMnrCUogWwr2o8ddl+u7IOT3WLv4V460r9fjW3KNIyU6PCiVpCSm
         vZCA==
X-Gm-Message-State: ANhLgQ3nK9CugKxpJRafv43zrDhAZ5Kht7FK7XoQUsetW3/2aor78QiL
        Q9DjTqkObZxdECCsh/EzuNo=
X-Google-Smtp-Source: ADFU+vsT0/Z4PU2UomcJqRHtUgdyWwdF3R/X8ISgBIX9L3FzbVvBeFFoq2yt85TLpVR/Q1OLRjSVxA==
X-Received: by 2002:a05:6214:983:: with SMTP id dt3mr8690638qvb.145.1584037694002;
        Thu, 12 Mar 2020 11:28:14 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b189sm1670715qkc.104.2020.03.12.11.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:28:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] midx.c: fix an integer overflow
To:     Damien Robert <damien.olivier.robert@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
 <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a538c497-a79d-43be-3d00-c7a619acc4e6@gmail.com>
Date:   Thu, 12 Mar 2020 14:28:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2020 1:35 PM, Damien Robert wrote:
> When verifying a midx index with 0 objects, the
>     m->num_objects - 1
> overflows to 4294967295.
> 
> Fix this both by checking that the midx contains at least one oid,
> and also that we don't write any midx when there is no packfiles.
> 
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Should I add a test? It is a bit troublesome to generate a zero object midx
> file since this patch prevents it from using 'midx write'...

I'm glad that your patch makes it impossible to generate a zero-object
multi-pack-index, and that makes a test hard to implement. I'm not sure
what history Git has for storing explicit binary content into the test
suite. There really is only one "empty" multi-pack-index, but it is
unfortunately still a bit big for a test case to write explicitly due
to the 256-word fanout table.

I _think_ the t/tXXXX directories are used for this kind of data storage,
so you could generate an empty multi-pack-index from an older version of
Git then store it there. Please wait for someone else on-list to say that
this is a good idea, though. It may not be worth the pain of a binary file
in the patch.

>  midx.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/midx.c b/midx.c
> index 1527e464a7..2cece7f9ea 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -923,6 +923,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	cur_chunk = 0;
>  	num_chunks = large_offsets_needed ? 5 : 4;
>  
> +	if (packs.nr - dropped_packs == 0) {
> +		error(_("no pack files to index."));

nit: I would use "pack-files" here. Second best is "packfiles".

> +		result = 1;
> +		goto cleanup;
> +	}
> +
>  	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
>  
>  	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
> @@ -1124,22 +1130,27 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>  				    i, oid_fanout1, oid_fanout2, i + 1);
>  	}
>  
> -	if (flags & MIDX_PROGRESS)
> -		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
> -						 m->num_objects - 1);
> -	for (i = 0; i < m->num_objects - 1; i++) {
> -		struct object_id oid1, oid2;
> +	if (m->num_objects == 0)
> +		midx_report(_("Warning: the midx contains no oid."));

Should this "Warning: " be here? The other calls to midx_report() do not have such prefix.

It could be valuable to add "warning: %s\n" to the fprintf inside midx_report(), but that should be done as its own patch.

Also, it may be valuable to return from this block so you do not need to put the block below in a tabbed block, reducing the complexity of this patch.

> +	else
> +	{
> +		if (flags & MIDX_PROGRESS)
> +			progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
> +							 m->num_objects - 1);
> +		for (i = 0; i < m->num_objects - 1; i++) {
> +			struct object_id oid1, oid2;
>  
> -		nth_midxed_object_oid(&oid1, m, i);
> -		nth_midxed_object_oid(&oid2, m, i + 1);
> +			nth_midxed_object_oid(&oid1, m, i);
> +			nth_midxed_object_oid(&oid2, m, i + 1);
>  
> -		if (oidcmp(&oid1, &oid2) >= 0)
> -			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
> -				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
> +			if (oidcmp(&oid1, &oid2) >= 0)
> +				midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
> +					    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
>  
> -		midx_display_sparse_progress(progress, i + 1);
> +			midx_display_sparse_progress(progress, i + 1);
> +		}
> +		stop_progress(&progress);
>  	}
> -	stop_progress(&progress);
>  
>  	/*
>  	 * Create an array mapping each object to its packfile id.  Sort it
> 

Thanks for digging into this!

-Stolee
