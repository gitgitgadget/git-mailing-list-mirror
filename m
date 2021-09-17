Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E31C4332F
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 12:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AC660F9C
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 12:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbhIQMIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243550AbhIQMI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438A2C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 05:07:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g21so29194451edw.4
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HxGig8LH4t/OVIatcKkUoPnF777XgOjFKJI2zMw+H2Y=;
        b=lDWR02+sxAN9HZZvKJuos+BEztfuGfq5l8xB5mhfYnloMDU/Whih2B6YFFKYvRgSjR
         yZd7wul8lm4WROtoDvQCx2yS+rj6dAePw/c0/BZ8if600MWNl75ID48gRa8uBeF4Vxw5
         wAPm3mh9QfK2v3m3jdDb6OlS/vIcODp/youTddhwwN1ub8/Q5WItYdJLYuvJgblwf9Ku
         QCWKOtSwkbLDUA+wO8I85PtBaFMpA+2EY3fZ/DPRnPO+/2ipHc9aWexK7DCz5e5MhL/Y
         OldXsLThO5OkKJZNKKLS1Giwva5biUm9oQ7i2qFMdp0PWYsaEVOU26NnQfpjejEF4oWL
         QSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HxGig8LH4t/OVIatcKkUoPnF777XgOjFKJI2zMw+H2Y=;
        b=IPbW1IgulMQmUckZgO3dNwh61CEgI+7w2xzoM0TH7U/JV6CuEMpWgBOjiXIGf7mI4B
         4z8I1YvGwT0dCiUXy1GxRV8gsJ6grp2g/Jhp9FG5nY8e2bCL9/gQi2BpqB68q/1WprK0
         gPbWJugjy9ve3fXmDQu+VdmbMmqI1oHfMiQEJ84Uc9bU9v3QTCj7tW7kldzjEOKclqz7
         /gjMkzJxLm9vkJ/vR/c+DSSaUCzX36uQMi6b1ImmuauyEenaoyzD017FUql5j5LLS+Rd
         90OWwhwBDRmHmTONo3DrLAtsnbPCP7ODWRL9FI3qnNR6RmQP4PMBfqOoz1d8Dh5TuFEi
         E91Q==
X-Gm-Message-State: AOAM532Z4rkgBzIDvcgX0wqNMeT33+YhxUy+EyzOWD6EfgnTMOfMOaiX
        zINN+OThznzLdXexYO5rGPU=
X-Google-Smtp-Source: ABdhPJygsQnxtmJV5mXbW2cvJell4E7qS5QNzKRnBhLEYSErdPoF4Ko7NfMyFx+3/jsYYcZPVNfIEQ==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr12080122edx.267.1631880423734;
        Fri, 17 Sep 2021 05:07:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e11sm2182583ejm.41.2021.09.17.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 05:07:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 05/22] rev-list tests: test for behavior with invalid
 object types
Date:   Fri, 17 Sep 2021 13:59:10 +0200
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-05.22-82db40ebf8a-20210907T104559Z-avarab@gmail.com>
 <YUOryeVj1WNk1Sqd@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUOryeVj1WNk1Sqd@nand.local>
Message-ID: <87lf3ve789.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Taylor Blau wrote:

> On Tue, Sep 07, 2021 at 12:58:00PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Fix a blindspot in the tests for the "rev-list --disk-usage" feature
>> added in 16950f8384a (rev-list: add --disk-usage option for
>> calculating disk usage, 2021-02-09) to test for what happens when it's
>> asked to calculate the disk usage of invalid object types.
>
> I'm not sure that I agree this is a blindspot, or at least one worth
> testing. Is the goal to add tests to every Git command that might have
> to do something with a corrupt object and make sure that it is handled
> correctly?
>
> I'm not sure that doing so would be useful, or at the very least that
> it would be worth the effort. [...] I think there are so many parts of
> Git that might touch a corrupt object that trying to test all of them
> seems like a losing battle.

I'll drop it since it doesn't have anything directly to do with this
series. This slipped in from the work I meant to follow-up after this
with.

This isn't just any random command that might come across an invalid
object though, it's specifically reporting object sizes. Once we change
that to not die we'll we'll want to see how invalid objects are handled
by it. Will the disk size be reported as -1? 0? ~0?

> [...]
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t6115-rev-list-du.sh | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
>> index b4aef32b713..edb2ed55846 100755
>> --- a/t/t6115-rev-list-du.sh
>> +++ b/t/t6115-rev-list-du.sh
>> @@ -48,4 +48,15 @@ check_du HEAD
>>  check_du --objects HEAD
>>  check_du --objects HEAD^..HEAD
>>
>> +test_expect_success 'setup garbage repository' '
>> +	git clone --bare . garbage.git &&
>
> Since this is cloned within the working directory, should we bother to
> clean this up to avoid munging with future tests?

In general (and I had some other replies with this) I think no, if a an
individual test is picking a unique name for its data it doesn't need to
bother with test_when_finished, it can just leave the cleanup to the
eventual trash directory cleanup.

>> +	garbage_oid=3D$(git -C garbage.git hash-object -t garbage -w --stdin -=
-literally <one.t) &&
>> +	git -C garbage.git rev-list --objects --all --disk-usage &&
>> +
>> +	# Manually create a ref because "update-ref", "tag" etc. have
>> +	# no corresponding --literally option.
>> +	echo $garbage_oid >garbage.git/refs/tags/garbage-tag &&
>> +	test_must_fail git -C garbage.git rev-list --objects --all --disk-usage
>
> See also my earlier comment about this being much more readable in a
> sub-shell.

*nod*
