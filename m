Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A624C4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 22:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8CB23106
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 22:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgLEWVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 17:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLEWVg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 17:21:36 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2AC0613CF
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 14:20:55 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u9so7158844lfm.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 14:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQElxADnSK2M1MMFcAWlS5/18rVdqmfqaMbTNlA16tE=;
        b=grhwYwEYOo593QwyeQEr0c/jk5YM249mR8fUFgLWmC7xC2GWomNeyZPbfIvaVDzPSy
         fEvDh1X/pWAWzKw47h0+LMFdbT3YGXiDwtiWvHYUNPvkDOhDVomHNFkB2Id+fo2zW3ta
         nkPwM6txmWuJUoNQpaTGdj9G5WtJg0I/Zy7BYy+B8U0LicGQFaPXPGz78ve5hAWE7lsK
         zWUrSKwRLCuF6rgkT7htRCHPtk5rdVU1Wf5Dpw61cTL/l/+D1hBQ/CMHK953fcLWN8Yw
         hWssdHNYpHT4VDZ4nCIhdh9UwJYLlGRTmBiBvd6iWhJxCLnCVWhTbqGFOKL8KSIge+gb
         Pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQElxADnSK2M1MMFcAWlS5/18rVdqmfqaMbTNlA16tE=;
        b=d4dO5XgwTUz3PMNvZVhtPPWAK2/yzYWhpRM7jztSi6RWoIh50bdBla+366/Elynt53
         zCDTo3l3sVldJYd+TZV2qKTRaG8gHiADwoOeJqzrAh4JHia+uGChRzkt1pEuEX16a9N/
         Q+CLjIL9HCcF7h0Vm21QjmFUQsC0/VULoKbT+UyByHmhLQWIdTaew7p2F1nBgdl83Rm1
         C0de7VYHJiBV57BKpORVybUWJo4ZY3OFpV7QZ/DijzLFZBWn3pQgJkBOQYOn7uRNgMwg
         lzX+G5BjpdG0NysE8YtKRkp4+AfPNlmE+uPlTVAG9FCPYRqTGwSEAxUm8BkU3xTsNijE
         eSmw==
X-Gm-Message-State: AOAM533vPjos5JNCxrSivKWYbz9ymh31RdpXIInAfTMeUanU1cI7zUsK
        az4DpiKhn6JB+5sDcC5w9Fxfj6eePSX0wTfy9BjLfg3JzJo=
X-Google-Smtp-Source: ABdhPJy3coFUyAeVDJ/oPbSZ+oqNkofaR5pNUZF0GK8nAv6NEDlIK/eXyshZJUci4MRWtfTNDEr4gFnVzWz67w1vyoU=
X-Received: by 2002:ac2:53bc:: with SMTP id j28mr5704595lfh.39.1607206854158;
 Sat, 05 Dec 2020 14:20:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <fc03417592c25a111fbf77f9e5b9e5468b9070ae.1604521275.git.matheus.bernardino@usp.br>
 <CAP8UFD398EON0OpfQ0=bgJhO-0r9f1Z7LQRj+rKLp9pEwUnxHA@mail.gmail.com>
In-Reply-To: <CAP8UFD398EON0OpfQ0=bgJhO-0r9f1Z7LQRj+rKLp9pEwUnxHA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 5 Dec 2020 19:20:43 -0300
Message-ID: <CAHd-oW5rFL9i-1GMkyNtLs-w2KDhA8gVsyUsy+2ANvatJDeOEw@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] convert: add [async_]convert_to_working_tree_ca()
 variants
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 8:10 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Separate the attribute gathering from the actual conversion by adding
> > _ca() variants of the conversion functions. These variants receive a
> > precomputed 'struct conv_attrs', not relying, thus, on a index state.
>
> s/a/an/

Good catch, thanks.

> > They will be used in a future patch adding parallel checkout support,
> > for two reasons:
> >
> > - We will already load the conversion attributes in checkout_entry(),
> >   before conversion, to decide whether a path is eligible for parallel
> >   checkout. Therefore, it would be wasteful to load them again later,
> >   for the actual conversion.
> >
> > - The parallel workers will be responsible for reading, converting and
> >   writing blobs to the working tree. They won't have access to the main
> >   process' index state, so they cannot load the attributes. Instead,
> >   they will receive the preloaded ones and call the _ca() variant of
> >   the conversion functions. Furthermore, the attributes machinery is
> >   optimized to handle paths in sequential order, so it's better to leave
> >   it for the main process, anyway.
>
> Well explained.
>
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > [matheus.bernardino: squash, remove one function definition and reword]
>
> <rant++>I'd rather have "Reworked-by: Matheus Tavares
> <matheus.bernardino@usp.br>" or "Improved-by: Matheus Tavares
> <matheus.bernardino@usp.br>" than lines such as the above
> one.</rant++>
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>
> > @@ -1447,7 +1447,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
> >         ident_to_git(dst->buf, dst->len, dst, ca.ident);
> >  }
> >
> > -static int convert_to_working_tree_internal(const struct index_state *istate,
> > +static int convert_to_working_tree_internal(const struct conv_attrs *ca,
>
> It is still internal, but for consistency it might be better to add
> "_ca" to the name of this function too, as we now pass it a "ca"
> instead of an "istate".

Right, will do.
