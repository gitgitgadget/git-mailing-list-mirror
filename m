Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75BC4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 01:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17EE20753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 01:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZJaseat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgCVBwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 21:52:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45856 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgCVBwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 21:52:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id m15so5194037pgv.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 18:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+Fc9TiVRRFbQ/gDxwlUHXlhACXDBuS304L+81nPbwTw=;
        b=eZJaseatNFhdHJbmk4lyU6UeBS5HwIq2PNwQNgCXrWhryVJaZ1aWXhplJ+QPPBrZDv
         +RBRsdAQGB2MqW78Vp5bZalFdvbpNBNYAZugN2BkioCTncrkTgZ75aaPif7Bb48RWc/r
         sxGDTJMokkkyMQDM96c79HdzJuX2CZrF0dXxuJJLPMJIXghON8ffLJPPiWq45zFsyGRK
         LxChMJ6IHH0/GhRmCR4rABatXjwCwBKw2BYlKEWV12CBZ1oBThfvbGicQXoHdRzXsXIU
         xK82l/RmjZKd/I8i9RnDXKQhRW+s9FJmDpMVH8GwNkbRoiUpj4k5WTfHb8vjP8uaIy9l
         rS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+Fc9TiVRRFbQ/gDxwlUHXlhACXDBuS304L+81nPbwTw=;
        b=rW7pN0yZuCcP+mwcb0kz69162krFDwQ1UXzlRDrUePN3+YMuYgBZ+rVnZG6OeqrwV9
         bVazlDIiB5BaqZmOxwrG2+qgKjKW/3Mtktd++4VaE+5Z1TwcVTPjxmuC6BcFj61xuLOE
         cc5vf+3WANM1hK31a5kuZsbb8U6+6wBOVaPX/R3X30kuTPxjqgmcdWTCz0Zqk1wq2YpK
         gCNNXpjFFC6ayZqbFm0fTjsLY5XKH6hXtHZaY8rPz5bTulr2axZydxD4u7h2tYWgov+L
         ih0ehwXodg7tf4gGosneCYaAE8vZ99cQzcQXlY0Cww4e975aOlZt5ONZS4xewdZe6xQW
         Joaw==
X-Gm-Message-State: ANhLgQ2aI2mzhyocvFlu1HO77fmnfnH6i9ZLv3K0mV8kFJ1FyvMaT+Zq
        8CVnMeGG3AuZ7FRoPYWLBYyicyda
X-Google-Smtp-Source: ADFU+vsILxkKFSEhvAEG+MtJEQVEa/QVm/pevU4HtT2+SWEtPHvbKo8t00fXPRlnUrqMxgD5VkkPyA==
X-Received: by 2002:a63:f010:: with SMTP id k16mr15431776pgh.328.1584841956572;
        Sat, 21 Mar 2020 18:52:36 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id y9sm5132204pfo.135.2020.03.21.18.52.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 18:52:35 -0700 (PDT)
Date:   Sun, 22 Mar 2020 08:52:33 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] t4061: use POSIX compliance regex(7)
Message-ID: <20200322015233.GB11801@danh.dev>
References: <cover.1584838133.git.congdanhqx@gmail.com>
 <4830bd3aaf6cadc02c00732f8447646064a6ae3e.1584838133.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4830bd3aaf6cadc02c00732f8447646064a6ae3e.1584838133.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-22 07:55:10+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> BRE interprets `+` literally, and
> `\+` is undefined for POSIX BRE, from:
> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03_02
> 
> > The interpretation of an ordinary character preceded
> > by an unescaped <backslash> ( '\\' ) is undefined, except for:
> > - The characters ')', '(', '{', and '}'
> > - The digits 1 to 9 inclusive
> > - A character inside a bracket expression
> 
> This test is failing with busybox sed, the default sed of Alpine Linux
> 
> Fix it by using literal `+` instead.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>

Due to error in my part, please ignore the v2 with 6 patches.
It's the same with v1.

Please look into v2 with 8 patches instead.

Sorry for the noise.

-- 
Danh
