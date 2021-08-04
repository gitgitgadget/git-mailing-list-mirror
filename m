Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D49CC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE45660FC4
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbhHDUGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 16:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbhHDUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 16:06:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BECC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 13:05:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y12so5084463edo.6
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VGdvMGALomRMaLSNoz8jHQqqxoJ166bj956INRnL9+8=;
        b=SMunoaAnVCWK7F9l7lGpwmVstzkbaSLy45wQ9+WachEGYc10h/Qf1xyBF4+eqsqiVn
         ygtzlCst2hMOe6iL5t449mqk3KRdIzVFluyS8pkPqNGGKZ7EBO0E1EhDqP9264CgAyrL
         xtw6LhQVPRB8aRLz/uX0CtMgQXc748C9o2kqRiMM0kdkXORDxhDmJgXDi5Tn/v17Tqlb
         /f/Yhzs+EoQxkmaMBfel3+PZ8jZtkNp9AQgPI72oJnZGvSRnTT5AHVrzLnPIXCC8wvb+
         oyzD7Pzl/XVNG7iMuWFRCITnoOQP64Udi+Qf9RHOiL+YM+nndxtrzSvUhRLjRIKFilIz
         XC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VGdvMGALomRMaLSNoz8jHQqqxoJ166bj956INRnL9+8=;
        b=aGEeGdL2BeT8rbzk+KTNlpau4AcGctcWeF1VyD4LB/i9pNNlRk3VfBQzTtxtT+gcT4
         cugkSSSdYIhxHnDJoucQSOCy4GtKYGfQfbHyum/yq3bSj7t3QfDk84LGIos9JDr10cm7
         V6dCAD78R43txBVFPkoCE32w8XnS4GfUkPIU+5+Y75kBmXJj7aYNqM7IoSb8zJITed67
         55pfoFF7d6Pdwm2Tn9Nv0Wfr9UcwCTvTWhY1BIBKFzAi4hbtSteyrKyjVjWIztb5ZSiF
         T/HTzz9kDUA0u0Ih70wD83V8HvGO0+UX2t/zOg2dLh3wlAb2NvkZI+6+/9CFZXVTTLZb
         r2Ig==
X-Gm-Message-State: AOAM530+CC+X3gecFciybvLOkx96r0K7KlmIK8Tmlwbn+38TKi1YzKiY
        EO2bkCs7UElx8Am0S6Wt2Dk=
X-Google-Smtp-Source: ABdhPJxtMaLXQ2KcevuA7V6ELe0RC34m8Kq0QSX/ZI9cNc40R0FRONlwbcwHDtEcOIK/rKrCTWzL3g==
X-Received: by 2002:a05:6402:291d:: with SMTP id ee29mr1706885edb.289.1628107549704;
        Wed, 04 Aug 2021 13:05:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o7sm948600ejy.48.2021.08.04.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:05:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Date:   Wed, 04 Aug 2021 21:53:02 +0200
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <87wnp1mqv2.fsf@evledraar.gmail.com> <xmqq4kc5ozi7.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq4kc5ozi7.fsf@gitster.g>
Message-ID: <87lf5hm0v7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> * ab/test-columns (2021-08-02) 3 commits
>>>  - test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
>>>  - test-lib-functions.sh: add a test_with_columns function
>>>  - test-lib-functions.sh: rename test_must_fail_acceptable()
>>
>> We're going to need this or another solution to the v2.33.0-rc0
>> regression in c49a177beca (test-lib.sh: set COLUMNS=3D80 for --verbose
>> repeatability, 2021-06-29) before the final v2.33.0.
>
> Just a question.  Is that true?  Wouldn't a system that needs these
> on top of c49a177beca already break the tests without c49a177beca?
>
> IOW, is c49a177beca truly a "regression", or is it merely "a half
> solution that solves for most but not all platforms"?

Yes, because with c49a177beca your tests only break if you use the
--verbose option, i.e. if your stderr is connected to a terminal. I.e.:

    ./t0500-progress-display.sh --verbose

So in practice it mostly affects git developers who run with --verbose,
but probably nobody doing a build in the wild.

With c49a177beca they break on e.g.:

    /bin/bash ./t0500-progress-display.sh

If your bash is recent enough, so "make test" if you're on a system with
a recent bash whose /bin/sh is /bin/bash.

This is because post-c49a177beca we don't "unset" COLUMNS anymore, which
bash takes as license to update it.

So we really do need that series in before the release to avoid that
common annoyance, a revert of c49a177beca is also possible, i.e. it
would still leave things broken under --verbose, but that breakage is
rare and existed before v2.33.

I think given the triviality of the fixes and that the cause is
well-understood it makes sense to go forward in this case.
