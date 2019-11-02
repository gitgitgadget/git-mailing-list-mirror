Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313451F454
	for <e@80x24.org>; Sat,  2 Nov 2019 06:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKBGLs (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 02:11:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBGLs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 02:11:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so11640907wrq.5
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 23:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3gtxtjW/Vjia1LsZ3iOpoxukzFeWCavSPCsZ+1SztA=;
        b=bDkaW0gS+tbgT9epolQ7XBsuyQEnl3MERKu5HVCPvXJya7M9jfNlyDUYIWhuwLjOo+
         WwJCHWnp7Y0hDw4ByzVPy2gn3wmNeEVi72C9UH4wMYUhDh/hpGNwMSOS9oG25IOlFDCw
         QXFUqbW4QpU9rp8FrhnWGixx31tSx1jzHakykxMnjm4Pj5bQyug/tgaYHDH+BBlhmfUt
         xS0fsfj4jeuaUimU2Exrjl60gS5N+WmfJrsQ6xsBsoKL0XGNbqDhR3jIdyWdV3Z+c/jA
         n+ujfRcCnwK+HUdXXz1uiLpNnhQxwaqpx/UETehGORrNKANjYIs4N7BzRalLmeFxooHp
         /BMQ==
X-Gm-Message-State: APjAAAWWYwUQ1cgY5QgQhk7eZnEbQ6mauMM95PWz/TuiFRTFo0vDUAF0
        SxWAlFkDamb1s+FcayyVatjtoVijNTRGx9PkD7A=
X-Google-Smtp-Source: APXvYqxOoJFuL7UmM1q91g/GG1gqa2v424KCYaNSG0ThK25EWF2PHkgrn7SSD6EzopnT3nmUv04jpokgbBFIW9rwy6g=
X-Received: by 2002:adf:f010:: with SMTP id j16mr14296553wro.317.1572675106271;
 Fri, 01 Nov 2019 23:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191101203830.231676-1-jonathantanmy@google.com>
 <20191101220537.GA249573@google.com> <xmqqv9s23jr5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9s23jr5.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 2 Nov 2019 02:11:35 -0400
Message-ID: <CAPig+cTqKe7Xz4tZrA+sC7peVdjaVS1wQfJ4fLVVUzVzjHdrmw@mail.gmail.com>
Subject: Re: [PATCH] fetch: remove fetch_if_missing=0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 2, 2019 at 1:55 AM Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > nit: can avoid a subshell:
> >
> >       test_seq 1 100 | sed -e 's/^/line /' >big-blob.txt
>
> Yeah, but it costs process start-up and "sed" that may be rather
> heavyweight.  At least
>
>         for i in $(test_seq ...)
>         do
>                 echo line $i
>         done >big-blob.txt
>
> would save repeated opening and closing the file, I'd think.

More bikeshedding:

    printf "line %d\n" $(test_seq 1 100) >big-blob.txt

is reasonably concise, perhaps easier to grok than the one-liner
incorporating 'sed', and shouldn't run afoul of command-line length
limitation.
