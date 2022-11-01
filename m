Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13912C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 15:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiKAPb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiKAPbx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 11:31:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F714D33
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 08:31:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so20669111wrq.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhXBmgGV9GfUsw8KlZcThsGWJ/enAgKo7AUEZqJxb/o=;
        b=jW40TuUoVRIxJjxz0LrwMzQrXprWFgh6Km+sTrEFpnRYFc33Je8j03fAS3OIEQMhGv
         debGF6M7R7CFrrUl97p3dlU07C96lAVVjCqWIBKHMzNUOstnf4WJ9uIE9RVDCPO8OM5U
         Dmw5Bfc17Jq5Dq4XjE36BHwnqKloWydFYriCFri16jlc5KSXzl3mj6CxoGpLGDFkNeD/
         OEU/9xPGHbUKSfooDf6dhEFO44lKNmTNfje92O1IgzyFZo8sFxwYpWp57dZcsruL6+5E
         EozyXjL+1I1Ggjsnup/Nr3ESIgQY3XcjTXxweMDMCSDoHcmlgjLpxMGN2HDRPtTkM8yq
         MyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhXBmgGV9GfUsw8KlZcThsGWJ/enAgKo7AUEZqJxb/o=;
        b=rHFAiiVJS2QTM5Um2MDVAllu2yAB4JQutd8wJJzhwAPVjYFYpELF0XD0cG2wajjrWm
         ppEoTewNJabkFb6QH9Fq2VaVv+7vuFU0Tea3EEWI+Ayy162/3l0iup1lbt1bTpwAWWsi
         Yw2d72uBFHX3w++xec+/sLTHMY6eGU7ZLz0mowYFpYUR5a1qfSL4wIqyO+T8fHiRfZ9C
         2SkeqzSraAG64N5J9mH+ri5mZKJIlsKERpGAb/dFFDFtCxhtUBOSvEmhkUXAekYXt5nB
         WA117nJnmKQpRsx657nfIlNrNfog7o9EoV519a8gD3JU+Yg7IdNmG6mF5IZSHTC/u61v
         NHOg==
X-Gm-Message-State: ACrzQf3wWMkYf9hpMDUoSX8R3/3fqjGrJ9IrPJ0kR23rKTrqTJAtDgpS
        iNeqummmoLbOLvEQMeReEtgwGVpDL6jsawN1ljXyHvG3KP4=
X-Google-Smtp-Source: AMsMyM6moTFcQ2QAoNOK2MMMzlR+3BD3gfKolUzPE/xaXD2g0ndI7ju75dxR4jqGgOHujO6SheXy7yXexKvGXxxxM4Q=
X-Received: by 2002:a5d:40d1:0:b0:236:786d:611e with SMTP id
 b17-20020a5d40d1000000b00236786d611emr12355777wrq.355.1667316711271; Tue, 01
 Nov 2022 08:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
 <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
In-Reply-To: <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
From:   Martin von Zweigbergk <martinvonz@google.com>
Date:   Tue, 1 Nov 2022 08:31:39 -0700
Message-ID: <CAESOdVDmLxj2chGZzJYPjD6bw4XqWjjrPesc2ZCiE8JLPenADw@mail.gmail.com>
Subject: Re: Bug in `git branch --delete main` when on other orphan branch
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2022 at 3:15 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Oct 28, 2022 at 10:46:37PM -0700, Martin von Zweigbergk wrote:
>
> > I did this:
> > git init test
> > cd test
> > echo a > file
> > git add file
> > git commit -m a
> > git checkout --orphan other
> > git branch --delete main
> >
> > The last command fails with:
> > fatal: Couldn't look up commit object for HEAD
> >
> > That's a bug, right? I can of course work around it with `rm
> > .git/refs/heads/main`.
>
> Sort of. This is part of the "is the thing we are deleting merged into
> HEAD" check. It tries to look up the HEAD and calls die() when it can't.
> The more correct thing, I think, would be for it to just return "nope,
> there is no HEAD so nothing is merged into it".

Ah, so that's what it was about. Thanks for looking into it!

> And in the meantime, hopefully you noticed that "-f" is a better
> workaround than manually deleting the refs file. :)

Nope, because I had no idea it was something that could be first.
Also, this was just in a script to reproduce an unrelated (non-Git)
bug, so my hacky workaround was okay :)

Thanks!
