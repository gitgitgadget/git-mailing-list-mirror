Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB573C4332F
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 06:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiDXGus convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 24 Apr 2022 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiDXGur (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 02:50:47 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861DF5F8E3
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:47:48 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d15so5711369plh.2
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NgKtFVpQ0Fe5tlKFlmoJrgX8Xb6NXWcmuH7Rgy2Z7QY=;
        b=v7Ew7yRTNHlV2B1vZlh2HUEKDodFS8qhQZr3zB6wcqvmxmp0b9+xPfR1nlwdWi7Tyj
         NiPv18dc82/rl2OY5hmqSwrDYlry2hDNIds3VjRLKo3F/cy8XrmAk3S2ovwDIudoWkLN
         keeiZHLJY3cpgG6eVjxjyyPaxwdYUT+CeCZJ8QLrrve4ExNK8GLkMp0g4OW75FYLBwbK
         ipLyPYtJeUvZkMDvFHhva5u1RQcrmzdVP4k8jrknR/ebVDczn4Qh0EHAluJ1MkZCkLM+
         V1uEUvbZ+x7tO8bkg64DDQs6pkb3lc++hpi4VEVPrRr1UihaIgq8OIS/eCQ3DPQaZmid
         3PYg==
X-Gm-Message-State: AOAM531Ec+rqpgA9xHIGv0HyEIKKlQPqnWiCIeI+iveTiZ1ZQfiEE6U5
        wCRyrzQyIdGOiYZaqNkQqGIfNZ4mfXYusbthQU8=
X-Google-Smtp-Source: ABdhPJw1BxGsiiM6+U4DcsI34x3XPwJIiB7pO9yphaq9DcKMppz18s6fubrNf+DF0HacVslAbCrIpcWXhp9nSkcD12s=
X-Received: by 2002:a17:90b:3e82:b0:1d9:3195:f259 with SMTP id
 rj2-20020a17090b3e8200b001d93195f259mr6312465pjb.150.1650782868036; Sat, 23
 Apr 2022 23:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220422013911.7646-1-carenas@gmail.com> <20220423142559.32507-1-carenas@gmail.com>
 <20220423142559.32507-4-carenas@gmail.com>
In-Reply-To: <20220423142559.32507-4-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Apr 2022 02:47:37 -0400
Message-ID: <CAPig+cTiNr2E56g-nUMYxK5Dj1YoQJPZUL7fW-iyA2R5DyursA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ci: reintroduce prevention from perforce being
 quarantined in macOS
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 10:26 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> 5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
> introduces this prevention for brew, but brew has been removed in a
> previous commit, so reintroduce an equivalent option to avoid a possible
> regression.
>
> This doesn't affect github actions (as configure now) and is therefore
> done silently to avoid any possible scary irrelevant messages.

s/configure/configured/

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> @@ -41,7 +41,8 @@ macos-latest)
>         (
>                 cd $HOME/bin
>                 wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz" &&
> -               tar -xf helix-core-server.tgz
> +               tar -xf helix-core-server.tgz &&
> +               sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
>         )
>         PATH="$PATH:${HOME}/bin"
>         export PATH

I don't see the point of the `|| true` since the code doesn't care
about the eventual outcome of the &&-chain. (The &&-chain itself makes
sense, though, to avoid executing commands pointlessly if an earlier
step failed.) May not be worth a reroll, though.
