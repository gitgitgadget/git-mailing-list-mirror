Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F1C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 01:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011312081E
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 01:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0rTSZMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgAPBd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:33:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43662 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgAPBd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 20:33:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so17458382oif.10
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 17:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p13GGxdwiLzYefV2htlpCkxTC/qdtoFZfto2mfFAq5M=;
        b=n0rTSZMhgvFP989M0Aci2nHC6EPTMLP2eoKXuk599647jqO2WnecU2HICX5H46rjMa
         C1d6V9L63RDwcUOJyt7jeeU9XzEvfihIG1WA9D8Iq0Wsg547xU2D9YSdOI7r/d6h4P7t
         cUinCSzAWZ/0m14o5SAizlmVfViVExrKiFl0e5Pw9ga1lMM9XqkHhyuhGjm3JeWUblM1
         bZcGRDFUAozSnpKznug5n8oTVRudA0t2Dc5yPm49Z8hCrf6Mxi9qO0TUdS0EOhyHi+cu
         Q0t7+hOKB4Qh/BxA9eqSKmMPRA5pPKRk1YtnPm8C+bjbQK6gA5zPyRFhC97H1zIv2FPW
         y6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p13GGxdwiLzYefV2htlpCkxTC/qdtoFZfto2mfFAq5M=;
        b=sSvSLrDt2ZlBthLRet9vJDPUbs6IThQExG2ufJBp6A1EQFZXWApHJx8Pk3k+VqDQU7
         q6uJpR10iDZY7ROza5w01H46tF8ApmFm7qWKRP/4ig83VpyHpybXwMhOAZ0CQrZVXdUR
         WHJBaTfPUhrRVG4Vc/jMszTE6tNScf/Hq7zrgeH6VbNVpTT//NqxhbW60YWGYlfqRXUl
         9uadKeieftN2gYzv+/ryJpkjVCA8qOO7GmpnCrtbd4kd1M0jTnomraPlOQ/ekNa4cfTJ
         wT9/gH2IGow6RHI+6B5oglHSvk8xtewHG8ZXpU87WKjnjxjXRDKJQiLpQ2z2BZzAngvl
         S7Mw==
X-Gm-Message-State: APjAAAXf3anRwu1woFvtG+rpIuzi8KjX1xWyt5Mweb7nA6f6zEt22TUH
        LvqDXkaoF4P82uWtYzCueRk98leES70=
X-Google-Smtp-Source: APXvYqwusWV3i6mBQdRSFM4zyEodrZBAfFULDl49UMfaJb+BNG4Ch+cYEUrylAnjxh/TqnW6/wYOSg==
X-Received: by 2002:aca:4ad5:: with SMTP id x204mr2260678oia.162.1579138407350;
        Wed, 15 Jan 2020 17:33:27 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x15sm7165889otq.30.2020.01.15.17.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 17:33:26 -0800 (PST)
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
To:     Kyle Meyer <kyle@kyleam.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kevin.Willford@microsoft.com,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
 <87zheo2t7b.fsf@kyleam.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6ae84c45-d207-74a7-fbef-ddf78d30d3a1@gmail.com>
Date:   Wed, 15 Jan 2020 20:33:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <87zheo2t7b.fsf@kyleam.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2020 6:30 PM, Kyle Meyer wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> b9660c1 (dir: fix checks on common prefix directory, 2019-12-19)
>> modified the way pathspecs are handled when handling a directory
>> during "git clean -f <path>".
> 
> I can't find b9660c1.  I think this and other references below should
> point to b9670c1f5e (dir: fix checks on common prefix directory,
> 2019-12-19), which matches the base-commit value for this patch.

Sorry for the digit swap. Thanks for pointing that out!
