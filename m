Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F02C00A5A
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 08:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjASIEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 03:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASIEn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 03:04:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224D460A9
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 00:04:38 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jl3so1596424plb.8
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 00:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4C29TzLLQbBTKae/Wrs0J81SHefcBaQqB5hCj9HwY0=;
        b=CgGSahhMSYm6GGCs2MfPjXCfoTDJCnVhz8QcxtiCgshbfUx1k0mzxxUAdFAeWQZodm
         zpkoZ+VpW6iRgs+z46xFe/0yBzLKvrzXto0Pu/6MuFipstXZ4u36fnaP7+Vu1hkB+mQZ
         ceRrFb1UXBmu8r8sEZcVBzxPJDlSIakoNZr+mNPNwKwOlZ4a0k+V2QhqUIEIMoSVfPjr
         jmuqb+AysHitL7AGLf3d7g2OpJGtaW9KKtAbGoAmw2SPH7QWe4C+Z7nq51BvWb0EXPnE
         JjevBDy9pFoROJLt/5XOvo67dGmebW2LwmfWzRSDe2wcE0DY+Y+5StpnvzIQGJ8zlJVa
         o4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4C29TzLLQbBTKae/Wrs0J81SHefcBaQqB5hCj9HwY0=;
        b=kZ1i3xoRMRDykL4hfGfCQTfgfpnXI6pi/6STyILUDoVV+h5/Ph59Xe1W3UWUu90lQy
         GMo4dOQNvWAQ7oi+gcgVxQSKxeUccxqGoKU91iOS8Y1srGcuL+nTrTf4tpWcotdOgMgk
         YZo1kRy1kta24uWd3lUCp3DAbYG2BXL/TxQHG17NzdZ22LFP/k+tomG8MjacMgh8gT5t
         bBMsOwMUzLbzHiNU9vjFY+VKEDcUqc1S/UXXOnmZNZVqOuifdvyb0SfY09g5B6iu7n1y
         cjTA+a+oc1bclBq4xa285zWtayBXe1w6JgIC/J/UeRim1JyNpKI8hT40a3icMUElt0Ez
         o2OA==
X-Gm-Message-State: AFqh2koBCu5PHeAVlwOUrxSLZfeE10jzc7x5f8xwvIgPCm0juCRC8cRr
        UFU6TF/tk+5iy12HTUFYaUvWDiDEd9b/mya6DgIC05f4Bkm2pg==
X-Google-Smtp-Source: AMrXdXsFjOcqtNb40mxTBmSsMUs6kOycGUbzWT1ohdeubs9OIzm0cAtavgM49huW3mB09InrKA8le4I1gMzuENeKA+Q=
X-Received: by 2002:a17:90a:4dcd:b0:21a:1a66:cd91 with SMTP id
 r13-20020a17090a4dcd00b0021a1a66cd91mr962174pjl.190.1674115477557; Thu, 19
 Jan 2023 00:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20230118082749.1252459-1-martin.agren@gmail.com> <xmqqzgaf4xrf.fsf@gitster.g>
In-Reply-To: <xmqqzgaf4xrf.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 19 Jan 2023 09:04:26 +0100
Message-ID: <CAN0heSokODyuYUEgaU8Ym_Evvmdp_y1-V0LxbsTECgm3sP9d-g@mail.gmail.com>
Subject: Re: [PATCH] git-cat-file.txt: fix list continuations rendering literally
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Jan 2023 at 17:23, Junio C Hamano <gitster@pobox.com> wrote:
>
> Are you comparing both roff output and html output, by the way?

Yes, I'm trying to make sure all four of

  {asciidoc, asciidoctor} x {man, html}

agree and look good. For the manpages, I use our doc-diff script. (In
this case, I wanted an empty asciidoc diff (HEAD^ HEAD) and a good
Asciidoctor diff (s/+//-ish).) For the html, it's a bit more manual
labour, switching between files in a browser and convincing myself
everything is good, visually.

Luckily, once both tools agree on the manpages and they look good, in my
experience, the html is probably also ok.

Martin
