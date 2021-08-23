Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA5C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBC36103D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhHWGp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhHWGp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 02:45:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F1C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 23:45:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h1so5441765pjs.2
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=396vv6VDeycU0FCBXqkTC6S0Y8IG0UVz3KhsY+Y45A4=;
        b=u67zbgstTEq1p4f8e8OL9kFURl1So3vRcGj0VxDh5qsgXJ/6+0z+AraBT6YIDE5vEz
         LUHfzfbt0n808Ur6O6SRo0lbpOy9fHQl6Xa+eOZ299xaVngNV7UBlo7oN/km0iMmlBxn
         zA4qdPxTG2MRmUN+sjUcgiNyMJOyFMd2bj1Vt1KzF2KMCy8552NzNrBcKEP+FCJSZA/+
         5x2DwjvSHC0zly+mSbQUkqYQsixO1W6nepk6KFEB2y3SrWgjTwsmQ2KizMDbD3U8ohJg
         CKMmpN931vjOTpNx0luDHTjWd0+N4JNXz8NuqJYGPxlndNmlzOYbZ1QVpIHhaH8PPITY
         HhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=396vv6VDeycU0FCBXqkTC6S0Y8IG0UVz3KhsY+Y45A4=;
        b=M7Yk2a6+V+ruEyHbtQrrRWr/oPxrqvwKFz6b46pOH7nhXTnZmopYe9ZtRDHGFYxCm0
         7mtfOlwahWqrcB5aWbK4myVYRrJzVAxk4TXmvGi1/IcMiHLU/Mgq32h4jEQy3ukWOgsT
         qAJhEeHzDYURtYL4iRio29iEwwKMb8DVoNE40GcOfVHqCuOy6YGdRNHQA2xxCA0SSpts
         Q8Hfr6s9hdEU7D2yFFemCodyaly+ZF/MhMl3E/qAML2cqWAsU9jc6qjWWaWEusLP9Ny2
         g7HEY+DSIbEHItexNqFx+TgFtwb+lkbnjd3n/IYuoJFa1tsKUpWfwvAFJh36ATf+Cyk4
         Xi6Q==
X-Gm-Message-State: AOAM5324E7WDNm+59Baxo8gmvjlrChDMb31rmimNbPlY0bRvff3lQf47
        Tq4JjTWaDIRWwAjF3E2qDreEjpgmsNA=
X-Google-Smtp-Source: ABdhPJzD/Mwaj/r04qmVXwD6tQ4+gUBqLKx9L/VSVF1zZIN4CgtQvZagP3HZUWTOrVGuH1H4VU4L+w==
X-Received: by 2002:a17:90b:1246:: with SMTP id gx6mr10463283pjb.94.1629701115562;
        Sun, 22 Aug 2021 23:45:15 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-47.three.co.id. [116.206.12.47])
        by smtp.gmail.com with ESMTPSA id v1sm14772183pfn.93.2021.08.22.23.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:45:15 -0700 (PDT)
Subject: Re: Feature Idea: Expanding git to support automatic Semver stamping
To:     Pavel Rogovoy <p.rogovoy@gmail.com>, git@vger.kernel.org
References: <CA+NVOTBjgQ60hUZyRcK=igEP5=PSJqUFKf4Z-wYr=7+ESp3Ziw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e478d313-e773-6d83-7d7e-ffce2a4fa0b9@gmail.com>
Date:   Mon, 23 Aug 2021 13:45:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+NVOTBjgQ60hUZyRcK=igEP5=PSJqUFKf4Z-wYr=7+ESp3Ziw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/21 02.28, Pavel Rogovoy wrote:
> Hi all,
> 
> My name is Pavel Rogovoy and I am a git enthusiast. I have developed a
> git-based generic version stamping system that is compliant with the
> Semver standard and I believe it can be integrated into git as a
> sub-command such as git stamp in the form of an external plugin or a
> complete rewrite into git’s source code.
> 

I like the idea of automatic semver tagging, especially on case when 
developers do releases quickly (with manual tagging, they must know last 
tag version in order for the new tag version to be correctly greater 
than previous).

> I welcome you to take a look at the stamping utility:
> https://github.com/final-israel/vmn
> 
> I will be happy to discuss the main benefits of such a move with you.
> Here are just some:
> 
> - Effortless version management and state recovery for single or
> multiple  repositories.

If you `git checkout <something>`, you get whatever your code in 
<something>'s commit; no need for external tools.

> - Can be used as a convenient git submodule alternative.
I saw "root app" concept [1] in vmn, which is roughly superproject in 
git-submodule. But looking at resulting `vmn show`, it more like 
metadata for CI job.

When developers clone vmn-ed root app repo, they only get code for root 
app only, whereas when they clone normal git repo with submodule, they 
can initialize any submodules used and have all history of them on their 
fingers.

[1]: https://github.com/final-israel/vmn#root-apps

-- 
An old man doll... just what I always wanted! - Clara
