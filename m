Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C68C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiCASaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiCASay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:30:54 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926B1D327
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:30:11 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h14-20020aa79f4e000000b004f3aa388c1fso10233870pfr.6
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=va3fC7wqqGUeJ9hTkaIQYY57aXLHdxP7nv/I8lSuXbI=;
        b=Dp1fps7msRAjcv0NUI47zsXh6ikcly1YcBE4foY81VaN7MV96rNMwi1D7SW8+79vxT
         xGopB5Q7R/ICT1u+6sqD3rCh4WLyCHChxP2OXYbF7nvouSv7O0FMOWyEQ4Ty1WzFTy4o
         KtIvM/StwP/swoY9zZwp+NDncYeFK2ydW/t2q6wLLIPPaSkOW6YMefmD+vm6h+mTGvlY
         WfCYWA4uHKrFdBaKL4zWFP3S25jFUiL8PTSmHxdX+tD5TzrhOi9MGddd8TpEEQS8uD9o
         o8CeT0EpER0opK087csbPwGCrE/PF7P7zUCU1xcAeF4qEsYaZoTuvYJLbQDXluir67kQ
         kdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=va3fC7wqqGUeJ9hTkaIQYY57aXLHdxP7nv/I8lSuXbI=;
        b=0OB5KwH2aMuUCoFWi+8rpXUy+uQjNLkrevjXJCGsVyRyY/zo18eoYtek0TBggfyNJy
         ITaLc6JyoY0GHZ01FdW7sldiyEJrN+TPeGHRkAxmPWSvfR9YnxDrU9gGXmZPtV7jMD0y
         WRiwzewYE4IJ0ZyvhUPOSLl51fhgbhVsWbmZhgwhqopYMWtF6ypyMUFlGjgr7ju5mFV7
         rnizHq7bEgkJqy5Z2T+rhoTQOn8PuXb5FngzlmT42MBHruYr3yMVBky66VYl79Hj/+qK
         CTPQZGHDvYf7bbyUONUSSIBj0v2QUy3/2lxk7paF1CZiUmMaBHSOA/WjXVLvjTx8/K0p
         Q1gg==
X-Gm-Message-State: AOAM531eCGp79ciBn93FQ/13bQ0xCboF3LFLUYkRcW4NsnPBWxN7/JDB
        5Dv1WkaWD6asRKdCyllvbbbMmsUs0WxfbQ==
X-Google-Smtp-Source: ABdhPJy6UnzwSdrgAYNEwhCyYTkbo8nlidm51UUO/rwNCKNIu/lMy8wQSdgIYWxXf+t4Nk+qdwokZeWhGfswWA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2481:b0:4f4:2662:bb4b with SMTP
 id c1-20020a056a00248100b004f42662bb4bmr6216953pfv.49.1646159411070; Tue, 01
 Mar 2022 10:30:11 -0800 (PST)
Date:   Tue, 01 Mar 2022 10:30:08 -0800
In-Reply-To: <220301.86bkyq14e9.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lo82pedan.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
 <20220301044132.39474-13-chooglen@google.com> <220301.86bkyq14e9.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 12/13] submodule update: add tests for --filter
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Feb 28 2022, Glen Choo wrote:
>
>> Test the "--filter" option to make sure we don't break anything while
>> refactoring "git submodule update".
>>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>  t/t7406-submodule-update.sh | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 7764c1c3cb..6cc60ff5e5 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -1071,4 +1071,17 @@ test_expect_success 'submodule update --quiet pas=
ses quietness to fetch with a s
>>  	)
>>  '
>> =20
>> +test_expect_success 'submodule update --filter requires --init' '
>> +	test_must_fail git -C super submodule update --filter blob:none 2>err =
&&
>
> Should be "test_expect_code 129" (presumably, or is it 128). In any case
> other similar "usage" test check for that:
>
>> +	grep "usage:" err
>
> We could retain this then, but FWIW if it's 129 other tests consider it
> redundant.

Ah, thanks for the tip. I forgot that this is how we check for usage.
