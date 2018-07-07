Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B66D1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 19:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754357AbeGGT6p (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 15:58:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45020 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754300AbeGGT6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 15:58:44 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so13748972ioh.11
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZhdSAZcW5goUWflPvxlfOWKRNRoMKrVey0u2JL+qbQ=;
        b=K2VYvD0U8gardqRGZdQs6ccMF/Y+HtScp79W16QLLq6Kn5vzJDLWWYq5E9fiT5qHPa
         Nc8M3Nf+8mdGP77kU+l4BeVPe5akRNGuPGhARxvohEurtvNFJZulAD12V/r1c0cAYgNl
         /TmdIEPIr+7vIo8U3ddHLFKr4rwwLn6yDSnO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZhdSAZcW5goUWflPvxlfOWKRNRoMKrVey0u2JL+qbQ=;
        b=uQPXIX9Ybc2saZ7L6lSIkxW4/qJeRBKYwX3Kub4Ts5SqbnqpRnsMzbp7sBs8fkuW3j
         D3B4hqvGKx2omFPfj3Bz6gUdeJ6lxZbf7B5ww9vTgQfhMX/tdE0dgbF3ksjT4A9R+BxV
         5kq3gkj7p80AQd/Nepu1mz5vAX5/gMHeKiLCC7RnjreL1P/ZfE4NgTC+hQmFroWHbpUe
         PKyR/WeMVZvmxRtQC6oX9G6xeQNrfFqXrRzr9DrxHoe5VEYcPk7bbGQzm4yWrdUJRba6
         HAlgdP2NXw9S2hrwQnXfWX8zdJB4pCVC6YL6GIFBsjeOFO3x0L4uLVQTfY7wrHcu3GSF
         U3Lw==
X-Gm-Message-State: APt69E1I2NVdebm3BiTRaoB04hh120lbj9SanrtxYN3CVvjj5brZ3nUX
        KOCGod+jv7e5j2ac7KNlifgFocVfrhdTIpl3NxL2QQ==
X-Google-Smtp-Source: AAOMgpchZxSh5G5E3Q14Bk18kROpu1Fzl6aOOhTjfQnSivMCukt15V4yxJ3UHPcR13LGAVDOpEXN5v8czkYBiKviVYE=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr13241488iov.203.1530993523960;
 Sat, 07 Jul 2018 12:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
In-Reply-To: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Jul 2018 12:58:32 -0700
Message-ID: <CA+55aFyh4=Udhfn+L__9MiCbjqSLTWBGaAvDOPg5EJWs-DjjPQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Add 'human' date format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 7, 2018 at 12:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> to me, but with "--date=human", right now it just says
>
>     Date:   12:21

Side note: this is probably my least favorite of the formats.

I'm playing with making all "today" dates just use the relative
format, and then the "a couple of days ago" dates would then have the

>     Date:   Fri 19:45

format.

But since it's _explicitly_ about a "human legible" format, I think
the format could be a bit fluid, and things like that might be tweaked
later. Anybody who would script this would be crazy.

I'm more looking for "no, that's just stupid" comments, or "no, you're
not the only one who has wanted this" kinds of replies.

                  Linus
