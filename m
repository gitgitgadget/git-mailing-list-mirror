Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F1C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 20:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D84611BD
	for <git@archiver.kernel.org>; Tue, 18 May 2021 20:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352276AbhERUzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 16:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhERUy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 16:54:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20AAC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 13:53:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso9893121ote.1
        for <git@vger.kernel.org>; Tue, 18 May 2021 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nrJO7k3tl3wyK1W4y8xaGKBnTA1taCoquwLoX9PDJnE=;
        b=q0zUhn/2kT3yfM3pOQtYeBbcA1IU5rpscbZyx4mjHtPpafqMcmR3cWDAheyO4H/Pf1
         CRwRalKvtjzxHHLtUmCm3c2f+YRptp3L0sGvW7/cHQ0wpU5Md+M+O8oV7hXbdTG8WMg3
         ERqrRvN4yD+B23XhmoWuCWvAO/sBbbHmiSZqurWpAIqfENqyTv0YJL3PRqUD65o0fmWm
         NANQV1PkZPQtH3A2Vc3OnncpXqy6uDU3rQgNllBFNFIAvs1+BtXAhJUI0DcHbNj59C/T
         wp8b6INdC2RSRMNJGSIoMEOE5mVhqmHS/ZaEceqQqq7mbIJQptCW8Qnecj3M1i+tXp15
         9EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nrJO7k3tl3wyK1W4y8xaGKBnTA1taCoquwLoX9PDJnE=;
        b=f265cp3///b+RVP7jA7BaEUGXH16jL4JhHUZvIayiV9/ZKY9+wzrAtbxMsqJcmrEDS
         kRHgGkoVJFV5vG/QWJameCp7Q5GyVyptqUMgH3cdVpPa2qYlGsq22kJSFVkU30rwId/Z
         2Ifpx59vCVJf3Q+VtD0K4YhnguyQWN0P1RaUSTw6IcsURy68FINclSBoBWidMspy18CN
         ieBrgBKeGTxONn/lBd/1M4KEdnaTdoUi26pZush/rrI9b8sYCaiOOdj9w7g4pNQxYmtC
         n0hVWkaCgbwaEB+zss0V9pJ/WpHaSEboYu2iFV9S7dRZNT4cp12DDWiJjesM8SHq9e4V
         Os4g==
X-Gm-Message-State: AOAM53322N5z2hAYesQ7s5wgy0lhFtAbmiBsWFalV8IXhbXc25Mbqwx+
        cWJCdwqiM/QXFZsTwY9nTJI=
X-Google-Smtp-Source: ABdhPJyoh2SJITDlEPmrg8pSJuW3Ur5ewa6tGE5/Em6pBcv0k7lvTXckc+udu689xrOR2cNq3zzHXg==
X-Received: by 2002:a9d:2271:: with SMTP id o104mr5709801ota.201.1621371220156;
        Tue, 18 May 2021 13:53:40 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id e11sm4000363ook.20.2021.05.18.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:53:39 -0700 (PDT)
Date:   Tue, 18 May 2021 15:53:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a429526d3f7_2c1020870@natae.notmuch>
In-Reply-To: <xmqqa6os2j05.fsf@gitster.g>
References: <20210518132056.2003135-1-felipe.contreras@gmail.com>
 <xmqqa6os2j05.fsf@gitster.g>
Subject: Re: [PATCH v2] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> This seems very specific to use of "less" and hopefully does not do
> anything (bad) when a different pager is used by "man".
> 
>  - Would it help readers to somehow tell that color.man does not
>    apply at all to those whose "man" does not "less" in the
>    documentation?

Indeed it would. Done.

>  - What does it mean to set this variable to "always"?  For commands
>    that we control how the various pieces of output are colored (or
>    not), e.g.
> 
>    $ git -c color.ui=always log -1 -p >git-log-output.txt
> 
>    it is obvious what "always" means, but given the implementation
>    that tweaks how "less" should behave, a similar command (below)
>    would not colorize its output like the "git log" example above
>    does, would it?
> 
>    $ git -c color.man=always help -m git >git-help-text.txt
> 
> I am just wondering if we are better off not to mention "always" in
> the documentation patch above.  It seems more like that the
> configuration variable is to answer this question and nothing else:
> 
>     when 'git help' shows manual pages and internally uses 'less' as
>     its pager, do we tell it to colorize the output?
> 
> for which sensible answers are 'true' or 'false'.  For that matter,
> it is not clear what "auto" ought to mean, either.

True. The user most likely is not going to run 'git help $x > output'.

Initially I was making color.man a boolean, but stopped when I found
color.pager. Since Jeff said to use want_color() in the same way all the
other color.* configurations, I forgot, and used a colorbool.

I've returned back to a bool, and updated the documentation.

color.ui=auto is still respected (if stdout is a tty color is disabled),
but it doesn't really matter because less seems to be smart and disable
color anyway.

v3 sent.

Cheers.

-- 
Felipe Contreras
