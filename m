Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B0C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D23864E9A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhBBPch (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhBBPai (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 10:30:38 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6749BC0613D6
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 07:29:57 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id k142so8696435oib.7
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsjYiEfDmTNeuosEB2NyJ5k54FXc28GaCYwPE1KueVI=;
        b=X+wU3LSMq3jNngDbDmh856sZGeNtnbBvO6JTzjgGk9Ci+qCS/asIWoas4KbfSy7Jsv
         eMtAVGdli25tlmkwt+KzySqnACKrRZWUAM46kCtv6ixdTfSm365RFxbbnIkg0QuDjqVy
         YDTVdidIEu9ymzeMYNxoGYEA0rWBPRTabcC0Qvcgkw+gOu6wvVFoo7XqasdZ8qjv4Pfe
         tKIJyWjRGjt6O9FMrXX/fXck+9Y4KJTKKNTKnA3RWiJvcFRA4I80zUsh1NLZ6XbuqHFC
         KUqJi6mYhHdAqg4bJ2/nV9coSxgDWsKL++yyRwNL0XJy8O8Sgc0lHv/9BjXj9oJ6AC77
         tZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsjYiEfDmTNeuosEB2NyJ5k54FXc28GaCYwPE1KueVI=;
        b=boWxh2ax38/PhlW42vDGE1ON8souDC5bHYhCCO7kXxd9NhuLN0Mg4oUiJcBtU0hAQa
         4gBRgdgl+IniWjhqVokwPt9WxdZAf2wVCONLSyNCTHcv8xROPI0FYYOosrCGFHaTfXUp
         sWhA6EEog+tc957AlTzqwN2HutAuzOEei4rskhQfBAgwvBus/q40DALOtRz97Pv8Q7AK
         gIOX6QDCzpGtg5vAU+RP/8NwjONE8t3rLVPuotYcwrpsp/wk4APQTd2FoZd61tBwlWWu
         cTgAfZYRhRWg0VP7r5USzIKPc+bSpI+MAtT637Kyh/e0CVHDAMIl4bhed9LYp3+Aq9U8
         DVag==
X-Gm-Message-State: AOAM532I+QwnZigpF19jPL9B0Ngv0+h4zbKPN3m2T+aCWpL5oxesCp/h
        uZzioYnNH/KKBvip750vLinyDN21mouGp/uMdPtPq4cMP8o=
X-Google-Smtp-Source: ABdhPJygEa/ltHbwSmhkyIiEy5fTI9CfyO1j8jEEFZt7tC21lwDMgavEVQM+rEI49Wd4oF9Ts2Mpq2zBekILbB5BU7o=
X-Received: by 2002:aca:db03:: with SMTP id s3mr3169492oig.48.1612279796845;
 Tue, 02 Feb 2021 07:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-9-charvi077@gmail.com> <CAPig+cTyK_OPixAnJQc_cO4vHzA++hfyfGEA7uZBK3ukCWD0PA@mail.gmail.com>
In-Reply-To: <CAPig+cTyK_OPixAnJQc_cO4vHzA++hfyfGEA7uZBK3ukCWD0PA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 2 Feb 2021 20:59:45 +0530
Message-ID: <CAPSFM5cRcVYfNSnm_-FyRRJc4mnh-t2BaSbhd7nE3uz-zv=+vQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] rebase -i: teach --autosquash to work with amend!
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Feb 2021 at 08:50, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jan 29, 2021 at 1:25 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > If the commit subject starts with "amend!" then rearrange it like a
> > "fixup!" commit and replace `pick` command with `fixup -C` command,
> > which is used to fixup up the content if any and replaces the original
> > commit message with amend! commit's message.
> >
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> >  sequencer.c                     | 23 ++++++++++++++++-------
> >  t/t3437-rebase-fixup-options.sh | 12 ++++++++++++
> >  2 files changed, 28 insertions(+), 7 deletions(-)
>
> Is this new behavior of recognizing "amend!" in the subject documented
> anywhere? I checked the documentation patch [9/9] but didn't see any
> mention of it.
>

No this patch series does not include that but included in the patch series of
amend! commit implementation that is not sent to the mailing list yet.
(Apology for the confusion)

> > diff --git a/sequencer.c b/sequencer.c
> > @@ -5662,6 +5662,12 @@ static int subject2item_cmp(const void *fndata,
> > +static inline int skip_fixup_amend_squash(const char *subject, const char **p) {
> > +       return skip_prefix(subject, "fixup! ", p) ||
> > +              skip_prefix(subject, "amend! ", p) ||
> > +              skip_prefix(subject, "squash! ", p);
> > +}
>
> While the function name skip_fixup_amend_squash() may be accurate, it
> won't scale well. What happens when additional fixup-like prefixes are
> added in the future? Does the function name get extended to name them,
> as well? How about choosing a more generic, yet still meaningful,
> function name which doesn't suffer from this scaling problem. Perhaps
> skip_fixupish() or fix_squashlike() or something.
>

I agree completely, and will change the function name  to skip_fixupish().

> Also, making this function `inline` seems like a case of premature optimization.

Okay, will remove `inline`.

Thanks and Regards,
Charvi
