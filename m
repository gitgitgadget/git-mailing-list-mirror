Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B40C3DA7D
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 00:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiLaA5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 19:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLaA5K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 19:57:10 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B8F03A
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 16:57:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u12so19850381ljj.11
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 16:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMb+xM98e/sch94eYiydpxt6MlEvgKYEJwJtKBowU7c=;
        b=djAaYDJaWL2wCcLfB+U0FfswwN2O3Ts93ojsPMCDpslZ5tbF+C3RjKltgUTMpsvurT
         tWaLgaF/UlRfiYIexR/233Xr/8QTYstdiFKV6D1AycAeU3DMdoZPKRylAPLgDhLXKbDU
         LiP7pRKn/uSH2Z+i0jlNsmY9zpKn2tJMJPCX32JChFHSmghzlBKd3c1UL/Vl3yZkBU8Z
         P4zlpn5mJu1b/SpUIxuKzVS0R38ahN+XjKX4m0rHU1DtV9gfjwyVhCfRk922C3bXNlIm
         0zaCPcT3gJfGMq2/s4z3Nqm5lnOGYhc07tDqCBHvzoEuFPxFpXNDjQtHHIAJeEx8U+Cx
         vq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMb+xM98e/sch94eYiydpxt6MlEvgKYEJwJtKBowU7c=;
        b=uWirVOs+61jvBaz+UGJMOqj2nFxY2ybu3OZtYx0842brIkgA1H4Y7xiBG5iAniI4tZ
         emnPmzsMsH+ABS/o9E5MrzMXLbFvIxrirjpVLAzBukUC+vOUlLB3g4oY8PWMfn6l82eZ
         mzgV9v/Tqt4R2hgyi2jCy1dBC4YNQaJB3z5BWOKl/YOrsurwEkFgBhsH74f9OuVrWVc/
         xoOCI7U4/grZlcx7oznIKe4x8Dp7JpNW07ocF0Z6zBklpAW9CpaNPTQ35qu8aqoRRIQR
         n9kk/7Bi7e1KApvzD0Xl3GRqmLmLjgjPVMgOSARKc8HHpxAHSEOrbZRdr7rBP2wy1p+d
         B50Q==
X-Gm-Message-State: AFqh2kq5ZYzs/0DQUdDtji96BXK24vMSuQ+sVqm9gAvrN6djxky5kNi4
        LDX9FeVJ1evNeNdSkIK4t2ddx8hsMiDPDwFbAeFWWOT2uYfr2tLL
X-Google-Smtp-Source: AMrXdXsDvcGedxyD/33A0LQMxwvVwIUdEaFzpsr+CjlkwFCbMbg+j43kC1U/UQ9JMYlFYotaHP154LMW895HBcCQ/8I=
X-Received: by 2002:a2e:b048:0:b0:279:fd34:154b with SMTP id
 d8-20020a2eb048000000b00279fd34154bmr1254672ljl.185.1672448227636; Fri, 30
 Dec 2022 16:57:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c266:0:b0:23b:5e81:46ba with HTTP; Fri, 30 Dec 2022
 16:57:06 -0800 (PST)
In-Reply-To: <000701d91cae$6c8cbbf0$45a633d0$@nexbridge.com>
References: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
 <000701d91cae$6c8cbbf0$45a633d0$@nexbridge.com>
From:   Samuel Wales <samologist@gmail.com>
Date:   Fri, 30 Dec 2022 17:57:06 -0700
Message-ID: <CAJcAo8tY55sUNr=HX9-tVPYDoSOx-xkH0WtZuXuLqs0S3sXu-A@mail.gmail.com>
Subject: Re: is this data corruption?
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

more below.

On 12/30/22, rsbecker@nexbridge.com <rsbecker@nexbridge.com> wrote:
> On December 30, 2022 7:18 PM, Samuel Wales wrote:
>>i am not subscribed, but am of the impression that's ok.  please copy me
>> directly.

...

> I cannot account for your emacs issues, but have a question. Have you don=
e
> any git add operations? Git diff is subject to what specifically is stage=
d.

idk what this means.  there is nothing in the staging area at this
time, if that is relevant.

> So you might be comparing your file with partially staged content that co=
uld
> account for partial diffs. See if diff --cached makes a difference. Also =
try

diff --cached produces nothing.  0 bytes.

> different algorithms, like --patience or --diff-algorithm=3Dhistogram.

i tried both with git 2.20.  they produce different output from
regular git diff.  i looked for the paragraph i mentioned.  in regular
git diff, the problem is the same as i described, with - - +.  in both
patience and histogram, it is -.

it occurs to me that, although unlikely, i might have in principle had
a duplicate copy of those lines in A, and deleted one, and moved the
other, when i created the current version, B. thus, i /think/ both
regular and patience/histogram could be /in principle/ correct on that
one point.  to confirm, i will check rsnapshot using grep -c to count
the matches in all versions of the original files.  unless i report
back, the number will be 1 in all of them, i.e. git diff and magit
status buffer are both producing an incorrect diff.

however, even if this is user error, i.e., i deleted a duplicate and
moved it, the patience/histogram - result seems still incorrect:

 The next few commands work with both=C2=A0grub>=C2=A0and=C2=A0grub rescue>=
.
-***************** REF bigpart is a partition
-biglike and homelike are distracting nonsense i think except
-to describe inferior filesets.  anomalous subset of home
-might be called homelike or so.

 1) The first command you should run invokes the pager, for

you can see here that the context lines are from a different org
entry.  it is intermingling a live - line with a context line that is
not adjacent to it.  that seems corrupt unless i, even more
improbably, moved an entry from inside another entry.

>
> --Randall



>
>


--=20
The Kafka Pandemic

A blog about science, health, human rights, and misopathy:
https://thekafkapandemic.blogspot.com
