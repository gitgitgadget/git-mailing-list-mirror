Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ADFC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4F460200
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhGSKCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbhGSKCW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 06:02:22 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C5C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 02:50:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id b24-20020a9d60d80000b02904d14e47202cso330213otk.4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vWaeh15AbnTM0bqpJ4mpuJA8TkBcmYZpAtvq9osRuMg=;
        b=V4UXMEaxGGCPhoFR4Gogj6RVWZ0ZAoSfkWzzYEH6Z/d5hxdiBvTSWeQ7a937yW8UZ9
         X47RAtANJehQi8HWrxBOvVMnLUCihsdK6/QR4gX2pkLRJ7aJT7n9286RPu+Bu2QPm7Ez
         /T1i8MHe3L4aDAcZYQ0V3CLtfzQtviLP24f6vNKUqMl810Qq/79vyovn7Mpro3asOTVk
         HVirO9yeQ0GiPom4k1antv2H2CZsetqhjIf8c0MM2jmakwdLNaJyqeyqDhwBW+5qiqeL
         5+TRw5tSTsU2sIjsgO1yiG93FOq9wBJWWXbEHFRht1cXO6mYz24lH/4cDfFkeUpkuxjm
         kyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vWaeh15AbnTM0bqpJ4mpuJA8TkBcmYZpAtvq9osRuMg=;
        b=QKeHzW+AU4TevbzCs8qeWsxRPEQlbelyESd9ssqhLBuq+7+wtNpy0xYtMkR0XuyKqw
         rGKTbGqyx94YdE2tzSaLfrV78j2721jxizvZvma1RoHS1qeYVrEGNxi0D28mSvRfeCcf
         V0BE2LeXvMTwnvfY3akM6obcLxgwLXcwP6I2o6LPGGR28BZ8UR9ecorV1O2IPd1G+gtD
         bmGiWqLpKDSdDbZmRSYZVp5RGhOg4jLbe24iniVai4DsIYUTbV+Q/jRvnJ35DCN6beLu
         y+1PygownNu3lmJ+BzNeNb/X/DY3FDtr6oLpUs5WxpBOZoTrwVL0Dk8jB01mKMxoR+Cq
         Zw8A==
X-Gm-Message-State: AOAM5308vFi/658VtnXOSZp/R9Tnq0/ZQfPVWIweu1wPEIQj8DrlSvZT
        03vR7p/MBzEgPDfCuk1sRXM=
X-Google-Smtp-Source: ABdhPJy6zpWnmKljI63kNpME+wjAeKA4WC/6AcKrqVHaWsXkmmfycaZvBwUX6Vh0XM0UEhwsyG0L2Q==
X-Received: by 2002:a05:6830:913:: with SMTP id v19mr5933487ott.156.1626691381240;
        Mon, 19 Jul 2021 03:43:01 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x20sm3561312otq.62.2021.07.19.03.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 03:43:00 -0700 (PDT)
Date:   Mon, 19 Jul 2021 05:42:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60f5573312036_13ce8720841@natae.notmuch>
In-Reply-To: <YPU5NyoDrQquWOYo@coredump.intra.peff.net>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <60f52f7a52671_1e0a42083b@natae.notmuch>
 <YPU5NyoDrQquWOYo@coredump.intra.peff.net>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jul 19, 2021 at 02:53:30AM -0500, Felipe Contreras wrote:
> 
> > Patrick Steinhardt wrote:
> > > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> > > [snip]
> > > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> > > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > > > 
> > > >  Test update.
> > > > 
> > > >  What's the status of this one?
> > > 
> > > From my point of view this is ready, but it's still missing reviews so
> > > far. The lack of interest seems to indicate that nobody has hit the
> > > issue so far, and I wonder why that is. Am I the only one who sets
> > > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> > > tests?
> > 
> > No, I do the same, and this other fix for TEST_OUTPUT_DIRECTORY is being
> > ignored even harder:
> > 
> > https://lore.kernel.org/git/20210707030709.3134859-1-felipe.contreras@gmail.com/
> 
> Note that the linked patch will break Patrick's, because we would no
> longer set TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS.

Is Patrick's patch specific to GIT-BUILD-OPTIONS? Or can
TEST_OUTPUT_DIRECTORY be taken from the environment?

Either way I think the priority should be to make the standard tests
work with TEST_OUTPUT_DIRECTORY.

-- 
Felipe Contreras
