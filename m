Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24FDC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B21D610A0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbhIBNLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbhIBNLn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:11:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F226C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:10:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 22so1929940qkg.2
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3DCumyhC2WFBP8XsohUuiUeLHaWf+1xaUQMwfnSe8L0=;
        b=p8Px/3cmkoWL3r/FmgIfdTU90++Sg/mWBfW1VP9mkmmqVPlqnXDofT+23KgHl/ueQY
         qIetOlxE1U2D4xZj0QjL6SiGwg4pRa46A54fWnvsBEQb2SPfVN0YK9PzfU1ynxEra2GR
         ZuqgPvTn/h7fvul7VJGgz+n2JHHHqBraTRksyO+gIhw6oj9dg07Ff+ABNIeyuXdT1rZT
         ZkzWWUgjyoB0Co1EOw4DmWgMuEFc6wYKApFgIoegnXtfJP3hOos78fmW2vrsiofEagIT
         j3GrfyIRIaeUqhje9YEkobOv5xIEzv8LKqD/Vgxx9LxqeABznEBSi1jjRm1wbMErp/uO
         SIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3DCumyhC2WFBP8XsohUuiUeLHaWf+1xaUQMwfnSe8L0=;
        b=YVKaDUkQci4JhmtXUmkFYcRXl4gNPTnPtNefkcWgGaJ3EnJIMAOKghHQX9tkr8zIOH
         ZgeFZCcNJQsrT0ST3c7SOsjVnOaxFaqr69xH7la0xWGO5ZEt1KQk/O/EtOheZn1PUuks
         JepNPjMvZFjEqCv5jAXD0ooxXY030rtGYk4aoBgrcneSeFRNHusnjGqTzXXVdu5NSLfb
         BeMaqSYiw0VVzymE6szdzqKGyVxXvKj4bzozA2w1Ad5UzuZgOrrjfvhYWrgX3p+8cMrk
         G34O+VBqtjnsmpaeSSfXxq9Sn3Ryvdk5q937UURlkWQAOJHSc9wQzsx0eh6uYcucIAdy
         wnPw==
X-Gm-Message-State: AOAM533hcJ8cVCtR/13TPPUO2P9KDg2JddpIjjLdNJUArPuugWj3iSXZ
        lBkpT4F7kq1u1qZZcCtKTSA=
X-Google-Smtp-Source: ABdhPJxoTTpv3a4gngHaLhnWuyqmgb4CswiJIIcramG8DGG66JrGqe82Ic3PDYfcTIpNO8sCLiPjQw==
X-Received: by 2002:a37:681:: with SMTP id 123mr3042030qkg.53.1630588244512;
        Thu, 02 Sep 2021 06:10:44 -0700 (PDT)
Received: from [192.168.66.137] ([142.46.68.231])
        by smtp.gmail.com with ESMTPSA id c7sm1011830qtv.9.2021.09.02.06.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:10:44 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] test-lib-functions: optionally keep HOME, TERM and
 SHELL in 'test_pause'
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
 <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
 <328b5d6e76f598590d24b35ec23b5fd854c6cf05.1630503102.git.gitgitgadget@gmail.com>
 <xmqq7dg0oxdm.fsf@gitster.g>
 <CABPp-BFEvSXHAzFFs8VaWK5QUTj6Zyow9863p=qM6G8v3OPy1g@mail.gmail.com>
 <xmqqa6kvoptx.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3256e230-9db4-57fa-8b43-b9d7e18ba725@gmail.com>
Date:   Thu, 2 Sep 2021 09:10:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6kvoptx.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah and Junio,

Le 2021-09-01 à 19:09, Junio C Hamano a écrit :
> Elijah Newren <newren@gmail.com> writes:
> 
>>> Because a new process instance of $PAUSE_SHELL is run, the options
>>> you add when inserting test_pause does not affect what happens in
>>> the tests after you exit the $PAUSE_SHELL [*], right?
>>
>> I think the warning was less about what happens after test_pause is
>> complete and the testcase resumes, and more intended to convey that if
>> the user tries to manually copy & paste snippets of code from the test
>> into $PAUSE_SHELL, then the use of these flags can cause the result of
>> those pasted commands to differ.

Yes, I added the warnings based on the reticence I got in v1 to change the
behaviour without adding flags.

> 
> But the difference of TERM and SHELL are much smaller issue when one
> cuts and pastes the lines from the test script.  Even if you do not
> use -s or -t options, shell variables and helpers won't be available
> to the interactive session given by test_pause, and that is a much
> bigger difference between the "real" shell environment that is
> running the tests and the user's shell environment test_pause gives
> us.  That is why I think the WARNING should be attached _directly_
> to the description of test_pause and not to individual "this uses
> different X environment compared to the real shell environment
> running the tests" options.

OK, I can make that tweak.


Le 2021-09-01 à 17:52, Elijah Newren a écrit :
-- snip --
> those pasted commands to differ.  If so, a small rewording might be in
> order, e.g. "WARNING: this can cause commands run in the paused shell
> to give different results".  I'd also say the CAUTION would perhaps
> benefit from some rewording (since the option itself doesn't cause
> files to be overwritten), e.g. "CAUTION: using this option and copying
> commands from the test script into the paused shell might result in
> files in your HOME being overwritten".

Thanks for these suggestions, that wording does seem clearer.

Philippe.
