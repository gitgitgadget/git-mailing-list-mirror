Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E7C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBYPPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 10:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYPPp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 10:15:45 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E790
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 07:15:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id b13so2022902ljf.6
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 07:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srTgiDQyJ+iHlVvY0oO/Aj8hpbQB5lmra+IabD+2tas=;
        b=ABpP3HQTNEhy09PWwHOmB/bTJkFORCGy5oRmJ9zmffvIucG08I/M5O8fJsotyq+Rg1
         C5rdy2+eyB3Pb8r0EoyZC86gIbyxGhAPhxtv2jGuRi6J3hvXTpl2mF8bLm7INpqxEBgV
         uaMDg1B+eoCvB/iib0nL0Fw/Tnc2jWt/AkxqrRxgQYRy472VV0wLlhz60CjiWwvBuHQx
         0V/i23lEl44TcUaex3Spp3C1Lr4lM/Q0LRkS8HLtD6e1hKTxqf1J+gbB0P+I3uE1dCTZ
         OAxfWm+1593CmY70dgFfyqoYzJor5Dx2I4BZyHYqKlPHXwrPYUypUyxhg4liN8ZdZEnr
         IB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srTgiDQyJ+iHlVvY0oO/Aj8hpbQB5lmra+IabD+2tas=;
        b=GW+ETY2hqtdxigaEXyYFRUNr8v1+bBAHTIBD4VcrI/yi9/rlB1BJcliCs1i0MGsWeb
         UYgnQBk9BUpyjFLVkUUMwtFE2G2ewN6FxvpknpuR4rfAIhRQkyA6N6CEoMTsZaB/JNLT
         Yladx6WClwRSsqxh7TP6MDy9W2LekQzX5R1hlnxK0T8b/PHhlddJq1Cif32Aed3xotmI
         JHpcQYtCdFnLMF+E5SUAon92ghriHlIYNcMmMqDJl1mEIK3e/kCEFkymRwjrHAGGUYX5
         uQ3Wpu+eRhhd9+5BztGQtQWeaXDBYlK8acR3uRiMTQ6RPBgOwkI7+tkyAX9aUspwN5lo
         4RsQ==
X-Gm-Message-State: AO0yUKVf9zL4L33UmygsR1+tqdGuJeQLqT2na2nSypeRYp6iE7MAd61J
        W/JEKnc8UvIONDoRJ3ohJWA=
X-Google-Smtp-Source: AK7set/cp3oPJOKJX30WddGkb0514ZWNs4+qzJemmxj5EQWE8Fx2pg/T202ZaqVJmQ0olB5NLNI+0w==
X-Received: by 2002:a2e:870d:0:b0:295:a7f3:521b with SMTP id m13-20020a2e870d000000b00295a7f3521bmr1728192lji.13.1677338142446;
        Sat, 25 Feb 2023 07:15:42 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i124-20020a2e2282000000b00295a43fa3dfsm190159lji.76.2023.02.25.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:15:41 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
        <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
        <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
        <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
        <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
        <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
        <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
        <87a615vkqk.fsf@osv.gnss.ru>
        <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
        <87bklilnvp.fsf@osv.gnss.ru>
        <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
Date:   Sat, 25 Feb 2023 18:15:40 +0300
In-Reply-To: <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 24 Feb 2023 15:59:36 -0800")
Message-ID: <87fsatixnn.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Feb 24, 2023 at 2:06 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:

[...]

> Please, go read at least [1] to see Johannes comments about how the
> prior proposals don't work beyond simple cases.

It's exactly handling of simple cases that we need most. We can get
fancy afterwards, if feasible.

Thanks,
-- Sergey Organov
