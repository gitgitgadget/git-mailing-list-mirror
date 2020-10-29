Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8892C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB002076E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEWE+5dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgJ2X2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2X2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 19:28:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C2C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 16:28:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c16so1373136wmd.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6s2677vlL33x6Swom29Dkb5CfxRrGzn/bVBPqcy2xc=;
        b=TEWE+5drXx6AlJ1BxU1e1pUbjXPhaJfjS41ullKY4VVu63WllQIXJwlDvIy0LKZNB3
         To0LfelSbaEyPD9sSgncCs8Xw/Y8UUPwBg/IlFuju3xbY6Evy4cjRH8WPZEk0VgpmqEe
         RsZfgcOS69wPH5BNa0dNYZ0EUrWwM6U4zHIMP1Hx60aVJEXYiOibcMYHzaWzQcDN+8AW
         bVcXGXzOzpAbWiYZ6lYK54H1x758Vs4EioUIl3G/aWnNmfsJEQdbt4r+3CMuK2WFfEhw
         9Ylc1cwf0yiKg6VvVGsulrOxXVmAhzg79BWilD8+PvfyACLQaRDxtNrMeZM9Izclpcpe
         wOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6s2677vlL33x6Swom29Dkb5CfxRrGzn/bVBPqcy2xc=;
        b=TGJpfs+1P85DOxCPu6yGSgKo3EaukQQwD1atzzNz43M1/1FVuY7feMGzHux8O1HmOP
         femeVUrJcP/9KOPAm+P2kGIrvW6aSDMdTODoo7Mb6gTUQ1709uIzurAdG91/fWt+QcDF
         DOrC7QHja+vX4b1lHqiEgoYkpNfmtvT2+UxNbAZrv+0MRo4nFfgSq/Z6n8nmnPDJH+wB
         6gG1dncsDWp6BbkautC7mbi+flrHKM3byk0VdND1pphocx0U/iHClpAz1wvnCQAFzZnM
         i9jeQ7drbBywcVPfaG9beOXjnveIKYh8sUxUkTVUIlAq7pq0a0dXUjNnhN0c4kg3PmgA
         YElw==
X-Gm-Message-State: AOAM533fpl8RMAnRHfTsUC8Rn/GdaVxUEgRVIgKb3f+MuGzc7uE0roYx
        CF7AqdMQWf9j8zfx6P1EI/YTYbRdRNfOqw==
X-Google-Smtp-Source: ABdhPJyYcuCu0NeUuFY9ac3AXhbsmX1mdfhzSKm2kwFxgZet6Dk3vEy3uNLSlHw7cnm/m9fpa42T3Q==
X-Received: by 2002:a1c:4c04:: with SMTP id z4mr1358848wmf.2.1604014101824;
        Thu, 29 Oct 2020 16:28:21 -0700 (PDT)
Received: from partizan.lan ([46.98.123.221])
        by smtp.gmail.com with ESMTPSA id x10sm7389337wrp.62.2020.10.29.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 16:28:20 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     marcnarc@xiplink.com
Cc:     git@vger.kernel.org, Serg Tereshchenko <serg.partizan@gmail.com>
Subject: RE: git-gui: Why are the main panels no longer white?
Date:   Fri, 30 Oct 2020 01:28:16 +0200
Message-Id: <20201029232816.68285-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <b85e0713-81d6-fcf2-6292-1b5acf86650a@xiplink.com>
References: <b85e0713-81d6-fcf2-6292-1b5acf86650a@xiplink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 11:58 PM Marc Branchaud <marcnarc@xiplink.com> wrote:
> > I will check it on kubuntu later.
> >
> > Can you show your `xrdb -query`?
>
> *Box.background:        #d6d2d0
> *Box.foreground:        #221f1e
> ...

This massive list of options could be the problem.

> Thanks.  Seems to be /usr/share/tcltk/tk8.6/ttk on my box.
> Nothing in that directory sets that greyish color (#d6d2d0).

But many options in `xrdb -query` is setting that color, and this is the reason.
And that's exactly some KDE-theming-TK-apps thing.

I tried to install Kubuntu 10.04, and in gnome-boxes it could not
configure the network.
Luckily 18.04 has the same big list of options in `xrdb -query` and I
was able to reproduce the issue.

I traced source of the problem:

> *background:    #d6d2d0

But if you change this, many backgrounds change color.

Now we need to find right *something*background to set that panel
colors. I'll continue search tomorrow.

--
Regards,
Serg Tereshchenko
