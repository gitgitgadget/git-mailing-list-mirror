Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1481F453
	for <e@80x24.org>; Thu, 18 Oct 2018 12:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeJRUYx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 16:24:53 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45029 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJRUYx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 16:24:53 -0400
Received: by mail-oi1-f174.google.com with SMTP id u74-v6so23800839oia.11
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 05:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUELdlOoKtZjDh6LknklKBKYuqkdM4G+97RcG9UiQ2I=;
        b=WTpxUfT7ApH+hivfaLRP8Od1S+hHarojvHJ+GRgg64eeXUnpPBijJJ/KcGpMiq5YLt
         CxcoCVDKIibJ9+lfsJe/HxarLUf25Pw9i4Py4ijIkWLTCIHFtI+wmB7sVJGyAQ/iMWqg
         BJ+EkFg/wivY2qt8xDbJ/U3GI9yEg06WGe3IiP4217R3JOszcAY6pWaoFutfRKnPYG7e
         O1K+dOWxZY6PJ+slwGz+O/9hKi5YYhK1lduj9bIHuflG7pRkssiv3Wwnzz1+gj6DwTtO
         grZx9AnoNtvheFHnE6BRwsXoKnkHCZe7MgzwjpPjIkA5dJgXDz1GT8Hbr+xcXaJ2WlMg
         VVZA==
X-Gm-Message-State: ABuFfoiImjpXM3bUem3ktJWPhpZz86Ow3xGEh2HREQSXC7OmMaSvyG+l
        fhRth8hb6ZoSCppO81Q6jSF5BERHtRcuNTmvZnBtIg==
X-Google-Smtp-Source: ACcGV63mWl3xw7d+FLbavwEkjmUQHaKwpK3h+uRXdfBT649AXbWLTNUth0uVP/D6P0Pq4FqO++RUDMHn12JcHPRn5hY=
X-Received: by 2002:aca:50c1:: with SMTP id e184-v6mr15380565oib.264.1539865446445;
 Thu, 18 Oct 2018 05:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181016212438.30176-1-agruenba@redhat.com> <20181017091215.GA2052@sigill.intra.peff.net>
 <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
 <20181017181350.GB28326@sigill.intra.peff.net> <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Oct 2018 14:23:54 +0200
Message-ID: <CAHc6FU4n0uiK64G_srb-B0b+Ut39fxMyyjZfYM_EogOtGXZzUQ@mail.gmail.com>
Subject: Re: [RFC] revision: Add --sticky-default option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     peff@peff.net, git@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Oct 2018 at 05:23, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
> > I'd probably call it something verbose and boring like
> > --use-default-with-uninteresting or --default-on-negative.
> > I dunno.
>
> These two names are improvement, but there needs a hint that the
> change we are interested in is to use default even when revs are
> given as long as ALL of them are negative ones.  Which in turn means
> there is NO positive ones given.
>
> So perhaps "--use-default-without-any-positive".
>
> Having said that, I have to wonder how serious a breakage we are
> going to cause to established users and scripts if we made this
> change without any explicit option.  After all, it would be rather
> obvious that people will get a history with some commits (or none at
> all) when they were expecting no output that the "default behaviour"
> has changed.  I also wonder how would scripts take advantage of the
> current "defeat --default as soon as we see any rev, even a negative
> one"---in short, I am not sure if the theoretical regression this
> new "option" is trying to avoid is worth avoiding in the first
> place.
>
> Is there a way to say "usually this command has built-in --default=HEAD
> behaviour, but I am declining that" already, i.e.
>
>     $ git log --no-default $REVS
>
> that will result in an empty set if we accept the change proposed
> here but make it unconditional?  If so "This and future versions of
> Git will honor the --default even when there are other revisions
> given on the command line, as long as they are ALL negative ones.
> This is a backward incompatibile change, but you can update your
> scripts with '--no-default' if you do not like the new behaviour" in
> the release notes may be a viable alternative way forward.

That would certainly work for me.

Andreas

> If there is no such way in the released versions of Git, then that
> would not work, and a strict opt-in like the approach taken by the
> proposed patch would become necessary.
