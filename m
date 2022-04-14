Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA1C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 06:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbiDNGTy convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 14 Apr 2022 02:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDNGTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 02:19:53 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93331DA77
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:17:29 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so8409778pjb.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JxMgBTFxGZDfaHLeJT6DenXh3JwUnaUPzlCQ+QkwMvw=;
        b=XgI1TC3qfnn5ASykLqLGUkf6SBKF+snnl4FaZ9vV1+YeZz5HbFE1IUqmC8Mnh6kW+2
         WuvfPg0woQ54gFmyFnskiC8vOKr6uyFaNdyKM5r8TGKTe67mTBZ6lxx97Nc8vEIaQOZ0
         5jLYVSHYNY/7SlaA1FerKGe+eqA+MEQQHzfHZMtv58aD7dOi8Z9vuC6IHb7PoT55FBGR
         qMXJULAp5+2mFsXhJinipVsR8/onaEa8HBKjxiqMMO1UGFZpqtFhVyz4WARy86lyw7vE
         ps2r3sED011refGoO4Qe5tdCIQGQJAdq5PT1AVFCMjLWFi0t0Lj886LASf49YCBB/0zR
         q7mA==
X-Gm-Message-State: AOAM532uDQdWFgmFPQ/9u6ZG+lzwtz/VngxxWuB0AbDsmVdMLxca0CGx
        Zs2oVejwP1UFcD2STMV36N/ucUfc9xEAnWOql+M=
X-Google-Smtp-Source: ABdhPJwa7JpKy7s3AyCEGTKv1agya245KKiebtaPDVYF3ifwIGpck+S1K1/rclgWebrrTlOv6GVz0cKhQP0fUydREPM=
X-Received: by 2002:a17:90b:380c:b0:1cd:4f85:8385 with SMTP id
 mq12-20020a17090b380c00b001cd4f858385mr2637849pjb.236.1649917049137; Wed, 13
 Apr 2022 23:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <patch-v3-07.29-cc81b9fe37e-20220413T194847Z-avarab@gmail.com>
In-Reply-To: <patch-v3-07.29-cc81b9fe37e-20220413T194847Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 Apr 2022 02:17:18 -0400
Message-ID: <CAPig+cRhRzPL7OHBPNnsXjqYeZudHiM+ntHWSGPiJTD7mvT+=Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/29] CI: don't have "git grep" invoke a pager in tree
 content check
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 5:33 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Fix the omission of not adding "-P" (a.k.a. "--no-pager") to the "git"
> invocation that spaws "git grep", added in 0e7696c64db (ci: disallow
> directional formatting, 2021-11-04).

s/spaws/spawns/

> This didn't matter for the GitHub CI, but does when running the check
> locally. A subsequent commit will start invoking it via a new check
> from the top-level Makefile, and without this we'd visibly spawn a
> pager when doing so.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
