Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C8C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6830A20848
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 17:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwzDk9kL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbgCaRN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:13:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35143 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaRN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 13:13:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id t25so19596114oij.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7hW84VoP+elEeMZALf3M5a1Msrmz1A+rWW+ZAONQsp8=;
        b=KwzDk9kLtT6a9I22zPq06AwkOwZBez2vJhgX+u8gmrxBpj5eLfGsOifbZhYHjW92+O
         lM47fKNuqs8pfNw3/DajzjFVphHeGReQmQr79yZigHaXBuQFZ7YMh8dILHDM8WHCC4Qc
         XnuydnF4Pt6GQdHgkGWvRqXLNEqRpe9QA5ejbx9lashoNp2CSCSAOtmmIcn1NQGyG0fC
         BpK7/UC4Tjkinhkk5Iapj60evx6TXo9T+9SO1MJ5NDnXNNiHGNc/IOny79yYcvJq+cG7
         aMiCrgW6GyyyyjX0yAKba3jRq/DJ08EP6v46a7Z9y2vcIAU3u7hxESHU7g6GRjGo32Ib
         TEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7hW84VoP+elEeMZALf3M5a1Msrmz1A+rWW+ZAONQsp8=;
        b=tYOT8L8gDVgcO5qUveuIWgcPFon0UjB0pfgIco0M+9gMPDRd9NvvjeAm/iMOCVQzul
         P9ViOy9xsVxTPZXgu9Pso6fSLtiK4ndFwoF9XQPXXBsNUY5Vcruq4foD3TJFiSeeZ3J6
         VfCANHNWmODdcIiGRlE5E3FfUcaOxDV7OpxHVnsMydqda4/pH4F+dvnR0HYAcRY3dicp
         Gws7CsMlwzvVaWRA7kuX/Bz1Ghp8GA00VRMjWKXtSh5V/63cNfYOa9pwcX6b/J+jzvd2
         yV7yekr/K3BTikjxP4YjxrfCLPXaq2gIY+KiQKgVoAyf3ppJP43L7NfyWPv52uKNBfpv
         fe6w==
X-Gm-Message-State: ANhLgQ3lml7IOO9yfVwtB3HAw8A9U+b0Vglqms91XkVJ5EWPTAMagVMf
        gHK0fRz6Ggo5sS3im1fabkM73uck31HS23oQ9QaeQg==
X-Google-Smtp-Source: ADFU+vuwoDcejf61kef8ZhDuzb8uUDZD8/rd8LkktQkpUcItwjstLfQuOlIe14sAocTt9yZWHOkHdconNcAm3NFEDE4=
X-Received: by 2002:aca:de42:: with SMTP id v63mr2641841oig.99.1585674806510;
 Tue, 31 Mar 2020 10:13:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d844:0:0:0:0:0 with HTTP; Tue, 31 Mar 2020 10:13:25
 -0700 (PDT)
From:   Josep Torra <n770galaxy@gmail.com>
Date:   Tue, 31 Mar 2020 19:13:25 +0200
Message-ID: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
Subject: Possible regression in git 2.26.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today I'd noticed a failure in some custom automation that seems to
came as a side effect after of a git client update.

The issue issue I'd spotted is the following:

$ git clone git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic
linux/bionic
Cloning into 'linux/bionic'...
fatal: remote error: Parameters must have values

Reverting to git 2.17.1 didn't show the issue.

I'd asked at #git in freenode and @rafasc was able to reproduce and
bisect, pointing to

https://github.com/git/git/commit/684ceae32dae726c6a5c693b257b156926aba8b7

For the time being I'd added `-c protocol.version=0` as a temporary workaround.

Is this a regression?

Thanks for looking into this.

Josep Torra
