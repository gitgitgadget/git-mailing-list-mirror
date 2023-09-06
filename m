Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45101EE14A9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 22:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbjIFWAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 18:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbjIFWAc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 18:00:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B56172E
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 15:00:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5008faf4456so412485e87.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694037627; x=1694642427; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=floHCfB5IXLOqhIMSdC2BJh4DRlgwfL214F1HauKSPg=;
        b=pmo1ftgJLXlRcwVj9Cngg4hSfY0SxC7FSpMzVc0wwsWWBKNASej0nhsm05HAJtH7NN
         lT6hcXEp2eB+JiBHWcgAqEscoQiZZY/E51XAC/p8h0/7NcELU8OfopG6iH4L0L5JA74q
         k3GgXbC9F7p8HhMHhzDQNtOfIMx1xNz21uZnyS+/tg9oDMzvb49CARK9edNNNc1xTFWo
         a/g4P/Ne8S5o+xL+4u4ekm1yhv48yPAsUsY5wi9rNKfHmFVsupcHmUjiQEeQNPNGpZIt
         rt/2Fxzd6vSPa9WCCCdp8fV19HqKsM6AA3QHApRTLSDg3IfS+3Lq2bpzCDtcj32PFBw2
         wIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694037627; x=1694642427;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=floHCfB5IXLOqhIMSdC2BJh4DRlgwfL214F1HauKSPg=;
        b=h+YicEqSGvaiSDoReLzXtOxWFiA4q2+/eUOSlecpXu/l6i2RLhdZcq0PWwxbPzzea0
         /NjYZ0U3dckm6yrBb18ZyfQYjPhwOgKyHMXPdVp4xmCnHx+6HB38pEWKVzc/xSquiFXI
         Th42eyy5FuX9hKi9DwP8gvpl75hd66s5xt6k4S89vXnRk9ggaq+FyJ3LXEBg4PQmKPzF
         HtUnh7eeijm21Q2KKb3Eyex4l7HiJ1WJC6W1PoPjFqtmReS9w+MqwVvJKyV+G1BsXi3s
         4URbXTL9DrBm9dC9F4IDqS+ct3LHIufqWr1ab1X4dNIikJ78+l2orrEOKkCu0rwZnKV6
         zROQ==
X-Gm-Message-State: AOJu0Yz5ozHl4JT2LGdrm1vXI3/faa+XNxQqodWmHYyaSAyKFH/ASx8h
        7Iu3ak049TtrCmXvqlC9psUvH3mtJso=
X-Google-Smtp-Source: AGHT+IEkahTpHGYC4fcbxg33eqa/Hrj3rOhIXBkHsjsc5oB+UPCp6Savf6+Ct6rnDQC6fcfBMuARkg==
X-Received: by 2002:a05:6512:2212:b0:4fa:5e76:7ad4 with SMTP id h18-20020a056512221200b004fa5e767ad4mr4232658lfu.10.1694037626498;
        Wed, 06 Sep 2023 15:00:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m2-20020ac24282000000b004fe47879d93sm2906356lfh.106.2023.09.06.15.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:00:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        <87edjbuugw.fsf@osv.gnss.ru>
        <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
        <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
        <xmqqledjm4k2.fsf@gitster.g>
Date:   Thu, 07 Sep 2023 01:00:24 +0300
In-Reply-To: <xmqqledjm4k2.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Sep 2023 13:26:21 -0700")
Message-ID: <878r9juflz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Tao Klerks <tao@klerks.biz> writes:
>
>> I like the nomenclature, I like the simple "zero (i.e. bare) or one
>> inline worktree, zero or more attached worktrees" explanation.
>

[...]

> It probably does not add much value to introduce a new term
> "inline".  Here is what "git worktree --help" has to say about it.
>
>     A repository has one main worktree (if it's not a bare repository) and
>     zero or more linked worktrees.
>
> I applaud whoever wrote this sentence for packing so much good
> information in a concise and easy-to-understand description.

I agree "inline" is not much better than "main", nor "attached" is
better than "linked". I just pulled mine out of thin air, and what's
already there is probably fine. That said, to be picky, "main" suggests
that linked worktrees are somehow inferior. Are they?

-- 
Sergey Organov
