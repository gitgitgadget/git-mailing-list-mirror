Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62683C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 13:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2D561042
	for <git@archiver.kernel.org>; Thu,  6 May 2021 13:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhEFNMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 09:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEFNMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 09:12:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3D9C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 06:11:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e15so5063478pfv.10
        for <git@vger.kernel.org>; Thu, 06 May 2021 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VMD3FhALL2CK9gv/ISv4j6XUF/W6H3uM291jhEIsfyU=;
        b=l5WOqHKD2MpidL4LF2TP2EyCJmlQaV/vPHF74mLIhRr+ZbJ8PoRYl3um3TO3h47fzA
         Gg27MpGCnzrnZ/EYtHefDaee94TfcKZ/YSNhZ3SbIMxwCUIQTnGe10OEOI7qUpr+WvUy
         r/yLKGEhsTvxFxJY9rYpi0FdQFKQrBys0Wr5ZzzWZKaq6mpDSRY7hHFiaUIEribpi3M5
         KgJv4iumTRh5Nr+VcLQ0HRO/fVCAzSrF3+Hi5wO+dDgJOIpnGiOatuupL14VQgOHFcC7
         wPNldLtmgVQZECntaX8gBe5JvrNtbmlhBwMpuTXxTssrR9CfUIC4tjhJ8rdeVrWpEC0f
         LGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VMD3FhALL2CK9gv/ISv4j6XUF/W6H3uM291jhEIsfyU=;
        b=Fo7oBUxoFtYr9tLhvFrKJvsROfQQ33NiEykn454f/lmdR4oI8HgPhsc2SjKz2ZJzQo
         ky+Z3vITx+izvHzVKzAzXvNF92kxTBWQjCuXL13n4NFqyMzuL9oOB797qhNkR4GmZTYl
         7Fw+U/plYwLPwGvdLqnhly7XGYTUrUVYluID7tjE3MhG9nmFna7SpGNQlB+e12NUbTOC
         j+F0P1/2cCBvQUaKubNtmMcUtMyOmhZJb5uMDjbTqZW4bIcyy/6sxrf4BmNJ65TllvDz
         tvSrSTxjXzLHz/iWA/vK8LCP9v9kRgO0h8kgvjSb+CSLpEvpwKcSmV2A9cSXf/Erc73l
         pU5Q==
X-Gm-Message-State: AOAM533NMm6asLeS69kjyBmeI3psnJrZ20JBbJW8HH/odzWG4ZAkX5HW
        74nFERzbVDcXKT+USWd4gA9LA99rvbJrwQ==
X-Google-Smtp-Source: ABdhPJwGGkIgf3ktAjv13DtG8S20GE7DentHsTrr9INP89MLgwQ8AupVi7q3KPa8rgVT0q61aRyS3g==
X-Received: by 2002:a63:175e:: with SMTP id 30mr4220833pgx.48.1620306673769;
        Thu, 06 May 2021 06:11:13 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-28.three.co.id. [180.214.233.28])
        by smtp.gmail.com with ESMTPSA id r3sm2105768pgn.82.2021.05.06.06.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 06:11:13 -0700 (PDT)
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
To:     Mark Amery <markrobertamery@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
 <20210504151954.aczbvml4rh7t2svc@tb-raspi4> <xmqqtuni58ra.fsf@gitster.g>
 <20210506043429.zqgzxjrj643avrns@tb-raspi4>
 <CAD8jeghZKDcp=weHtcMZ4z8KaO1jQJqfPqaRtYgtiwrX-1+NNg@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <15ba96cb-c682-f6d2-0bc2-eee4094c243c@gmail.com>
Date:   Thu, 6 May 2021 20:11:10 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAD8jeghZKDcp=weHtcMZ4z8KaO1jQJqfPqaRtYgtiwrX-1+NNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05/21 16.12, Mark Amery wrote:

> • Above, Torsten mentions that there are filesystem-specific rules
> about what names are equal to each other that Git can't easily handle,
> because they go beyond just ASCII case changes. In that case, maybe
> the right solution is to always defer the question to the filesystem
> rather than Git trying to figure out the answer "in its head"?
> 
>    That is: first check the inode or file ID of the src and dst passed
> to `git mv`. If they are different and the second one is a folder,
> move src inside the existing folder. If either they are the same or
> the second one is not a folder, then do a rename.
> 
>    It seems to me that this approach automatically handles stuff like
> `git mv bär.txt bÄr.txt` plus any other rules about names being equal
> (like two different sequences of code points that both express "à"),
> all without Git ever needing to explicitly check whether two names are
> case-insensitively equal. Am I missing something?

On case when src and dst have different inodes and dst is a file, rather
than a directory, mv will overwrite dst with contents of src (on Linux).

-- 
An old man doll... just what I always wanted! - Clara
