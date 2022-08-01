Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917F0C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiHAS6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiHAS6o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:58:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD81BF9
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:58:43 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bb16so14058401oib.11
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NAQyjHAnglSo06wG2ArIxRRSJjxVJ+RKgz5vtD0074c=;
        b=LqpT0elLq8fNnGFyyX6C+6vgWy8j5zZ82hjsTmOgBsjF9Vbq+UBnUgSMNF1+8Ry04K
         pUjlUeM+MzJWDUACZFvcGrYz/nYApEfE83M0G6BS6awJddcLz7b46ftPE/6L6bXGOOD4
         lCpELyNvluITKDjtX36amlcE61/3ygqo60TFFiJnc5mlS3s1uB63tbZvob3WikxrC7BM
         iTV4MbiMnMCgR8Os+MvYzg8jDTHU4X+77O70Qul48Z8Xn4bd+1kbmSZXLgEJYLx0MTOZ
         iopakMlYLnjFwd1z+fi7Ade0q5XzYsJnL6DRKniJYc2cfIDxeW6AJuNavA3+pveOXUr9
         woiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NAQyjHAnglSo06wG2ArIxRRSJjxVJ+RKgz5vtD0074c=;
        b=SqoZzMeXN01AFTZ8KKbWDdN6eewBjArWSeWlxRaq1TvFWwqSRAYC4MvuxUIbDSVToZ
         JFgo5Euty6fqUbQYD+ZPV725k07WbPNuf35IEvTTGr2XFz6xUW+p2ol4Z47PlA08LywE
         l/G0ICwJgWxI1vJ4tocJbotysw7s6Br1YVqALYCBteuY0lkRAj4QMRGsF7Mh5BEuHbO6
         WZJ4+RIF9ol+3o4/hNYfjFPEjBV8NQ6jzu0TRiqlEQW/rStOFz6OIkVgL2HhcJfV9HQK
         3YAGLAO7oRxdQrFx57eX90iJO+ch547yRdVfGg2Px/hJF90xua5G9xlLmheYEwHXePup
         VDLw==
X-Gm-Message-State: AJIora/BT10qVPXuyaLyXkbmN46/i4ehubNCsqyBYz/umcnWjcpU7Ta0
        +X5c323HA+Yj1nUElw8TUIX2n0Z1UP9x6Qn5KhchZUmcgegeHQ==
X-Google-Smtp-Source: AGRyM1v7iSM7nuekOqFs+jxoD91L4Xb9tWASxvr3hUP25h7TEhpuiMwhiCUWsnhWnU6TtyAVPB+wxPxLmHrMhrMoV5c=
X-Received: by 2002:a05:6808:1294:b0:33a:de39:89e8 with SMTP id
 a20-20020a056808129400b0033ade3989e8mr6774491oiw.236.1659380323171; Mon, 01
 Aug 2022 11:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-5-calvinwan@google.com> <xmqqk07v7qe4.fsf@gitster.g>
 <CAFySSZAPzO9YzGhsjhG7YRXv+ctTHM2FXzrwRW2bTW4pUt8q7g@mail.gmail.com> <xmqqtu6vyf5n.fsf@gitster.g>
In-Reply-To: <xmqqtu6vyf5n.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 1 Aug 2022 11:58:32 -0700
Message-ID: <CAFySSZC7+j-35TD9jy5y7RW8zmQi+mAZEdwdvhuXwN9-XvZQ-w@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] serve: advertise object-info feature
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is it?  older clients by definition does not know about "type", no?

Newer client, older remote server was the situation I was thinking
about

> I am perfectly happy with the capability advertisement to say not
> just "object-info", but also what attributes of objects you can be
> queried, by the way.  If clients right now (i.e. without this
> series) expect that the other side who advertises "object-info"
> without "=<these>,<attributes>,<are>,<supported>" supports only
> "size", for example, perhaps treat the bare "object-info" capability
> just as a synonym of "object-info=size", or something?

This is a good idea! Thanks
