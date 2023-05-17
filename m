Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8816EC77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 19:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjEQTBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQTBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 15:01:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456CB210C
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:01:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae3fe67980so12575965ad.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684350093; x=1686942093;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWHakxy0qiHeBzTfc97lUezjPVHqzu58ED1EuvWPD54=;
        b=aESiihEDZZzQbvGCi5Q4TrZ4+jbFXYS7CEHeXgM1Yfpbt3tu0ae1P2I38l9icE7r/D
         kcF+wJ3UAkD6M9fCOwVRKGR1viuX5IPEAZIRjCnQCQXWJaRJD0OEDh/NKT1F2LjXHLWt
         DjQN6L/aDBAoLnwZyNwQjVaeYbC41folpsNFlImQIzgGoRWv/+8wmSoDRjoYWcb491lk
         bE7hoS7jsMKUaLXSnY+RoTimh0BYv35wGB8ExmHOIT1oovC4Ab/SKJcQPJkDKix6bkne
         sBQXb9sHu73zMh2HlwVIr2PO07B9Z2pX2xBZqNTW3xjZgMMcRDUoarxtrTPrPw9IjuDH
         r6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350093; x=1686942093;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aWHakxy0qiHeBzTfc97lUezjPVHqzu58ED1EuvWPD54=;
        b=jce4g/cHiMH+WK1gQsGZxfAzInL90kPlj7F0IGwkQnHtb1knEwdB4ZLVkmZ00mhgKz
         vMFCWw/WOP582mB2zRLDP5kLEc5axv8YSkpEUgC8lBpJ6xYbv76i9JJRuRtLDl4qv3eU
         KIr9l057ptCEw94yAhTQUQmldSvGT0Zx+OO/2s4lp3nd47TMso4aD/WhQ/+/c35IrZjL
         lVAUKgcR08xFdeMXiWOeer+F7+7U2X1LlFmmw1jCozjyThT3+gNlyn6NJ6eY4DOr3msN
         8kCV7uOG595/aZhU/zPiKJN3//jYfv+bC0z+s/qLG2GqyI100yg9uwV64tEczzmnhXlL
         iinA==
X-Gm-Message-State: AC+VfDzOc087DRHZu0gynfrqWT/UfFkYwKi7+LzKgESSTGlVel0UKzE7
        WMA7yWh4t92hazsfknxAFPYe8i48hhc=
X-Google-Smtp-Source: ACHHUZ7VWviKSjbWSnDV1MKgz6pciTFH7geGJ/L9gDFtdhsaCxIf0V2X4/Qs0XmPpTtlhwDSAqQ1cQ==
X-Received: by 2002:a17:903:32cc:b0:1ad:cba5:5505 with SMTP id i12-20020a17090332cc00b001adcba55505mr31821448plr.14.1684350092584;
        Wed, 17 May 2023 12:01:32 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001acaf7e26bbsm16024780plg.53.2023.05.17.12.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:01:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, michael.strawbridge@amd.com,
        dianders@chromium.org
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
Date:   Wed, 17 May 2023 12:01:31 -0700
In-Reply-To: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
        (Emily Shaffer's message of "Wed, 17 May 2023 11:38:01 -0700")
Message-ID: <xmqqo7mipyt0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> Following is a report from inside of Google:
>
> **What did you do before the bug happened? (Steps to reproduce your issue)**
>
> ```
> # With the attached patches, where all of the patches have a
> # Message-Id but the cover letter doesn't.
> git send-email *.patch
> ```
>
> Specifically, you can see me doing it:
>
> ```
> $ git send-email *.patch
> 0000-cover-letter.patch
> 0001-dt-bindings-interrupt-controller-arm-gic-v3-Add-quir.patch
> ...
> 0006-arm64-dts-mediatek-mt8195-Add-mediatek-gicr-save-qui.patch
> To whom should the emails be sent (if anyone)?
> Message-ID to be used as In-Reply-To for the first email (if any)?
> (mbox) Adding cc: Douglas Anderson <dianders@chromium.org> from line
> 'From: Douglas Anderson <dianders@chromium.org>'
>
> From: Douglas Anderson <dianders@chromium.org>
> To:
> Cc: Douglas Anderson <dianders@chromium.org>
> Subject: [PATCH 0/6] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
> Chromebooks w/ bad FW
> Date: Thu, 11 May 2023 15:25:55 -0700
> Message-ID: <20230511151719.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
> ```
>
> If you look at `0000-cover-letter.patch` you can see that it has no
> Message-ID, but the above clearly shows that the cover letter is being
> sent with a Message-ID (and the one from the last patch).

It is correct that Message-ID needs to be assigned by send-email if
the outgoing message lacks one.  I am not sure what is meant by
"from the last patch".  Do you mean that Message-ID exists in
0006-*.patch but not in 0000-cover-letter.patch [*]?  I suspect that
is the root cause of the problem; if 000[1-6]-*.patch already has
their own Message-ID: because --thread is used when running
git-format-patch, they would also have In-Reply-To: and References:,
but there is no way for them to reference 0000-cover-letter.patch
(because format-patch did not get a chance to generate Message-ID to
it), is there?

Is this because format-patch was used without --cover-letter but
with --thread to prepare 000[1-6]*.patch and the cover letter was
created separately, or something?

The simplest fix I can think of is to stop using Message-ID related
options when running format-patch, and let send-email do the
threading.  It would avoid problems coming from mixing output from
multiple format-patch runs.


[Footnote]

 * As a reproduction recipe, the report should tell how these files
   were prepared (format-patch with what arguments to get there).
