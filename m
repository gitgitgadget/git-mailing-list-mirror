Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC94C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7612613FA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFDSFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:05:15 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:45019 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFDSFO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 14:05:14 -0400
Received: by mail-ej1-f47.google.com with SMTP id c10so15756501eja.11
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 11:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBOjIWRgirw6hFudNqOWI8gMLfJU9r+Y2/kdGj5pL8M=;
        b=oTKVf2Zp8RQ/Fm9xOEr8Aw5wDmRNVYDCMu+zjJognW0yQQtGlxr05fuefaGaBTyFHM
         dreVDqfULz++YUtYjjmRGyTQueOIRTHCbfV+JzUAgGhfyv4FshtwFxJA8gFahELlG/ou
         7rgk/15WX1LbqcTJLSEKPNfxh4nQzdCVNrktA9MoxnAUObUvngr30zilrvtJF3BWQ8Wf
         3HV14/YFavyfo8Mtp2ZlYTQ0+suGLMDUsimTctrapCC+JZUpncoapLXs+10gdAj3hjJ/
         ytM+02l3KRxNNp9F8NG4kBNbOc9Vk5hGZz4l6LiQEGL2y6Y1s+PUU+lCaPNx2XF1JAsK
         OX+g==
X-Gm-Message-State: AOAM531e7wjl9tUI89ar7V9fS7DgJOGbiV2FkGTiZMAZt1XyuHwklPJa
        OBCWaUmyH0Qk5q6x6SPWt46+csC5FTRQ6jnc7F4=
X-Google-Smtp-Source: ABdhPJwi4zOJecqPdvl77MNAX3jIVxUsqq7THOl/4GJ7Nao6c3tGjBg/cBaS0BkJL0ITdmBREA+a2AXG6ylpazUk8p4=
X-Received: by 2002:a17:906:c311:: with SMTP id s17mr5287023ejz.202.1622829807351;
 Fri, 04 Jun 2021 11:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Jun 2021 14:03:16 -0400
Message-ID: <CAPig+cRBQYbhPbvGvEcmqUFmXM4yysRnWam=Sx_Lr8uWbEZVMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmake: add knob to disable vcpkg
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 1:44 PM Matthew Rogers via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When building on windows users have the option to use vcpkg to provide
> the dependencies needed to compile.  Previously, this was used only when
> using the Visual Studio generator which was not ideal because:
>
>   - Not all users who want to use vcpkg use the Visual Studio
>     generators.
>
>   - Some versions of Visual Studio 2019 moved away from using the
>     VS 2019 by default, making it impossible for Visual Studio to
>     configure the project in the likely event that it couldn't find the
>     dependencies.

Is there something missing between "using the" and "VS 2019"? I'm
having a hard time trying to understand what this bullet point is
saying due to this apparent gap.

>   - Inexperienced users of CMake are very likely to get tripped up by
>     the errors caused by a lack of vcpkg, making the above bullet point
>     both annoying and hard to debug.
>
> As such, lets make using vcpkg the default on windows.  Users who want
> to avoid using vcpkg can disable it by passing -DNO_VCPKG=TRUE.

s/lets/let's/

> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
