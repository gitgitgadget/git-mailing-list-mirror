Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDC0C433F5
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 06:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiDXGqc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 24 Apr 2022 02:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiDXGqa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 02:46:30 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF9522C8
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:43:27 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id t13so10794897pgn.8
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WuwefwcfDFYwXAOhnyWyxdmyQn0KdrjlPtw+T3cmT40=;
        b=3Z9Vjw2coCJ8ECwGTFByr7SvtsJ5e+iyAx+WgUEq7QKylR4yAGrDdHoOnxSLl1Nesx
         n/VqaSiGUlZk6KjOLYKm5tg12HW2sTFqJXd6UH4nH6aEiElnjWuhZvv0NBmP9u4cNtO5
         DqjFHLtZ1+Vn8NVp0U5tEFKMCTIEp8C1FJofKolLyyf5A+m9KnPdG5nHwhKFaSQEwvdR
         T4ZZbnzKo6dlTa0GMNlGc6JVZ0V0KZB3c/vjJZ2ezIXBBWvDqcx6c2vVMibhC1encTwk
         qb4Ds27TRGHVbsyCJoVl/W4w72YkNTUuYj3mTBjbmRtZX9129q8O0Er2EoAMMtJ8LsK6
         4GmA==
X-Gm-Message-State: AOAM533iiYoAn8+aamxKaG1z4FSpAsIocfLOWuNzogVZdIrHjx0MraW2
        2YZxB1nk3A8yLhYqvnUGg2M0e89vSYi5Kz5qGMbsVgWUuIj7Sw==
X-Google-Smtp-Source: ABdhPJxy7L69iIlB6i13Nbr82J1ZdItGBGa3wl9/BDxllmEfu7De222sntDQGPno/ktzvaWEkXKHkjEEWfrMo3TuGUA=
X-Received: by 2002:a05:6a00:23d2:b0:4fa:f262:719 with SMTP id
 g18-20020a056a0023d200b004faf2620719mr13164111pfc.4.1650782606801; Sat, 23
 Apr 2022 23:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220422013911.7646-1-carenas@gmail.com> <20220423142559.32507-1-carenas@gmail.com>
 <20220423142559.32507-3-carenas@gmail.com>
In-Reply-To: <20220423142559.32507-3-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Apr 2022 02:43:16 -0400
Message-ID: <CAPig+cSex1y=dFAfVBo+PuuwyF3GF4OJzK65ykSxVec3qQRhPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ci: avoid brew for installing perforce
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
> Perfoce's cask in brew is meant[1] to be used only by humans, so replace
> its use from the CI with a scripted binary download which is less likely
> to fail, as it is done in Linux.

s/Perfoce/Perforce/

> Kept the logic together so it will be less likely to break when moved
> around as on the fly code changes in this area are settled, at which
> point it will also feasable to ammend it to avoid some of the hardcoded
> values by using similar variables to the ones Linux does.

s/Kept/Keep/
s/also/also be/
s/feasable/feasible/
s/ammend/amend/

> In that same line, a POSIX sh syntax is used instead of the similar one
> used in Linux in preparation for an unrelated future change that might
> change the shell currently configured for it.
>
> This change reintroduces the risk that the installed binaries might not
> work because of being quarantined that was fixed with 5ed9fc3fc86 (ci:
> prevent `perforce` from being quarantined, 2020-02-27) but fixing that
> now was also punted for simplicity and since the affected cloud provider
> is scheduled to be retired with an on the fly change, but should be
> addressed if that other change is not integrated further.
>
> The discussion on the need to keep 2 radically different versions of
> the binaries to be tested with Linux vs macOS or how to upgrade to
> newer versions now that brew won't do that automatically for us has
> been punted for now as well.  On that line the now obsolete comment
> about it in lib.sh was originally being updated by this change but
> created conflicts as it is moved around by other on the fly changes,
> so will be addressed independently as well.
>
> [1] https://github.com/Homebrew/homebrew-cask/pull/122347#discussion_r856026584
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
