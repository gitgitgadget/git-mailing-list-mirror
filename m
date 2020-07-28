Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEEC433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999A920663
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hQWEFf1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgG1QZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgG1QZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:25:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC386C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:25:31 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id y11so6415948qvl.4
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcDR+fC+wd5gBdgKKz49mt094rmjjieQdK8vyrV4WpE=;
        b=hQWEFf1AG/hBeakq7wMglxHXVb9KTPHdULpxcVvAw0ymcWZl2qlM4B2MtIX3BP67Ho
         HrtgFm+ZzJocgxkERa2pIwqEHBN4RcRThFaKfR5a7m9H3yn/3Rd+KgoiJba0anwXB5QU
         v0GGeRHg1f0OK5a+3ZP0cN47E7rXhGqifgsMlf+6/WCesdpq8vprEXhu22ybQ7zabq22
         8A2Ow1nRcacvWDfkQG/nni+fDmyfTRC4Yt7WgKDmNxp9x9oMkam+M8UZnRUiTIUg/ZJu
         1ycAmg/iQASUi+ip39PiDQWnHXtTNQZRjHaskgdPU8kX2n4NqwzFAwJjk2ouKvqh21lI
         86bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcDR+fC+wd5gBdgKKz49mt094rmjjieQdK8vyrV4WpE=;
        b=rgHtbcRV+vbGGHg4n7g9fUGjfjWB1654uFa6PWnh8Px9Hmzj8vjPhpyhHwjMt1i3JB
         iYLMDI7umU1kQ8x/LH7QH+jfPKrqWVf1chFYW/+h2LdY1aJfA5XJaxPYX78TAg3ei7RV
         8fheOxef9akOUtg8VSzeja8kfHD2ueIJ9bcXD4j3tw/DBEb988q46mal5/a9DzwBzLy6
         76f9TW1TRfi3qN8nq89g2Npl0YAr8leMZF6TrOG0+OP+Jye5S/qP+JWkBUMLvTfLEuhv
         BlNdiH3naYbbjwoNMEY+oaHAO4GPuNr9f9s5AQGp2DSXTAcVQnHUabp4hvEFPIX4uRJt
         I6Ag==
X-Gm-Message-State: AOAM5336amYu/Zfa8l4wvIBrDeIgPB1NsbJ04tPxWSmaeKJPUd6DUQe0
        ZRVP8lWnlvtitKInqMtROvCaLg==
X-Google-Smtp-Source: ABdhPJzOygA2NJ07qKzxDO9sxGjnpSO1+t1Y251w3gKkdJBvtq8Qkq74HP3h/Uw8YrgTHLi7JtsUfg==
X-Received: by 2002:ad4:4744:: with SMTP id c4mr28571217qvx.126.1595953530540;
        Tue, 28 Jul 2020 09:25:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id q16sm22730232qkn.115.2020.07.28.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 09:25:29 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:25:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Wong <e@80x24.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Carmen Andoh <candoh@google.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git Inclusion Summit
Message-ID: <20200728162528.GH87373@syl.lan>
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200726040226.GA19030@dcvr>
 <20200727151023.GB62919@syl.lan>
 <20200728100726.GA24408@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728100726.GA24408@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 10:07:26AM +0000, Eric Wong wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
>
> <snip>
>
> > I think that it's tough to make individuals on both sides of this feel
> > comfortable. On the one hand, folks such as yourself may feel
> > uncomfortable with this format for the reasons that you posted above. On
> > the other hand, some folks may prefer audio or video instead of text
> > because they find it easier to express themselves with their body
> > language, intonation, etc.
>
> I can understand that.  However most coding nowadays (especially
> for this project) is text, so that's already the lowest common
> denominator.
>
> > A bare minimum seems to be using a free service (I know that Jitsi Meet
> > is an often-recommended alternative) with support for joining without
> > video (either using audio only, or participating over chat).
> >
> > Hopefully everybody should have a good-enough internet connection to
> > stream a low-quality audio-only feed so that they can listen in and
> > participate via the chat feature. This is what we did at the
> > Contributor's Summit in March (I know we had a number of text-only
> > participants in time-zones where it was late, etc.).
> >
> > What are your thoughts?
>
> Jitsi w/ audio-only certainly seems to be a step in the right
> direction and would be more inclusive.
>
> Is there any speech-to-text transcription done for the hearing
> (or extremely bandwidth) impaired?

It looks like such a thing exists:
https://jitsi.org/blog/a-speech-to-text-prototype/.

> It'd ideally go to #git on IRC (or something that doesn't
> require a browser to trigger swap storms on old systems).
>
> Even for people with good hearing, acceptable audio quality for
> speech seems tricky to get right, being dependent on mics,
> bandwidth, codecs, background noise, speaker/earphone quality,
> etc.

I haven't look hard enough to see if it supports redirecting its output
to an IRC channel, but my guess is that it probably doesn't. In either
case, hopefully disabling audio and video is possible within Jitsi's web
UI, and you should be able to read or write in the chat as well as read
the transcription.

Thanks,
Taylor
