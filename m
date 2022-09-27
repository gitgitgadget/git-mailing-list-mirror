Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E1CC6FA90
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 08:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiI0IPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 04:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiI0IOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 04:14:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12665B5A55
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 01:11:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x29so10089959ljq.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y0dPMGzi5iW2yObMBsK3tuU1w8GlA6uVwkUWQEn3Bbg=;
        b=qX/vGYa2xNr96OuY+Bf8La6eEbP8ERlAHw2KCJbmj7KPGaGPp160szZc2OCC+YdTnT
         PA0psR35C+aiGnVUPip8Li25EVyp6LgMQ//Y/PaYyLtIy//KA18Yk2wMyDG0ECZ3pcz8
         JBoAoC2XYYkck4m8Ob6xOYS44yFCywqhpz64oKoN2Pu8RO9+jCBfPxTvi+lInQ2k9Nqd
         EYyE4vw2ph6JsmgQWtyma1HP0iXLcTfZnaMjCam/kTLhZyGS49SspMr5bYBmUJcrJoM0
         LuLyzIMTGRtaldHstjknjVUP0pxHypVthh1Gyezn3Jlg5xf2NhNDsMgk55cz2VMAqj8Z
         8yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y0dPMGzi5iW2yObMBsK3tuU1w8GlA6uVwkUWQEn3Bbg=;
        b=TdJy0Owcly2zzjo0s0odcdSiQ5Z8vxVEmGqoFD4yn3vTZUbEycDNJL7GUVHdnDNwmt
         l6NIjqh9San6/1PWZvOTiYVZqk39TGv9+gP25s7axgVKZbOh6y4tEGGP3YGNjJWsw+97
         JhzqS4Xw6RRIlUAEv98jOQmhlYTVV6CBq4lHVsVR8iJ11Z1LuMyMNIVRGtTfmhVhy4F7
         XQlqgUCFuFIOP6FGG88C9IYPUe0uX3qn/swRmbcLmA0RMfKmdO/MW6BeT+xQYKPl2N5a
         useZQeL+StxEkjYl27xSJE2bVO+DMFuroheiDQ4wM8gee47NhVs3eRJD7ONDzi/Z/7et
         XlPA==
X-Gm-Message-State: ACrzQf1e0axf8lGu7+bzymLXHc1/bIpzxgV4FZkIWAUDseUMdHr+fDLe
        hrsdL6luZ4PRGPr6NbulGaZp2X6yGkn+mBqR3qU40EVS
X-Google-Smtp-Source: AMsMyM6o/CaoV07ra63HZr8eG7E1Lc/ykfy8+YERGkjLQTpE2Gs268/MXF5+0VSGOkOHng15xu/2kNeOfPeiZOj4EKw=
X-Received: by 2002:a2e:8054:0:b0:26d:9549:b460 with SMTP id
 p20-20020a2e8054000000b0026d9549b460mr3955814ljg.194.1664266294280; Tue, 27
 Sep 2022 01:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com> <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Sep 2022 01:11:22 -0700
Message-ID: <CABPp-BGJueKtcdvzGWH_ZK6yeA6r3457ue5Uub9_gdU5M-WmvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] merge-tree: fix segmentation fault in read-only repositories
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 2:55 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Turns out that the segmentation fault reported by Taylor
> [https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happened while
> testing merge-ort in a read-only repository, and that the upstream version
> of git merge-tree is as affected as GitHub's internal version.
>
> Changes since v3:
>
>  * I now consistently use the pattern int ret = 0; ... if (...) ret = -1.
>  * I added a commit to properly propagate write failures through the
>    handle_content_merge() call path, even if it is not really critical (it
>    just fails sooner, but the merge would have failed just the same without
>    this patch).

I'm a little unsure about the commit message of patch 2, as I
commented on, but the code all looks good to me.  I don't think the
comment in the commit message matters too much; whether your commit
message addresses the weird case I mentioned, I feel the code handles
it just fine.  So I'll leave it up to you to decide whether to tweak
the commit message or not.  Anyway, after you decide on that, feel
free to apply my

Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks for investigating, for tracking down all the return codes and
how to propagate them, and getting it all fixed up!
