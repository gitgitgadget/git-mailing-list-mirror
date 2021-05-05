Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12692C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6A1611AC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 17:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhEERrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhEERqE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 13:46:04 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA62C04BE71
        for <git@vger.kernel.org>; Wed,  5 May 2021 10:18:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso2368675otv.6
        for <git@vger.kernel.org>; Wed, 05 May 2021 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=stiai7EFDoD7en4k1rQnDPMu9lfupbUPmr0jaSO3Bnk=;
        b=lmTUOHAEjB2KHaMSMYL77LwHk7oEQXPL4ALZOac4XbpJVRMoAcoM76+43zUhARCMic
         94kBcYfL3H1L4DzP5PPYTx6tMGfSj944+q4+yBtqqpBmzFkDvDiQrXGIpRfNuXuf6/hJ
         FwtJzuY8tuP9pnzLq//JLlq2Yy609rioq6HMEoQYs5jFMm1cj39phqvVUJSu6ag4mCBz
         NAzr7IwCv/X1Jl8zaEUsESoHVh9up6uv8SPzRA7ELZS0aLB0qHtaIhcK9koG30Y2Yy4Q
         eGEQ2xAl9NP7Vr6iVvfNTq/2yVhcYynF4DSHi2bgLOYNpqxk6TNAbpsSED/S+G/R39jV
         5mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=stiai7EFDoD7en4k1rQnDPMu9lfupbUPmr0jaSO3Bnk=;
        b=ZPUlCGHMlGI7g5y2Xtz63+PPotBZkOE1rjYvtmoo7YlQxvpfdpeWQ8XnW92Nl9jnGk
         ivDcMqYzsl3COIt+X++/QH0oD1MYVmgHbJgNIiMG3JIEB/twsni7gS+seao0ILQRMGaJ
         n2+RJhFH0R5w1bHcQV0aARWvhgioS7Kxp3f6UvvDPcDn7Xyh/V8sbNZk+2qVGXw0gsMl
         Xhnm/y18F9FAIor7EUqcuExIsnH+rY2zQccPRyKhg8lKXo6oOo0rtcYoMt7jiS0SfoYb
         XzXdRAF8ETfIMZG5VFdgGuCbNptCosxiLqKYo/xPrGqqHHc5rrqHlBzBICJgSk1/o2DS
         jpyw==
X-Gm-Message-State: AOAM533l45sptfoZr48zjgNGMfSaCBgqCOAa9T9vWsjKiiusCUYkm0SR
        ty969Gn8vvIQfky0RCdboWXP7OnyPLlBfQ==
X-Google-Smtp-Source: ABdhPJyPvXlrnETbvIEeP+Y+sfEKE2BjYIeFR8B+yfpMsyWAIk1lez9JxbIik1i5ORX1RElb6+vuig==
X-Received: by 2002:a9d:4617:: with SMTP id y23mr14321071ote.71.1620235121159;
        Wed, 05 May 2021 10:18:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m13sm5169otp.71.2021.05.05.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:18:40 -0700 (PDT)
Date:   Wed, 05 May 2021 12:18:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <6092d36c6d1a8_1d245208a4@natae.notmuch>
In-Reply-To: <YJKo02fG/riIetpu@coredump.intra.peff.net>
References: <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com>
 <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com>
 <xmqq7dke7jeo.fsf@gitster.g>
 <87a6pawmyu.fsf@evledraar.gmail.com>
 <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
 <6091e1f12ddf9_cc8208b9@natae.notmuch>
 <YJH712E2kT9yJkGT@camp.crustytoothpaste.net>
 <6092180651fdc_105ac2088a@natae.notmuch>
 <YJKo02fG/riIetpu@coredump.intra.peff.net>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 04, 2021 at 10:59:02PM -0500, Felipe Contreras wrote:
> > Indeed. But it also probably doesn't meet many other needs. A quick
> > check shows 54 failed tests just on t0000-basic.sh. I don't think it's
> > something we should even consider.
> 
> Yeah, we have visited this off and on over the years (links below).
> There are some modernized ksh variants that work OK (like mksh), but I
> think we've declared ksh93 as not worth it.

Just to clarify what was said on that thread: ksh93 is not a version.
There is at least ksh93u+ and ksh93v-, which are *completely* different.

-- 
Felipe Contreras
