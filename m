Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B8CC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 08:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiHEIjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiHEIit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 04:38:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BB07695B
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 01:38:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m4so3819865ejr.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=RrTot6DwK5BCkVDFO6xTpIYUP4JgHYI9tZp1xcbk6Qk=;
        b=i0J4MJA/moXySkAoT9q0evMJAG+QXevOvUvgfVuPn0Mn9lv1tLRSFrUyh2ViE/EWRF
         GpYWSsVuZCBsNIJvig9xQfLu0XNCzsaXYRsv8903plqzFNqlFoJGo/xad/iHaSH756QN
         KQLgmSYuMBGGjwNTx1nixtLxrBxRGeiDbOTuQ5cvu91fUijzepwJxSjg7f8hJbtvpDGX
         55V/AxyMB7J31nzz/AVjTEgVYiq/QG4dLxQBeq2bKLSdzIn/gHGZv1lQ0ISP4FZOn1GF
         RZTfoeg5+OPWh23H+feyX3dn/dAWAOUeBnWdK+8Dt3GQI+cJb1ss1OcpHwbNyJoG4Wif
         yaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=RrTot6DwK5BCkVDFO6xTpIYUP4JgHYI9tZp1xcbk6Qk=;
        b=XGpjdR0mbQLCdSu61zDlBqVKFCELYA0dRn3z5BxQ01HS4H0MKho0l68GFUqfHzGMn7
         FZ18y+Xt2MPOFpcI+XuKQFp52lKbKEX2zgRjwkpfiSfRUL6iNyuWluKte/67WqKZkHEK
         G5HKqqZQHC2waxIhJzHiE3xOojeiq7DCOFaiLxBpvlDP/eaMhJjNO1sXQpDOguAeHGkN
         b8uPGHf7hTYXCGAT2yrO4YbxVtxvimTCVX00s4cz8K2NZg/1yUgRsbPSK0Awx7XSfAQp
         wFyVt/tqjIcBWUEfYe7CBctMYiRxaWR514yjgCKUxJ5xB2WWqUbdQLpM8ovShtUpTj4K
         JeUA==
X-Gm-Message-State: ACgBeo0juFs62ZzavQy3atVKec8THvCw5ZONo0oCujpthH/UsRajFV3X
        dRWZgVb8D2aOViy7ESBYMd4=
X-Google-Smtp-Source: AA6agR571yVuyBkpYmiLbWl5oTl6MpfGJqDCnp1mhO7l8TgDDbSloteLrYSmV5yZF9cea4KeGSWgAg==
X-Received: by 2002:a17:907:7ea7:b0:72b:6e6b:4895 with SMTP id qb39-20020a1709077ea700b0072b6e6b4895mr4436482ejc.338.1659688718205;
        Fri, 05 Aug 2022 01:38:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709063caa00b007262b7afa05sm1285140ejh.213.2022.08.05.01.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 01:38:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJsqq-000SCC-2Q;
        Fri, 05 Aug 2022 10:38:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 07/10] docs: move protocol-related docs to man section 5
Date:   Fri, 05 Aug 2022 10:36:56 +0200
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
 <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
 <patch-v7-07.10-cfd1b0afb53-20220802T125258Z-avarab@gmail.com>
 <xmqqbkt1cohu.fsf@gitster.g> <220804.867d3ot1gt.gmgdl@evledraar.gmail.com>
 <xmqqles34xij.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqles34xij.fsf@gitster.g>
Message-ID: <220805.86czdfrsoj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I tried to address all your other concerns in the just-sent v8, but I
>> don't think there's any rename fix-up here, but maybe I'm missing
>> something. These files are all being moved to their new
>> gitprotocol-*.txt homes (and weren't moved in preceding commits).
>
> Sorry, I thought it was rather obvious from what I wrote in my
> review for the step before this one.
>
> This is an "oops" fix-up buried in other changes in 07/10 that fixes
> the duplicated entry made in the previous step.

Ah!, sorry about not spotting that. I see I misread the "that renames 4
files[...]" part of your reply.

And when I was looking at this patch I'd already locally fixed the
earlier commit that had the duplicate command-list.txt entry, so I
couldn't see any issue with the rest of the commit either :)

In any case, it's all sorted in the v8, thanks!
