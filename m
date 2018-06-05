Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9761F403
	for <e@80x24.org>; Tue,  5 Jun 2018 19:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeFETl0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:41:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46690 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeFETlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:41:25 -0400
Received: by mail-yw0-f193.google.com with SMTP id v197-v6so1121310ywc.13
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 12:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OU2XJiaBzvVRM69uTTeKGsELolpufcQz5GJVoyRpIS8=;
        b=meODIWXqUnpRT8LwIiOoDqjGKBogrL/a6g8Rjd4B80nVpbDpGL09hhy7jsEB9UNNwY
         fkXg2cgdaiavyfIFPTeX2Bu3WU/lFcTcIRqUsq6PrD3y4Pm2wkN+tKqltO785Gdwa3lH
         kutMKWvwclH3/+NFO01wpvC7jbeMKPp91y2gDzdJnV9ATraLWyXJJEMw82xJ3JU+hifc
         UPOu8AEfNYK4buqJd4Po+LxnKXfLFkCk+bDxC5NA/jBO+055vcZIVce7gZIVHErZR0by
         js1EZK9i4uLaZV7uM4OGCSNXH/HpCNt+32EZqd7e+Ljx323rR1jsf/4Hd6gjk+OEH6b5
         T2mA==
X-Gm-Message-State: APt69E1CXjOeRLzS9qNyVXSOFlV6q8c3b+VV7XA8YCgpzjxJY9KLSWJA
        b8eJtc0KZUHmyovvLolQm64t1cJwktvPCAkTR7Y=
X-Google-Smtp-Source: ADUXVKL5sWTUzkwfMZPnqCJIlJcJgRbCi4W/GEHwOXPpfqbKUk8t7M3OE5C7hLJ9aaRVRbYmqjBfK5Ng0K4/VdY9EBo=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr933995ywd.131.1528227684365;
 Tue, 05 Jun 2018 12:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180605091350.14476-1-luke@diamand.org> <20180605091350.14476-2-luke@diamand.org>
 <CAPig+cQTTY8wc4d=4jV8GxHDOjF7xk1vjA62JS6s4Zr0uXiegg@mail.gmail.com> <CAE5ih7-1StB8RNrobO+hpG2QOSdoscUNfVP9+muZV0_b+m+XSw@mail.gmail.com>
In-Reply-To: <CAE5ih7-1StB8RNrobO+hpG2QOSdoscUNfVP9+muZV0_b+m+XSw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jun 2018 15:41:12 -0400
Message-ID: <CAPig+cTSrzmOtYPwPWLpGfDa5tt0SV6Aq8SmhYTTicK0ikst7Q@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] git-p4: raise exceptions from p4CmdList based on
 error from p4 server
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        merlorom@yahoo.fr, Miguel Torroja <miguel.torroja@gmail.com>,
        vin ku <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>, lex@lexspoon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 6:56 AM Luke Diamand <luke@diamand.org> wrote:
> On 5 June 2018 at 10:54, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Tue, Jun 5, 2018 at 5:14 AM Luke Diamand <luke@diamand.org> wrote:
> >> +                    m = re.search('Too many rows scanned \(over (\d+)\)', data)
> >> +                    if not m:
> >> +                        m = re.search('Request too large \(over (\d+)\)', data)
> >
> > Does 'p4' localize these error messages?
>
> That's a good question.
>
> It turns out that Perforce open-sourced the P4 client in 2014 (I only
> recently found this out) so we can actually look at the code now!
>
> Here's the code:
>
>     // ErrorId graveyard: retired/deprecated ErrorIds.

Hmm, the "too many rows" error you're seeing is retired/deprecated(?).

>     ErrorId MsgDb::MaxResults              = { ErrorOf( ES_DB, 32,
> E_FAILED, EV_ADMIN, 1 ), "Request too large (over %maxResults%); see
> 'p4 help maxresults'." } ;//NOTRANS
>     ErrorId MsgDb::MaxScanRows             = { ErrorOf( ES_DB, 61,
> E_FAILED, EV_ADMIN, 1 ), "Too many rows scanned (over %maxScanRows%);
> see 'p4 help maxscanrows'." } ;//NOTRANS
>
> I don't think there's actually a way to make it return any language
> other than English though. [...]
> So I think probably the language is always English.

The "NOTRANS" annotation on the error messages is reassuring.
