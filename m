Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BCC433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F9E6023F
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhILWfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhILWfa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:35:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659AC061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:34:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so10005446edn.12
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qyQq/kgkhAQzQwjXjy+otcx5BClirof/EaaZNL1qQMs=;
        b=cTZdxQgTIr7yevPzWIENFtP790DKMGDJAsMHD013mQbHyATDd4WNWcTo0BGwpg0lTn
         4HSJRAnYPEOnqWpVAhJC1SGg2r+mK53CuaSL+xbkrMA24UbZlbSufkPkA/gkncrbVI8B
         T7APq0ownD/ki5M6Oqkmh2S1JoTr3959P78sHh/xHyoyqMtbhKC7kWePlYL/x6RGUExw
         TJnx0BjMBFK4JlBlPC5iURasYMxU2vJNG0Kp6BbWkF/I7bnIW73pDnttVfylapDNsyhs
         tNc/3wQ0oyznKjnjlf2TgY8A3cgcA9ap8c+Kol+p6urpcjWo/qeiQMeD71VRFv7fPNWs
         Lqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qyQq/kgkhAQzQwjXjy+otcx5BClirof/EaaZNL1qQMs=;
        b=EYuNbjD/RN0sNBjYeR8oxd13eHqdnGmHvXc4ZQ5h05NfH+7RHQY4Pu7vm/LLoeX4+K
         mEk1Bnx8iPNTxCCawqo5UTgppi3aD+V2iUGcmjaPKSmSlvI94vVDBezMLxTfr04rsbAC
         zOMogNNSsG78WCdyl3oA7A2U2D4St1UQMGyT7jGRxXYV503hLf7Ax33YsW6OsLIaQRwi
         fNaft+24OynXgVlPBax9Rl7PmvT9GanRqiUaoVY3c++9N6fX5p9pk0o/BoWtIKYT5a37
         KZj5HJk7r+9is246r2WSXIFsPJOWDamqlV5mHlRdM3aWNAD3JaZJllhuacYWSCqCDmnZ
         9CIg==
X-Gm-Message-State: AOAM530AEzO+gwNyKb615L5Pf9KuPuVTLTOiBEbMSkoH46v1F4WrAeC2
        07DGbIbHfJqXOCEaq0riSK4=
X-Google-Smtp-Source: ABdhPJyzjkgeJyzqufssAJsFUU+xVKCZB0rs6stzIqKjbDCjuScV2Y7NYjR9pt1yYk0u4lGXszv9gQ==
X-Received: by 2002:aa7:ca0a:: with SMTP id y10mr6683484eds.329.1631486053587;
        Sun, 12 Sep 2021 15:34:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p11sm516380ejb.61.2021.09.12.15.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 15:34:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs mode
Date:   Mon, 13 Sep 2021 00:32:40 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com> <YTzYYfBGqG87O5mN@nand.local>
 <CAPig+cRAKJyzuMwPNdmC+BobrMjk5TF-o3Ort8R0E77ij=g6_A@mail.gmail.com>
 <YT1kDVBHtPhxc6Wk@nand.local> <87bl4x94ux.fsf@evledraar.gmail.com>
 <xmqqlf41juju.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqlf41juju.fsf@gitster.g>
Message-ID: <87czpd5spo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Or maybe the whole approch of the string_list API is just a dead-end in
>> API design, i.e. it shouldn't have any "dup" mode, just nodup, if you
>> need something dup'd you xstrdup()-it.
>
> ;-)

I realize in practice that's a bit too much, i.e. it's very useful to be
able to use a string_list to account for a bunch of already-allocated
memory without strduping everything.

It's just unfortunate that you can't look at any code that works with
the API and understand whether it does an implicit xstrdup() or not
without tracking down its current state / where it got allocated at.
