Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6233C43460
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6BB610C8
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhEFPlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhEFPk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:40:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF0C061244
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:37:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l7so6698967edb.1
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ih/XpsnAs+VlmeIwMpA+LFfbAWjUoe4HG0V1yuoRmpk=;
        b=rwxLaRX3upt3dclwmV4FRK9NXE8ymx8EFSD2+VED213ndgO9OxtF09XCCGNug7r2+O
         jwL53vp0GSbylA24h7NLzdp4rJHOJj75EFSsRIyQZMzd1I1RjzFwmyetYFcAaDhbn5oo
         jdoAlvK1R759/kjtxbUtTBreHR4NpSpYBvhxTMqdhFHugItGsV76o1239CJjW4RhuTmM
         hNYSGIJz+hSA1+AqHD3eNPSDoBZ2gKB/KVJ0hWSUqvm3ImlG1o7dTItczrBvrQZs531e
         h5yjoZUfAm6y1oY4LNIFWdIIub1EhjOV8kC8qQQQUKj1w9QXPd2QKXueziyyuME07lCx
         wS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ih/XpsnAs+VlmeIwMpA+LFfbAWjUoe4HG0V1yuoRmpk=;
        b=jtUGIvh9jPigfnc+DiZImo9TbnGE67yY+XLwrI8UAK2WsgWlm4QGC6ztRTaynno5W2
         JWy0zjZb+kIHttLXtxlG6hNKrqTMkSkjegoHPWW9PlPTge9mAHYQtGesAH/FyH3GiUHX
         sJl3jDP9Xq3c18mgm7uO7Y3O0eEv85JLiCtOR8Pay2pPYeheIX9rhkE0nWA9y5cNRWhA
         tkZ+Uisr1MuzPRJnxxWBC2cOitXsqCIzAlftETctWQ1BLkIjiV8eV7B+ZKc/kofGcGcs
         dF/IlRQKOBam5TVw2qEbaZotqJXA4tqUCIC7H0NCiwd/NMeEnRyB/opxuYnM9+tfu7hk
         ILSw==
X-Gm-Message-State: AOAM530n01YwWevVTjUwTkG+eJPx6CbEg+kRmB6qQysQuiD8N2Nd3WSn
        8i4+UHJHw18RBAYXaiLL6u8dCdyZYy5GvQ==
X-Google-Smtp-Source: ABdhPJx71V60vm8XEmiB1qMHPS652VC8Le8v+uWvGbzSQ8K5ZuKWbyJfc04jkurAEg8XYmafDt3eGQ==
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr5845087edc.51.1620315436233;
        Thu, 06 May 2021 08:37:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s11sm1919687edt.27.2021.05.06.08.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:37:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
Date:   Thu, 06 May 2021 17:36:46 +0200
References: <xmqqr1itfo41.fsf@gitster.g>
 <87im44xerh.fsf@evledraar.gmail.com> <xmqqeeepbpig.fsf@gitster.g>
 <xmqqsg30zdql.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqsg30zdql.fsf@gitster.g>
Message-ID: <87bl9nvpp1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> * ab/test-lib-updates (2021-04-29) 11 commits
>>>>  - test-lib: split up and deprecate test_create_repo()
>>>>  - test-lib: do not show advice about init.defaultBranch under --verbo=
se
>>>>  - test-lib: reformat argument list in test_create_repo()
>>>>  - submodule tests: use symbolic-ref --short to discover branch name
>>>>  - test-lib functions: add --printf option to test_commit
>>>>  - describe tests: convert setup to use test_commit
>>>>  - test-lib functions: add an --annotated option to "test_commit"
>>>>  - test-lib-functions: document test_commit --no-tag
>>>>  - test-lib-functions: reword "test_commit --append" docs
>>>>  - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>>>>  - test-lib: bring $remove_trash out of retirement
>>>>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>>>>
>>>>  Test clean-up.
>>>>
>>>>  Waiting for an Ack before merging them to 'next'.
>>>
>>> Is the ack a reply to
>>> https://lore.kernel.org/git/xmqqo8dx7dv4.fsf@gitster.g/ (or here, I
>>> suppose)?. Sorry about the in-flight hassle.
>>
>> No, what I meant was that v4 had review comments and v5 was done in
>> response to that, so I wanted to make sure that reviewers are happy
>> with the delta between v4 and v5 before taking v5 and declaring it
>> good just by myself.
>
> ... and this hasn't happened yet.  Can you ping them yourself,
> please (distributed processing at work ;-)?

Just did so in https://lore.kernel.org/git/87eeejvpuy.fsf@evledraar.gmail.c=
om/
