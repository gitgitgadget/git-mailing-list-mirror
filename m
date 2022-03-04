Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8957CC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 06:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiCDHAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 02:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiCDG77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 01:59:59 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A592D3A
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 22:59:12 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qa43so15432062ejc.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 22:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fTOM7xNJ5VImLxOju0kC/GIoSSme2bt6MDK3fa2dCxQ=;
        b=pnkD1VSd0L9YtnmteuDH18Emey9HG8DTYGZA+UzAqPNXZNnW5bZFHWmKAN3rpBVbrM
         eMPi0VBdmq2XxBrRhikBj+H3kTKdj3+iO7K4mxdomNQy1ciwPUnP0T2SD4GwSetplbK2
         6ekD2wbjgTxZ1A29iCOCR7X+VJRCIY+dBSQnEV2w2X1IjzhCRKLsLIMYOTvYPMB13mvI
         aH2Ew6VFeT5jkke4K5QonMR63yMnGJVzLfGfLydHgf4j18X4Kt+BrS01i0BzduWAjQjE
         Q3qVzgDYX1dXSOX/PNLH3EdDwYM6PCzRSdN4e9nU17YSNapz4ycE36v3ZllAi75RSDi4
         n4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fTOM7xNJ5VImLxOju0kC/GIoSSme2bt6MDK3fa2dCxQ=;
        b=hjCwcro3bO7hVydCTutp0BWIuWYc1HuKyMDkUMm2dd4P2pYkG0hx37p+ow67d/0yD0
         tC/KqV+1PmTysEFkuiK7RPVpoAbo7OW3ntWNTvnyiOJAYlnboe/mqfKRXkP4GOb8r3Ig
         TXDm8N8q4xbdjX6VEffoLdM+hmHfBY/S+N3SHwirX4KaVQTczEmj44oU3uqTMmfzFbSD
         0fcEqXC0ML2rqbg8M+yjDw+7oc1kXrtZB6F2MBAIwRbpUr/2vo/8qRNrRGi1SNk5kFPo
         fj5UmoDnkDNH1EgGvJkaVS7AwTy6zHXNUrmyiyfweqccwM0h12HkGlwQ+EUsd2zcvl0k
         3xhg==
X-Gm-Message-State: AOAM533f1XZAdw5UG6/F0A9EOYdwCB9vFAkdWP6MKJhuPf+R2E+qpItA
        p3wBLRyt+LG9bTyFbHwLpf4=
X-Google-Smtp-Source: ABdhPJzuQa1nyfZGfhpjt6u7nfUUa+RgMgl4GcXKQHm8HARTVHgyHarCIqAzS1gUF1eX7F+ujiddRQ==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr30330172ejs.105.1646377151254;
        Thu, 03 Mar 2022 22:59:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kv9-20020a17090778c900b006da693d5e91sm1393509ejc.122.2022.03.03.22.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 22:59:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQ1u8-0006Ot-8I;
        Fri, 04 Mar 2022 07:59:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
Date:   Fri, 04 Mar 2022 07:57:43 +0100
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
 <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
 <e3090436-4479-bbc2-3b62-00473f6f530e@gmail.com>
 <220303.864k4f3uqe.gmgdl@evledraar.gmail.com> <xmqqlexq4et6.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqlexq4et6.fsf@gitster.g>
Message-ID: <220304.86zgm6fbk3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Yes, it returns the correct status code, but that doesn't help with
>> (pseudo)code like:
>>
>> 	if (run_command("foo")) /* exits with e.g. 123 */
>> 		die("oh no, foo failed"); /* exits with 128 */
>>
>> I should have said "code using run-command.c does not do that...",
>> sorry.
>
> Yeah, but even if callers of run_command() can tell "foo"
> segfaulted, I do not think it is sensible to exit as if we
> segfaulted (or, we _could_ actually die by segfaulting ourselves,
> which is worse).

I should have made it clear that I'm thinking about this as a test-only
mode, so hidden behind some GIT_TEST_* variable, i.e. as a means to an
end in getting the test suite to spot the failure in the sub-process.

It's not the only way to do it, but it's the simplest and most reliable
given how our tests are run.
