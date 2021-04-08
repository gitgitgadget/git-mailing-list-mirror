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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75F1C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7768961159
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhDHU0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHU0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:26:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F9C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:26:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c6so3817676lji.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jO85N8moQapmdKEpgkCKjVbeYyYwhbpgRSxtsq1wgD8=;
        b=CtpcOlbbIu31gvz6g7FAFEsHw+WwDAQ6ygmbvitF6Tvn5seFdqLvcvJ21b4pbvDzCF
         VpC8VrW1gN6drhhfQvgxE7O6EgvdVIJV6KM6RjqdXceoMlfBJFCF2uFicr5T9ySNimdk
         EhPPHFs8im1y2eyjDvg5wbeskZwKkKGVuhoGAHnSmdRUckmpIDGonHtw6q6KRBCtWwv7
         8hfgEAJhxwMUrqSk3oSeixOQJP5zDVibtdG/306ZLzFtf7LFvhXeZPmINaP9MGsnREQ+
         YnqVH55yLCf6BwxtUFQ6rnJbRNR+XKgxt+jS2XLJLgzbwJsyjx/LNR39Xe5WGqM13L8w
         KSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=jO85N8moQapmdKEpgkCKjVbeYyYwhbpgRSxtsq1wgD8=;
        b=NDPF/JxGms09r8nKrXCdCrk/NiDtTtddE/jlCwlRU4fweHiF4HbowCk7Z5kM1xaFXY
         Nb2z+ZmRZDAOC5somuuE2gViw+hRw3jMJUDyaMbcVBSc0IKVwJ4G+5QOeKcKsCO4c12N
         gloyMG/uMppB+UtkDqZNOWgj6UQhyq8Mx/VUNawAP3UcBL1++ZwrIaRk5XlIokdAHDZT
         obr3VnpIVsFaOpDSO/oiYXBR9dGHXxR+pflO1jx00BQbvzAg89C/iq1/IfbquV57ewXV
         Wz55Hxp2fWP1/cq/+SmfdDqSthccFyZHo8m0zgBmMxP/GttzumR9iZ3HyEi/L5ET46Cj
         CjsA==
X-Gm-Message-State: AOAM531NrR5O5m/uJg/ZC7CeWHL4gHKVV8J2BI+1xhrKUHPr8WeObrNz
        3fxUOJOutkH1DTBE1+n2YfbyXy8XdZ4=
X-Google-Smtp-Source: ABdhPJwFurz+b2tsGp+n/c94yMxkw4RU/12p2i3V1r9dcLz+OE5DgY9HKm1j9vaYDm2tjhEyIqLWsQ==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr7293909ljc.313.1617913599864;
        Thu, 08 Apr 2021 13:26:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 10sm48565lfg.157.2021.04.08.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:26:38 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "Philip Oakley" <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/9] t9902: fix completion tests for log.d* to match
 log.diffMerges
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-8-sorganov@gmail.com>
        <87y2dtitlp.fsf@evledraar.gmail.com> <875z0wdekf.fsf@osv.gnss.ru>
        <87sg40imit.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 23:26:38 +0300
In-Reply-To: <87sg40imit.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 08 Apr 2021 21:50:18 +0200")
Message-ID: <87k0pc7cap.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 08 2021, Sergey Organov wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Apr 08 2021, Sergey Organov wrote:
>>>
>>>> There were 3 completion tests failures due to introduction of
>>>> log.diffMerges configuration variable that affected the result of
>>>> completion of log.d. Fixed them accordingly.
>>>>
>>>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>>>> ---
>>>>  t/t9902-completion.sh | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>>>> index 04ce884ef5ac..4d732d6d4f81 100755
>>>> --- a/t/t9902-completion.sh
>>>> +++ b/t/t9902-completion.sh
>>>> @@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
>>>>  	test_completion "git config log.d" <<-\EOF
>>>>  	log.date Z
>>>>  	log.decorate Z
>>>> +	log.diffMerges Z
>>>>  	EOF
>>>>  '
>>>>  
>>>> @@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
>>>>  	test_completion "git -c log.d" <<-\EOF
>>>>  	log.date=Z
>>>>  	log.decorate=Z
>>>> +	log.diffMerges=Z
>>>>  	EOF
>>>>  '
>>>>  
>>>> @@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
>>>>  	test_completion "git clone --config=log.d" <<-\EOF
>>>>  	log.date=Z
>>>>  	log.decorate=Z
>>>> +	log.diffMerges=Z
>>>>  	EOF
>>>>  '
>>>
>>> Commits should be made in such a way as to not break the build/tests
>>> partway through a series, which it seems is happening until this
>>> fixup.
>>
>> Yep.
>>
>> Could these tests be somehow written in a more robust manner, to be
>> protected against future additions of configuration variables that are
>> unrelated to the features being tested? If so, I'd prefer to fix them as
>> a prerequisite to the series rather than adding fixes to unrelated 
>> existing tests into my patches.
>
> Hrm? I mean if you have a commit fixing up failing tests in an earlier
> commit then that change should in one way or the other be made as part
> of that earlier change.
>
> Yes we can skip the tests or something in the meantime, which we do
> sometimes as part of some really large changes, but these can just be
> squashed, no?

I mean I don't want this change at all.

I didn't change completion mechanism, so completion tests should not
suddenly fail because of my changes. I did entirely unrelated change and
noticed the breakage only by accident, as tests even don't fail unless
you *install* git, not only make it. So, for example, just "make test"
doesn't fail, while "make install; make test" will.

It looks like something is wrong here, a bug or misfeature, or even two,
and if it's fixed before these series, I won't need this in my series at
all. Besides, that's yet another reason *not* to squash this change into
an otherwise unrelated commit.

-- Sergey Organov
