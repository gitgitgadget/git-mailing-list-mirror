Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C6BC7EE22
	for <git@archiver.kernel.org>; Tue,  2 May 2023 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjEBTbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjEBTbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 15:31:09 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C192100
        for <git@vger.kernel.org>; Tue,  2 May 2023 12:31:00 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1925ad4953dso1179645fac.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683055858; x=1685647858;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kybcUY5sNtVeoFIyYBRnnFQ4aerre/PYwXElvgER8+Y=;
        b=ADmnUpa3Vwo0VePydvSTxlTVJTlkANjj3hoUcAgp+ArqE9u2MaHW6fAO/X6oz0ow+n
         8TCG/G/zL+1JT7kv1pyWfXYL35JfcvVK/6HF2j/8j0MNVU2mEh6BzthM/pz3NYxlcQji
         U92/NzwJMQ1cvTUZ8eBvT56LrNXBtTiQ62p2gn+xCg2Lk6HvrI9WLFmjQ4Guom1U4Tyr
         42rHSq+Z4PA00nZ40DeQkdrzdD27iT6CSIW/DOcRFrti3qjdaagcv59V6tSMlzA+uU/o
         O/ZRO6hP3h9xmNZ4mJTj5Q68sPwD2UspO0ptSsWBzYBSajbj0+D/2WB/zJrBHlqH9eNG
         G2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055858; x=1685647858;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kybcUY5sNtVeoFIyYBRnnFQ4aerre/PYwXElvgER8+Y=;
        b=XPYcs1F/v6kCkSLdASIlXETsDRv8LyCJbUFo3e6GW4trpRgdn16+rByvGnGc6qjSZY
         JaJKReACpid8v3l4xgZHMM8gfm3jMf+xFu5g2jBsgVDtQSoMN6K7PvF+0c5Xs7KtYSz6
         P7Hx1go8RU6ZCi8329cPB5u1IzuXZQ9WbJ7kc2JoOG5d3scHBX5FpdwyYXz/tfEkSFsG
         NT9t26bb22cAd5jx/Cacd+AFqy4C5TRw1yyS6oQO8Bv9hByYRQPD07x72N4BVwvfGQBT
         PaIVSBFkDRO4AwYZTSbwr7uqCTwSP+Ky4hIrDYAID9fGxEC5aL1cS/dzza22AdQ/r7BD
         ksyQ==
X-Gm-Message-State: AC+VfDza10xkH0Yq3qCU74tgIa67vcH1WO2zBBdx9a8wr8ESbWBjzRUg
        6BQDopTa4dOxcE9AVhOz/F4=
X-Google-Smtp-Source: ACHHUZ7h+34/r3a3wu8osx95Gk5x+09x/GMu9x06u+IDf334LtKm269Kq20Eo4mijUmzPcD2sh4TKg==
X-Received: by 2002:a05:6870:5b26:b0:192:79ba:ef35 with SMTP id ds38-20020a0568705b2600b0019279baef35mr2190647oab.18.1683055858443;
        Tue, 02 May 2023 12:30:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id t1-20020a056870e74100b0017280f7d653sm12608433oak.35.2023.05.02.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 12:30:57 -0700 (PDT)
Date:   Tue, 02 May 2023 13:30:56 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>
Message-ID: <645164f0e6064_1ba2d294b3@chronos.notmuch>
In-Reply-To: <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
 <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1682634143.git.gitgitgadget@gmail.com>
 <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 1/2] cocci: add headings to and reword README
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I fogot to mention:

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> If we are converting it to asciidoc shouldn't the bullet-points be
> un-indented too?

I don't think that's necessary.

-- =

Felipe Contreras=
