Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D79C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AE964FEA
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCLPRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhCLPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 10:16:55 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A91C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 07:16:55 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so1550903ota.9
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8qbF2gOnOW8CreNFuqOeijvpJ8Tpf/xmwW87SAPSXTI=;
        b=HPXy91ctXvIzXOqCNe++E4UyRa38BgVmL+yaUPytzn7QcUAMH6YLrd0gkRdNU/w2sA
         VkLbZniiuJzDs1VgV9A7Q27fptlZ9+XiPMGiIblxMrU45cl8a6LoWzAXFUJDkeCHBufV
         4MexSr2dN3k4lAn6L7aO0vaWew50Bgoy9JtoHagDvJJbPmpj9sNWJasJ2bgQ4TKMPS59
         siPXau3xJKiE5wxJh+w38JTm54ag9lloLqksRelDeOMCqL71cSkVsu08EmtduQ5xEgue
         NHk9NjeG0g38NJ4SdIzGYlajHHaVdEhchWKILRK4vjD4aOokmgCSOt0ULw07GmitK/oN
         2VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qbF2gOnOW8CreNFuqOeijvpJ8Tpf/xmwW87SAPSXTI=;
        b=m3pNy4IgdEagfVz74IVJejmwxkcl/B28j2Z46xlBQMWh/Mh5gx62N/C99arJOl8nlB
         3ZHONsUQsbCVlGy5utM55BLAnukNrRT6v6hwaINgkiFFmr+w6Cxmgr/0MEc2lnI5NRbq
         IcpzAUNYP6LDsVfX57ZTYVzwB+9U53hWNyUN+honrvpB8RaTTdxL9l3jJUh4rZ+IGxo+
         ztuVkgiYV0IXex/U/PEwRcY2nfYXpXr/U15kAsdYCRUaSR8gBklTYk/2Io1o4XNZHPEb
         nalhuBbCac9E45r+a51xFL71kyLpxEFpwuMH+ALWlkykJZAQwz44xEwcGrgCqU7eJfUv
         9/VQ==
X-Gm-Message-State: AOAM531FsVKcNKVxnTDB5xf62rEbHu/sq6sjSI+nPq93Sfwx/hZ3utu5
        4Xj8Z2LHUT/UEpeKXGzfhxg=
X-Google-Smtp-Source: ABdhPJyi9cVs4uoZ6Qi784LfgC6KF6Gm/nIdrRlNe3sjO7kzVDzHuCxzQS9BULD1LfPZiUQMmbf9TQ==
X-Received: by 2002:a9d:2f04:: with SMTP id h4mr3718826otb.364.1615562214589;
        Fri, 12 Mar 2021 07:16:54 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:1448:4b23:85a8:b6a4? ([2600:1700:e72:80a0:1448:4b23:85a8:b6a4])
        by smtp.gmail.com with ESMTPSA id w7sm1257316oie.7.2021.03.12.07.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 07:16:53 -0800 (PST)
Subject: Re: [PATCH v3 00/16] midx: implement a multi-pack reverse index
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c4e18157-3070-9ad1-00c9-1222340101ff@gmail.com>
Date:   Fri, 12 Mar 2021 10:16:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2021 12:04 PM, Taylor Blau wrote:
> Here is another reroll of my series to implement a reverse index in
> preparation for multi-pack reachability bitmaps. The previous version
> was based on 'ds/chunked-file-api', but that topic has since been merged
> to 'master'. This series is now built directly on top of 'master'.
> 
> Not much has changed since last time. Jonathan Tan reviewed the previous
> version, and I incorporated feedback from his review:
> 
>   - The usage macros in builtin/multi-pack-index.c were pulled out and
>     defined separately.
>   - Some sloppiness with converting a signed index referring to the
>     preferred pack into an unsigned value was cleaned up.
>   - Documentation clean-up, particularly in patches 12 and 13.
> 
> There are a couple of new things that we found while testing this out at
> GitHub.
> 
>   - We now call finalize_object_file() on the multi-pack reverse index
>     to set the correct permissions.
>   - Patch 14 removed a stray hunk that introduced a memory leak.
>   - Patch 16 (courtesy of Peff) is new. It improves the cache locality
>     of midx_pack_order_cmp(), which has a substantial impact on
>     repositories with many objects.
> 
> Thanks in advance for your review.

I've reviewed the changes since my last review and this one looks
good, including that new patch from Peff.

Thanks,
-Stolee
