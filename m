Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA5C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E9B22CA0
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgLDTF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgLDTF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:05:56 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66094C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:05:16 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id lb18so1128735pjb.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNnGV7Vxwtnx2TyQL8v/FG+og0ah5PHO9ybPxjCWcHA=;
        b=zdG+TxtEXi3q8V6KRVZhMzFy916fTWN++CG4vaS0Xbf6eSs5JSPybSUotqjAvWAeJi
         w3fcehHsDay1rg8/iX9pppZYasgDg0n0B6tYyus4vlVcjj7itTHCbKo44lnM+x3yxAe9
         aq9z8aN+2i6qDTdIOnB0Ix4Z7rgDtgUwIVrON3zn0jx1mNYEP3K4fBNlZFEE0SADlkl7
         scNWkL2ayKXJSgbHs+tq3QPStzDWhXql9DJFnysDEYx2BFBFH3tANneUi7IBLPEeRe7C
         DH4wW3syzi37bQYNpcLDRlkU+Wd7733lf0HWNOCCWGPo8krg035G1HcZebCGt4uwCamC
         HT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNnGV7Vxwtnx2TyQL8v/FG+og0ah5PHO9ybPxjCWcHA=;
        b=mmXjplsIPVmcE6Np/Zg/qsYOfhibHGcd+gZyn1ONNohTYLEWpuOi0gliM+q5FBFy/V
         /9NVAtE2emPNbK1yI+2ZtZW936To9RZojHNxFEr5gpZa2CxexHr/g/qrcFQoGljf+sp2
         cRcxQab/3/3bgJgudvzLYkKEd4Nnp2JbTqRlXmzseNlJNMjLMIwwH8E6tB9DxuNoYqbJ
         m3DF8FGMmMUFsJS31mzRZvKPoSuEHqYsX7SxTppYFvV1ahN/JVSNlKmqvYSvB9NW1cZE
         ISD1CLq7k5ZwErupJsMi6sNIX3TPZ1L/1kwBuIqsVtOi5B6MlHgOwXUhNSksTKgHMhoM
         k6mg==
X-Gm-Message-State: AOAM532tKr6eXiamX5DwBNiY73AjzcxVJqtzReFEAEDGTbRL6IMeG+9h
        +mch6DuVEoyHjpoRg3myJ711ZQ==
X-Google-Smtp-Source: ABdhPJxi/22e2DbfjrEXNBlYXhqK9llqhAMK7nX5whTbRAS3zseHAkuabVU5EprXt7tG1acS2RB5uw==
X-Received: by 2002:a17:902:7c89:b029:da:97e0:689d with SMTP id y9-20020a1709027c89b02900da97e0689dmr5229780pll.70.1607108715914;
        Fri, 04 Dec 2020 11:05:15 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a20sm4361586pgg.89.2020.12.04.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:05:15 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:05:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
Message-ID: <X8qIaOe3aT1qr+es@nand.local>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 01:53:23PM -0500, Jeff King wrote:
> I also considered adding a full iterator type with init/next/end
> functions (similar to what we have for hashmaps). But it ended up making
> the callers much harder to read. This version keeps us close to a basic
> for-loop.

Yeah, I think that a full-blown iterator type is overkill for this
purpose. Another possible approach could be a macro:

  #define for_each_oid_array_unique(arr, i) \
    for (i = 0; (i) < (array)->nr; i = oid_array_for_each_unique((arr), i))

but I don't think that's making anything more clear than
'oid_array_for_each_unique' already is. So, I like the approach that you
took here.

> @@ -111,4 +113,24 @@ void oid_array_filter(struct oid_array *array,
>   */
>  void oid_array_sort(struct oid_array *array);
>
> +/**
> + * Find the next unique oid in the array after position "cur". You
> + * can use this to iterate over unique elements, like:
> + *
> + *   size_t i;
> + *   oid_array_sort(array);
> + *   for (i = 0; i < array->nr; i = oid_array_next_unique(array, i))
> + *	printf("%s", oid_to_hex(array->oids[i]);
> + *
> + * Non-unique iteration can just increment with "i++" to visit each element.
> + */
> +static inline size_t oid_array_next_unique(struct oid_array *array, size_t cur)
> +{
> +	do {
> +		cur++;
> +	} while (cur < array->nr &&
> +		 oideq(array->oid + cur, array->oid + cur - 1));

I don't love the pointer math here (would instead prefer
oideq(&array->oid[cur]) and so on), but I don't think that it matters
enough to make a difference.

I additionally had to make sure that cur - 1 >= 0 so that the second
argument would always be valid, but it is, since we call cur++.

You could check that cur++ doesn't overflow, but I think that that's
mostly academic.

Thanks,
Taylor
