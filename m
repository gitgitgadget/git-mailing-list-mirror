Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9640C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbiDFQ4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiDFQzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 12:55:42 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561043479AE
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 07:19:55 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e1dcc0a327so3064215fac.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=FCnBIc8mjyXQJkW0rtcJF9iahFaPz++4+L7iX+VD1MQ=;
        b=DIRw6UlpxWWm7QH38xjiFSDetb7zWr9wAQr0V+67Oo+zmLmZ2ORj1zs9WPdLne1rRF
         HUd21f2l++LZEuB5RSZ+H3G9e39pcaBQ+xYpayjN+YFVhGdRGsYN+W6VmKSS9NaR9hfV
         Bx/DtAcjTNegPcqVF9HAXlQ/E0RBeZMJWEUJ3OwcyvrmoUo/5mXeHQqqvoj35e0MqSlw
         WNSywA40P9TS1k4nu2IPTubkmXDUAbEAiTSNU2z30SzEgGx3ADoHgRJfuLfztpbMpbZ1
         H7Q99SDDeD2WkTfXYNwG7a7wt4OaQ/lejQKru60ITNvHSxvSBAm+7C/tRE4vt2RSgnAT
         hHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FCnBIc8mjyXQJkW0rtcJF9iahFaPz++4+L7iX+VD1MQ=;
        b=6FHL1Drv3WiO1JXIIdDnOAGaKMpC3ru8o04KDOwPVubjn3ncqp9L1b0vmAlJEM3g7R
         k5etJlDoD1A/CIgEcxo5bYaCIDiafWnsmXyMOq+mfEBinMoWkzerd9Opf8keZSuUOXK5
         mUpkstYl772ejca1nIJYMmCUCY1+KLCq/AzUL8UWDRyelamS6Gx2JsnHhbtA2frIN0bM
         z/fjolsGjbMusSbOJPs8bWEdddcaR2lzaiZ300KuzK7Dws4Rkux/o7S7y9PnU96MrNfx
         cZ2ZzXfJf2nFWnqJK4D2cFggE1lSNlUm15++PTYV7kKWc72lxCxdrKVBrbp98/m+8ibP
         IIXQ==
X-Gm-Message-State: AOAM531lRcpaIUhQfI+7pdmUHq8vb11aV63Segx4lKUP8yyp8i1dotsJ
        +dTF0WA3caXjKU5uOR7M/UZcmUsb9bNfP0SPLRjAqLis2OoGJuR7
X-Google-Smtp-Source: ABdhPJyZx+dCXzx09LoT4t8nuZfFuD6HJ2PsQ8vmVrzkr6GjbetFFn0y96sYLzovQ6Il1wOtDkbdCwIn7FKwb4fNvVA=
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id
 ej19-20020a056870f71300b000d28adbaaebmr4067978oab.111.1649254794643; Wed, 06
 Apr 2022 07:19:54 -0700 (PDT)
MIME-Version: 1.0
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 6 Apr 2022 22:19:43 +0800
Message-ID: <CAJyCBOSAekywgzVSf1uGb8s+hY7a7A=0fC5kFhMVpiqS1KEw4w@mail.gmail.com>
Subject: How to get git-send-email use a proxy?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings, Git community,

I'm using git-send-email with Git 2.35.1 under system
5.4.72-microsoft-standard-WSL2, x86_64 GNU/Linux.

I am on a system-wide socks5 proxy. Although I set the global
.gitconfig to use the socks5 proxy trying to send emails, the
connection to the SMTP server seems does not go through the proxy at
all.

Other git commands do go through the globally set .gitconfig proxy,
git-send-email seems to be an exception.

So I'm wondering if there needs to be a code change in
'git-send-email.perl' to run the connection through a proxy, or I just
need to tune the setting to accomplish this?

-- 
Thanks & Regards,
Shaoxuan
