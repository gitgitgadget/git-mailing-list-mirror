Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C9DC46467
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 03:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjATDxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 22:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjATDxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 22:53:44 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF665BA
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 19:53:43 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15bb8ec196aso4991381fac.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 19:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mUBHambcvY/EYhwha4lx69mko22hiUjmF6AQgJ7Do80=;
        b=Dp6xAoJwiU233NLvPmQ1ptU5DBSETwEanBbuSHrMcMgTtnimF7SNRi5ZTRb1Kseekb
         YW3fJA+lH7ROZtDzmLgA7q/3Z26zFHk/5o2r3rvgNv62oytWVKmwmBlq96+G//7OwxEu
         wr2el2DTpv/qVRiillIJcSiSed+lNDY6HTlx6/rI1lTl+9lhNp63NSfotdxdu+uxMTMx
         SXWfVVRPYEo2wX01T+7OsHh2K0f7sp9+I6FFCi3dpa6pBRQ2le373Ik9tSuOc7wzmHod
         3fgCWmbQyB3uMWQyoC4VqPImK556qGTxgU8ndUyTBHQCoLGQAfvGx4T4ac20oguUJkfE
         jOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUBHambcvY/EYhwha4lx69mko22hiUjmF6AQgJ7Do80=;
        b=dnPMPiTmvNrRB1ll0P1GEi04kDeaW9/xDOnm9w77Gcbv7UCjJCuekZ4fe2Bg84QcWi
         Ol5LWMR5somLdujE2lky6nNt7h0D6BoPH0QspjTbVvjFIOB5Gs2RdOmPEffHYSrgxX4N
         DgvAD60Y9K56eyn8sbXlt+we7PfLxDd6PiVvfcTgqHMWNuFN/pnSDNiwDyOkCxfylmuq
         SHoE2wiy6Fqx3ZGNm3KhxIu2yfYFS2cCUlmr5+aJCa46yeuAGtBlFv36tmjGvB0PF2IK
         CQmqXtIhw85fXAlazyxeTHX1YHfO1o6FuGsFxy5YEr/8B8xEPhAHN54ClO1g68jFs/iF
         aVEg==
X-Gm-Message-State: AFqh2kpXVlLDbW+kWxTSYIF3LCXLPxfqnJ37NuvfTj+qRM3GZwBl/rv7
        SxnzaUGE8Kq+Rr5XuqmUMRSb7jx/ZX6uPSAdDeU=
X-Google-Smtp-Source: AMrXdXvnHsqBsjvPOCtg3y1A3pk9pPBafEwnexDu66Di/XUpyMMSCT6f0pU2jtKShYalohlZD9jEeYLyIoRPND3r0BU=
X-Received: by 2002:a05:6870:bc01:b0:15f:33b4:879b with SMTP id
 oa1-20020a056870bc0100b0015f33b4879bmr908908oab.59.1674186822900; Thu, 19 Jan
 2023 19:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20230118061527.76218-1-carenas@gmail.com> <20230119055325.1013-1-carenas@gmail.com>
 <xmqqa62dzyst.fsf@gitster.g>
In-Reply-To: <xmqqa62dzyst.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 19 Jan 2023 19:53:31 -0800
Message-ID: <CAPUEsph5phu8z=nYJt=zRh7q40-BwKuzhVQ-F=iLQppd9gR5hA@mail.gmail.com>
Subject: Re: [PATCH v3] checkout/switch: disallow checking out same branch in
 multiple worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think it only fails its own test, and I can't reproduce locally
either with macOS and clang.

I was going to propose a newer version but it seems to be similarly affected:

  https://github.com/carenas/git/actions/runs/3964409976

It will be better to drop it for now; will produce one without the
heisenbug, somehow

Carlo
