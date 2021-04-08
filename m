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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934CDC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67209610FC
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhDHTud (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhDHTud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 15:50:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54546C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 12:50:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hq27so5012575ejc.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9Y3ZhL3j4NsXuoGvcNAuRQMHwZPoWtwdKjuu15f4HTg=;
        b=k5gpRFXl8AIlm3IV2JAfkMxc3DHkOhWRKRziy0pYBgNT1jXG+ZxmBacPMwIVHw3Nty
         nWOWhGzO41zVouz6xyC0QTG4hJkXSSeEcyrqzwp2AyKL5Ws6BlxGybzBH3fBc7P9sI1u
         Fy4TVQ31rVSAcz0iO6FgGEVutbs50Y0HIhVKKqGrctDoFHPnmNU5UnZBczg2TyfCiulY
         dWVCx6Wukjb42Vtu3iqD4APaIGoTsZhddd9EFIYQoQtEXXY7lDxERi3Xj4nLOK1OAvlH
         f0n5IS+VQEzC/3onfULbMgNu7tu56hXM9BKLaCR9MHawXF4Rog73BLpChtsrcOPxVzQr
         fCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9Y3ZhL3j4NsXuoGvcNAuRQMHwZPoWtwdKjuu15f4HTg=;
        b=Oc1iLZ0DHZtj9MPyB0XIj8GbUsWHcxTUUaC9JcJQqXw95R+WWPNFCt6mI01Dm0+2Mp
         t1DCoxrK+m2I1QpTjnE/fjfXMwMtiqXVyCWEi/JDePRrVfMcgDJeg2QodlpRA6uWS3oc
         G3JQ+48npXm7Rah8/10+o0YP64Ujl5YNzkcNIlnkkJcW50rpTCvlPH+swD4+lwPmZ8ZJ
         DZdjeFbiZl9P5ONpNSmkUn3iBg6pmkCAH70biNfoGsV2Vwi0EYe5eh+RB3QRmIKGia/4
         yfE/e3XR/KVM7R8irRPiYbmwuYgr0x5P2mDCDOwYw4fNfDpdq4CB1R199nLKLXzU6dNs
         vi/g==
X-Gm-Message-State: AOAM530AvLBxFp+2icjbdXOM7/PmFcIDqJy3/sKLqXe1fble37hd1cXY
        k7TIrOPWkzUAXJLpJcbR7qw1mtn89ltU+A==
X-Google-Smtp-Source: ABdhPJw0a/rZrIjD/XxWJJ4RZmyqL8vaUv1Q5wx1eJGgAnSx9RnfTqUzg7EICp1cxZlz4w5927h5+Q==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25mr3959745eji.268.1617911419993;
        Thu, 08 Apr 2021 12:50:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q12sm161162ejy.91.2021.04.08.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:50:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
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
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <875z0wdekf.fsf@osv.gnss.ru>
Date:   Thu, 08 Apr 2021 21:50:18 +0200
Message-ID: <87sg40imit.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Sergey Organov wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Apr 08 2021, Sergey Organov wrote:
>>
>>> There were 3 completion tests failures due to introduction of
>>> log.diffMerges configuration variable that affected the result of
>>> completion of log.d. Fixed them accordingly.
>>>
>>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>>> ---
>>>  t/t9902-completion.sh | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>>> index 04ce884ef5ac..4d732d6d4f81 100755
>>> --- a/t/t9902-completion.sh
>>> +++ b/t/t9902-completion.sh
>>> @@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
>>>  	test_completion "git config log.d" <<-\EOF
>>>  	log.date Z
>>>  	log.decorate Z
>>> +	log.diffMerges Z
>>>  	EOF
>>>  '
>>>=20=20
>>> @@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
>>>  	test_completion "git -c log.d" <<-\EOF
>>>  	log.date=3DZ
>>>  	log.decorate=3DZ
>>> +	log.diffMerges=3DZ
>>>  	EOF
>>>  '
>>>=20=20
>>> @@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config=3D - vari=
able name' '
>>>  	test_completion "git clone --config=3Dlog.d" <<-\EOF
>>>  	log.date=3DZ
>>>  	log.decorate=3DZ
>>> +	log.diffMerges=3DZ
>>>  	EOF
>>>  '
>>
>> Commits should be made in such a way as to not break the build/tests
>> partway through a series, which it seems is happening until this
>> fixup.
>
> Yep.
>
> Could these tests be somehow written in a more robust manner, to be
> protected against future additions of configuration variables that are
> unrelated to the features being tested? If so, I'd prefer to fix them as
> a prerequisite to the series rather than adding fixes to unrelated=20
> existing tests into my patches.

Hrm? I mean if you have a commit fixing up failing tests in an earlier
commit then that change should in one way or the other be made as part
of that earlier change.

Yes we can skip the tests or something in the meantime, which we do
sometimes as part of some really large changes, but these can just be
squashed, no?

>> Having read this far most of what you have in this 9 patch series
>> could/should be squashed into something much smaller, e.g. tests being
>> added for code added in previous steps, let's add the tests along with
>> the code since this isn't such a large change.
>
> In general, I try to make commits as small as possible, but if you
> prefer tests to be included with the code in the same commit, =E2=80=93 t=
hat's
> fine with me too.
>
> Will meld new tests into code commits for the next re-roll.

I'm probably the last person to give advice on this list about not
overly splitting up ones commits :)

Having said that, some sage advice:

It's really helpful to split commits into discrete understandable pieces
when it aids in reviewing/understanding the code.

But something like say your 8/9 is IMNSHO a step to far, you're just
adding a feature earlier and then docs for it later. That doesn't help
to review or understand the change, now you just need to look in two
places for what's one logical change.

Ditto for e.g. the 5/9 here. That's just a test for a feature added
earlier. So let's add it to the commit where we add that feature.

There *are* cases where it helps to split up these changes, but they're
things like adding tests for existing behavior before changing
something, as an aid to demonstrate what the behavior was before &
after.

In those cases it's a lot better to split the commits, because nobody
wants to waste time discerning what's a test for existing v.s. new
behavior.
