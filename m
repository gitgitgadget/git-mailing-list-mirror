Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCAEC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630E1215A4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QDK8yTlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDWVB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWVB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:01:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D1C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:01:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so1906298pfn.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fPtRBme082MU8UOBb8vmYCkimFbKzCk5UsidkX4j7U8=;
        b=QDK8yTlHFdviVHjk6ZQglCdrS/DASj4cyU861bKUDA9O4GAPYNnOaqthEbzmRGjeg/
         GwDwN/+utxlKAB6vZBccTN40PZokqzfto71C2u8TDARWWjJ5Gad/4K/sN8y924LR9kB9
         skDWi9cOZM9HEbhZn5EyyvH7ufodkok7G64vJnuZsyT1eaNZyxPKdk4vYy1mlu7wbDZu
         sv2+tzlYWCWN6qYmDYEwYqHUcZbXQ+xdpy+/WIvtnSqzhyEdT7XXu8RN1XACx7K0l5F5
         O2NWsZ+7xamsSOOtlbEn9uoyx8KLuDwDXya/4UTWNb3ChD6PFK+CeKj/k5A4gjbwakp1
         zsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fPtRBme082MU8UOBb8vmYCkimFbKzCk5UsidkX4j7U8=;
        b=FH5d2C8+rokCmGKQTrcTF+19r6a4/VCSlWIeVlSt8bKhT88V1wM/FL+us+macvao/K
         H9St2K3MxnpuiWhMXGfNxBaEjIuQZvTezy9qv61affawGR94ALDhU2g6q5CpBRhpb7Ep
         fnNKzyH8/tFOvlZsF/4EG+hgMbTDd1g6PjCHzOlkL27Y7OGM/uJx9UrLhhCJtJV602rU
         q5zaxO6GumPB2mvzOcmM/3sWhM2QjaJx/KvVD6k4wz/WhmJXTL/OOlvuLdf25wn1u9aE
         4UrZ42Bj70rAYeUDotCvKZ/ulTJ1X4vWd4/FbWIAjYPFQLgJOSRmangCLoLfVKDQ52Jf
         aLPg==
X-Gm-Message-State: AGi0PubYaVURVS2u0G9y/HHmtW8gdmci8IpqmfP3jp0UuEWjKiwQtllz
        UtNRoLncjwmy1jexYn8MZlVR1rGiMh0eAA==
X-Google-Smtp-Source: APiQypIieNjli2OK8h6TJsCFsvx6UQ/RK2DFhjuMlHkKt/4vt/x7UOS+Rt+PJwAmKNuEyK2WoiHu8Q==
X-Received: by 2002:a63:e210:: with SMTP id q16mr5600150pgh.26.1587675718164;
        Thu, 23 Apr 2020 14:01:58 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t23sm3083111pjq.27.2020.04.23.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:01:57 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:01:55 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] test-bloom: fix some whitespace issues
Message-ID: <20200423210155.GA46862@syl.local>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
 <20200423205907.GA1634224@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423205907.GA1634224@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 04:59:07PM -0400, Jeff King wrote:
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/helper/test-bloom.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index ce412664ba..f9c0ce2bae 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -27,7 +27,7 @@ static void print_bloom_filter(struct bloom_filter *filter) {
>  	}
>  	printf("Filter_Length:%d\n", (int)filter->len);
>  	printf("Filter_Data:");
> -	for (i = 0; i < filter->len; i++){
> +	for (i = 0; i < filter->len; i++) {

Thanks for fixing the spacing, but I wonder if these braces should be
here at all. Since the body is one line long, maybe this should just be:

  for (i = 0; i < filter->len; i++)
    printf("%02x|", filter->data[i]);

>  		printf("%02x|", filter->data[i]);
>  	}
>  	printf("\n");
> @@ -50,13 +50,13 @@ int cmd__bloom(int argc, const char **argv)
>  		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
>  	}
>
> -    if (!strcmp(argv[1], "generate_filter")) {
> +	if (!strcmp(argv[1], "generate_filter")) {

This spot looks good, and ditto for fixing the indentation.

>  		struct bloom_filter filter;
>  		int i = 2;
>  		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
>  		filter.data = xcalloc(filter.len, sizeof(unsigned char));
>
> -		if (!argv[2]){
> +		if (!argv[2]) {

Same note here about the brace.

>  			die("at least one input string expected");
>  		}
>
> @@ -68,7 +68,7 @@ int cmd__bloom(int argc, const char **argv)
>  		print_bloom_filter(&filter);
>  	}
>
> -    if (!strcmp(argv[1], "get_filter_for_commit")) {
> +	if (!strcmp(argv[1], "get_filter_for_commit")) {
>  		struct object_id oid;
>  		const char *end;
>  		if (parse_oid_hex(argv[2], &oid, &end))
> @@ -78,4 +78,4 @@ int cmd__bloom(int argc, const char **argv)
>  	}
>
>  	return 0;
> -}
> \ No newline at end of file
> +}
> --
> 2.26.2.827.g3c1233342b
>

Thanks,
Taylor
