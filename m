Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D30C433E5
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 03:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEA4206F4
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 03:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZySZp3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGQDt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgGQDt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 23:49:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF4C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 20:49:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k5so5734535pjg.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=T/7q1TdtqDua6HGzJl2+Qks40ZAuvJqTTf20Ag9PXTM=;
        b=UZySZp3pOX/e9G7aUZ3Z7Pu7H2TSMGMRCjZHcByQC1/3JJCIUTmXWAGYLwC/o4WChe
         L1s01LrGzKRmcIFUFbpHpWl8bfZLx3bIASNb0Jo6HXUI24wWgTLQMhozP3D3vQxzPC7M
         sQsEvrK7/msEh9d7Ru2aJp5QjuWncWBWEDEVIAwt0BR1VOFlBfV5AOdySKb7QTabsohF
         Km/hol96Qhewp9G+HaVmlQvONuTtpSMGxQpylwXNZm1xaWhfLcc7kqcheioPV0Bgcpqm
         X2+KEI+gDyHYUcV2badPFiEJZ/ywAF087LGVMeTZ+iqYBiVn+X3xWskzl8jt++vSZvlp
         jo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=T/7q1TdtqDua6HGzJl2+Qks40ZAuvJqTTf20Ag9PXTM=;
        b=Me81sgvdHa5ecktqlIeNcc3p+e1qmHQtwWe49vi36sF+tLMI1nEYiBzgZfDeGBODyQ
         +kRvEojeKeqbpyLHFktvXwIdpBcItJ5bcVUYJ5e2Jg3vRvv8XxE+XASa+rwZUxN0WQe1
         UfM5Mos/ZGnyZ9eWnI8sFCiaMlxg6JFmKH15lBteMARiL/oaTuFXPsmkGtVJKmuu6KfE
         YgAqixI7tXCJ5ovj/HRKcvtqworS5T10GXskGoIEBWR7ghZ+PAfoRCwoW8nZV1eCVlaV
         x9dlNVkwREunJJqTZLaL9KnAbtk01coBjRZDjShWYt9yT0Ck6+gmYFJk3zHrifjmNmlr
         BPVg==
X-Gm-Message-State: AOAM532i+Pk6Gazczhy3DoTS6asUDcAtqhYKb97Zhc2X9kbyoJoPUYRP
        pagjgF8r7NjweiTXTh0VTY8=
X-Google-Smtp-Source: ABdhPJzJXz/Dqe2iehPf/l/PbsHUQDAi3JGTS65yExPHLFB+J5kpvJ451EyY4OTWAZ5JbQT5YiFpXA==
X-Received: by 2002:a17:90a:319:: with SMTP id 25mr8250302pje.77.1594957796907;
        Thu, 16 Jul 2020 20:49:56 -0700 (PDT)
Received: from [192.168.208.36] ([49.207.132.10])
        by smtp.gmail.com with ESMTPSA id z11sm6120247pfk.46.2020.07.16.20.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 20:49:56 -0700 (PDT)
Date:   Fri, 17 Jul 2020 09:19:52 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20200710135935.6416-1-johannes.schindelin@gmx.de>
References: <20200710135935.6416-1-johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [ANNOUNCE] Git for Windows 2.28.0-rc0
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1B17D6F1-953F-476A-87A8-FA0FE5B5C2D0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,


On 10 =E0=AE=9C=E0=AF=82=E0=AE=B2=E0=AF=88, 2020 7:29:35 PM IST, Johannes =
Schindelin <johannes=2Eschindelin@gmx=2Ede> wrote:
>Dear Git users,
>
>I hereby announce that Git for Windows 2=2E28=2E0-rc0 is available from:
>
>https://github=2Ecom/git-for-windows/git/releases/tag/v2=2E28=2E0-rc0=2Ew=
indows=2E1
>

Thanks=2E I just installed it in my local machine and it seems to work fin=
e for me=2E

>Changes since Git for Windows v2=2E27=2E0 (June 1st 2020)
>
>New Features
>
>  * Comes with Git v2=2E28=2E0-rc0=2E
>  * Comes with subversion v1=2E14=2E0=2E
>  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
>    3=2E1=2E5=2E
>  * Comes with the designated successor of Git Credential Manager for
>    Windows (GCM for Windows), the cross-platform Git Credential
>    Manager Core=2E For now, this is opt-in, with the idea of eventually
>    retiring GCM for Windows=2E
>  * Comes with cURL v7=2E71=2E1=2E
>  * Comes with Perl v5=2E32=2E0=2E
>  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
>    3=2E1=2E6=2E
>  * Comes with GNU Privacy Guard v2=2E2=2E21=2E
>

The above has "Comes with MSYS2 runtime (Git for Windows flavor) based on =
Cygwin =2E=2E=2E" for both 3=2E1=2E5 and 3=2E1=2E6=2E I wonder if it really=
 comes with two MSYS2 runtimes=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
