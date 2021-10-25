Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93466C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEEF61039
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 13:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhJYNDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhJYNDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 09:03:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AFDC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 06:00:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g201-20020a1c20d2000000b00327775075f7so4894553wmg.5
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ojgnvg3AOpgxHpE+qPvLJTmDN2LwwstClKVr4S2mVhE=;
        b=LGBxVwdpphXN/hLX06jo4Jm4+9VlADVgKQc/HedKi9Zi2bEfBbt2B+w8hpPWe3bRep
         no5uLLEdVE2pgHRdsWX/euqvXBxPxRbEN7K6W30o+Q/bIG9+rNmZ4zocHtXpW82N/Lgp
         J3WLYevBeu4eMLvDhe1NRw7vflCVagdXL8MIxBmbP+h/qNoDVQU95CjPk67oclmXdmht
         ncPvayJVvxHH79m4r8UHUph/1N24D9ApUvW6Uw4hb5YUJTPP9U0VmrroQeq9Dj+urEKA
         yPb8zmSJuC4036lMhGOTa1RtKsaKwPWriSK2Gi9Dy9AOPO7DFS8mMOxjAKdvqqhTyRu1
         IV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ojgnvg3AOpgxHpE+qPvLJTmDN2LwwstClKVr4S2mVhE=;
        b=5sESG7FothVSvzWkcWE1Pi1tUQjsNWFpKFoJQL01tLm/hkOJMYRt2ZNtaG8Dx/o6of
         9qHI0ktTFelrc/OEJVuqDhwwEYBVfYSOsnsNS7XPeYXC7pyMbem1bXaTAmqgC5AEXToU
         TYHQ+zfkV/xilZyNHXoVsKs0lUxpaWEul1vS/5K9mPjL4mXFC3FL7Ca6dvovwwlWQmU8
         xTreGhNmQRBo60PzrCk+HmllS7MCJvi/LN/zgSQoriTcq7JVcR1JrY68AIWY2DEFsdlt
         T1GpZfij+TEweWJUaWjDISgKElyGXSVHnNSQ4g6pw3ytUfyGI4sp0u9viTrIM7tIwBr/
         8q7g==
X-Gm-Message-State: AOAM533rXWvJXn5AQlLqdqG1nhPcmk8RkjFDVTQoxnIoF+6lGBcWfFnY
        9Tm+nAJvYImgo2dP+gTxnE429QTJ2Q/cMQ==
X-Google-Smtp-Source: ABdhPJxdDb37gyXCzhEcw/T1BLSgYPvFarHiVRTrk7z0ZbGoKIMv4WBJd1jIjjW49nW01Tj2p93MIg==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr14741342wme.188.1635166849538;
        Mon, 25 Oct 2021 06:00:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s18sm14146138wrb.95.2021.10.25.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 06:00:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mezaq-001XHy-JV;
        Mon, 25 Oct 2021 15:00:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Let's have public Git chalk talks, was Re: Notes from the Git
 Contributors' Summit 2021, virtual, Oct 19/20
Date:   Mon, 25 Oct 2021 14:58:48 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110221143240.62@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2110221143240.62@tvgsbejvaqbjf.bet>
Message-ID: <211025.86pmrtgsxr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Johannes Schindelin wrote:

> Team,
>
> On Thu, 21 Oct 2021, Johannes Schindelin wrote:
>
>> * Let's have public Git chalk talks
>
> Okay, I give up on the mailing list. I tried some 20 times to send the
> notes out in one form or another, and it simply is not working, and the
> time I spent trying was definitely lost time.
>
> So here is a link:
> https://gist.github.com/dscho/003a0e112058e5794b5e08e84d34092d

Trying to see if it works for me. FWIW I recieved a bounce from GMail on
an unrelated mail of mine in this thread whose error suggests that
gmx.de's MX's may be rate limiting recieved mails on your account in
some way, which may or may not have anything to do with difficulties
interacting with kernel.org infrastructure in general.

Attempt to paste
https://gist.githubusercontent.com/dscho/003a0e112058e5794b5e08e84d34092d/r=
aw/8d825e01152d957671d5da9e7c5217cabc37afa5/gistfile1.txt
follows below:

This session was led by Emily Shaffer. Supporting cast: =C3=86var Arnfj=C3=
=B6r=C3=B0
Bjarmason, brian m. carlson, CB Bailey, and Junio Hamano.

Notes:

 1.  What=E2=80=99s a public chalk talk?

     1.  At Google, once a week, the team meets up with no particular topic=
 in
         mind, or a couple topics, very informal

     2.  One person=E2=80=99s turn each week to give an informal talk with =
a white
         board (not using chalk)

     3.  Topic should be technical and of interest to the presenter

     4.  For example: how does protocol v2 work

     5.  Collaborative, interactive user session

     6.  Helps by learning about things

     7.  Helps by honing skills like presentation skills

     8.  A lot of (good) humility involved. For example, colleagues who have
         been familiar with the project for a long time admitting they don=
=E2=80=99t
         know, or have been wrong about things. Makes others feel more
         comfortable with their perceived lack of knowledge

     9.  Could be good for everybody on the Git mailing list, might foster =
less
         combative communication on the list

     10. Might be a way to attract new people by presenting =E2=80=9Cold ti=
mers=E2=80=9D as
         humble

 2.  Does that appeal to anybody else?

 3.  =C3=86var: I think it would be great, has been a long time we=E2=80=99=
ve seen each
     other, and already feels different

 4.  One thing to keep in mind: it=E2=80=99s hard to program on a white boa=
rd :-)

 5.  Emily: some challenges:

     1. How often?

     2. What time?

     3. Probably move things around (because we=E2=80=99re global)

     4. Tech to use? Jitsi? Twitch? (Twitch seems to be particularly popula=
r to
        teach programming)

     5. Figure out what topics to present

 6.  =C3=86var: does not matter what tech to use

 7.  Emily: some difference may make it matter: on Twitch, you can record, =
and
     they host recordings

 8.  One thing to worry about recording: people might be reticent to make
     public mistakes

 9.  It=E2=80=99s possible to do a Twitch stream, and not record it

 10. brian: maybe record it, but not keep the recordings forever

 11. People might be uncomfortable having their homes being recorded

 12. At GitHub, some sessions are recorded just so people from other timezo=
nes
     can watch later

 13. CB: would be a nice way to see the other contributors

 14. Really like the idea, hopefully won=E2=80=99t replace other things we =
do

 15. Emily: internally, often about patch series in progress (or not even
     started)

 16. So retaining recordings for long time makes even less sense

 17. Weekly might be too frequently, Monthly cadence sound more reasonable?

 18. Junio: not sure we want an official schedule

 19. Assumed this would be an extension of what we do on IRC

 20. Remember when Linus would drop in and talk about a specific topic in
     depth, was nice

 21. Now we have video

 22. Emily: I fear if we don=E2=80=99t schedule it, it=E2=80=99ll never hap=
pen

 23. =C3=86var: would like it to be organized, maybe try some schedule and =
then
     iterate?

 24. brian: if it is scheduled, I can put it on my calendar, otherwise migh=
t be
     hard to block the time

 25. Every two weeks would be fine, especially when alternating timezones

 26. Emily: who besides me wants to volunteer for the other timezone?

 27. =C3=86var: if you start a schedule, I=E2=80=99ll see what I can do

 28. CB: also interested

 29. brian: can do, but Toronto is probably too close to California time

 30. Junio: schedule should be put on https://tinyurl.com/gitcal

 31. Emily: how about using a Google Sheet just like for the Contributors=
=E2=80=99
     Summit?

 32. One advantage to decide the topic in advance is that people can decide
     whether to make time to attend, on the other hand people might show up
     with a polished PowerPoint, which is not the idea

 33. brian: we can try, and if it does not work, make it less formal

 34. Emily: pretty much got what I need to start this
