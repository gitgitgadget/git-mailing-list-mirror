Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FB3C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B772D60E08
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 06:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhIWGvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbhIWGvU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 02:51:20 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E3C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:49:49 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id f73so2185252vkf.6
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jfLY/kSURxZL7LuT9GEyn8jmCg7UzCT2p1B2HPUFPs=;
        b=SCgVRKLBrfN2E98fuxX+Q44/xpqo3vyHLMlls9icCTO5eR485+JW/q/2BQld6hR+G0
         NhTyDxA2xFf9q4tciLvR84KGNbt5sGIvp86TJ51JDY1MyqxMyWkqJpWjvINqpQh/NE+J
         4+CTb/GYopNssS4OOIG0lJi1IpcsvS0x/YRgZWUmR9OkjU+bjW1dD1YKcIbNgymqWDiB
         vBwOjDoq42/MsgB1kdoJRwE8qt2S5Ea79QdgtvO3iFYNH8lJ8JcKZuOC5X8VxFX6eY6/
         Ogss2etxtPkQ5nvw3dfU4F5n3IRioInudQ9rnvXe6dr5HMW7+c5v3s1RnrJbi8JhH2mh
         wGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jfLY/kSURxZL7LuT9GEyn8jmCg7UzCT2p1B2HPUFPs=;
        b=igfKxG0sv0ox64G/O73+gpSrbvdYoQI69N+m6ZgltQKpEnYKNvwUjJik5NOcUDnUmO
         EqHSIY/YB81wcoJIPOehfNCe80oD5DXHv6gv4Vj9Xrtqts0ko9MKMxW0vg8TDmzO68gX
         7OiTJ/7W8Tf8z/spOc6mO9YSmopV7mS3D/+wU23BjJX2r8Z5XmBl9PyQgHEKk1OmZVIm
         kKB8ljY8Twkeupo8HRBdaHFfI/4c3nba+FvXKHJW/LJAGgNFBxFuTvDkC0kKD4/hhw+s
         133jvfgvBeitUTq5fpvDqcl+yj5tgcHeUlQjBnQiPvfNXshn13aH0/08iZSLKEwvwxK6
         k5mg==
X-Gm-Message-State: AOAM533vos5ER/eewYYYCTHQi6eXH91kzIOnGiQMSf8MFvQHRqiMYbri
        hp5+qavOI5kuMDERawLr0y/BHeSQ7dEj/XVi68CIRYinur4=
X-Google-Smtp-Source: ABdhPJz1q0CBFJE+ghSVPUKyHRs5LjXYP98uYBIdLbxB+BkxClalQq91WXaghTzkAyIri9IdXlqQewycUa85+R4PES0=
X-Received: by 2002:a1f:c9c1:: with SMTP id z184mr2084477vkf.7.1632379787713;
 Wed, 22 Sep 2021 23:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
 <20210923060306.21073-1-carenas@gmail.com> <88717872-d31f-c1b8-0d0b-364b154f7734@kdbg.org>
In-Reply-To: <88717872-d31f-c1b8-0d0b-364b154f7734@kdbg.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 23:49:36 -0700
Message-ID: <CAPUEsphH9-rhdmBYBy-toAyWKGFYyRwsrqNpodOyokH_VhG61g@mail.gmail.com>
Subject: Re: [PATCH] lazyload.h: use an even more generic function pointer
 than FARPROC
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 11:33 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> IIUC, this patch goes on top of mine in origin/js/win-lazyload-buildfix,
> right?

yes, but it has a typo :(
please use v2; apologies

Carlo
