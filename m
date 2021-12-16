Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B2C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhLPNWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhLPNWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:22:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F481C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:22:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z29so6857327edl.7
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=U/ynltcSPbv8tu6r1gTRknFy2ZhxyWKwlv0vcq+C49k=;
        b=i07miY6Y/15g/BlxqUtN4K5OKRMQHWAgnJUThbwliFC4pApfMN98PvAsb8ARwBulDl
         9moo5kktkovRbOw62n+yQ1B2OTOHy10zx7CoyxIpZAQgP0iYJ3jUO3+xOw7I5lfKV12L
         m2T6rEQzs59oi2GNF13skZiyISblfY3Dep1bMmQlUyfqI5meG/oLsVAzziiwv1mGN4Gz
         MIcRQE7VsqFV3vbyp5Wh0HEsU2UUrHpcJqty+tEWZgloIBDt7jTjIBUDjPGCMrYwtHPS
         gjeE2U7jrDkm//mSSwLIYjGN5VLSyYI3TPdXwdttlh4Z1Y+rBSrtDJPj8J6yWPa+hYmi
         yKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=U/ynltcSPbv8tu6r1gTRknFy2ZhxyWKwlv0vcq+C49k=;
        b=IzesH58ZQCEWJiw1rnMA4MrOannSDAEK698hTr/CJRnkHPnTMO+rZxgBdAPv6k7yaK
         0pqgSF1MqK1rY2TSwPQ6qlDK85mOf0hxFJDpXnngJjmBw6hYW2srz1Ljczqe5dTrZ++0
         GLPVsq+utP4OkJXI9vLzLHzUnetCzlTRxuGntBAwhM4KNPLfJ8awMQ958DvVos3okzPd
         xqAVu0wuVbwXXpQmiUXpTqUWkQ8PIAhuaxfXW6EHuyQk/Cf+gKDPWsdrwzqke5UVeezS
         UlfvKe41oPukQgGZrNHr+PAgsqfXaOEJJG0NDcx7mEPXi4giGKSezwX/Afh6Yu3KYWKM
         kTYQ==
X-Gm-Message-State: AOAM530u3nZLosIGJjBRnpdgLhXt3bxbkBiHYfCPcIu787rNUjyWXmfi
        Y77QBsBSoq5o0HtH+bqN0eA=
X-Google-Smtp-Source: ABdhPJwFn9ThviKPvciVMdiCdyvWLLyfFeNjJC1frhTXf6Q0KeiEIDBY/JNnvnUa6YXDg6vhF+TK+g==
X-Received: by 2002:a17:906:4956:: with SMTP id f22mr6010143ejt.279.1639660960106;
        Thu, 16 Dec 2021 05:22:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id do16sm1827753ejc.223.2021.12.16.05.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:22:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mxqiV-000OhL-6k;
        Thu, 16 Dec 2021 14:22:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Date:   Thu, 16 Dec 2021 14:17:58 +0100
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com>
 <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211213154327.pmhopjbdlkz7dgjh@fs>
Message-ID: <211216.86zgp0adls.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Fabian Stelzer wrote:

> On 13.12.2021 09:27, Eric Sunshine wrote:
>>On Mon, Dec 13, 2021 at 5:22 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>>> On 13.12.2021 01:30, Eric Sunshine wrote:
>>> > check-chainlint:
>>> >+      sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINT=
TESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
>>> >+      cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAI=
NLINTTMP_SQ)'/expect && \
>>> >+      $(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/a=
ctual && \
>>> >+      diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
>>>
>>> If I read this right you are relying on the order of the .test & .expect
>>> files to match. I did something similar in a test prereq which resulted=
 in a
>>> bug when setting the test_output_dir to something residing in /dev/shm,
>>> since the order of files in /dev/shm is reversed (at least on some
>>> platforms). Even though this should work as is I could see this leading=
 to a
>>> similar bug in the future.
>>
>>It's not seen in the patch context, but earlier in the file we have:
>>
>>    CHAINLINTTESTS =3D $(sort $(...,$(wildcard chainlint/*.test)))
>>
>>which provides stability via `sort`, thus ensures that the order of
>>the ".test" and ".expect" match.
>>
>>I think that addresses your concern (unless I misunderstand your observat=
ion).
>
> Yes, thats what i meant. I didn't realize $CHAINLINTTESTS is already
> the sorted glob. Thanks for clarifying.
>
> Personally i find the initial for loop variant to be the most
> readable.  =C3=86vars makefile targets could be very nice too, but
> especially:
>
> +$(BUILT_CHAINLINTTESTS): | .build/chainlint
> +$(BUILT_CHAINLINTTESTS): .build/%.actual: %
> +       $(CHAINLINT) <$< | \
> +	 sed -e '/^# LINT: /d' >$@ && \
> +       diff -u $(basename $<).expect $@
>
> i find very hard to grasp :/
> I have no idea what is going on here: `<$< |` ?

It's a minor point, and not relevant to this series proceeding.

But just FWIW I think both of you are wrong about the potenital for a
".test" and ".expect" bug here.

I.e. yes the CHAINLINTTESTS variable is sorted:

    CHAINLINTTESTS =3D $(sort $(...,$(wildcard chainlint/*.test)))

But in Eric's patch we just have this relevant to this concern of
(paraphrased) "would it not be sorted break it?":

	+	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >=
'$(CHAINLINTTMP_SQ)'/tests && \
	+	cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_=
SQ)'/expect && \

So it doesn't matter if it's sorted our not.

I.e. we've got {A,B,C}.{test,expect} files in a directory, and we're
constructing a "A.test" and "A.expect" via "$(patsubst)".

So if it's "A B C", "C B A", "A C B" etc. won't matter. We'll always get
".test" files corresponding to ".expect".

If it's not sorted we'll get failure output in an unexpected order, but
it won't matter to whether we detect a failure or not.
