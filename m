Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E8C4332F
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 13:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiK3N2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiK3N2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 08:28:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5E5D698
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:28:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id o1so12269617pfp.12
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5YGYVnXpMCvu8VGOMOwEZeh8h09TXMWLk7hFiJsbRI=;
        b=bZDYRiMXz0Q+jyGKs3B8nEsDWECo+OFKn81UZTmjuMH/u1B56zQhCBI8DHVa+XQcfd
         FEoeCDm3p6GAk6/z61nJ4KIgY+C/caOy8LUktYupdLNvPkGC5CaeL1K1NWCmGnNR1FsX
         QndG+rSf/KVqw2YJG+ro5hkzxCFcejQ/P9tgZuSLsZzXbE7/N+Red033mBH93jQu7b/g
         4I7iSJ+kGUyFbooSWuEHWJQTI5SDeP/0/y0v6zp8Z59bSDl/6gEj2y4Zv2GoKdDszSVg
         R4uXnVfZeQI0AcDTt1V2f/bZYjmd3eZMlCAhiUTrbp7aNNvER9WUCmDCIXfGKPWVZfsN
         8x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5YGYVnXpMCvu8VGOMOwEZeh8h09TXMWLk7hFiJsbRI=;
        b=RTGAWra7IljSI9e9XgPPS0Wo+AL9+JCkawS4YArtPi81rtMAoCLCYQQZ4p1J4yQxQ6
         BhFC7vuv0pGTTsU6Qq47uVlXG/aZpX+xe2Y4vY1gIVjihJFDP5/aG3S0RGgb2PoxW6zR
         m/pdkMMzJoXhyuvL3rX2coFu4o5g7m7y6v3VJKUipNW09abJ51kAvxLJdx4NgZTTEt5T
         A2BvEiByOOAA7uvxwQHrmp8+m9Lq3FxIa1irUn9os//kOIw65zT6n6jcbhLAgdUNLNmb
         wVwUKSoOD303cyR6nYz26K1+sMTxdRom68yFzKPvNOMwNSgRakDMc+2XBoeiTt/NXGMK
         AZSg==
X-Gm-Message-State: ANoB5pkiGo88Iy0U5KD9hGjzfb0TSe+Q5wkp0t/4bk2UH85lgbaEZvCq
        f3DLOq1Q5+T3UFl7zyTjJ8w=
X-Google-Smtp-Source: AA0mqf41kvOyaP0Cw4BTM/8qRYI7zZpwm7OZx9gI0R8bok6RXWi4FaXLExJBOWLQBEuCZIa3d3mKXw==
X-Received: by 2002:a63:1a13:0:b0:478:5420:d2c7 with SMTP id a19-20020a631a13000000b004785420d2c7mr4742130pga.105.1669814907063;
        Wed, 30 Nov 2022 05:28:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d65-20020a623644000000b005750d6b4761sm1368296pfa.168.2022.11.30.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:28:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-4-sorganov@gmail.com>
        <xmqqedtn957j.fsf@gitster.g> <8735a3gmuq.fsf@osv.gnss.ru>
        <xmqqbkop3hjb.fsf@gitster.g>
        <221129.86tu2hiqre.gmgdl@evledraar.gmail.com>
Date:   Wed, 30 Nov 2022 22:28:26 +0900
In-Reply-To: <221129.86tu2hiqre.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 29 Nov 2022 18:59:37 +0100")
Message-ID: <xmqqtu2gvaf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> If you have your own fork at GitHub of https://github.com/git/git/, I
>> think preparing a pull request against it triggers the CI.
>
> ...in this case though there's no reason to wait for the glacially slow
> GitHub CI. You just need spatch installed and:
>
> 	make coccicheck

And you have to wait for the glacially slow coccicheck run locally,
though ;-).
