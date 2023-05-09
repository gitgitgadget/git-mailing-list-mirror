Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9795C77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEIBe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEIBey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:34:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD634494
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:34:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6a5f602a8f7so3662347a34.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683596092; x=1686188092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETg57XxeHHNgdfKh4cnpFOefqs6GMq4a/uybUPXrp50=;
        b=ijlI4Iurq1mHlih1NN0W+5y8gHkwdNdvacoii99w+m/Q2mA5dN99Mua1Sg0QYD350P
         uDYOiW4WuuswMsPsmQ/OXzQZI+I9SfOO6kYxXa8ggWKLQg8w943P9LYpFcvuPl2lZDrF
         cTaQKNhN7FUlpFTCX+2QJKudpylDb8HCulnvfXRiM2L91acEcN7k8euePuNuas8vPUJK
         XM9K1ak+ILOBbddJEIkS2maVNuiqsh8HT00lvuoZn4fy7PSyVAggAGNsUIjeaSxFFBvs
         0DPqTSNPG5Jl5mmNeUGDcFTq8VcTtPco9U/VcK/B6C3TsgyVv2ZTbspvq/7jXB4aMrPP
         ovhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683596092; x=1686188092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ETg57XxeHHNgdfKh4cnpFOefqs6GMq4a/uybUPXrp50=;
        b=ldG28tEF6qkRc4Cv4j4zlClxIaIEH4Q8Rt3+6UHt3pjHDfD0X7s9835b9uokiaKSBL
         xycGlR1ab7LtRnDluCX5/IX4fgF6GpyKzevitE7/PuUQaf8vOrGZhb05S0MklVfaqtib
         NUCVcFPngxVhCCxoIm0GxZW76osbCfSBQQQVS+a1IIW5tfotV95bqpi1i5dBwz5yv/Vo
         faAJ5WIjNpVbZimlT2KtIjxcHZ0CqZTRyEIv7Xui7gRX2uHKutlQe2Thb2atrkhNaibz
         2DH3w5jiMPK3usKI+9IL1c2DRVB2lWdtRn+HPHSVMEUIDoEBxDhlR7sPSssxAjjSNlWV
         NkLA==
X-Gm-Message-State: AC+VfDyI+jfas4GYruba1naohQbgubpx+iTuzJifZqvAWzG5EMxjdu7z
        Wz3KDhjzna1D8smAOz5ZLy0=
X-Google-Smtp-Source: ACHHUZ4SFOtzSr9yoM/9bkwXM7Y8VGSBK+QonIhcqXHo8aCmKlRzEoQ2qLarBC6XOcpBL2AuN8yhGw==
X-Received: by 2002:a05:6830:100d:b0:6a5:ff20:82c with SMTP id a13-20020a056830100d00b006a5ff20082cmr459261otp.32.1683596092396;
        Mon, 08 May 2023 18:34:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g12-20020a9d6b0c000000b006a415c6f304sm4717968otp.68.2023.05.08.18.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:34:51 -0700 (PDT)
Date:   Mon, 08 May 2023 19:34:51 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <6459a33b14bd6_7c682947d@chronos.notmuch>
In-Reply-To: <87o7n03qgq.fsf@osv.gnss.ru>
References: <20230503134118.73504-1-sorganov@gmail.com>
 <xmqqsfcdtkt0.fsf@gitster.g>
 <874jote2zl.fsf@osv.gnss.ru>
 <xmqqmt2lqofb.fsf@gitster.g>
 <xmqqttwskse5.fsf@gitster.g>
 <87o7n03qgq.fsf@osv.gnss.ru>
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> > When a command does not behave the way one thinks it should, being
> > curious is good.  Reporting it as a potential bug is also good.  But
> > it would help the project more if it was triaged before reporting it
> > as a potential bug, if the reporter is capable of doing so.  Those
> > who encounter behaviour unexpected to them are more numerous than
> > those who can report it as a potential bug (many people are not
> > equipped to write a good bug report), and those who can triage and
> > diagnose a bug report are fewer.  Those who can come up with a
> > solution is even more scarse.
> 
> I'm afraid the solution I'd come up with won't be welcomed.

My solutions are often not welcomed, and yet I still implement them.

It might be a waste of time, but often I've found out that very quickly
after attempting to come up with a solution I realize there's a lot of
detail I was missing initially, so even if the solution is not welcomed,
it helps me to understand the problem space and be more helpful in the
discussion of potential solutions.

So if I were you, I would still attempt to do it, just to gather some
understanding.

Very often I myself realize the solution I initially thought was the
correct one turns out the be completely undoable, and often I need to
attempt more than one.

If I'm content with a solution, I send it to the mailing list,
regardless of the probability of it being merged, because in my view an
unmerged patch still provides value, as it creates a record that might
be referenced in the future.

In fact, quite recently somebody resent a patch of mine that fixes an
obvious regression [1]. So even if the maintainer has not merged my
patch--and thus it could be said my patch was not "welcomed"--the fact
is that it was not welcomed by the maintainer, but it was welcomed by
the community.

I for one welcome any and all attempts to fix git's awful user
interface, regardless of the reception of the maintainer, and the "core
club".

Cheers.

[1] https://lore.kernel.org/git/pull.1499.git.git.1682573243090.gitgitgadget@gmail.com/

-- 
Felipe Contreras
