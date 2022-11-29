Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EB6C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiK2NP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiK2NPK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD9C61BB7
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:14:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 136so12990987pga.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BslbnE6yAEzzag9fsOITWI/dtw+81RWPMio3i1ul2sY=;
        b=NBsVz0dX4IIkhZIN1xR41bWgk4Tg/btBfX0w8jMJkvFclAYG79u/5KTuf2ttE6FQ6Q
         4+K3h364XBD1/zhlDPldEveC5xzIjuSmTe+7rLdnrB2AgSVKRtdDyF5C0VCM+h7pnxXQ
         u40hsjDuDPu66BClNg0Ndkat6ALg0WaJRwIhpkqZQnmATjQwtoXU4O8FYNNC8Nl6cyMz
         +FpasZzE++j6R48wKGhFm2WLnz4/2W10uBo3XJg7547ucQjFSbPlhRbM96VlheCnV73/
         oh0d6buDoGVWxU1lmDlHB5Ouc81QbP4I3FEwkYDQPgIKSUsTBYCP8Ojff5vhSRo3+6uA
         Nl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BslbnE6yAEzzag9fsOITWI/dtw+81RWPMio3i1ul2sY=;
        b=soAxJ4k8NLJayj9s5xmhDhi6D/CPTlyMM2UY55dQtsZF2T3CNkGMHkHXsRbeqTf98z
         wDp42LTLGe2jJMR7INqB2JmfFtGkiY+ULfYXwR92scyW3uPO2jjI1pre2o1KN/UooeXo
         bXa3QCjf3Cb+tfvVt+RORLaOngb52+0Y+J2RKUJTVmaX0TrUBK2Qr/V0xylbCBlKwJPj
         MBlD4p9oMggNyts3+scNRRbN7QlMRRRzKpuqlEOs12ppTpVeRftQlO5GS8JuAyosnn3U
         KcqwNU7ikwrH15GfVPsFSe8/uipmeT50pFMq918i0x6b2dkeGtTix3Kuckq5CVHU/Jrm
         mGQg==
X-Gm-Message-State: ANoB5pmc9AFzyXP1+N2rkkrXFL1icSBGXf26ue0cDEDx2KkfR0Qj98Go
        QYDSX1XWhd+8fK2B+GOiU/I=
X-Google-Smtp-Source: AA0mqf64aaOUdJIFQX0wYkwTEQvqhT2AmBiFo9nPk6IJARxICBk3Yvmpch3Tl8Xj6bczk2EBpmxsBQ==
X-Received: by 2002:a63:1817:0:b0:477:fd2e:370d with SMTP id y23-20020a631817000000b00477fd2e370dmr13521915pgl.121.1669727669128;
        Tue, 29 Nov 2022 05:14:29 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a134900b00218ae9916c4sm1317680pjf.35.2022.11.29.05.14.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:14:28 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 4/4] pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
Date:   Tue, 29 Nov 2022 21:14:22 +0800
Message-Id: <20221129131422.82642-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <Y4VgG0Bu1P2NW4d5@coredump.intra.peff.net>
References: <Y4VgG0Bu1P2NW4d5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> > I agree it's not hurting here, it's OK for me to make the improvement
> > here. But I have a question, do we prefer to omit the initialization
> > in such scenarios if we make sure it will initialized correctly？
>
> I don't know that we have a particular rule here, but I would say that
> yes, if you know the initialization isn't used, then skip it. That
> communicates the expectation to anybody reading the code. And if you're
> wrong, the compiler will generally notice.

Thanks for the explanation!
