Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E36C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 00:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FDD22EBD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 00:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAGAdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 19:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbhAGAdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 19:33:11 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72127C06136F
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 16:32:31 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e22so3979275iom.5
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 16:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5q/qTS0EbIjnodY4VffuN5dG2Rv3I44LSBr6fnMQzEQ=;
        b=qeAn/iuTKPfvIk59cR9SeuxhoYeg2AA78hMzts02ST3xg2Fb5f2HzPSdKAkdNmxGD5
         CXKj/XTOuLTK/aqvp4McBtngT5Dtuo9kQF96nAIlQgpWtGyO68sbV1LyceAgV87b2bwi
         YfO489Q/qzWoDlwA5druaeKd9cB72/BBiv4wZKPdLaqze3c3YcA/ece7uUWV3WZfYPT6
         QwTSDbctzZFC/xgYmClzYEjwGIUCuXI0B+U9tpChXYyhDWjHOuhQ4mJG6tQftvVl0P3m
         0B6R5f4dPSL8gNjj3zO/JCowybRI5aaOtvlsMbNoAD6doIcjhtuT0k/L8HozdOEqDLlb
         Lfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5q/qTS0EbIjnodY4VffuN5dG2Rv3I44LSBr6fnMQzEQ=;
        b=e437zlYZ+SGhlGToy60C4rBBG8TXoN0yk1MBnJcClCkrKWzxjoILSv0uudO6Wm2u+L
         N0TH5nStYZ0oF8BK76GFHul5TUypHkxYii81cIQGdYCxlVpjIzqTprOFyouSb+PNaMXl
         pygKKbplFwhhA5qqEFqnF6S6Sd3xwzxa8Qx+ZEMQOK6lBqxE+vCh+HpZnx+LrcCoEyof
         HKsg2cNDDWDoEPMVivPCX9klxyjZMRhcX4ya/lwMwi3PbyFtJb8sIteQutgcDEh0ZU67
         l5mTKWy6fTx3SxWcwhCGeY6zfeRKCckV5XCLG6JyePYgMJ9Yv6oIMgwhTsow0a37/mao
         X0BA==
X-Gm-Message-State: AOAM533QHygG/nbZrbeVGs+SbkHQ8XyA8RYc9/iXvvCVIxB9SscBftkq
        ZenHc0g+E6as+HeBphlw/tc=
X-Google-Smtp-Source: ABdhPJy1X6dV3sfjkT3epxKKYDmPi7qm4gBouI6T1IxBw//oXKUa5U05kOczHDtnjIVvGBFVLP+rYQ==
X-Received: by 2002:a02:6c50:: with SMTP id w77mr5893494jab.68.1609979550935;
        Wed, 06 Jan 2021 16:32:30 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q5sm2994394ilg.62.2021.01.06.16.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 16:32:30 -0800 (PST)
Subject: Re: [PATCH v2] mergetool--lib: fix '--tool-help' to correctly show
 available tools
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
 <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
 <20210106131651.GQ8396@szeder.dev> <xmqq5z49rclc.fsf@gitster.c.googlers.com>
 <3664fffc-c2a0-62d6-298b-8e95f3c58a68@gmail.com>
 <xmqqeeixpsvo.fsf@gitster.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e9a1e45b-70b4-2478-1669-4308c5902c5b@gmail.com>
Date:   Wed, 6 Jan 2021 19:32:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqeeixpsvo.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2021-01-06 à 18:06, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>> What was the symptom before the fix?  Is it just missing only some
>>> tools among 30?  Was there some pattern in names of missing one and
>>> the ones that still got output?  Or was it more like "we see nothing
>>> shown"?
>> ...
>> Note that 'vimdiff', 'nvimdiff3' (last variant for vimdiff),
>> 'bc' and 'bc4' (last variant for bc) are absent, and
>> all other tools that have no variants are absent as well.
> 
> Thanks, that is exactly the kind of "some pattern" I wanted to see
> us looking for, because I wonder if it is a more robust and cheaper
> (maintenance wise) approach to find one single tool that we support,
> which does not have, and which is unlikely to gain, any numbered
> variants.  If we can find such a tool, we can grep for its name in
> the output.
> 

Or, just choose a few tools, including some variants, and grep for those?
This way we are not relying on a single tool being shown for the test
to pas...
