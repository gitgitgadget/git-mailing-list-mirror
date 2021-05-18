Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2CEC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3136611CC
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhERDYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhERDX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:23:57 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B37C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:22:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so7454003otp.4
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0HbQTihE2SI7NMN2L7lytOt5rq4zVZykwPQ3y21wJ6k=;
        b=J2fpSElCv0Vwj6Y7JfkBDSF/Q4GcwRJmmyjP0xLg2PgCUcc8NEXfrzMSSFRQ4u4VE3
         DAmq5ujWqaZjqq5/6mzwX5+ENay/ZUzR6Rn+S65UFVYGYduesW5CT7H/9wS/StCL+VjZ
         Ouf34UUrh/GJ/rSHE/SSazcG2i8Zg0rvS5IUSUGi04x79RsNT/Js0a+esL4Ar+hQASaJ
         r/jhozo7YKuOENY5e4B4pI1S6pnkdmr4oOBk/o8oenjz+ifHIcKklbIDZlVxrXdg/kHI
         OMZ5m6uM6bdB/TPjoRwzSPNuE5qhGvMg+792MSZNXY4OEJwPlTE/Kx+fBI21A2mmSZ8k
         rahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0HbQTihE2SI7NMN2L7lytOt5rq4zVZykwPQ3y21wJ6k=;
        b=kl4vEpRHlI8cR3f01DWbxnoSHzm3W2iAxioYLqT9diomqoJdUNmDPi0RZfnZXi1op7
         13nT3xPo7KWSL825J4rfhssgaumpNias51AV2iwDoEitPe/7X+MJ7Cwu6irYWU4F3fu+
         dX3yzwxyQudLLhkrROm4menGsIhx3zxeLpDjlN7MQgmyiG3rredlm4xsX7yr0yZlmCGh
         71glrkdCqt4NB6uE/bqoMw8BtolwBnLuxe0eqWNJUie3ZvHlCQrNPzU7bP0GxbZ8oDlJ
         vDWZJ2cF3jPenZrga8d+GVCBS7Es6Oyz9jx3lpPiFrTPJtCsvVfUfK+cs4J9FTQTWPcs
         zdSA==
X-Gm-Message-State: AOAM5339WkR4QFEj98nGYo7DQMw0WlnV/AHy8OHGcmt7sEPH/G2pHIt8
        ANf+wh7pYDF96JW6zrHbvlQ=
X-Google-Smtp-Source: ABdhPJwA1n0RLDMNv1eQYvYxvgg80kBcHm5RIlXZzGcyMAw5StavTuXZs23Wixf+liu/qPPXDawSwA==
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr2372264ots.218.1621308159084;
        Mon, 17 May 2021 20:22:39 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v1sm1938479ott.62.2021.05.17.20.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:22:38 -0700 (PDT)
Date:   Mon, 17 May 2021 22:22:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a332fd22dad_14c8d4208ed@natae.notmuch>
In-Reply-To: <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-18 at 01:01:21, Felipe Contreras wrote:
> > Our man pages don't contain many useful colors (just blue links),
> > moreover, many people have groff SGR disabled, so they don't see any
> > colors with man pages.
> > 
> > We can set LESS_TERMCAP variables to render bold and underlined text
> > with colors in the pager; a common trick[1].
> > 
> > Bold is rendered as red, underlined as blue, and standout (messages and
> > highlighted search) as inverse magenta.
> > 
> > This only works when the pager is less, and the color.pager
> > configuration is enabled, as well as color.ui.
> 
> I think we should let the user decide whether they want to set this
> feature themselves instead of setting it for them.  For example, I have
> specific colors set up with these environment variables, and I'd like
> Git to honor them without having to configure Git independently of less.
> I expect other users will expect Git's rendering of the manual pages to
> work like other instances of man(1) on their system as well.

It does respect them.

This would render the man page with the color specified in the
environment, not the default of git.

  LESS_TERMCAP_md=$'\e[1;33m' LESS_TERMCAP_me=$'\e[m' git help git

> Additionally, using colors poses accessibility problems.  I know someone
> who, due to his colorblindness, finds terminal colors distracting and
> hard to read, and prefers not to use them at all.

  git -c color.ui=never help git

> Even users who want to use them might find some colors to be too
> similar, and this patch doesn't permit them to be configured.

Yes it does:

  LESS_TERMCAP_md=$'\e[01;38;5;33m' git help git

> In my particular case, despite having normal color vision, because I use
> a transparent terminal which often results in a grey background, I find
> the standard terminal red to be difficult to read, and so this patch
> would result in a significant decrease in the readability of the manual
> pages for me.

If you have LESS_TERMCAP_md set in your environment, it won't.

-- 
Felipe Contreras
