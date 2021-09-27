Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706CDC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 11:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A4360F46
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 11:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhI0LDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhI0LDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 07:03:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264BC061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 04:01:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g7so8097475edv.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GxPCnal1F/yde5OUwAX3XyzcXtmg7IU8Qc7A+LE2Vqs=;
        b=m1blf7hL+I72Jwxw2o/UgaSE5DmKGQ2A8VQG7Ny9iGRwpUPLMKR12AdTvxkro91akz
         X1EdG1ENauXe6TtcS3qbgtEaPNKLugkpSbtYl3pxhj3Oxe14W0nF63tRApdkC8Vrl8yQ
         qiIspkL3QL6z9EeYKiC20a9C8gLRSkzRG0VSQro8krR5+XOV+Thfe+9NmrOka1ePuKFt
         ek2ms7bc8YwPn4TT6HCQloOllXxz3ZRtGnIvNDmqdqC61dm+4rl1uTaoQGUXkM99yhge
         cQxq7Blzsen2PVGtvAWtgA6TdUIQjakKBILngysoXRDhxmBW9dGP2oylw0R4yhzUhG7Y
         r/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GxPCnal1F/yde5OUwAX3XyzcXtmg7IU8Qc7A+LE2Vqs=;
        b=GevnNHWG5MVHcvz75msd2/bcLJ5A0hbhzNQAJJKBUYbVZhQ+2Iux/X7meHf/yFxa8X
         UOz5y+WWt9gc/JWxBoEZ2vSP9OCu5c+ccs3SCkZ0GsJZuUbQ1AaJGWl0sj4WDLarggOm
         HECYORyN+JdaQtwhYKhX/BIZQZ9qOUyrD9ZT/pie1g77PIMC6DlL9mqA+6R7qU4O+lB8
         I+E6dYJie2AWFBBAhRsyt3WNGG3hQq+6dr+0Qp7KwJnWnmKIc+NkDs8O5rT8qIBoYED9
         yOnq/rXOXzfdNpzLVC+BJwmByzeNDhMMcmoUWcUtH/rllWxR+AWtj15jcb6HksPOk2dS
         HZ7g==
X-Gm-Message-State: AOAM530x3O/86aLxn3h0PyPSni3u9Qf+Dvcsotrzw37kPyTrUfAXf9E4
        AXfPHwAc6mEbmW+J7mJxNVg=
X-Google-Smtp-Source: ABdhPJz9oTG0m96LV4ulk/ZfEqGaEKiExcZGsGOPnBafBvlxB0vPFrG9MdsDT4//5PSKOwFWjURJ3Q==
X-Received: by 2002:a17:906:b05a:: with SMTP id bj26mr7374873ejb.226.1632740516702;
        Mon, 27 Sep 2021 04:01:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g6sm10130512edr.15.2021.09.27.04.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 04:01:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Date:   Mon, 27 Sep 2021 13:00:01 +0200
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
 <ef724a3a-a4b8-65d3-c928-13a7d78f189a@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <ef724a3a-a4b8-65d3-c928-13a7d78f189a@gmail.com>
Message-ID: <87h7e61duk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 27/09/2021 01:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Use the same pattern for cb_init() as the one established in the
>> recent refactoring of other such patterns in
>> 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
>> macro, 2021-07-01).
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   cbtree.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/cbtree.h b/cbtree.h
>> index a04a312c3f5..dedbb8e2a45 100644
>> --- a/cbtree.h
>> +++ b/cbtree.h
>> @@ -37,11 +37,12 @@ enum cb_next {
>>   	CB_BREAK =3D 1
>>   };
>>   -#define CBTREE_INIT { .root =3D NULL }
>> +#define CBTREE_INIT { 0 }
>>     static inline void cb_init(struct cb_tree *t)
>>   {
>> -	t->root =3D NULL;
>> +	struct cb_tree blank =3D CBTREE_INIT;
>> +	memcpy(t, &blank, sizeof(*t));
>>   }
>
> Slightly off topic but would this be a good site for a compound
> literal test balloon?
>
> 	*t =3D (struct cb_tree){ 0 };
>
> Compound literals are in C99 and seem to have been supported by MSVC
> since 2013 [1].

I think that's a good thing to test out, FWIW I've also tested it on the
IBM xlc, Oracle SunCC and HP/UX's aCC, they all seem to accept it.

But I'd prefer just doing that in some general follow-up to bd4232fac33
(Merge branch 'ab/struct-init', 2021-07-16), i.e. let's just use the
init pattern it established here.
