Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856ABC4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 01:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjAABPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 20:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAABPM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 20:15:12 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C77647
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 17:15:11 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id g14so25855363ljh.10
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 17:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p60EDrIqS2rYSj+Fi8oeSXotoB1EwCKX+SjktuEFGnI=;
        b=IhRPsqyFTFwK7fDB3d8bbdHCB8TaAsjMGW9acuvs91m+CtBvLpKDEiNo+2baADAwfL
         Pp5J2S0wE/zyJxfNTzO7uOjz17edeFH24YtgRlCZ4EkcdCzaOf06Y5ioitPGAxt/0Ilq
         MuEyS4cMBfzMja+Atr+Wm97ZLUYAT1p1Mn/0MxbwvPFBt/53544Rzjth4GpRuOvMLPze
         Q+m1pgPijNrEvTfxc8SY0qvTcUPxF1uaXnYs/mXbRi7cFfzmRERUhmYnxAU8hyXiWjL3
         wezr6l4/q5di6JH0BYeXXP0hISMqNyIqQayxtworl01r72k44CTmfalzkfEPH03IleLy
         Zd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p60EDrIqS2rYSj+Fi8oeSXotoB1EwCKX+SjktuEFGnI=;
        b=4Ee7cu8olIkoWs+DUlfX2Uh0DljpN0MVNDhRpNjX1v2WkwhvhZjepnbd34qyKYgVBd
         gP+SRO41NlWlTTYvgS255ujYDPh0guMALo4hPfHIQHPfhBoUbZc5/29mBIxwYr3OPgX2
         a6rL/IeeDB4pLOtehBpfgi49stbiYo2lDRyNA5/lz+RbHbL5LXMsCwf9np4wekInR7m7
         p9DQJdcbJhy9ipqw6BMe9Fu7uXMI8e1SyQsfs7+X209X4uZdQjN2gwGE6leiBADAJ4kT
         kljEl99gCmUAcKBw8mdOiHzUJjNfmjim6Xf6EZZFr2NWYUkVd3gBetx8w0XruQfDJxh9
         oaXA==
X-Gm-Message-State: AFqh2krpJVAiA1XyFe1GAqSCCjDP6sfJmfq52L4aTGgi4lMpBlC4tF5l
        uKeomH01RSUR19X0Dn4kmD0q3TnQTQYa6RsL2qb96YxHsRxsbY/r
X-Google-Smtp-Source: AMrXdXuiU5dLq3Ep1OwwwrtpnwCdh/syy2qh0H8Yr3vxg6UL7nmS4JSBfG1v5VvtWMu2SA0noCs9LR7KpSXEcHpNYrQ=
X-Received: by 2002:a05:651c:1142:b0:27f:a93e:1d21 with SMTP id
 h2-20020a05651c114200b0027fa93e1d21mr1154404ljo.503.1672535709829; Sat, 31
 Dec 2022 17:15:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c266:0:b0:23b:5e81:46ba with HTTP; Sat, 31 Dec 2022
 17:15:08 -0800 (PST)
In-Reply-To: <CAJcAo8tY55sUNr=HX9-tVPYDoSOx-xkH0WtZuXuLqs0S3sXu-A@mail.gmail.com>
References: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
 <000701d91cae$6c8cbbf0$45a633d0$@nexbridge.com> <CAJcAo8tY55sUNr=HX9-tVPYDoSOx-xkH0WtZuXuLqs0S3sXu-A@mail.gmail.com>
From:   Samuel Wales <samologist@gmail.com>
Date:   Sat, 31 Dec 2022 18:15:08 -0700
Message-ID: <CAJcAo8scjTMqUGsJ8BDp95avmmv1vEvEUx-iqNvN14f9VkkTGg@mail.gmail.com>
Subject: Re: is this data corruption?
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

as expected, there is only one copy of bigpart is a partition in all
of my rsnapshot files and all of my emacs backup files.

therefore, the diff in git and magit are incorrect.  it was not a
question of me removing a duplicate.

for future reference, is this mailing list correct for this question
or should i use the git help list which i discovered just now?


On 12/30/22, Samuel Wales <samologist@gmail.com> wrote:
> more below.
>
> On 12/30/22, rsbecker@nexbridge.com <rsbecker@nexbridge.com> wrote:
>> On December 30, 2022 7:18 PM, Samuel Wales wrote:
>>>i am not subscribed, but am of the impression that's ok.  please copy me
>>> directly.
>
> ...
>
>> I cannot account for your emacs issues, but have a question. Have you
>> done
>> any git add operations? Git diff is subject to what specifically is
>> staged.
>
> idk what this means.  there is nothing in the staging area at this
> time, if that is relevant.
>
>> So you might be comparing your file with partially staged content that
>> could
>> account for partial diffs. See if diff --cached makes a difference. Also
>> try
>
> diff --cached produces nothing.  0 bytes.
>
>> different algorithms, like --patience or --diff-algorithm=histogram.
>
> i tried both with git 2.20.  they produce different output from
> regular git diff.  i looked for the paragraph i mentioned.  in regular
> git diff, the problem is the same as i described, with - - +.  in both
> patience and histogram, it is -.
>
> it occurs to me that, although unlikely, i might have in principle had
> a duplicate copy of those lines in A, and deleted one, and moved the
> other, when i created the current version, B. thus, i /think/ both
> regular and patience/histogram could be /in principle/ correct on that
> one point.  to confirm, i will check rsnapshot using grep -c to count
> the matches in all versions of the original files.  unless i report
> back, the number will be 1 in all of them, i.e. git diff and magit
> status buffer are both producing an incorrect diff.
>
> however, even if this is user error, i.e., i deleted a duplicate and
> moved it, the patience/histogram - result seems still incorrect:
>
>  The next few commands work with both grub> and grub rescue>.
> -***************** REF bigpart is a partition
> -biglike and homelike are distracting nonsense i think except
> -to describe inferior filesets.  anomalous subset of home
> -might be called homelike or so.
>
>  1) The first command you should run invokes the pager, for
>
> you can see here that the context lines are from a different org
> entry.  it is intermingling a live - line with a context line that is
> not adjacent to it.  that seems corrupt unless i, even more
> improbably, moved an entry from inside another entry.
>
>>
>> --Randall
>
>
>
>>
>>
>
>
> --
> The Kafka Pandemic
>
> A blog about science, health, human rights, and misopathy:
> https://thekafkapandemic.blogspot.com
>


-- 
The Kafka Pandemic

A blog about science, health, human rights, and misopathy:
https://thekafkapandemic.blogspot.com
