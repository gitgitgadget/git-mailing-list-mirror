Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B2EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA866115C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351998AbhIHTiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350546AbhIHTiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:38:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC2C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:36:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u19so4441948edb.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SqPLJCcyj8z6wwdxyoE859AAoiouNjV2luQ4PRJmjkc=;
        b=PUWpOCfsjaz9vNETYBRKyNBiHuc+59G6QWRQwso7bY1cIZQWRH7eKpoEMkSjMfmwIN
         TJUIUi2+P4kNg7A04YYyxAZ6kXo+DvmzOCqPAxp0r7QvC/hay+KyX5P7zwmvWW07i2dw
         pxs7U4+Da3auCDUNidbBoA0k4BDCULXjPQviIxoIPkAD4yG8h33TWIBcD+UtSl5nj9M1
         p/JK1QxjiVIlObOvIDKwBgK8sNgWqyI5bh4/QCe9chhU7eMv55MqRgqOf7iwHivLOx6M
         o6RHPA3EdCYeT7XUe76oa6aPgKdocQZjM1JHc8bN6fxDqzx2o44xol9+sYF+NozlunM6
         IkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SqPLJCcyj8z6wwdxyoE859AAoiouNjV2luQ4PRJmjkc=;
        b=4nBkg6XK1+kBo7lpfq8hnbK9uOtrRdlBi4V70e/PZ2T8G/wCyIDx0im9Xs0fM792RI
         fH4bjdBQ9ubCguQalhkZlDKTBzFYjTjV9lwUTQuGepK6JqndLgUsK2EeNkg/VPBFfgX5
         SVEaB5+UKHBuAo/IxsaVYIFqP6vodLgFIVsB08aQMe6MwR0dzjgsiFPVJkEFcdVw53Gv
         W72OyB/fyXm2ep5pWgGcjMIf+mWjFERPFcBz5g6FRMC4srR85CJQNYfpwi5JDQYUTy0O
         El2mAGuvW/qF1lEGmpBrV7xvCX6qUiNDsxulznG/ZXeZzaP+xXzt1Ipbnj0sGA3jPH7O
         UM/g==
X-Gm-Message-State: AOAM5332DsGM1l1Y0++DYebp/WK6psxBAMTTFHZL15MqkTkryrGzoGNJ
        KqHyianofNDur40qzIHaEbI=
X-Google-Smtp-Source: ABdhPJx3FtG+AobmqUHObueoiMooA6fvPhuSyu6goXWkPKxuXA948QeguNLOJPd8p3fAhlqg4kuWbg==
X-Received: by 2002:aa7:c9cd:: with SMTP id i13mr5618292edt.178.1631129811407;
        Wed, 08 Sep 2021 12:36:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j14sm9140edk.7.2021.09.08.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:36:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 4/6] help: refactor "for_human" control flow in cmd_help()
Date:   Wed, 08 Sep 2021 21:36:04 +0200
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <patch-4.6-e4bc7e57a6d-20210908T151949Z-avarab@gmail.com>
 <CAPig+cQVsFvkLMXrm7d3mCUoJKj7x+0PNcAYJ0-uFHaqbRw0ag@mail.gmail.com>
 <xmqqsfyf3srv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqsfyf3srv.fsf@gitster.g>
Message-ID: <87fsuehnal.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Wed, Sep 8, 2021 at 11:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> Instead of having two lines that call list_config_help(for_human)
>>> let's setup the pager and print the trailer conditionally. This makes
>>> it clearer at a glance how the two differ in behavior.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>> ---
>>> @@ -574,13 +574,12 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
>>> -               if (!for_human) {
>>> -                       list_config_help(for_human);
>>> -                       return 0;
>>> -               }
>>> -               setup_pager();
>>> +               if (for_human)
>>> +                       setup_pager();
>>>                 list_config_help(for_human);
>>> -               printf("\n%s\n", _("'git help config' for more informat=
ion"));
>>> +               if (for_human)
>>> +                       printf("\n%s\n", _("'git help config' for more =
information"));
>>> +
>>
>> For what it's worth, I find the original logic easier to reason about
>> since it gets the "simple" case out of the way early, thus I don't
>> have to keep as much (or any) state in mind as I'm reading the rest of
>> the code. However, it's highly subjective, of course; just one
>> person's opinion.
>
> FWIW, it makes two of us ;-)
>
> Quite honestly, I do not see much commonality in the code above that
> targets two different audiences, so whether you handle simple one or
> complex one first, a single big switch upfront that gives clearly
> separate control flow to two distinct cases is easier to follow than
> "as the middle step that calls list_config_help() is the same, let's
> have two conditionals before and after and serve these two audiences
> with a single code path that is slightly tweaked", which is the
> result of this patch.

What do you two think of the end-state of this in 6/6? I went back &
forth a bit with whether to keep this similar to pre-4/6 logic, or the
switch statement in 6/6, and then for that switch statement whether to
have the fallthrough case or not. Perhaps 6/6 with no fallthrough (but a
bit of duplication) is the best?
