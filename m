Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB534C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 08:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32EE615A7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 08:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348840AbhI3IM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348866AbhI3IMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 04:12:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDABC06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 01:11:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so19084907edt.7
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=N+2nDQWAJ84KdiyFmxJTdWwON35tviwS7lkMJxF9TuQ=;
        b=I2B42VrcJdJJFWqh2oa+dvVKPMJ1QqU6mwie+LTeSHpegFHOtk3AIFVnDu4ev6SJYA
         pteyFDJ4FBRdI+QZPg/p9JGdQSv1o507KJ9Ccn96oWkl00iYH5gKhBNH3b94kVEncyGV
         dWt32r8NFqiykoVrO3ed+DGNfqlYD0K0n/daVj1cuRhKr1wHYI+zGagcZnrbgK7aU2iB
         vi6YDs9MuMq8SlgjiERYKhdhEF0p/Cr5Z8b+n4k3T9AQ37zDiHkbZ4sqEXYn5aDBqRgP
         jyBR6XhODiiImAQE/Am43pJBTmPCTE7qF0o9UySKZCKr4UdrEiVe7cGiNPaphHBKzMND
         mvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=N+2nDQWAJ84KdiyFmxJTdWwON35tviwS7lkMJxF9TuQ=;
        b=rIoVqGuFfOsy8iuCSgJEw9c6zzt2wGqwBYoAcKNrMQe7ceBu0fhLWQ19e+GM52NWa3
         FuIvQ+ohOMJKfenQTD3OvwEESUakZta93Y9bMy/5xoqDQWas0NRa6riuw3GuB1IxWNPE
         TKxBB4v9WRlUA7RvCBLin+/K5JDaooFouGWtxa+QZRlmiq3gefg600TuXxbTX83HkXTi
         mkx2P1Rq8bL3tcwZzW+yF7mPv2LH8p86P1cymgxd7WoKuZRQ1EVr/V2RNmz+2ojIZJiJ
         FOzhmjYc+M7YJecwlVwRhRVknGSFtDJglBZbRAuNQUK+2RXDGiyJECLPgjZ9Jt+87sPo
         pVJQ==
X-Gm-Message-State: AOAM531B92FDoOmSqnTWEpS9A/XMoCSs+ftlKoxwVA/78Yl0DgYUZYDW
        Wv/pc20ZXKcRH2iR71gLFF2OXTqudurg0A==
X-Google-Smtp-Source: ABdhPJxhfLdQftdMycLKoXyYzHJydCDpaJ8VpsOv/uJoX8ODrLBGVSEiElmQdaoogGH7tubYqZkF/g==
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr5344137ejc.62.1632989469039;
        Thu, 30 Sep 2021 01:11:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j16sm1134549edw.23.2021.09.30.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 01:11:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages
 in a file
Date:   Thu, 30 Sep 2021 10:09:09 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
 <YVOXPTjsp9lrxmS6@coredump.intra.peff.net>
 <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
 <YVVuP8ReqaPi/Z5E@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVVuP8ReqaPi/Z5E@coredump.intra.peff.net>
Message-ID: <87a6juv5yb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Jeff King wrote:

> [...]
> That said, I think it could also make sense to annotate the conflict
> files by giving them an unusual set of mode bits. That would be easier
> to recognize (and while real trees _could_ have silly modes, we do
> complain about them in fsck, so it shouldn't happen in practice).

We don't complain about them in fsck. I've been meaning to get to fixing
it, but my fixes were contingent on the rather big "tree walk mode bits"
series: https://lore.kernel.org/git/87wnu0r8tq.fsf@evledraar.gmail.com/
