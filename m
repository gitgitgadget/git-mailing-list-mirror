Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95130C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7205620656
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTIu0pes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbgFWPbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbgFWPbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:31:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782AC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:31:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so10024214pgn.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UmicGo8uFu4cV2p4lxe4/1+eNElXE8Qa9sh57feEl+o=;
        b=UTIu0pes7z9Bz5Om41QLKi5ZPTxgiNS9AJQUAfU9zHzGMC5BS+BRNJsrflpmYvnDXI
         KZjbJi/dvw8VBDRTRIfaGC39vKgBlxlk8ANNumeJmdmpaarmG1KTQO6jJ5zzjovNQeFH
         XKhdlPr3pJ7EvPdUVLN6SnpUjm+KuHDb53zT6GGrLnkz0fsPPbU638P39f7yJwu/KfAx
         svLChGkp2pKR8LV0DS1UCOcVEl9N3g8A3WDn1h+TTaQNHkccJy6zsoOm1LVHkBi4CrzD
         zoEus8FYmJcGmPN767IRqoSukYA79+qZfXONr47yuA1Mq5hJhz+4jifpMntMpqZN0USk
         LT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UmicGo8uFu4cV2p4lxe4/1+eNElXE8Qa9sh57feEl+o=;
        b=BVVqaP+oO9CvRBosXPTL7Mv5fhgLkNTaOSRVF+9B/G/ONxyfrLlLlpVkexb/8NMqwH
         Xe8RchkQ1YE825irEXorRZcmZzENZaIVi+BgC2VM75l7SgI2kEGchBks44af3DalkV/q
         7W1FZrBKTjcwJNBGH/qtskZUZ1jNMiP4Z8jSIbHS/reX9e4BuKmBTQHlPG/5vf9BwIWC
         t9/6Blj90nE2sxD/IL55K9tugnJ7mdPP7vk9QICpCDvSF4NzICOBZ/yENOTK0QIbn1T/
         JRw63wYXVNtKZUtrqSzgUqFJ3e+GnUyteJ43RJERfQ+g6tPsTQjqJvdhCaEmz5bLDIrX
         bxCg==
X-Gm-Message-State: AOAM532V84fBMuUGc8BfhSSdyIMxig53yGZTWL+GUU5urzOv0NKjVl3Y
        EbiVyQ5RfzTPCOXTXjVBD1E=
X-Google-Smtp-Source: ABdhPJyDRNalXYILO9pR+pWgemqmTeZvyJY9YgdghbcS5MSK8wJQoqRtZ0rAemA9dYhHvC0d7ynEzQ==
X-Received: by 2002:a62:804d:: with SMTP id j74mr25524564pfd.233.1592926268973;
        Tue, 23 Jun 2020 08:31:08 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id z7sm2957677pjb.26.2020.06.23.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:31:08 -0700 (PDT)
Date:   Tue, 23 Jun 2020 22:31:06 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] docs: adjust for the recent rename of `pu` to `seen`
Message-ID: <20200623153106.GB20455@danh.dev>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
 <dc6f97129019e9176d91c77576a84549c00a74b5.1592924655.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6f97129019e9176d91c77576a84549c00a74b5.1592924655.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 2020-06-23 15:04:13+0000, Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 0a5c8b7d493..492e573856f 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -101,9 +101,9 @@ f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
>  7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
>  c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
>  0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
> -$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
> +$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc

rc is not with us anymore.

Should we replace it with next, too?

>  5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
> -c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
> +c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
>  $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
>  $ git ls-remote --tags korg v\*
>  d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99

-- 
Danh
