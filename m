Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C817C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BF661360
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 20:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhFAUwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhFAUwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 16:52:32 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF56C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 13:50:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k4so284025qkd.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NRByF5GIo5eLQxGA7SEwgs2BjcsM069OGWRQmObSfq8=;
        b=HTnCAz1gKMsC6nV6L3qHeld16q+F53vPBsKaBuEVZoh5Kp7EWbgk9WRXNFkMAJnYGT
         LeenKNdaYElt9DjEx5NLMLXfu84BhowDqPBR8Zeqofr0RpgMl1Y9Ypf1xSQyluCH1o/r
         bWCN4F53BRErDwrt23U/Ri/BeUnFFwcysQlY5JYR6tUZ9u9TVjAXr5Q3uV+JG6Z6yEoq
         nyIZIIHVdZPKzig58TqrXrcK3CkMSGXVR1o8m1WrYJnZnRY8JJJ2w05KROYJAfRrLpaM
         7xSkyATgD5QJPqsZ9xG8aqXI+Scc549cDL+vvzUT09tHwXb61yD0xQJoKd5bNuY3t56D
         ArgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NRByF5GIo5eLQxGA7SEwgs2BjcsM069OGWRQmObSfq8=;
        b=AZ8q+ROudZvlDmxx3af3IeiIAvSrIUDwCfw5W+VIokgKblDRyPwMyHK9eZlTmPpIUa
         NGqlGTtBiaKYdpZ1cfEsxEVp7EvzY0hyn+RV/SUb6+S4lO2G1QI8fnqTWDMP5wxhgWPo
         /0FqVjCLC6cWAMlJCbA/Ly0H+e5iQ/MffZRsEKlZqkGSVYZdMvxJFspiAUusfan+9W8r
         euY8l3JXY5LbnqEEPix+bGRgH4ExPIVdV5zQ8SbspRGifpWeFnGOlRjamWYoD1k2vX9i
         ez2bwB2nTxWPAIeB4mJ/6LTuKPYU88oLM09wwYavhiN6tcpoXKDIPUeGLQ0bruMnBpwz
         FTdw==
X-Gm-Message-State: AOAM530wtqqkD/BAlzvK3JtzIg0V7EdOMOzAWYE4WZQ3Z8beiTQLtZWw
        xBINW79Z0Vge+/O2VvnX8bc=
X-Google-Smtp-Source: ABdhPJypXEir5A4RijkrmIq/XBIY5Q7QdWSN4wEGFGmjcZ17QTMIllm3J2JkbvbISxl2YAkp7ciInQ==
X-Received: by 2002:a05:620a:2941:: with SMTP id n1mr23800439qkp.330.1622580648478;
        Tue, 01 Jun 2021 13:50:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e430:c189:dec7:db39? ([2600:1700:e72:80a0:e430:c189:dec7:db39])
        by smtp.gmail.com with ESMTPSA id t196sm1317760qke.50.2021.06.01.13.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 13:50:47 -0700 (PDT)
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
To:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <179668e9-008a-0b70-a193-b0a479ba0146@gmail.com>
Date:   Tue, 1 Jun 2021 16:50:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLZ5H2Muh39Q4M5T@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2021 2:14 PM, Emily Shaffer wrote:
> On Fri, May 28, 2021 at 02:11:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> After suggesting[1] an another round that the config-based-hook
>> topic[2] should take a more incremental approach to reach its end goal
>> I thought I'd try hacking that up.

I think sending this complete reorganization of a long-lived topic
is not helpful, especially because the end-to-end diff is significant.
This series has been extensively tested and incrementally improved
for months, and it would be a waste to start over and lose all of that
hardening.

It's also a but rushed that this comes only a day after the previous
message recommending a reorganization. It would be best to at least
give the original author an opportunity to comment on your idea before
working on this.

>> So this is a proposed restart of that topic which if the consensus
>> favors it should replace it, and the config-based hooks topic should
>> be rebased on top of this.
> 
> I'm not entirely sure what you're trying to achieve by sending this
> series. It was my impression that the existing config-based-hooks topic
> was close to being ready to submit anyway (since Junio mentioned
> submitting it a couple revisions ago); rather than churning by reviewing
> a different 31-patch topic, and then re-rolling and re-reviewing a
> (reduced) config hook topic, wouldn't it be easier on everyone's time to
> do a final incremental review on the existing topic and then start in on
> bugfixes/feature patches afterwards?

I completely agree here.

> It would have been nice to see a more clear discussion of patch
> organization sometime much sooner in the past year and a half since the
> project was proposed[3], like maybe in the few iterations of the design
> doc which included a rollout plan in July of last year[4]. To me, it
> seems late to be overhauling the direction like this, especially after I
> asked for opinions and approval on the direction before I started work
> in earnest.

I've also seen messages as early as January where Ævar mentioned
wanting to review the series, but not finding the time to do so.
It is reasonable to expect that contributors attempt such major
reorganizations according to reviewers feedback, as long as the
reviewers are timely about delivering that feedback.

Thanks,
-Stolee
