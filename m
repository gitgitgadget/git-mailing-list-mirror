Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B74C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 07:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40F360FF2
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 07:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhISHhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 03:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhISHho (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 03:37:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FACC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 00:36:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c21so47394597edj.0
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AtnzmbpGb0PXiU4Lx4CeA14Xrda8kvhau43TMQuvXgM=;
        b=gjnEIZN/SwdYvLpPb51tPetVtZh6tlSc/lfUZUXjRqljnv6n3cdJkFBu7WWMyAXZFX
         ezkESR2/3zZVSTeZH1OUNdoEEn7KojL3ufzAcSY45nTQI3/lrUHTBYImJXrN6qV0PH3/
         OuKtSLuBGknvZwiV0oFZusTcltIk+H+7DMLpC6k533Vi0Kg1EqSZnioIjlkR//OfIk4y
         UgSyO+UXyVz0U0PDm9en3ONcIdPGJsnPCeGLYFxyErFYCs/dT1I/7s2LqIQ49ZijgfZG
         /5ZYmKB9697GO93iAAZAO3002+jQYMZr9XrRGuxxikZv7BX3W7nPTmH+5wj0drzyW1i9
         2g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AtnzmbpGb0PXiU4Lx4CeA14Xrda8kvhau43TMQuvXgM=;
        b=Ronu+g1Ld96FBCXDXE9ReTdvhucWDus74yKmiyEL7IZZqiwJixirmXqLCkrT3oiYO3
         clmOZ1Yz3be/ygqlX7fc38u2tB4VxZsDUrKXEJu9Llyb1u5tiyRpCwmy3q2nRr0Tgry4
         rg5a+wq9KFyCBpKrX0b1OqMeOfjO3wMw9OtTGR0LcHI2vdR4Y2qXUGIWKc6/hR6u1L+o
         U7+wPzAy8uGZIS9rndI80f3Dg81awVfjnlMgJCFNFlBvs0la8JnRPfFJ88gB9xLQpYe+
         7mlnT0rNa8sDrD7r1n9Ja0QUlS9vvuBvmqgE+LkAfLDozMDOd6kVvVJBHaZZD+4Geg4M
         q0Wg==
X-Gm-Message-State: AOAM533UIpcUjVP3jPnYmisZnw/yaDzvDlv1OQmrmcw5L4HtPuE8EVqz
        nNBHrU3zbxONORFZc5sa4y2pgPV5Er0=
X-Google-Smtp-Source: ABdhPJyOuEFAbpxog+9ccnjdTHxW2uq9ZIsxd2l4TJDZopG5//zVju9SwOzQNujDQR8oZpRxrzj97w==
X-Received: by 2002:a17:906:1f09:: with SMTP id w9mr19125893ejj.472.1632036978147;
        Sun, 19 Sep 2021 00:36:18 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gl2sm4512377ejb.110.2021.09.19.00.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 00:36:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] range-diff: make output format more useful for
 "rebase --onto"
Date:   Sun, 19 Sep 2021 09:34:59 +0200
References: <xmqqv92yg5y6.fsf@gitster.g> <87r1dmcooj.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87r1dmcooj.fsf@evledraar.gmail.com>
Message-ID: <87ee9lc8zz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Sep 17 2021, Junio C Hamano wrote:
>
>> In a range-diff output, we often see an early part of an updated
>> series having no changes since the previous iteration.  After
>> applying an updated patch submission to the same base as the
>> previous round,
>>
>>     $ git range-diff master..topic@{1} master..topic
>>
>> to view the differences since the previous edition, we might see
>> something like this:
>>
>>     1:  9a05f02b1d =3D 1:  a05f02b1d9 t/helper/test-bitmap.c: add  ...
>>     2:  78de300e1f =3D 2:  8de300e1f7 pack-bitmap.c: propagate nam ...
>>     3:  7caca3c9f0 =3D 3:  caca3c9f07 midx.c: respect 'pack.writeB ...
>>     4:  72082224f1 =3D 4:  2082224f17 p5326: create missing 'perf- ...
>>     5:  097b89c815 =3D 5:  97b89c8150 p5326: don't set core.multiP ...
>>     6:  a1dd4c97b9 < -:  ---------- p5326: generate pack bitmaps ...
>>     -:  ---------- > 6:  bf4a60874a p5326: generate pack bitmaps ...
>>     7:  2b909ebad3 ! 7:  54156af0d6 t5326: test propagating hash ...
>> 	@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitma=
pTips' '
>> 	 +	(
>> 	 +		cd repo &&
>>     ...
>>
>> Now, after noticing that up to step #5 there is no change since the
>> previous round, cleaning up the application result with
>>
>>     $ git rebase --onto 097b89c815 97b89c8150
>>
>> will help making it easier to see that earliser part did not change
>> before committing this in the longer term history.
>>
>> The output format of the range-diff unfortunately makes it a bit
>> cumbersome than necessary to come up with the rebase command line.
>> Because "=3D 5:" gets in the way, copying the two object names from
>> there and pasting them as the command line arguments to "git rebase
>> --onto" becomes a chore.
>>
>> Tweak the output so that the change numbers and comparison sign come
>> first on the line, followed by two object names and then the title
>> of commit, to make it easier to copy the two object names together.
>>
>> The updated output format looks like this instead:
>>
>>     1 =3D 1 a05f02b1d9 a05f02b1d9 : t/helper/test-bitmap.c: add  ...
>>     2 =3D 2 8de300e1f7 8de300e1f7 : pack-bitmap.c: propagate nam ...
>>     3 =3D 3 caca3c9f07 caca3c9f07 : midx.c: respect 'pack.writeB ...
>>     4 =3D 4 2082224f17 2082224f17 : p5326: create missing 'perf- ...
>>     5 =3D 5 97b89c8150 97b89c8150 : p5326: don't set core.multiP ...
>>     6 < - a1dd4c97b9 ---------- : p5326: generate pack bitmaps ...
>>     - > 6 ---------- bf4a60874a : p5326: generate pack bitmaps ...
>>     7 ! 7 2b909ebad3 54156af0d6 : t5326: test propagating hash ...
>> 	@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitma=
pTips' '
>> 	 +	(
>> 	 +		cd repo &&
>>
>> Incidentally, it becomes easier to see the correspondence and spot
>> the reordering of the commits with this change, for the same reason
>> why it becomes easier to see the two commit object names---they sit
>> close to each other with their peers.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * Obviously an RFC.  The output format would be fairly subjective,
>>    but I do not care deeply enough to make it configurable.  If
>>    enough people appreciate the convenience of seeing the two object
>>    names and two change numbers next to each other like I do, and
>>    nobody processes the current output with tools, then it may be OK
>>    to take this patch as the final version, but otherwise, this is
>>    only meant as an inspiration piece for somebody else to have a
>>    mechanism to allow the output configurable in some way (which I
>>    am not intereseted in doing myself).
>
> I think we carved out a sufficient exception in df569c3f31f (range-diff
> doc: add a section about output stability, 2018-11-09) to just change
> the output.
>
> I do happen to have a one-liner as part of my build process that relies
> on the current output, but I've only got myself to blame. Aside from the
> change being proposed here I think we can just change it in general if
> we come up with better output.
>
> As for the proposed output, I'm a bit negative on it, so first, if we're
> trying to note that two commits are the same wouldn't it be much better
> to just omit the second SHA-1? I.e. consider this variation of your
> proposed output;
>
>      1 =3D 1 a05f02b1d9 a05102bfd9 : t/helper/test-bitmap.c: add  ...
>
> You might eyeball that for a while before discovering that I switched
> the "f" and "1" around, i.e. the SHA-1s look /almost/ the same. Isn't
> this better? (or we could use "++++++++++" to not overlead any meaning
> "----------" has):
>
>      1 =3D 1 a05f02b1d9 ---------- : t/helper/test-bitmap.c: add  ...
>      2 =3D 2 8de300e1f7 ---------- : pack-bitmap.c: propagate nam ...
>      3 =3D 3 caca3c9f07 ---------- : midx.c: respect 'pack.writeB ...
>      4 =3D 4 2082224f17 ---------- : p5326: create missing 'perf- ...
>      5 =3D 5 97b89c8150 ---------- : p5326: don't set core.multiP ...
>      6 < - a1dd4c97b9 ---------- : p5326: generate pack bitmaps ...
>      - > 6 ---------- bf4a60874a : p5326: generate pack bitmaps ...
>      7 ! 7 2b909ebad3 54156af0d6 : t5326: test propagating hash ...
>
> (Or whatever other syntax would follow from the shorthand of the "1 =3D
> 1". Having it repeated in the human-readable output just for the one
> use-case of passing it to rebase --onto doesn't seem worth it.
>
> But then if we get support for say --ignore-matching-lines (which I've
> wanted to for a while to omit the Signed-off-by lines you add) we'll
> note the same SHA1 if you used that option, but a different one in the
> same slot if you omit it (i.e. we'd start showing that part of the
> diff).
>
> Then combine that with --left-only or --right-only and we'd ignore the
> diff depending on what "side" it was, and then either duplicate the
> SHA-1 or not.


As a follow-up, this proposal really mixes two things, the appearance of
the text format & its semantics. I.e. it's changing (1)

    1:  9a05f02b1d =3D 1:  a05f02b1d9 t/helper/test-bitmap.c: add  ...

To (2)

    1 =3D 1 a05f02b1d9 a05f02b1d9 : t/helper/test-bitmap.c: add  ...

Not just (3)

    1 =3D 1 9a05f02b1d a05f02b1d9 : t/helper/test-bitmap.c: add  ...

I happen to like (3) a lot better to format the existing information, it
emits the "1 =3D 1" so you can see at a glance what maps to what, but I'm
not sure about (2) as a semantic change..
