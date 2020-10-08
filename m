Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D290C43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA39721531
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUjxyLIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgJHIUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJHIUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:20:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469DC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 01:20:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y7so1279960qvn.13
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhUz8PTZWTM+7gsEN1si4tfzl8ikFB0IdNzbzfPmxZs=;
        b=sUjxyLIs8hCorB46YSKujiSiBkwL4cQEUdDUMIvdOCOS1IC/Hbh7Q5OVMhrUv1OoAZ
         PUrek9Nq8gMV0uZDxxVxOuAfWPMJXOf4mzVFzpG48yBhxTdBEmuB1bm2u/KCTyakcrvN
         iTmVo5Z+/aXRUNjf/HAr78EJZD661ha8MKdOY9OpwQWYXo0NrzZOVo2Ct82YC88EMAPd
         hgfgq20Oze9pZ0zP62RrpSdRVSf1/53YMlT+/pSyrjn+8PDCyyy0Xkl23RLth01IurAM
         /Dr48s5Hp2035g+5o1HgYDH4YMoWjNmRGFpb2K0T/pt0h7fFVw7Ufr2BqE8Cvcjsoutx
         Mdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhUz8PTZWTM+7gsEN1si4tfzl8ikFB0IdNzbzfPmxZs=;
        b=FdvCufyP/YxrY1/SN3KYhcFx/9//uRFuphz/7sk/3AqdpRDuqwAJbOS86Dr5e4Shyk
         DbdSso8hnOSYUWZSi8Yq3cY+lMYXZgUr9OO9UenWMap5v9YYb/UdFOFTcjPUk72O0YGy
         5qi8yUXPX/cUyXw55OXweC8mlHII4ulA12DderM3CwKhdTnvXZb/ceDU4GRHaKnwcmiE
         5Er1bQmblU5doJcpjz4CO7AypSsQgrbj0UVxkoyxUVX1Bg62EaGEBHVJNWfl+pMY5g7v
         renoTMQOI19BSUogvr/NyBb8KCkJT2pIfLRq79M2rTMClLfkqPwd5BKj6GJ39k9UZQQ7
         qgHQ==
X-Gm-Message-State: AOAM533bdtSauzjLIhWYofe/C02eTzGNx2PGojluHlWYdx/eR4xwP83r
        TaPKh1fs2BuyJc8qf9MStgI=
X-Google-Smtp-Source: ABdhPJwrRZjLbUeoWxMvt1RAwmR9Sarq3GY4BMcu9dpHYspX8Ymux2ksQDqkOMaE+rNr4o4E9V2PtA==
X-Received: by 2002:ad4:5843:: with SMTP id de3mr7187275qvb.12.1602145231093;
        Thu, 08 Oct 2020 01:20:31 -0700 (PDT)
Received: from partizan.lan ([46.98.122.162])
        by smtp.gmail.com with ESMTPSA id d10sm3304722qkk.1.2020.10.08.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 01:20:29 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: Basic dark mode support
Date:   Thu,  8 Oct 2020 11:20:04 +0300
Message-Id: <20201008082004.5643-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007111333.iojf5dbwoxbnie3z@yadavpratyush.com>
References: <20201007111333.iojf5dbwoxbnie3z@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> How do you tell git-gui which theme to use? I had some trouble setting 
> the theme and ended up adding code to source the theme files and then 
> set the theme via `ttk::style theme use`. I hope there is a better way 
> than that.

Yes, there is. To change theme on the fly use:

    echo '*TkTheme: clam' | xrdb -merge -

To set theme, add "*TkTheme: clam" to ~/.Xresources and run

    xrdb -merge ~/.Xresources

There is lack of dark themes in default tk installs right now,
i'm using awdark: https://sourceforge.net/projects/tcl-awthemes/

To install theme you need to unpack it somewhere like ~/.local/share/tk-themes/awthemes
And tell tcl where to find it.

    export TCLLIBPATH=$HOME/.local/share/tk-themes

I had to modify version numbers inside awthemes package to make in work,
but hope it'll be fixed upstream.

Here is blog post which explains this in greater detail:
http://blog.serindu.com/2019/03/07/applying-tk-themes-to-git-gui/

--
Regards,
Serg Tereshchenko
