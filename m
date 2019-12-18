Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E73C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 00:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD59222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 00:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="11iVe7hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLSAC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:02:27 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53220 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 19:02:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so1621461pjd.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 16:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Ttaxet+NVfLmmeKE5Ssmn95vZoAuZhYldIOzRpCYxLQ=;
        b=11iVe7hVOUW1rzlRu1K8E/DdPM606JV4ULRT4jQnsGJISQVALNXh0X45K6ja4M9oT9
         ql4AHSwoZfoFSRI5C28VcaiTeQLy89P1yLv8BRs4AxaKfkIInHUJ6DbUxaNv/Il+MCsT
         NlvnQl9Evzfw8LKjoh8vyDXCAm3u99A87My3ulR3znGAEGij6YfnDGgwy3AQGq1Me2gf
         ZpJnO81Q121vAS3O3e8CIlufYi69x7M/S0iI8uYJsy439aqqknS/z3l5YVbf+pAtamw4
         TIm0YMAeN17o+8O8eb/XKUyGRPUgUj8it4xj9s9wJwHa6G+cCx96UJagmsfZPsSu2hao
         CgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ttaxet+NVfLmmeKE5Ssmn95vZoAuZhYldIOzRpCYxLQ=;
        b=akOR5tqFz7AKTWoPXRP0qo/yQw7pizqXNMe8knLtLwAspA3J0d3i2OGdJtRpYdspOs
         4kRe9/68uArepfluz7ySd2psP9aW7fdIqHLw7pdiY7bd56UAJqlagasGIjLba2+M2cAe
         ifYgPlp7e7h2kGrjjhFkgVwSebnbYOH4zaGSB4Q08g3pNxswWHduvmswJIiac2YM5WcH
         nfcxOBhyLZodq7GXaxwwoMVBUHrxwGVWvNPb2Ftq/W5vF68se8VDrNSBZO0TQNYxcxtB
         Cs5pPqRVVMN+HR/miVJq9kqg9QOAAOPjEJLgvoMDaPzEkjlZr1tv8Hy0CSFnLcWEwTfd
         qTGQ==
X-Gm-Message-State: APjAAAW7JXq5a6W515HvPgkM4GbOCpJ56p0xf4ev3XejyL1K2szWZsOQ
        bEPT2a1XjZ3EtycJHg0RRRdRuwOAzzw=
X-Google-Smtp-Source: APXvYqyCsJG5QaIjexgv86Hxzjd1h1DMYnaVk6x1lHLzUynUeR+eDAKKZTEgqRgSoe+8ELxWcTVtiQ==
X-Received: by 2002:a17:90a:8008:: with SMTP id b8mr6058625pjn.37.1576713746559;
        Wed, 18 Dec 2019 16:02:26 -0800 (PST)
Received: from localhost ([203.144.75.20])
        by smtp.gmail.com with ESMTPSA id a19sm4820884pfn.50.2019.12.18.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:02:26 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] gpg-interface: add minTrustLevel as a configuration option
In-Reply-To: <xmqq4ky0j8ca.fsf@gitster-ct.c.googlers.com>
References: <20191216153204.8906-1-hji@dyntopia.com> <xmqq4ky0j8ca.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 18 Dec 2019 23:59:10 +0000
Message-ID: <87pnglyylt.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16 2019, Junio C Hamano wrote:
>> Unfortunately, it breaks backward-compatibility in two ways:
>>
>> 1. The default trust level is TRUST_UNDEFINED.  This is compatible with
>>    the old behavior of every code path *except* for
>>    verify_merge_signature() (since, again, it used to die()s on trust
>>    levels below TRUST_MARGINAL).
>
> This might be a bit problematic.  If we can keep the default
> behaviour identical to the code before this patch, while allowing
> the configuration to tweak the behaviour, that would have been
> more easily acceptable.

Done in v1.

>> 2. The %G? format specifier no longer includes 'U' for signatures made
>>    with a key that is either TRUST_UNDEFINED or TRUST_NEVER.
>
> Hmm, I can sort-of-see why you want to introduce a new placeholder
> "%GT" to disambiguate two sources of 'U', but why would this change
> to "%G?" necessary?

U is re-introduced in v1.  %GT is still there (since %G? doesn't print
all trust levels) but I don't mind removing it (I added it for
completeness sake when breaking backward-compatibility in v0).

-- 
hji
