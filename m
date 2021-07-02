Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63632C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3524B6140E
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhGBWTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhGBWTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:19:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D2C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 15:16:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t3so13059763oic.5
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bpAQeS82liTDLr/WO+sxPIAFpBu9izF/dP/MG/q1ipk=;
        b=b3VwFcW1Hbk3agK/5U9GW790D6s+tjoodcAot0+K0wSgVmzs622M5nDRedoEh519oq
         /0zEC5bKSXWS8YPFXQrRCe8cPdnofZwo1B9UKW3pMDy5pX9gVilNYoOUj7GLt6YXZ014
         Um6KGio0gZSgaDvStOFb88wwYsGTE1b4TUb7LzlVggy3gOeAd4oyUSBzy4UDB87K9nxe
         vQ0TOQgf595JfwjaVS13o3K45coZikseSvS/HUqRSmhzDScNskc3OAwhdH5MQJ7zLiA6
         gU7Qm471S4UIb0AWljfqVm3cPPN6Sw7eEqfoXHmbQxkMRJg21vD5dIebyTlpaZjNAQTO
         sJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bpAQeS82liTDLr/WO+sxPIAFpBu9izF/dP/MG/q1ipk=;
        b=il7JsAbceIjlw7r+TznTnyUI1Rbqx2wCn2jmyqPGnihN7bPzVjDGE/eq6GbpMc7dq5
         SHmc2d+dz9KoH4fe70PWaodBXPw8Bylqlo8HFMX7BbOJTG5vn6a8GEwSB9xzU4IemmZf
         ylhsuQ/YWkUy1k7otneJ/NDyRbdzSDBVNmjqLyDnSiBjOElsxcbxA3LF0/h9I2/tIXew
         nTPPlq8NzMGd9kqWQAgkhJn8VK6JRz5YWI0D85x0gGP4unjghMu49UDdCDNcM5Gvoopm
         1WRJklWCcbWO8qLg5Thg59qi2ogjSvI9CgPn7kinnxGFlvVABgx4t/PoKAyTaScFjn6s
         Ew7g==
X-Gm-Message-State: AOAM530ZOB4xeONY6l5hfx8WiPFz1h2cuh82gjZd3HNuyMyK5FfCUlN2
        +djn7wQDbsTydNflkWMXgMI=
X-Google-Smtp-Source: ABdhPJwDbGajlxOKiuIc17LClybE1/slf51NRf2Aj9WvK7VVDNfcjwWdZxZX3+YpsTLw+y/Ld/kZOQ==
X-Received: by 2002:a05:6808:6cf:: with SMTP id m15mr1505995oih.39.1625264199429;
        Fri, 02 Jul 2021 15:16:39 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id f138sm987113oig.21.2021.07.02.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:16:38 -0700 (PDT)
Date:   Fri, 02 Jul 2021 17:16:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     martin <test2@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60df9045d0825_28bb208eb@natae.notmuch>
In-Reply-To: <74124ed2-2905-a167-90b6-9b289521ea83@mfriebe.de>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
 <60df7ee3128d6_28bb2086c@natae.notmuch>
 <74124ed2-2905-a167-90b6-9b289521ea83@mfriebe.de>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

martin wrote:
> On 02/07/2021 23:02, Felipe Contreras wrote:
> >
> >> If I was a committer on this project, I would have to be much more
> >> convinced that there is long-term value in this series than appears on
> >> the surface.
> >   1. It doesn't affect anyone negatively
> >   2. You don't have to use them if you don't want to
> >   3. They don't affect your aliases, even if they have the same name
> >   4. Everyone has aliases
> >   5. Every SCM in history has had aliases
> >
> > What more would you need?
> >
> 
> Well, it might be good if they were configurable.

What value does that provide?

> That way no one is forced to anything, but they are easy to enable, and 
> self advertising.

If the default aliases were part of the git version you are using right
now I bet you wouldn't even notice.

-- 
Felipe Contreras
