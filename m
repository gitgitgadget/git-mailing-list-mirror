Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA4CC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6E120720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="E87kg2qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgA2Sgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:36:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42112 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgA2Sgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 13:36:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so636585wrd.9
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ga6hjYkr2PfMyaKPWGzZkP3wv9I7AmPazoQbkSBK9TI=;
        b=E87kg2qq6pyUjDiG03YblvbMFMWJOoW86G8Ga8D/2v0JD4PLU0vIXtdj42uQAmq+kp
         dBHl0z0Q2DEeNDX5fjL37XLG2g9fjnUmGwlQF02506Sn+L9IBiE9+5S5EoQXvq6Jz1qt
         JGMgYWyE90cy5kUSmFyU5zIdu27NSMvVraKcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ga6hjYkr2PfMyaKPWGzZkP3wv9I7AmPazoQbkSBK9TI=;
        b=ajOK09DNdkBp4GFAQEXem4XmMJ/ZEFmsyh/Xkbsvx24AId55Fe3+70ViaaUF0T1+Dg
         /AqVY0j0gGzvYaMuY+foZggSvvj+3PVcJtQe55JVvZLG/MFc0WDndAvMkRLa+olUBFog
         YdE7xM9HL8zGl4LYrHy1l1pWGl0wAs9Nfb6RzKIVRQhYGhPoOwy8EdA4qF0WurqKSxmH
         3o4arleCNkLG+w0iASEwMR8HQCUPg6jJHbdknrkhZ/XEB2Sf9WxVve1qLV3z7dN1+5tp
         MRkA/TkUvfJX6JNuMaVswp8qlZwHzzc5KibJ2D3xd7OReTTe18krW+OrgwpTOk5KRxJK
         TM3g==
X-Gm-Message-State: APjAAAXybOFq7AMFPP2fn3luvtu9gy80wVE81sWXhW+yuyxteg+QG35J
        ZHkekhZUgQhQOMScMKjH4//BAc4dIUVxdktTIXyfWA==
X-Google-Smtp-Source: APXvYqyNIARXfNEXa6NigK2giQb8XaslGBs2b3NEYOIVGKWLj3hRKVeSJLxd7Zmc0Fn9ql+dMBtBH3NcE/BzCcp/feE=
X-Received: by 2002:a5d:5044:: with SMTP id h4mr196320wrt.4.1580323009351;
 Wed, 29 Jan 2020 10:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20200129111246.12196-1-luke@diamand.org> <20200129111246.12196-2-luke@diamand.org>
 <20200129111246.12196-3-luke@diamand.org> <20200129111246.12196-4-luke@diamand.org>
 <20200129111246.12196-5-luke@diamand.org> <CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com>
In-Reply-To: <CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 29 Jan 2020 18:36:38 +0000
Message-ID: <CAE5ih785Nv584RU-xEQSqrcuGiUU2zmjRrJ=ghtFX7_7EuiDnw@mail.gmail.com>
Subject: Re: [PATCHv1 4/6] git-p4: create helper function importRevisions()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 29 Jan 2020 at 15:00, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Jan 29, 2020 at 6:13 AM Luke Diamand <luke@diamand.org> wrote:
> > This makes it easier to try/catch around this block of code to ensure
> > cleanup following p4 failures is handled properly.
> >
> > Signed-off-by: Luke Diamand <luke@diamand.org>
> > ---
> > diff --git a/git-p4.py b/git-p4.py
> > @@ -3555,6 +3555,73 @@ def importHeadRevision(self, revision):
> > +    def importRevisions(self, args, branch_arg_given):
> > +        if len(self.changesFile) > 0:
> > +            output = open(self.changesFile).readlines()
>
> Not a new problem (since this code is merely being relocated), but is
> this leaking the open file? Should there be an accompanying close()
> somewhere?
>
>     f = open(self.changesFile)
>     output = f.readlines()
>     close(f)

with open(self.changesFile) as f:
    output = f.readlines()

I can put something like that in either as a followup, or the next re-roll.


>
> or something.
