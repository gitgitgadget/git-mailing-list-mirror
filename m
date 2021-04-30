Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3240CC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016BE613B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhD3Q03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhD3Q03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 12:26:29 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18016C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 09:25:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id z20-20020a0568301294b02902a52ecbaf18so12545631otp.8
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYlfwh5u5nDcb6qwjrvAgOe0QFR4JK/4rDoHgmGNvKA=;
        b=RuujnDEe+gOalbhZkH6HcYXGfl1VYlslKTagbOqicBlRjMAdH839O6tXK4yBJBCe1a
         qnT7m4mFuJOV/LDNKUKeji0WIGRhJt3f4UY6T/9D4GM/M1nzBOgGFDqEt8vtJ279EbuC
         PND9/UpK1LswRg2lrUSCvowsXLAOWQPnFUpnaZsm12ZeIRAyfWv47vBG4XjlMIZMWKcq
         hiuLwlu7B9yaw/wxUheXF1Bkl+nkBMTqXawPC848LNPwEUfhm5Qr2IIxDRlZ0QPUrj2J
         Hntm3R/dDbFkQZCcd5eCXd+pDErS18Htd1+e7tUNIljbwqXLgMBF6gxQr/QMHiO4YM0E
         NrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYlfwh5u5nDcb6qwjrvAgOe0QFR4JK/4rDoHgmGNvKA=;
        b=Vmhv1EBOX2T6XnEwRyI0+kCRrZOU4KOjgfRnL57ilqWAWAEZroOPwGsCHDDajRJUcE
         HG26Cwyb1joXaKfw3bhwuKJ+dM8ICZXJfc/vFpmcZ61fp24v5ov5JSHxpejs4S2zkrpD
         yGs46LjXszkZTpPgKr7TZQm9ZwL6Kt6PdEehuNDHWkGYTV5mzbiIL0c8vKkL5jpYWPQn
         FoYMDWJpHuLkQIPpGE0pC1LtKX53r6juatW3Y7WwcwEYJqjkjmo05H7mKVvGwfML5Rg5
         T07EEFIKm9C0E9pq8mFLjSOdLh6v0W5WTEOtTFwMITce48ZiLlmC+dqYB1ur+M35peBG
         arsA==
X-Gm-Message-State: AOAM530sZFNoqnVYTNsZEzLZgNB8djceq+d6xtEjlyTBIqeYwQ3HjFSc
        HoLV5Qgeuf6PlVS21K6a2cprCbHHHaH+f0E57He2OXv/isc=
X-Google-Smtp-Source: ABdhPJwtqlUSDx2m6P/jljTG9oQU2P282Z07cy8QbstADVE2LZYeXDCniMyYSbq4cHL7FHKXD65AGKQInqdsZdMIEbM=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr4303403otf.316.1619799940497;
 Fri, 30 Apr 2021 09:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com>
In-Reply-To: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Apr 2021 09:25:29 -0700
Message-ID: <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com>
Subject: Re: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 7:58 AM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> From ba4beb8ed0dff67ae6b95692d346adce346e2871 Mon Sep 17 00:00:00 2001
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> Date: Fri, 30 Apr 2021 09:56:09 -0400
> Subject: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
>
> This enhancement allows the NonStop SSH subsystem to be supported by
> git without the need of a wrapper script. The command arguments for
> the platform SSH client in /G/system/zssh/sshoss are constructed based
> on optional supplied environment variables SSH2_PROCESS_NAME (system
> defined), SSH_SUPPRESS_QUIET, and SSH_SUPPRESS_BANNER.

Before introducing 3 new special environment variables, I think this
commit message should explain why you can't just use

GIT_SSH_COMMAND="/G/system/zssh/sshoss -Z -Q -S"

particularly since GIT_SSH_COMMAND was introduced specifically so
people wouldn't have to create wrapper scripts to pass to GIT_SSH.
