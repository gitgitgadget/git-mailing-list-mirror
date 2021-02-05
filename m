Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803AC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AB64FEE
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhBEW2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:28:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:38107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhBEOVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612540744;
        bh=Fqq8g4Hi6myYtUzy0ZttL12bCsmbbBcOrfVK37PO3iE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E7zNGKU5cM+Qf+oLskh9+XcYOahxXj8uQwYaF7L3EmHi/Y5UI/Dpi/GW9sk0CI2FZ
         qrLRbFvTb2X4aMSQyRHJQMi/JLwIc6gRRp/nOBxd88rSCraE6NvbJR0lm/m21OS6wR
         UgAZzeo9utTJUzloAQfSJh4gdfVmDTmPiVpf6uiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1lKJxG33gt-00O3YK; Fri, 05
 Feb 2021 15:13:21 +0100
Date:   Fri, 5 Feb 2021 15:13:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/6] range-diff: combine all options in a single data
 structure
In-Reply-To: <CAPig+cSNCVT8h-wFBGvDWB4u0OUQM-Q-1DwuLepnjTdwEpk_4A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102051513050.54@tvgsbejvaqbjf.bet>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com> <b620be042eb31c0e771230434951d983f4173ecf.1612469275.git.gitgitgadget@gmail.com> <CAPig+cSNCVT8h-wFBGvDWB4u0OUQM-Q-1DwuLepnjTdwEpk_4A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9x8u2AkkP7PoBAn8CYrJZZJX+3JKDMk+DHWhWyWFhXmA8QwSzwS
 jK9qd9cZdi9wevXnMm0/GHk0djSgvgLaNUFL74Avy6zyPsJXKRhOnO6OetvFsdJKev95019
 U4gS7a7Ubh4kxommQAIrUzlciWzj9V8ZoWC+4WVKnyv5rxRKUf6yaUa2ZBtHvjHkokKwNfm
 pnLuY/slGBPSs9aAIDpYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tvd1xqhd4ho=:9ooRMesLDGVLs+ygS1FuDe
 sMRPpt7mzKcUX7Yr84NP021/vjvwSfu8oK8HOxO7e0T9xFlNxchkb7wOxLJDm6KjBwMfktj70
 6rQFWwOhiojmD+Wkh2l2nhcT/hWv5I31xCZ6R/I2h8mguCpiloaoucZQqRgFKit/NfPnlzWq2
 H83v7gsMOpv5vW3DVui7g0jFhAvj/zvWKhYqVp1AT6ooi/8tGkSk+CY7AJuI4mrFduSxfxhX0
 arKIa7hQQBkzu6hAvChxLBNCJuMhHRPtyrsdYXuPCop3poQU+3Uolj4b1dEmhtmkFaqL9DAgj
 OFH/qkx6hOW8fI1BywjquVBdwbG5rFdJVpQW9M9ekN5+cAn07qwVEHwlxtL0GhdQUTHBl8bS1
 qCKQaGXxfhaCgpMZSNIhUnKCtEtMmKBPMF6N9IsElMfUuZFw1K1vvAR5kioLGVgmbp45gsfHb
 W29iwQaa4Qm9scBjEvMDBGys+G9aPDRI7Le7+TEbFVPpnKGbJVh+BCiol0BGs6n+04hYNp+NM
 IsDV8MnziyE4nimX6OZJHvFG7NAuRd3W3VYw0IB6TZkPCYGOltru2E65RmmcQdzZ9nWNddg6X
 5zfhtQkyh0P0lFON/puDvw/3QYU+ZrxCZcwYTriJ/NlXKGTlHnXJ56S3O2Dsjxo5uOGkV1a+m
 dg2smtPLbl9jxcfzmzSEv/pgvlEjvO1QttNxAmjmin/JUPIP3b0/9wn44e3KDNgiGSF7cIBu2
 qlUwB6QDiH6RnSdb2BR5FuzD3hGmbOH+8XmJzbdJvkuobfZy+TpKd1Sfzs9dvFjmHqOyUBoRL
 qW30FEywZ0j1KLZM95u4qQSummC0SxOC2lpfV1Hnn8ZMeNE03G8+wt/6CaH7N2e0XzANO84eG
 8ORxn2h6+BC3ZFkb5t0VUGZuAnZY1hvIlIKSMDavA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 4 Feb 2021, Eric Sunshine wrote:

> On Thu, Feb 4, 2021 at 3:24 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This will make it easier to implement the `--left-only` and
> > `--right-only` options.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/range-diff.h b/range-diff.h
> > @@ -6,15 +6,20 @@
> > +struct range_diff_options {
> > +       int creation_factor;
> > +       unsigned dual_color:1;
> > +       const struct diff_options *diffopt;
> > +       const struct strvec *other_arg;
> > +};
> > +
> >  /*
> >   * Compare series of commits in RANGE1 and RANGE2, and emit to the
> >   * standard output.  NULL can be passed to DIFFOPT to use the built-i=
n
> >   * default.
> >   */
> >  int show_range_diff(const char *range1, const char *range2,
> > -                   int creation_factor, int dual_color,
> > -                   const struct diff_options *diffopt,
> > -                   const struct strvec *other_arg);
> > +                   struct range_diff_options *opts);
>
> The function comment's mention of DIFFOPT becomes outdated with this
> change. Perhaps update it to say `opts.diffopt` or something.

I actually moved the comment to the new `struct`.

Thanks,
Dscho
