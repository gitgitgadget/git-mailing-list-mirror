Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F939C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD266224BD
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbhAKL63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbhAKL63 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 06:58:29 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C34C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:57:48 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id g24so10961958qtq.12
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vqwwXF8G47ApqIe0lAyReHIYSgIDRcjBwHw/gz2ik8o=;
        b=AnIdJIWNFo9be4836ZIaDrfmKudijafczDwX80SaRVccJvrC76ljVDd4IzF/8p12IU
         JxNyATDwikFVh967JwzY/wsnoFSr2ccVqaPqE92MVK6yzxJzG8Fis6j5oogkv3zjqUmP
         rd8BXvnJwB4sAdXaN92/fMAGf+CPhqrQomZ0Gd7MmuFW/0pWFVbB3hsKAhx7WZcdrzX0
         TpNdzDHa8nN/Wrxh/Gp2KaAF3uaEOHo9OM3u/ObyIVwvUp9S+3qqqOZnVMdiOANY8XdC
         5ksu6Woq5ObhEmMK2aa5SyPStMoeBLtGb+CH7h81X6OsBkPmzERywpY6LLUxExDlauDq
         S/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqwwXF8G47ApqIe0lAyReHIYSgIDRcjBwHw/gz2ik8o=;
        b=lwffewFat3/IK9G5f4tXtPJfFxykwAGlaUoXlg4KRX8pcwqBm25UwFbdfzVzEt3aw9
         m4Y9PkkCTQDMFTiyApbITZ9lHlRwdEyWfc/QdT83c5O2W8416fCWgup+ZMxKMd18OZuZ
         f/L5LFArbBQMZFoDi9eJXCygJN4NV3HQ/b27O5Db7dAUgk9vrjwoTVMYHM/Yo4lp/waD
         m1S9kTNwlC9oIYiqTMVjiqhuWyluhNTklkE8tYI3HFVrDMoKXv9MbfXRQmqX3+V0clx/
         PnLaTJ10XfeVOTmM1GZsyrgUgINTFhBYmPpcEFuSRz1/N6Om7arhMr5mzorUfUFoXi4F
         LjOg==
X-Gm-Message-State: AOAM530OIgSjMK8GwDzgjcP+3vyP6J325gNQtHChKV1zElnTjjPA3Os5
        ZlIjBB7X3+xqnMUtgEXhb7brBl6Opgc=
X-Google-Smtp-Source: ABdhPJzm6qlW6VwCkr+gr+Lhrp56nCkyhYJS/rgDT8fiWnIBcvbf3ATse6CjBWdNnaMO+rvrQYKR/A==
X-Received: by 2002:aed:2c24:: with SMTP id f33mr684810qtd.218.1610366268109;
        Mon, 11 Jan 2021 03:57:48 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id i27sm8252481qkk.15.2021.01.11.03.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:57:47 -0800 (PST)
Subject: Re: [PATCH 19/20] pack-revindex: hide the definition of
 'revindex_entry'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
 <7c0e4acc845d1135e684188b2ccc61cf358994dc.1610129796.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b3a59c5-5cb7-cd0d-2658-b1e7cac236c3@gmail.com>
Date:   Mon, 11 Jan 2021 06:57:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <7c0e4acc845d1135e684188b2ccc61cf358994dc.1610129796.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2021 1:18 PM, Taylor Blau wrote:
> diff --git a/pack-revindex.h b/pack-revindex.h
> index b5dd114fd5..b501a7cd62 100644
> --- a/pack-revindex.h
> +++ b/pack-revindex.h
> @@ -3,11 +3,6 @@
>  
>  struct packed_git;
>  
> -struct revindex_entry {
> -	off_t offset;
> -	unsigned int nr;
> -};
> -

Very nice. A successful anonymization of a struct.

-Stolee
