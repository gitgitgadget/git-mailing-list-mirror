Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAC0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EEA60FC3
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJULiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJULiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:38:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD9FC06161C
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:35:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so2418242edb.12
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=15coU6EwapUB1iE7HdgvvZNv4OVOoBPt1tjiEFL8OLQ=;
        b=nRxXNGZmJTujHI5xpSR0hAbk5ZHDVmLsiHgBx4qLGXWWKhLFralhNw9PQg+Gnk0qaj
         FrwN4WO+ZkCoVFGTLZAdiTzRKYBwKhrmpRLvaySv0+gAbXlwiNmd6JEugaPikD7g1Bvo
         Eg60/EJdSAn/GoVyRVpTXP7Obv2J+XV4+XPfVDeT6G+pU9BV8iOjqn9z65AgB/wdRauI
         Cj31nXdon3QHtN8nUmOiYnlgRD8q9k6DdRvEEYCFrBP6RSYx42oTOgmGfONDbHhG3lmt
         atkl5KMdp/g4GYuV1/W8izETCccC7c0djoKoT8OHWN3xDgF4qSXvCgGBxOiwUC1MY6i/
         ppVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=15coU6EwapUB1iE7HdgvvZNv4OVOoBPt1tjiEFL8OLQ=;
        b=5aabQ2hegchLfsrHeo4tdDI82zVRqU1Ijz0/NQ3u++jBTbe8FxDW6gWkVMysxhI9T9
         fsKd589GbYdXs6i+uO81ScshyBLheNdVnGKB20JRDxC6I4kq97KpqdXvifuR8hpTi2dH
         RpZHlPAQmViktSEhvjhaxoaQF9Xr34A1sfsoSlHZwE90/aEseswnTJfNNdbY+SlVw4Wc
         S5EAilcW1+GzxycG3gR+fTJ3H6wwY9CwiLRw6ayYW7XZejwaYSxMZb1sXC5ZRTyq5jHW
         tYt2sRDoBk1RUDL9KpSNsXYyqJmenLXqeDYGe5AVXJWtgnzr1vIHdl/x7Vkgmd6L2YVo
         /Yxg==
X-Gm-Message-State: AOAM530BG2yuINS4NqOOZ7ESDdJ+D1EZkGN5u4rTc6xYc7yhhqgvf0mE
        bYR9V7GK+dYm2VzVbuTm0Jb49Iwj4uYy8Q==
X-Google-Smtp-Source: ABdhPJy/zoYffiG1XGFDzJ4Ha4JyvY0+YplVlBDkR3n7z7UOEIeoKjGOjxp1BNTg8N6k1rUcpCKDfQ==
X-Received: by 2002:a17:906:fad4:: with SMTP id lu20mr6915707ejb.316.1634816142058;
        Thu, 21 Oct 2021 04:35:42 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ck13sm2777780edb.0.2021.10.21.04.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:35:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdWMF-000yw5-Gp;
        Thu, 21 Oct 2021 13:35:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 01/11] midx.c: clean up chunkfile after reading the MIDX
Date:   Thu, 21 Oct 2021 13:34:30 +0200
References: <cover.1634787555.git.me@ttaylorr.com>
 <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
Message-ID: <211021.865ytqmwz8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, Taylor Blau wrote:

> The patch contents are from =C3=86var, but the message is mine. I hope th=
at
> he doesn't mind me forging his sign-off here.

I don't mind, and (and maybe we should have an in-tree text file for
this) like I think Jeff King has noted for his inline-posted patches for
discussion you can assume my SOB for anything I post here on list
(except noted otherwise) in terms of copyright.
