Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B0C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A822224E
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skX+/MRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437488AbgJUNQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407500AbgJUNQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:16:28 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F0C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:16:25 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 16so1998897oix.9
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdV90xLygEAq5q8My7aT1dzV1M3cegDwH/dlbAjZK48=;
        b=skX+/MRIMX9d3rKwR8u2MnN1wO+26vqm6gnh2by9YfUolh6RpjoTXGjNT7bIJ41sB6
         OVcONOu7l/GDs+a1D5hu2KmvuzowPgggFkpmHo5qcBITPb2YH2gCseOYZ2bFU6p/+NjN
         edK+KlgT3/tGJgjN0/CWwTWI9qWLwYF6qCRfZDDb7OFL0tqNeX1kwlges2QLligd9aBi
         dl2axjL5KE4CRg62XPZBowkFqvnbQJTydaa/wn5I+WO9tumn9BJ7AuQ7Y6KCW0WNlTPe
         kgHl7y1qcvRKQitE4O88J+Th+8KfMIBjUYzK01uMUi8b7M847GSSLpG3nXhQczP58bGW
         4WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdV90xLygEAq5q8My7aT1dzV1M3cegDwH/dlbAjZK48=;
        b=kuVStBSdZrWnDsLMRSu4SVvkbAvQ4Hu6yshCSVGF1C3wBXsdTBiq91pkAIMELg06As
         FQx8uy/Xr8k5flZhsodow6cuE0w66ofLUV9PXNsV4FYV4nzvP6mt1vnFAG+/FXT9vX4T
         ITdN/MPDJk/mPE3pgThXRzF2nRQ/rA8sRJTH0idV5DTJr4EVAtM59EvoLgcEwecuBp/r
         YA1hrjMIvxce0fn06XqiYbvc2hoatv2rQ1ditSGnGHHKnxLneA3d2qxsY4XUFQqs52Sk
         IP1T1Hvcl1RTnIySMBK8n+nNEZ9rV4pi2TAYAtB4dB2k0R/We6WFp62ZKGuMVCQy0pWL
         zFxg==
X-Gm-Message-State: AOAM531BiKuiIMgygqTJSGDTL+AwQpveBraL6sNIDk7R2OekGbcGFj6r
        B4pvrTYwCfCz+8kqyBpLAMqx3loVMpxSPQQgYWM=
X-Google-Smtp-Source: ABdhPJwVQPjmmBeI9E89iKl5rCoc0WFtVRz/m7/l8OK6OfSwY7GSRBtMhdIMAXKnf45ZnnrekRIzW5IJ6qIBqr0XfxI=
X-Received: by 2002:aca:55c3:: with SMTP id j186mr2215279oib.98.1603286184824;
 Wed, 21 Oct 2020 06:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201017075455.9660-1-charvi077@gmail.com> <20201020121152.21645-1-charvi077@gmail.com>
 <xmqqa6wgbqpq.fsf@gitster.c.googlers.com> <xmqq5z74bqgi.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z74bqgi.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 21 Oct 2020 18:46:13 +0530
Message-ID: <CAPSFM5edytA_RR_ykYFnWdpbG8ThoESYh+JCSYQ83j4w8k1sDQ@mail.gmail.com>
Subject: Re: [PATCH v4] t7201: put each command on a separate line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        phillip.wood123@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 21 Oct 2020 at 01:49, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Charvi Mendiratta <charvi077@gmail.com> writes:
> >
> >> Modern practice is to avoid multiple commands per line,
> >> and instead place each command on its own line.
> >>
> >> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> >> ---
> >
> > This looks good, but I am wondering what happened between v3 and
> > v4.
> >
> > As you've demonstrated through the microproject that you can now
> > comfortably be involved in the review discussion, I am tempted to
> > suggest that we declare victory at this point and move on, but I
> > don't know what the plans are for the other 4 patches (I guess we
> > won't miss them that much---the micros are meant to be practice
> > targets).
>
> Actually I take it back.  This does not look good as a standalone
> patch at all.  It seems to depend on something in the 5-patch
> series.
>

Yes, Thanks a lot Junio. I totally agree after applying it locally and
getting stuck in am conflicts without using v3.

> Please make sure that patches you send are usable by your
> recipients.
>
I will take this as an important note. I have fixed it and sent the patch
series after testing it locally .

Thanks and Regards,
Charvi
