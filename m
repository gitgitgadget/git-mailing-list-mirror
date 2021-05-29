Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D04C47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF9611EE
	for <git@archiver.kernel.org>; Sat, 29 May 2021 15:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhE2PvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2PvS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 11:51:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCFC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 08:49:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso4188573pjb.5
        for <git@vger.kernel.org>; Sat, 29 May 2021 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQIQpglelwBi5T4iL0HKxKhbinEv3EXGpsMPkofdscY=;
        b=EASSK6tKWjILnk/34+vsiRBL1x346pS6I2Igma9yJXX2vZN1XDbNTfVfWjsZa53ijy
         GRalM75QIFZARONYXMKodZosPwjJ/3M9X0IKIB/HfrsSetDTsuINVbL06mGqQI3jaONd
         iWDQwTDT8FFmMbDEbsC+FG4Q60EArrOPsi+otC0TkpD4siT0ex5GQUL58kdEoxz+OYH6
         7C+L2aF5jSCUrqfyMOFb80rl6eeH0tcA8EMEibewRCmo8++ujGCZweODdjqNuJJ3TfSg
         y6kMXRO2o0/rqahPx8fcTmmGo1H6MELJ9gzTDSTm/4orMFvXk8B46nNz4pCjSgd/PLHK
         A0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQIQpglelwBi5T4iL0HKxKhbinEv3EXGpsMPkofdscY=;
        b=Bh6b9gwlPCOnm8X7ukjjzRfj50CfrQN91LsilLZCuK9pShwDXvHZBpqaoEVYqh6zkz
         qlS7VkNJbCK0r0a4ZTZXpF8OgaenZW36i+XgRAElPusl99FdNUPJO52xTDqSKBchrf+o
         M9Eder3SN1ppxbpUMWnlJnJ1+SGQcxJqEXJFBbJjHOMO+vX745rGBXFp8Hu8Q8gCf/rY
         r2Xu3XFosMHW3XwodKQGTEJb4fI1n/BpIHH2M6/dNs3dKbKFCuZ/iiu9wKdgPyRsBvhI
         I5HvZ7a/s0zBqARKAcz3c0ckY9Zj8Oun6OblbAyC25S1Yv+ABDOujRNOyim43X5NomLK
         YeKg==
X-Gm-Message-State: AOAM533Yg5o9R3wEsuTb9z6anVnzviejRb/TxQ1nImE4U4lrz71vx6x7
        LyUDUnkjp5fVK7uIWvAfIv6JhxwEddQvVhlB758=
X-Google-Smtp-Source: ABdhPJx1VVTVxLFbd834qXVMIlJXPZ+DgPZaeJFfpSKyDjG5UHLrmn4ec0D8WE0ZCeTApOlrlypkVGPXod3AQopYxYY=
X-Received: by 2002:a17:90a:e38a:: with SMTP id b10mr10181933pjz.169.1622303380784;
 Sat, 29 May 2021 08:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
In-Reply-To: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 29 May 2021 11:49:30 -0400
Message-ID: <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some experience at my job with CMake, but some quick testing
has found that adding a check like:

message("MSVC = ${MSVC} , WIN32 = ${WIN32})

shows that the MSVC is uninitialized and WIN322 is initialized.  so the
issue is that the MSVC variable isn't being set which is causing
vcpkg_install.bat to not run, rather than the WIN32 variable.

The msvc variable is intended to be set whenever the compiler is a Visual C/C++
compiler [1].  And it seems like visual studio should be setting that itself
either via a toolchain or some other mechanism.  As you noted the
Ninja generator
is os-agnostic and doesn't imply a compiler unlike the Visual Studio family of
generators.

running CMake with -DMSVC=1 should resolve the issue (Assuming you're
actually using
an MSVC based compiler).  If the CMake is intended to support non-MSVC
compilers like
clang, etc. and vcpkg is required to do that build then the MSVC
portion of the check
should be removed, otherwise I am not sure if it's a Visual Studio
issue for not correctly
configuring with MSVC=1 when using an MSVC-based compiler or on the
CMakeList.txt file
for not correctly specifying when vcpk_install.bat needs to be
installed.  I don't really
know what vcpkg does in the build to be sure though.

1: https://cmake.org/cmake/help/latest/variable/MSVC.html
