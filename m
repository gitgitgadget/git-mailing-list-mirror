Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2EED20248
	for <e@80x24.org>; Tue, 12 Mar 2019 10:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfCLK2m (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 06:28:42 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:53350 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLK2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 06:28:42 -0400
Received: by mail-it1-f172.google.com with SMTP id x189so3513390itd.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BVt91jXZvaP6yDV99ft8X2OLn8eZzgGnXbObU7e9LlA=;
        b=sUAzG+JAOpdvCFUyrZsNJoe/VosqqQVcU99slMvfsB35Xee6fXI+6ZExg/y6sPGy90
         gi6qgpmWkYBv/Xj24pNH1qHdVlU9uxpPjHjDOQ5C1satuAO74Y3a3PPoO32lNUTV3Sgk
         gb++360HEM4jfiAJSLxZSxhLZogToI9mtXc6HB86EiHWFldO11FkyDHWNpYszFFEg3t2
         BesEK4ON2KULK3fs0qdt1EzPdiYVnOUb360Aoci9lEKBDTXPNBZ4IARHDKEjm3nKY9Ff
         JS2hTQRxreSoOtruymDYm7BXmvqMENPNzybYwLKlKBSgv318MadQgKwslKQWQ0uFgzVW
         Gpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVt91jXZvaP6yDV99ft8X2OLn8eZzgGnXbObU7e9LlA=;
        b=HEpvTuIjnwMKxMsvphiBhclgdifOs0IS4Bcl22Vm2/v8Qjly2zXcFZ+BbMtCzcHcIa
         8I/5AOwq06hIxhox0/GYbT0t7+Jd6U/iYNx2xR1GLR8bENhe2CMKAObB7hyYhLwh9+lM
         RLZDT8X6EebgHFOwaW9cRLCubZF6olMNQQGU8gVpPD0LShrl5pSe1RkcD3Vjk7Iyx/iT
         swouaxtjJCHchjrcWMgFlvUuE7f8UI5Dfvtis9YFr5XvnToHjTuZdkqqFH+x1U+Hxi1r
         ASpAsbtcXvjDTaW3oTvp5xyr2dlXUCFIuaujucLgAEFBZETVD/TE3fp+sB0vRyilTA00
         4+3g==
X-Gm-Message-State: APjAAAWdhMZXJfPYx1HkPGZG5UXnMhmdJtbpgb3w5pebjag38o2v+5G7
        vpD/sl1twYZMjsoxTXR03K588jnHRhSWHi+GrU9vTg==
X-Google-Smtp-Source: APXvYqwYm5UmBZf5aK8LNdtuewj68Aj+WNezMv5zuBzF+eaJj1QAIYKcWMgqY8NHW7hsY4CvRq/axfjmFRSnzJsif80=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr1405144ita.10.1552386521338;
 Tue, 12 Mar 2019 03:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <87k1h55bx0.fsf@sergiodj.net>
In-Reply-To: <87k1h55bx0.fsf@sergiodj.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Mar 2019 17:28:15 +0700
Message-ID: <CACsJy8ANLkz=3cj1dAuHdUCkrgQzos=90EEG0n901o3QAp3PUQ@mail.gmail.com>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
To:     Sergio Durigan Junior <sergiodj@sergiodj.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 5:18 AM Sergio Durigan Junior
<sergiodj@sergiodj.net> wrote:
> This works without problems most of the time (well, usually there are
> conflicts and all, but that's a burden I have to carry).  However,
> sometimes I notice that git fails with:
>
>   # git rebase origin/master
>   ...
>   Applying: commitX
>   Applying: commitY
>   Applying: commitZ
>   fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exists.
>
> The first thing I did was to check whether the index.lock file existed,
> but it doesn't.

Is the output this clean? What I'm looking for is signs of automatic
garbage collection kicking in the middle of the rebase. Something like
"Auto packing the repository blah blah for optimum performance".
-- 
Duy
