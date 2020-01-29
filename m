Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9A6C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 14:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B1F206F0
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 14:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9YcaI1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA2OEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:04:15 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35390 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgA2OEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 09:04:15 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so8042176qvi.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 06:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLg6yItURUcc2cIK81nvQhyAOl2Drfjxxf3tfp0zqS8=;
        b=H9YcaI1yFVZEW5aNwfWbMw12Ia9u3ikEF5q8LXkPAwDtTMfvpr1VNwfp9BCzr/FJwP
         MXUOGGijdlOIRvT6JrTGiSl7SCAu4XfM1qjhwYa31pg4U/Ro+DPbJ0+afnn+oKQ6tTyu
         vC6xvDihhnymrOyCvrdUlOIBl8i8R/os+0hOnzhZCUGXfXRUaefm9TCdMeFebQB4KrZ0
         bL3BpMj6eMzlvZGz3GrUm9yfbh/VicYAjsd8f1v6cvPP/zUyH6TqJhV2nFCop+NdB1oI
         pgEG0jkk+ii9lZYbZ69ENuAsFG33gRlwQU77txPCqiF5uk+vk/38eS5UrpAn/vFm1baA
         dozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLg6yItURUcc2cIK81nvQhyAOl2Drfjxxf3tfp0zqS8=;
        b=XglfB7boCGgV8WRZw273f/yeWySAU42IFK2iXJTthNXAonwayAekrNUgvAPN2Skj0I
         iaCBqHLfI9QQuMWfDlNyMoJ0oFZBJe1/WZTWYGAaEC64dWKfwI4oywwcjvrNoJ0IISbe
         YJepiEOFnE4B+lgCyzPySWJCPii86BZ9AdekpZqqykcs6Zzi/J3gV7SFlsuMjMO2Zg63
         gvuLHfh4O29YL7MXG0Zb8/NqF0yQn3rVN27vhlMvarZHsYHKNTjs0dav7oAM1GpJ3LZA
         Vqv+54nzKpJ74Ziv34szPLGx7/+69ztVRXurJy6pIl70GLfHbVMyzA3jLBECJqFgR4iZ
         Qe6g==
X-Gm-Message-State: APjAAAV9sjFewtE+Ff9KEje1vuM46kMUijN5Js/8lhIYCiG1YF9mK+R2
        DyCK8IcXS97RhfIYb2r1wpM=
X-Google-Smtp-Source: APXvYqxbJB4dbbVjpBgO0eqjdYbItZRrbTJBi2dYVE74EIEQeR+CwxxPfvKCphILKkVdiVN/H7WzWg==
X-Received: by 2002:a05:6214:50f:: with SMTP id v15mr28062724qvw.42.1580306654117;
        Wed, 29 Jan 2020 06:04:14 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:90b6:a0a:46b8:addb? ([2001:4898:a800:1010:41ec:a0a:46b8:addb])
        by smtp.gmail.com with ESMTPSA id m68sm976640qke.17.2020.01.29.06.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 06:04:13 -0800 (PST)
Subject: Re: [PATCH v3 09/12] sparse-checkout: properly match escaped
 characters
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <9ea69e90694e53842acd68d3ac85c9a00c4bd343.1580236003.git.gitgitgadget@gmail.com>
 <20200129100309.GA4218@coredump.intra.peff.net>
 <6003bbf2-ad16-0686-dc58-2010fe02ce05@gmail.com>
Message-ID: <c4f3b0d4-c837-bec7-7ad2-2203bb577b17@gmail.com>
Date:   Wed, 29 Jan 2020 09:04:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <6003bbf2-ad16-0686-dc58-2010fe02ce05@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2020 8:58 AM, Derrick Stolee wrote:
> On 1/29/2020 5:03 AM, Jeff King wrote:
>> On Tue, Jan 28, 2020 at 06:26:40PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> In cone mode, the sparse-checkout feature uses hashset containment
>>> queries to match paths. Make this algorithm respect escaped asterisk
>>> (*) and backslash (\) characters.
>>
>> Do we also need to worry about other glob metacharacters? E.g., "?" or
>> ranges like "[A-Z]"?
> 
> These are not part of the .gitignore patterns [1].
> 
> [1] https://git-scm.com/docs/gitignore#_pattern_format

I should read things more carefully. There is also this information in
one of the bullets:

	An asterisk "*" matches anything except a slash. The character
	"?" matches any one character except "/". The range notation,
	e.g. [a-zA-Z], can be used to match one of the characters in a range.
	See fnmatch(3) and the FNM_PATHNAME flag for a more detailed
	description.

So this series does not attempt to properly work with globs, and I'll
need to test those a bit. Certainly they shouldn't work in cone mode,
so an extra patch to remove those would be simple. Input sanitizing
would be interesting, and I'll see what `git ls-tree` would output
with paths containing these characters.

-Stolee
