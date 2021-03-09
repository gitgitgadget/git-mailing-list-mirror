Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78421C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E5A65015
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhCIWHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 17:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhCIWHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 17:07:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2957C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 14:07:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l11so15521330wrp.7
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 14:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9bI/WGr0sfXA1LqnKNudC9j56144bIRhPo/y0fjS0mM=;
        b=N6rrvcRqq6MFFX3BWUk0kX/Sw9P8W4eBkRXo2bmi2hwn9RDWDO5HuwFRYMLNId7ewk
         XMni69vn9QFY65vN7HASepFVvzB7OGxBP3Qox0gWmi4JkUr3UupgYEIkmpOLXV62pcbB
         MEw+E3UyAe1B1j559qM3JEYjn9gFpHic2dCdXFoVFdn7oBcR9Qpu8GuTu6qCdwMVzTwU
         vHZsKoBVerfvxTXdQX4zcl6T7qmXh7ZA9ZkWx2k4i41ABzGLBngP31dPCr1hWFavfDS0
         oARrT9FFaUn0tn0ufLPS7kEF3e2P/Cny1DTHpbvFfr9ikxnXO4p+uhrBLPn5xFlFJRdw
         PUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9bI/WGr0sfXA1LqnKNudC9j56144bIRhPo/y0fjS0mM=;
        b=QPgINscVNtrGJBPscRE7F3sEz+2IQhdxV8BuKtXjTQk7JSvW0k9I8lnttSpGm4CLEz
         Kc+DsuzllX4uxkY5uk3ch/j4h0XC7oZ7s17J4M/G44oWDD/2RtYjvEW1cy50KJaIUcP8
         NMxmu8BtwEXNP/1kqcT4093/AgHUXSUUsoXii7gxu02Bx16yVl6fGhfUzq5Q1O08qDi+
         qjbltc/7MlZtip33hOW15PIVJYZXU4XiaT4+oRxithZtZfhfwxMb17GVstgLYCIpVdvk
         lPvov3OLb2wQi5Nd9gpAsS6Go1B0y21vOuQKtoYPa5/M9dhzS4Md4wzDai6DDgL8Ft0j
         HIfQ==
X-Gm-Message-State: AOAM5336kO4YjgtoYIClE8x5qTljiWGHlJ0jIXfzXxhVARRKvgs1/d0E
        HkXQN6pucp3mI7mwwnmNdZQ=
X-Google-Smtp-Source: ABdhPJzugRHig3VkV9eDte1NEMjBikmDUDpCyh5ox0Nphr0MG2MpzQc8GzOKRm4k7u8lwcoReyLcDA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr56474wru.78.1615327639448;
        Tue, 09 Mar 2021 14:07:19 -0800 (PST)
Received: from szeder.dev (94-21-29-148.pool.digikabel.hu. [94.21.29.148])
        by smtp.gmail.com with ESMTPSA id m9sm26022362wro.52.2021.03.09.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 14:07:19 -0800 (PST)
Date:   Tue, 9 Mar 2021 23:07:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6 + 1] test-lib: make --verbose output valid TAP
Message-ID: <20210309220717.GC1016223@szeder.dev>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-1-avarab@gmail.com>
 <20210309175249.GE3590451@szeder.dev>
 <87h7lkhwed.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7lkhwed.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 09, 2021 at 10:03:54PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 09 2021, SZEDER Gábor wrote:
> 
> > On Tue, Mar 09, 2021 at 05:02:12PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> The eventual goal not included in this series is to have multiple
> >> output targets, and e.g. convert ci/print-test-failures.sh to use a
> >> TAP parser.
> >> 
> >> Machine-readable "TAP --verbose -x" output can bring us a lot of nice
> >> things down the line, I have some local WIP code that's a smarter
> >> version of ci/print-test-failures.sh that knows how to spew out only
> >> the output relevant to the failing test(s).
> >
> > I wonder what you mean by the word "relevant" here, as I can't imagine
> > how you could possibly identify what is relevant for a failing test
> > and what isn't.  If you didn't at all meant "relevant", but that it
> > will show only the output of the failing test(s), then this is a bad
> > example.  Our test cases depend too much on previous test cases, and a
> > failure of one test can be the result of a change in a previous
> > successful tests.
> >
> > Therefore, any such change to 'ci/print-test-failures.sh' will have my
> > firm NACK.
> 
> On e.g. the github CI every step in the run is an collapsable button, so
> we could have our cake and eat it too here.

Well, one of the things I didn't like in GitHub CI is that I had to
click a lot to get to the information I wanted...

> It seems to me like a sane default would be to have an equivalent to
> "print-test-failures.sh" that only prints the --verbose output for the
> failing tests, and a "print-all-output-for-failing-tests.sh" or whatever
> which gave you the full output.
> 
> Even then, there seem to me to be some low hanging fruit for
> abbreviating even that output. E.g. if you we have 100 tests and we
> failed only on the 5th, isn't the --verbose -x output up to and
> including the 5th going to be enough, or do we need it for the other 95?

I have a test fix waiting to be sent out, where a failing git command
in the 'test_when_finished' block of test #21 went unnoticed because
of the broken && chain, and ultimately caused the failure of test
#91.

In my opinion your proposed changes to 'ci/print-test-failures.sh'
would make things worse.

