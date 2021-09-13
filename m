Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A13C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB87360EE5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhIMD6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 23:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbhIMD6w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 23:58:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D459C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:57:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j13so12178065edv.13
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xx6R25rJKVCTSqdZ2rdiSHp8gLyIEklIie5l8R04f80=;
        b=EZtDAc+P1U3naMPWcNPc3yZSr6jLolFI/wb0gj5KlPcY54HqSw5NKUswOiVH8043YX
         1oisN5Jsazmry88lk0Mvyh/Z0TXZrJqEI53bej4Md5ict1p9EmVeYrjCrIM18QfcUhUm
         Q8E/EPT2U8kO5aVHK1Fl8xALOHgNsYQoVRaHZpHTHMWjzqDvCJiSOnd910Lj5zM3nw9F
         qgY/NFb2I4meY/saZxnYxlhjvLj0UfBKkN3jQJdsRf5ca51fBp7UlCRbgr9s5Fdk6gQX
         kLxKYLxJ3AiqoofdCZjG+sJ05RLO9S9/yEcnf/C+XDzhp36x4BXgA39V/Py33t10JYoy
         brOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xx6R25rJKVCTSqdZ2rdiSHp8gLyIEklIie5l8R04f80=;
        b=jGZk0CWOPa0ll9bbTH9OVyBvKYvW6gcs567GLo8DxFNUOvdSTjLYy7kF+vJPdUz9o9
         jAHcNvv9O6uE+sFJZkVieRk/NpedWNLffih5Qg+v4yH81gRAgnhfh3YEZMilsOJGPsso
         uK6sgKSmg4O1TDCcaSiMBs9XcipZsI5YHCt3aK7aFPtuq7iAezx5PKGf0zAQtc+Kxak6
         I1hnNAnOwXjDp15vySNBkwThTBD42thf7mL7uPAVg8TC+vFxvyci7tnPMt8BDLV+2Ean
         bS6WVJDMueXp8mg6mHPGF4vAMkveFOVWwRHL61h/3j/9y0SBSdBS2zr2IkScJ6GGB5hU
         wpnw==
X-Gm-Message-State: AOAM530wInehR/V4aQA/jIRcrb8d4rZtOm0IcyKSzIWVJ6YpI0gHBiDI
        VKJlAYRjzCo/68PCP7eEyt0=
X-Google-Smtp-Source: ABdhPJzoolsyLVj/gHgiMLLcE4zZn/8EskpeiMxJGYLiHcEcx9I067yLHbQ7y0ZrWWiHsPv9rzOT0w==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr10900410ede.332.1631505455290;
        Sun, 12 Sep 2021 20:57:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id di4sm3189427edb.34.2021.09.12.20.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:57:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 1/7] remote-curl: pass "struct strvec *" instead of
 int/char ** pair
Date:   Mon, 13 Sep 2021 05:56:45 +0200
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
 <patch-v2-1.7-2ef48d734e8-20210912T001420Z-avarab@gmail.com>
 <CAPUEspizWWigu4yb_fK1kmzJDx7G0JUOFmRsAfaKeuvTPrk4bA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPUEspizWWigu4yb_fK1kmzJDx7G0JUOFmRsAfaKeuvTPrk4bA@mail.gmail.com>
Message-ID: <874kap5dqp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 11 2021, Carlo Arenas wrote:

> On Sat, Sep 11, 2021 at 5:16 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> We'll be changing the "int nr" in the "struct strvec" to "int size_t"
>
> Did you mean "size_t nr"?

Yes, will fix.

>> -static int push_git(struct discovery *heads, int nr_spec, const char **=
specs)
>> +static int push_git(struct discovery *heads, struct strvec *specs)
>>  {
>>         struct rpc_state rpc;
>> -       int i, err;
>> +       int i;
>
> you are already splitting them, why not then change 'i' also to be a size=
_t?

The conversion to size_t comes later in this series, this is setting
that diff up to be smaller. I.e. we'll then to s/int i/size_t /g.
