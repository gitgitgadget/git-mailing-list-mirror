Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45291C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 00:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072EF206DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 00:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="MxDScn2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgGHA5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgGHA5g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 20:57:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B90C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 17:57:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ch3so419246pjb.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=2pMfpdp3sFlBN3io8N9L4ubwbjiXF3OqsoPUyvmOOco=;
        b=MxDScn2eH6zLW8f6ieKClpXKNScQmorRjZOW+n02kakvnPoxgSymw7x7f1klj6DMJi
         ph80vnVxp5EhZYzCHhik5P87oq08l4dbVfPjZD/vZ4U8X+zcp5sW8ioaIFtV/HjCJl3i
         myJKPIEx1qBKlM+N/UFWpNQGSDAs0NvybK5MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=2pMfpdp3sFlBN3io8N9L4ubwbjiXF3OqsoPUyvmOOco=;
        b=XVZZJMlJFvyWWptiDlzLJd5kOD8wOxHNoWLVTj0nt0NsRMYVn7kKGY5Yaac5xsq2/C
         qWzG8G3SYVUo4zinLFFVAEXhOCPI275c6ArHy+686KgkrcRqCxXn4rt5Jxm38Y2iA1s0
         g43c4ahrr0UIRJBbNczKnFn1dxnmtRccYXruh5cODhFVaZXo6NongA+ig6rd/dmbeiGh
         Wcbf4Zw6Ag6NCYoK3EGqlAmlRPqxh3X/HmdroVH4S2llz/bpE25VzQ8vaoX/x2yGNHqW
         GQoapVkF8b2mQiObiOWSlurO4BG37NGq+f0sUgllcja2Dsc4qnc3949BB/mseEAy/Wc0
         DQfQ==
X-Gm-Message-State: AOAM532rg5IHxtDk8DIE+5oVjFIzhq/jZacmK4v6qRBQijH8KX14fbOT
        LKE6adJdgfSOLmtzY78diDGZqw==
X-Google-Smtp-Source: ABdhPJya7U6hVZDAjZ+ax9dByFlu3r9yg2zEyUBh1aPQNPH2k97WxRmcycSS7ZcII3srDamlT2vXXg==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr7363008pjb.52.1594169856228;
        Tue, 07 Jul 2020 17:57:36 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id d7sm23169385pfh.78.2020.07.07.17.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 17:57:35 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com> <pull.781.v11.git.git.1594106024078.gitgitgadget@gmail.com> <20200707153155.GC7003@danh.dev>
In-Reply-To: <20200707153155.GC7003@danh.dev>
Subject: RE: [PATCH v11] Support auto-merge for meld to follow the vim-diff behavior
Date:   Wed, 8 Jul 2020 08:57:31 +0800
Message-ID: <015101d654c2$c43032d0$4c909870$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI7+pCTk4TEt2d4mNGrW0NZuQhhtgHCWhx1AdfsxfyoFLyyMA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Doah,

>`$meld_path` should be quoted.
>...
Yes, you're totally right, I'll fix the `$meld_path` and more changes =
will upload with the [PATCH v12].
I'll update to you when the patch is ready.=20

Regards
Lin

