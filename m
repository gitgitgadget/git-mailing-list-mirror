Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3BE208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeHHLCh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 07:02:37 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36971 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeHHLCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 07:02:37 -0400
Received: by mail-yw1-f66.google.com with SMTP id w76-v6so989266ywg.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 01:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcpuxzoGBgovYM4Ra9IKULxGUzbkX04B9YvDQL8UyMI=;
        b=UTiqcVrOy+OZ2CqNSa1ncioDSP790eHntiNxRWGZ5jzpXfHQEPbrx9YvJcgmVruZ79
         jP7HgUzqWAfM0TaggxVm9D8m9vKkraR3sEtkhZCKls5QM21nc14wQN9wOmohlQdqZEUw
         yyBdboywEgFGuZ453a3y+ticxEz3NVx/kWaFji3VMstRhw0YS/a9j+iZ8GXZbZpveUG2
         cNW8RV+fiNHP0Y7ck/w/MAaIUjCY2n+Z0/Jz/ygI27p9O9vrMy5BZGHSsw5phiMYKTZ8
         tAyW/gH3GsRET4sk8+bgI02jIg9IlgakHfZCyfP/P0LyJiZ/JxfJq8toGjFTyBpvnfJW
         BwWQ==
X-Gm-Message-State: AOUpUlG0sbaMsO5ra9wnuMSSXNM/r/LKOCwfY0cEDY0Bk5lUxAAttCMK
        AvpAfIkMPKSLcYW4r7JnsHyxdFDv17kHU1Fnru4=
X-Google-Smtp-Source: AA+uWPxVb+ZtzNvr93uVsNvDOIryNiGGem0B3hZqW081bpRQbMub0BD1mQxJguqq9Ryt9LY6Lhr3P+2Z77AJukIcDa8=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr890923ybl.12.1533717835383;
 Wed, 08 Aug 2018 01:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net> <20180807093452.22524-3-phillip.wood@talktalk.net>
 <CAPig+cQkY1_qDu=fdbA0gVPH88B47bM5BpgbYY8ivsj1Y0QHTw@mail.gmail.com> <753b860e-c922-fd70-9d2d-0581976a6f37@talktalk.net>
In-Reply-To: <753b860e-c922-fd70-9d2d-0581976a6f37@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Aug 2018 04:43:43 -0400
Message-ID: <CAPig+cQdH+Xiunej1E6EnA6btFzZJTPo27cFY_UdaFZF7J7t-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 9:54 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 07/08/18 11:23, Eric Sunshine wrote:
> > On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> >> +       if (n > 0 && s[n] != '\'')
> >> +               return 1;
> >
> > To be "technically correct", I think the condition in the 'if'
> > statement should be ">=". It should never happen in practice that the
> > entire content of the file is a single character followed by zero or
> > more newlines, but using the proper condition ">=" would save future
> > readers of this code a "huh?" moment.
>
> I'm not sure it is that simple. If the script consists solely of a
> single quote then we should return 1, if it is a single character that
> is not "'" then it should return 0. Currently it returns 0 in both those
> cases so is technically broken when the script is "'". If it used ">="
> instead then I think it would return 0 when it should return 1 and vice
> versa. As you say this shouldn't happen in practice.

It shouldn't happen in practice, but if a human (power user) edits
this file, we shouldn't discount the possibility. However, I'm not so
concerned about quoting_is_broken() returning a meaningful answer in
this case since we have much bigger problems if we get such a file.
(Indeed, what answer could quoting_is_broken() return which would be
useful or meaningful for such a malformed file?)

What does concern me is that read_env_script() doesn't seem to care
about such a malformed file; it doesn't do any validation at all.
Contrast that with read_author_ident() which is pretty strict about
the content it expects to find in the file. So, it might make sense to
upgrade read_env_script() to do some sort of validation on each line
(though that shouldn't be in this patch, and doesn't even need to be
in this series). For instance, it could check that each line looks
something like what would be matched by this regex: /[A-Z0-9_]+='.+'/

(And, no, I'm not saying that regex should be used for validation; I'm
just using it as an example.)

As for '>' vs. '>=', it caused more than a slight hiccup when I was
scanning the code, and I worry that future readers could be similarly
impacted.
