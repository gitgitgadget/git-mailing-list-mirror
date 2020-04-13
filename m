Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B865C352B6
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172472063A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhbol2mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgDMLyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgDMLyo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 07:54:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D4C03BC93
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:49:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z90so6810634qtd.10
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Cw75nsnYWp0eSXr3u2rZvlriScMCQm7fIIqc+xUP+8=;
        b=jhbol2mFkw8s4MDJ0edbXBk9ZX8TSo/GeGrBoO5m05ya4ki/Kz3ncvCUfUVDQxlH9p
         4x2UjoBB7iZIzsy7SA1fLtZlXvLb2gsDBzR4qcv32TU3LakgodQjaJ+GXn5oZd1kB1RR
         NdHBz3unoxOjTqp8pNcJo/27Qg1HTrTL6OwsrHc7Lny0WLqEou0/8oobBA0dGOpSId8Q
         seDyeKy8YGsFzfYppZ/r5sN29G++YU9UOt5Hk+20WL8Dgr7JK2GjftnI7Zvt4hFPrAip
         1EvAIcKwe6DbHYPFzljUf/p+uADb2MDN+L3r0JF1ATJtA1UCJknytQeXB0jkpsdxL1kz
         cBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Cw75nsnYWp0eSXr3u2rZvlriScMCQm7fIIqc+xUP+8=;
        b=RUqLlfi60Hx4jI14SkXR/tC8vPzDZMOoQuaJfg/dODP6gzgGeluk1JbQ4g0LBmjx3n
         raxeUPiLoEsugfNUEig+P2t6LwzcTgd6XMwWVu65vjeUfv3aBcLzNvUjxAyyfV/F3fuS
         3z+jD8vBYVf+32Z7ZZS0iZfHP1nNpeN+NHAgJQOY3Bp0JQSv68OIi+s3S3OOI+33KSfy
         L6pCkX5ep08E9GAM3KI73sofvS7ZIN9A2CyeXX4NMiITasMtqKwgESgmp2AFQobRoiD3
         fWjaLJhgGhqKfkCBX2xlbQENCBPltP//lt7Ku7WAC6mY3idEzUJVWwqvKzZv2HB54Ftw
         0GFQ==
X-Gm-Message-State: AGi0PuZ6NVbAcSIcTpFZvfYMjRmkCLBkDRsH6Ks0ksi7DKZYbcSxbhhP
        bJuODDOtGhrTJqvkec3jZSs=
X-Google-Smtp-Source: APiQypKKQx3vbuzInPn+Ci4aaQvJWnTFqbHi5Kn9NrbQcRu3ahfs/rUNHwlk+WelgnA7TbQdNLSm6A==
X-Received: by 2002:ac8:6903:: with SMTP id e3mr10852043qtr.109.1586778554220;
        Mon, 13 Apr 2020 04:49:14 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v23sm368284qkv.55.2020.04.13.04.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 04:49:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
Date:   Mon, 13 Apr 2020 07:49:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqeesthfbf.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2020 5:40 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The changed-path Bloom filters work only when we can compute an
>> explicit Bloom filter key in advance. When a pathspec is given
>> that allows case-insensitive checks or wildcard matching, we
>> must disable the Bloom filter performance checks.
> 
> How often do we want to do case-insensitive path matching, I wonder.
> 
> As somebody who never touches case-insensitive filesystem, I would
> be a bad judge, and I would imagine that I would be looking for a
> pathspec "[Mm]akefile" rather than ":(icase)makefile" myself if
> there are projects that may have either/both, so I do not mind
> disabling the bloom filter for case insensitivity myself.
> 
> But if users may use icase pathspec very often, it may be worth
> considering to build the bloom filter after downcasing the paths,
> perhaps?  Given that many projects extract their source code to a
> case insensitive filesystem, I would imagine that downcasing paths
> would map two originally different paths into the same thing only
> rarely, if ever, so there may not be much downside to do so.

This behavior could be extended later, and carefully. My initial
thought was that the case check would happen on every commit. If
the :(icase) check only happens at the walk tip(s), then we could
compute a single Bloom key at the start.

Thanks,
-Stolee
