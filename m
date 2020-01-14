Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213CCC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184224656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqeP3+kC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgANWI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:08:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39265 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANWIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 17:08:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so14237001oty.6
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 14:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3zaT8ALKic2UIMeWTmMJk6vTEhKrjXjadBQGiCy7z2Q=;
        b=WqeP3+kCQ6kmQDBN2+iUS7iSljbxC2ToporJKViQBQe84DZQk9bUq2W9HdAGFlCRea
         TqY/r98pEoRu0OQxnBHIUXo4Fk3obI5fWHITEWotGgBb7HxHLdk/xuah6z43v6nz1kjh
         nYRlNJnizijNFglsRFEzz0XGtACDsVmbYRdk+eS6XN43q4MK9kJws6NMIAtc65D3apAJ
         TMOo2Gzy6cFjn9TXD5nQKh+qHIFGoTpXJ4MQU2dUzYNxr/s5Xd+p68tHPndnuG2NLlCK
         Lskqu+Uq7o1ZXsCTPdxkZUVvStXsjVBnX9nmpfQA9VVFTnbPreh+XegBTVOYpoPAdws4
         4UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3zaT8ALKic2UIMeWTmMJk6vTEhKrjXjadBQGiCy7z2Q=;
        b=B2cpxrowPyDWoE9r8/vgHYDzOoHpoq1Z48ihx6xEMZGzYv4nhh7kRag9baRw185gz4
         rLrqWFhevzMqozsr15vmlGfE368DCr4ziQ0IyqI/HxGZyx1JuA1L0XA97rKV7liCS3LK
         I6L+ZgvHbPuPL5KdMjtyR4OYi7H6gU3YbxsjpRT5E6Xbb7O9onRIXYKcxYv5XUzNuk5f
         XWW7vAQ5jM0GoQZ7VGYEk4CbTzCF3Oa862KmN8ofObxzKMoYKRjRU34ZtKKaldInalOU
         eznwAQH/nOYjgGYVEsN/wMmMwMgDF+ogl7YIIOKYU6441FbZ/pQYfVtl9RjhuskNGqyJ
         qvgQ==
X-Gm-Message-State: APjAAAUTBItxo6Eu213nmi7yvLPkmSgu0AuIY52VIh77OMTIq0uAZP3U
        pU9iOPLEhKnm8TzTRbbZBTI=
X-Google-Smtp-Source: APXvYqwYSD+LKLBcx9jTzbOIdj8AHhN0Nwgs3Ggzhpy9EfI2WiS/SHtaCGCf/wKpeiyrpQXizkeBWg==
X-Received: by 2002:a9d:600e:: with SMTP id h14mr410593otj.113.1579039704645;
        Tue, 14 Jan 2020 14:08:24 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j26sm5887222otq.18.2020.01.14.14.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 14:08:23 -0800 (PST)
Subject: Re: [PATCH 7/8] sparse-checkout: properly match escaped characters
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <09dbe1f9029d173e579b74442b02bc20e1a82437.1579029963.git.gitgitgadget@gmail.com>
 <20200114212120.GC3949560@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <79915215-15c1-7e38-6f06-294c719ff260@gmail.com>
Date:   Tue, 14 Jan 2020 17:08:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200114212120.GC3949560@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2020 4:21 PM, Jeff King wrote:
> On Tue, Jan 14, 2020 at 07:26:01PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> In cone mode, the sparse-checkout feature uses hashset containment
>> queries to match paths. Make this algorithm respect escaped asterisk
>> (*) and backslash (\) characters.
>>
>> Create dup_and_filter_pattern() method to convert a pattern by
>> removing escape characters and dropping an optional "/*" at the end.
>> This method is available in dir.h as we will use it in
>> builtin/sparse-chekcout.c in a later change.
> 
> s/chekcout/checkout/

Thanks.

> It took me a minute to understand the problem here, but I think it's: if
> a path in the sparse-checkout file has "\*" in it, we'd try to match a
> literal "\*" in the hash, not "*"?

Yes, the hashset would have the string "\*" instead of the string "*". This
would lead to missing directories when cone mode is enabled compared to
cone mode not being enabled.
 
> But we wouldn't run into that yet because we don't properly _write_ the
> escaped names until patch 8.

We wouldn't run into it when using the builtin, but also a user could
edit their sparse-checkout file manually OR figure out how to get the
"right" pattern by running "git sparse-checkout set "my\\*dir" (where the
escaped backslash is collapsed by the shell and Git sees "my\*dir".

Thanks,
-Stolee
