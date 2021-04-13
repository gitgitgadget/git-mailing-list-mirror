Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F3BC43462
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037FA613C1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347880AbhDMScz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhDMScy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 14:32:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA0C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:32:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w10so12566374pgh.5
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HgXO64i67kQjQxHDiLlnbQ20FQ/zNiIPMT2T6ys18QU=;
        b=VSmRsZeCbhH77eAS13DiyJE2SeVMIsDy+2z2qTuTG6YmBZYd7kRCfqaL9gFQkt+l8D
         1vpM455Ia8+LokJOciyeDA8D2L8NOYgfbwcBq9QP36RTl6yW2q2Xz8AncR1qCQ2RjrnE
         guF2hFDQ62h4MqItrgvR2QPEMgktcieDcNY41tAodPXhyElAGKzdj50k/Vnrh71Ai0K3
         St8u9SZNJ04AnglsnprWoA0xFrUEloQ98MADwYfiFpHvb8eLd81+vsqtSNRvsGIJXm4R
         ZuYv9bIvanwpI78ob/1d3pQBAuVVIWqbaKJuedC4zhJ/CbE2Dk4pRiKtSHhgU/yorUWI
         JgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HgXO64i67kQjQxHDiLlnbQ20FQ/zNiIPMT2T6ys18QU=;
        b=UL8tYSzROmDdW6QOtXc9YiupucMDssuVYyqm1ykF6MJGJJ2BUr46Asi2RYdXdDECIE
         D22ixWZsOkFfCLbD0/kb3EuBBZAvd6LSX4vZMEwlWxWfq6+4JrJeJG1EV/c2XpGBi0oL
         DEduPsCX4mrCFCThT205Y47aHRMRexb+p+sDuF/NsHthWV3Y7v93rG+uuBM4GP/ksHQJ
         nU7BKrcYX+EAfft9KUt1BZtCdyq0u1Cqcuj3+4mIn14Ke7m+daWzKSTO7YpJJxnLg4JO
         zuMZSnWGmtSRdK9Nh1lLCcokWnj7MWJd7hQRvsS1MrfZ1HhEt2mbeQg8jkNIOwIGA/wc
         kA0g==
X-Gm-Message-State: AOAM5316EK0PUR6p8rTa7fS7U2u2BxsoeleYPSwuMKwuVXOJgkvQ10gR
        hhwWUA7SEG39Lky3Wl0SZAc2WKS0BZ+ap8vWSc/nv9vWYdk=
X-Google-Smtp-Source: ABdhPJy4jFfdxGlBtvyCPWrbkNPeu9CzdKInDXQoztqpcwDaIPOFIYFK3qakEZ2YdJlfta/YZbcAjmo2tkyKOs6DtE4=
X-Received: by 2002:a63:be0f:: with SMTP id l15mr33526957pgf.39.1618338752248;
 Tue, 13 Apr 2021 11:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210409212724.GE2947267@szeder.dev> <20210411143354.25134-1-martin.agren@gmail.com>
 <xmqqwnt7e82i.fsf@gitster.g>
In-Reply-To: <xmqqwnt7e82i.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Apr 2021 20:32:19 +0200
Message-ID: <CAN0heSr3MQnqMiWiSYpmpx3ZRkyXK6z1VfW_T-EQi31ifs0drA@mail.gmail.com>
Subject: Re: [PATCH] t0091-bugreport.sh: actually verify some content of report
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 12 Apr 2021 at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > In the first test in this script, 'creates a report with content in the
> > right places', we generate a report and pipe it into our helper
> > `check_all_headers_populated()`. The idea of the helper is to find all
> > lines that look like headers ("[Some Header Here]") and to check that
> > the next line is non-empty. This is supposed to catch erroneous outputs
> > such as the following:
...
> > Let's instead grep for some contents that we expect to find in a bug
> > report. We won't verify that they appear in the right order, but at
> > least we end up verifying the contents more than before this commit.
>
> Nicely described.  I agree that the original intent (let alone the
> implementation) is misguided and we should allow an empty section as
> a perfectly normal thing.

> > +test_expect_success 'creates a report with content' '
> >       test_when_finished rm git-bugreport-check-headers.txt &&
> >       git bugreport -s check-headers &&
> > -     check_all_headers_populated <git-bugreport-check-headers.txt
> > +     grep "^Please answer " git-bugreport-check-headers.txt &&
> > +     grep "^\[System Info\]$" git-bugreport-check-headers.txt &&
> > +     grep "^git version:$" git-bugreport-check-headers.txt &&
> > +     grep "^\[Enabled Hooks\]$" git-bugreport-check-headers.txt
> >  '
>
> It is a different matter if it is sufficient to ensure only certain
> selected lines appear in the report, though.  As all the lines lost
> by this fix comes from 238b439d (bugreport: add tool to generate
> debugging info, 2020-04-16), it would be nice to hear from Emily.

Maybe something like

       awk '\''BEGIN { sect=3D"" }
               /^\[.*]$/ { sect=3D$0 }
               /./ { print sect, $0 }'\'' \
           git-bugreport-check-headers.txt >prefixed &&
       grep "^ Thank you for filling out a Git bug report" prefixed &&
       grep "^ Please review the rest of the bug report below" prefixed &&
       grep "^ You can delete any lines you don.t wish to share" prefixed &=
&
       grep "\[System Info\] git version ..." prefixed

Something like that could be used to verify that a line goes into the
right section, as opposed to just seeing that it appears *somewhere*. Or
maybe

  grep -e Thank.you -e Please.review -e You.can.delete -e "^\[" \
       -e git.version git-bugreport-check-headers.txt >actual

then setting up an "expect" and comparing. That would help us verify the
order, including which section things appear in. Slightly less friendly
for comparing loosely, compared to the awk-then-grep above.

Let's see what Emily thinks about the various alternatives. Maybe she can
think of something else.

Martin
