Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA40C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 12:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiCIMGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiCIMGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 07:06:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E016F950
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 04:05:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw13so4368804ejc.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ie3HBUs1wsd/aNY47qi1INHiTICMfLDj9/V7p5RhMfc=;
        b=Vf7+46aemamvNvSorCCfDW6wiGlotGKJ5Ru9Z/ujoRCsLxwvQNaKiZos/lSpGDUcK7
         M2gAyrHmy2G2zjR+mKGqsijxFJBSz+gUth/9faD8JKK2G2Yl2uMJ9JqInAMBEcME9oQF
         YXgHc9zfp0HDd7Xo15paHcdd9EQ3Eo/HIdc+Vo/1VaRBt+hixJYbpF87DOiIsTwz/yzl
         nNxwCAoIfzG3kxm0AeAnYMPqi3ouwbYryyMkIBNk7Zdw0KVjVtH43hNUlPj6XrfabVPa
         aNDYdt2VY67rcF7H8+fNWhb1/TuhqT84KOnt2/jqmHyiNKyiBPBkw35/Q3dNMwmS+lRw
         mItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ie3HBUs1wsd/aNY47qi1INHiTICMfLDj9/V7p5RhMfc=;
        b=1uO5dLLt8p17aY9SDZozPGrM6Vcu4HH/gEb4Y7QztMUybAWIMHz/LmU3h/JUlEZVTk
         52eOh684dY8rWFVgsNaDzOu/nw+jlgSpW/oXmpIgKOZZYgUh+kus8zQ1woB3xqi4ZmEZ
         +JMexgZrQRf0AtUyNHLmEE8nAAmPdOhvMqPLQHDXAR8vk8WvoPYwlyn5eCUBhokE34aB
         h0161Q69P2P8MTwUIfFOOq4WiTF6zlRYTdSfwmNS+r51d6A0LIBQjDYnEoHYTlMRtdwF
         JndOrDwaRVPj64aNVhomyPTCisEXAkZ5gFVXz0i6hTDG4vAe43kPnHWe93ZXDBJ1zbiZ
         2Eyw==
X-Gm-Message-State: AOAM533rbMjxm1SQoh6Gn0LhrpwnV6TA4Fv6jtvFMCmnKAWkwTSZryGv
        +d61NNdvkMYCNjOsVAfn8GE=
X-Google-Smtp-Source: ABdhPJwhWcDb2PB89fMgOa6shd/jER+9x6OgnMlQMv5eiOORoquOvk3fD+0x3kgpjhsyrGfnlHYrEw==
X-Received: by 2002:a17:906:7315:b0:6da:820d:4e02 with SMTP id di21-20020a170906731500b006da820d4e02mr17429820ejc.65.1646827503084;
        Wed, 09 Mar 2022 04:05:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906780500b006d0b99162casm655672ejm.114.2022.03.09.04.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:05:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRv3t-0008s0-Lj;
        Wed, 09 Mar 2022 13:05:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Wed, 09 Mar 2022 12:44:24 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
 <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
 <30dbc8fb-a1db-05bc-3dcb-070e11cf4715@gmail.com>
 <nycvar.QRO.7.76.6.2203071657180.11118@tvgsbejvaqbjf.bet>
 <xmqqilspu1pp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqilspu1pp.fsf@gitster.g>
Message-ID: <220309.86wnh3mivm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> One thing I forgot to mention was that when you expand a failing test it shows
>>> the test script twice before the output e.g.
>>>
>>> Error: failed: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
>>> failure: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
>>>   				git config core.fsmonitor true &&
>>>   				git fsmonitor--daemon start &&
>>>   				git update-index --fsmonitor
>>>
>>>   expecting success of 7527.35 'Matrix[uc:false][fsm:true] enable fsmonitor':
>>>   				git config core.fsmonitor true &&
>>>   				git fsmonitor--daemon start &&
>>>   				git update-index --fsmonitor
>>>
>>>  ++ git config core.fsmonitor true
>>>  ++ git fsmonitor--daemon start
>>>  ...
>>>
>>> I don't know how easy it would be to fix that so that we only show "expecting
>>> success of ..." without the test being printed first
>>
>> It's not _super_ easy: right now, the patch series does not touch the code
>
> In other words, it is not a new issue introduced by this series, right?

It is a new issue in this series, specifically how
"finalize_test_case_output" interacts with "test_{ok,failure}_" and
friends.

>> The easiest workaround would probably to add a flag that suppresses the
>> header `expecting success` in case we're running with the
>> `--github-workflow-markup` option.
>
> If that is the case, let's leave it outside the series.
>
> If we do not have to hide the solution behind any option specific to
> "--github-workflow-markup", then even users (like me) who reguarly
> run "cd t && sh ./t1234-a-particular-test.sh -i -v" would benefit if
> we no longer have to look at the duplicated test script in the
> output.

Unless you invoke it with --github-workflow-markup you won't see the
duplication.

I had some comments about inherent limitations in the approach in this
series vis-a-vis parsing markup after the fact[1]. But that really
doesn't seem to apply here. We're just printing the test source into the
*.markup file twice for no particular reason, aren't we?

*tests locally*

Hrm, so first this is a bug:
    
    $ ./t0002-gitfile.sh  --github-workflow-markup
    FATAL: Unexpected exit with code 1
    FATAL: Unexpected exit with code 1
    
Seems it wants --tee but doesn't declare it, this works:

    $ rm -rf test-results/; ./t0002-gitfile.sh  --github-workflow-markup --tee; cat test-results/t0002-gitfile.markup

Isn't this a matter of making finalize_test_case_output not print the
full $* (including the test source) for failures?

1. https://lore.kernel.org/git/220309.861qzbnymn.gmgdl@evledraar.gmail.com/
