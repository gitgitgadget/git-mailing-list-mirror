Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85C6C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2ABC61376
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 18:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhFHSGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhFHSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BABC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 11:04:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso658693pjp.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5T/MDMBGNWLjl7O9dLv3+UYvtT7WDSlGHcRkkqYQ7bY=;
        b=ScbSiuwJ0KDciSPhOIU2lX6x/IewNy+P7lms3AnyI1Ndhswhtrc7Q0ErJiMu0uZYZP
         M8gcEP50bYkvuLveeRMoQNyZ0TVWHscJVAHUGCBhxGTntMtlMKW/5UrJMItWFQUx6bLV
         QRcMfkrZ+Fwo99jMiVuZOPUeB0fYLD1nB3pl50U+9+XNUC3Ev74ucFAGDsgm5cqa8fjm
         Cnv0HXTGqTLn491IBsw/Q9hju4VXp63qjD5sv5z9R431gfWTXsdH1NqWJAnW3V82F+oC
         ivyYOQghNRgx8CfalAmvIVeCRJ5+zp9v0HgiNj1qLjdX2GUmSt/BszbuNHJdtzM/LoQM
         UZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5T/MDMBGNWLjl7O9dLv3+UYvtT7WDSlGHcRkkqYQ7bY=;
        b=NU6R1di6TH45mUx73EB/HiaNv/mG7nf8BdLljMlKYvAhIHELpCSuimJdLiNy+BEdBp
         2AvBgNrIhv2V2S02986CRVaR4Y9KaA2n/2r9JRMfa1xdtizHYgQKhw0R9CDaqMa95ff9
         DyZUt+2GAzIEAmDVay6QzK0ZOFWbs7k2pMwu1BPvALwBQuJ03kJX1I1+ewwocrgn/4XZ
         gMgwbKRYCnB6KW1x7Slx7QG2Y0omgO9RIduGxls89fMDimo4fY/txowBLtbJHDP1jZbU
         VdKAEo20KWPtVmzYkR0+KsdQM1zx5Up+h/3G8NANcguhpZnD8MQfI6geKG15Oo7doYUW
         7/xg==
X-Gm-Message-State: AOAM531Z+4iqPBPPriCDkW/6FsmHsWSFsr2rkktWNmeo/WLZVVCzYoGU
        D5I7rK0AupiyupEK6nxrkJA=
X-Google-Smtp-Source: ABdhPJxntGk8BRHIb8vWBV5OE3jaUn4WguasBiWyY27s/t+fJ0kaKdk4hDKxJuWn4VAgv4L+ICCnBg==
X-Received: by 2002:a17:90a:7aca:: with SMTP id b10mr6235255pjl.49.1623175445047;
        Tue, 08 Jun 2021 11:04:05 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id s24sm2990016pju.9.2021.06.08.11.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:04:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] MyFirstContribution: link #git-devel to Libera Chat
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <YL+ndHSLowy/qyZV@google.com>
Date:   Tue, 8 Jun 2021 23:34:02 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C8A2DA3C-8D30-44AD-99FF-C5394C5F3B30@gmail.com>
References: <20210608135114.71104-1-raykar.ath@gmail.com>
 <YL+ndHSLowy/qyZV@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08-Jun-2021, at 22:53, Emily Shaffer <emilyshaffer@google.com> wrote:
> 
> On Tue, Jun 08, 2021 at 07:21:14PM +0530, Atharva Raykar wrote:
>> 
>> It's pretty safe to say that most of the regulars on #git-devel are now
>> on Libera Chat. This will help new contributors find the right place, if
>> they choose to ask questions on `#git-devel`.
>> 
>> Since there seems to be no way to directly link Libera's web chat to
>> `#git-devel` directly,
> 
> I just typed "web.libera.chat/#git-devel" and it worked perfectly fine.
> 
>> I have put a generic link over the text 'Libera
>> Chat'. Users will have to manually type `#git-devel` in the webchat
>> interface, but that should be obvious enough to not be worth mentioning.
> 
> Generally, this is a bad approach to take for absolute-beginner
> documents like this one. Even if it "should" be obvious, why not just
> say it? Some skills - like how to examine the compiler errors from your
> C compiler and fix your code accordingly - are a necessary prerequisite
> to be useful on the Git project; other skills - like how to use IRC -
> are not, and we can teach them, especially in a guide like this :)

Got you. In fact, the fault in my reasoning was perfectly
demonstrated by the fact that I did not attempt one of the most
"obvious" ways to get the link to #git-devel directly.

I cannot decide what's obvious for other people :)

> But anyway it's moot, as direct link does seem to work.
> 
>> [...]
> 
> The prior link was a direct link to the #git-devel channel, so that
> newbies don't need to figure out how to join the channel they want from
> the main webchat landing page. It looks like Libera also supports this
> functionality. So please link to 'https://web.libera.chat/#git-devel'
> instead.

Sure. I'll send another patch.

> [...]
> 
> Thanks very much for sending the patch. I haven't had time to address it
> myself.
> 
> - Emily

