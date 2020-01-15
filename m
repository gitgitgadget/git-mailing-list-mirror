Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736BCC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FDB2084D
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWvDYVfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAOUcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:32:46 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39036 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:32:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id h126so11620041ywc.6
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O/ukQTlXeU7bK9pTr0S19sR2cIbrxly0M+5IP+j5j7s=;
        b=fWvDYVfF1g3qIrHTVkF2Ghhf8TAEv+BTDqUc1USgAHlhKg5Ss2dxdNnnu++gUkJSKX
         D4EmwAfXWlDe1PSm15eppT4wlXGnfgCa/X09kLXLbNw41k5sPjLcLiMz2S0PF99opSkO
         r74fXjZfp83qU6KLta8I58Mj0371UPLjo+DxOOiEk/IOs6JvCnZtiAdvzNaXWRgZPhve
         GYuQwjI9HoTO7CiqaNQVz07OVV804l6bH2hZhpyyD3p4qI3rkOqxs8jvB8Y2j0HtWsC+
         YNTJPyU92AU3yTV0IpacuYd9yYUnyh5lCLXY5i5Vlygg2Vqk199OrwgJPCcT5GHzawW5
         PDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/ukQTlXeU7bK9pTr0S19sR2cIbrxly0M+5IP+j5j7s=;
        b=HQma3S4yN0jodyBmLPAlN1eIqgCLuXJXzkO4JmoSdP2jfsSUcN3XA48QPsAxmMcn1+
         utJN/uJdaUjiepGBFyeqTMJ6PF4l1DEp5ojrSiSaPsO2cHC3rx9WvtxPdoe43JAiPxey
         3oUnrv7GCanlP3V94S6w07iBqUHLvK8etVB+m+/p/45YK1maEaFqdOpVzNfTKPYEfWrT
         RSwYx2suAeSsid9z7P2a9sAPu/ikjOKno50Gxk9I180IRDvh+nlQebQlySEoz8+/Fe1P
         c4eVbmzELITNUAmSVxNyFDiCyKPkLC/UMWqSqxTsO7f9RKY1dp/ISaEb3vFh0oYpm+Z+
         j4QQ==
X-Gm-Message-State: APjAAAXquoE8SdWxvGONKA6AxxF58v5voe8j0npe+JigYQKK6l2tqv5z
        br9r/vWiMStUPLroX3S0qRA=
X-Google-Smtp-Source: APXvYqwjJRcEwZyOAwedkF8I6wWsOJyl3CTSuB3OuNKiHy5Ob9gxbzmrYpNKkvXZOEFE/j6+TyC1Hw==
X-Received: by 2002:a81:3a06:: with SMTP id h6mr23066818ywa.170.1579120364379;
        Wed, 15 Jan 2020 12:32:44 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j11sm8539404ywg.37.2020.01.15.12.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:32:43 -0800 (PST)
Subject: Re: [PATCH 0/8] Harden the sparse-checkout builtin
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <xmqqzheoil82.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <19493656-c7d0-5916-7f9d-46c3183d2d77@gmail.com>
Date:   Wed, 15 Jan 2020 15:32:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqzheoil82.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2020 2:16 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Also, let's improve Git's response to these more complicated scenarios:
>>
>>  1. Running "git sparse-checkout init" in a worktree would complain because
>>     the "info" dir doesn't exist.
>>  2. Tracked paths that include "*" and "" in their filenames.
>>  3. If a user edits the sparse-checkout file to have non-cone pattern, such
>>     as "*" anywhere or "" in the wrong place, then we should respond
>>     appropriately. That is: warn that the patterns are not cone-mode, then
>>     revert to the old logic.
> 
> It seems somebody ate a letter to make "<some letter>" into "" an
> empty string, so I cannot quite grok the above list---two out of
> three bullet points are not quite readable.

In 2., the "" should be "\".

In 3., the "*" and "" should be "**" and "*" respectively.

These are things that are being collapsed by GitHub's markdown
processing. Sorry that this affects GitGitGadget's cover letter.

By escaping appropriately, these show up correctly and hopefully
will be fixed in v2.

-Stolee
