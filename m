Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0040C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 09:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46022146E
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 09:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLqwgQHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLBJup (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:50:45 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38709 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfLBJuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 04:50:44 -0500
Received: by mail-vs1-f68.google.com with SMTP id y195so10050426vsy.5;
        Mon, 02 Dec 2019 01:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ipg1WLEffdYnfTvQd1IRhgK8FSlTc8OcoNS/WRcxcW0=;
        b=WLqwgQHEsnBfqsvS0rIxr5QM7OYHkYfM8LrhsB/tsD15MrIlhFGlC20BtP6VXNRCg2
         +xDFCxzkcTzb765X57bQyZi9ZnDRYTXvpfo0Bcz9bOnwq0NLo9RYRW179t9GP4bxrjLz
         hMxOJkA9Vj2y9ofEct4i+lW4GyT3Hlgm7pUKeiqmud4cHY7sOLc41bBUPisZ1IaP8JyC
         8Aqvqg4kfjok17Ov7r3V+cLZsKIjpWFRKtPFQ/lNJ7o2NDg+hhbFr4WcLwFZUF7GVYfs
         QPZOigvEaqvwRoF4jMZKZouMnW/+DzWK6kdMml8cMovOy1fxJ4hEsXtRabToVBlA2Rbq
         u+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ipg1WLEffdYnfTvQd1IRhgK8FSlTc8OcoNS/WRcxcW0=;
        b=sJiG5Grih9fv+PaKT2zEqaZRw/TEl2tA98sfDGXJsEpb6eNrVfS63O4R5JpnpiIvf9
         4e+dsQN3ifOhXJ6kaUU4n3peAiiZuHyLJa3UNVwD1XFjMTYPdf2wL+7z6iJ7pNdsM8MP
         6tMVkjx44GaZLJlyMhFrCfE7uqC8dseuEVGZB4nqr8LRrSgXQVCmLaZsJRVcmhvXT0td
         hfR1qJ6BrDlJAcI+TUgdxhziDBSpdoVaOri0KAIQPbcdaqrFg/XE6bMBXWxqLS3J5kfk
         MNFxJTK0eWwwzSWFCfqvBWVeuXLr20jhoWkvLqdqSajTfebSWvr500QMC/urhd1pMxGy
         Ggmg==
X-Gm-Message-State: APjAAAXoJXiQ5Om85v0vFcfMsYYzVEcHR2Oe1gj1joe1LNvJSjKA/Lds
        CEqpt0FkTrmDqRlZ6ST5ddR57Yfm7GrNId+gFwA=
X-Google-Smtp-Source: APXvYqyiVZmMk0LsdmPaDP3UNQX15ikmg1n2j98bbuACw1hpO77IA0X0pLqtYDaZTw+dWTqrH32pe3kfaJ495a89q7I=
X-Received: by 2002:a05:6102:5c7:: with SMTP id v7mr37986140vsf.85.1575280243731;
 Mon, 02 Dec 2019 01:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20191130180301.5c39d8a4@lwn.net> <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
 <20191130184512.23c6faaa@lwn.net> <xmqqblss1rjp.fsf@gitster-ct.c.googlers.com>
 <CAHk-=wj9P8ukXOuTUnpkPNwc8B683Z0Za=-WxpLygMbjEtNxgA@mail.gmail.com> <xmqq7e3g12xo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e3g12xo.fsf@gitster-ct.c.googlers.com>
From:   Amit Choudhary <amitchoudhary2305@gmail.com>
Date:   Mon, 2 Dec 2019 15:20:08 +0530
Message-ID: <CAFzckaEQo6CQM9LukikgbtUKZX=eajG+OFNhnDJ_EY7M1V4XKA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove stray asterisks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Git List Mailing <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it possible that git complains about everything that has ^M in it
and rejects it (that is without trying to fix it, etc.)

Regards,
Amit

On Sun, Dec 1, 2019 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Sat, Nov 30, 2019 at 10:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> OK, so it appears that the tool is working as documented.
> >
> > Well, yes and no.
> >
> > I think it's a mistake that --no-keep-cr (which is the default) only
> > acts on the outer envelope.
> >
> > Now, *originally* the outer envelope was all that existed so it makes
> > sense in a historical context of "CR removal happens when splitting
> > emails in an mbox". And that's the behavior we have.
>
> Hmph, first of all, the one I was referring to as "documented" was
> about --ignore-whitespace, and not --no-keep-cr.
>
> And I am not as sure as you seem to be about "--no-keep-cr" either.
>
> What was the reason why "--no-keep-cr" was invented and made
> default?  Wasn't it because RFC says that each line of plaintext
> transfer of an e-mail is terminated with CRLF?  It would mean that,
> whether the payload originally had CRLF terminated or LF terminated,
> we would not be able to tell---the CR may have been there from the
> beginning, or it could have been added in transit.  And because we
> (the projects Git was originally designed to serve well) wanted our
> patches with LF terminated lines most of the time, it made sense to
> strip CR from CRLF (i.e. assuming that it would be rare that the
> sender wants to transmit CRLF terminated lines).
>
> If the contents were base64 protected from getting munged during
> transit, we _know_ CRLF in the payload after we decode MIME is what
> the sender _meant_ to give us, no?  Which leads me to say ...
>
> >
> > But then git learnt to do MIME decoding and extracting things from
> > base64 etc, and the CR removal wasn't updated to that change.
>
> ... I do not think it was a wrong decision (well, I do not think we
> made the conscious decision to do so, though) not to do that update.
>
> I dunno.
>
