Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5BAC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 16:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6EE6522F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCHQ55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 11:57:57 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:42164 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCHQ5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 11:57:31 -0500
Received: by mail-ej1-f51.google.com with SMTP id c10so21721252ejx.9
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 08:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEHh0a2emm5sSiG0Y6FOnPBGSUXU1TVJdTlLOAT6Zko=;
        b=TwXm18Q5Hl4gdGVmh5gzeC2MJmMcg5HnOkqIFYbfDoaHHNCNiB2veZbiZzmW0Vz3RG
         +8ooGfgUOoR9fyb2z2VDXK7dPxq8g1jWmPjjP0iP1XVHkGKR5bCqM6rwuRK+ECVL0Q5W
         iWxk9jilO2mgzXOb2WAJd0RQhEVQtuxZs+pR/mmx6Y6OXk5LoyJSuKf4u9pmmE4HJ/iJ
         hC+HX6DIUHrqq4abpD1R8XZ/T0wOkNB8sCgY0TJRUwSJEla8WXl0JYdKHflx2kOH2BLC
         Yog4k3el1SwhxQos5A5tCZmQaRjjVwbZ+TfPC8trtwFQlEW8r85B9CtPHQaCZU3ObLou
         eYDQ==
X-Gm-Message-State: AOAM530gPRVsdbazxBDGkG2cAuSKGitlROuGcEjP3y9TCS7YTmwpZ+js
        eUqPtb+1Fsw71Yx8kJwwFBMNBTRFT2uLnEFAfG0=
X-Google-Smtp-Source: ABdhPJwBvLnUzBkpyJc2eKSGg6h4Y/GDx0UmVuvo/dhAutI1djDsGHmO1SIw3O+pXP7lKS035O95orrqYl+/3Nuu1jk=
X-Received: by 2002:a17:907:76b3:: with SMTP id jw19mr15698900ejc.202.1615222650572;
 Mon, 08 Mar 2021 08:57:30 -0800 (PST)
MIME-Version: 1.0
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
In-Reply-To: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Mar 2021 11:57:19 -0500
Message-ID: <CAPig+cR13JTmLmjk=g8sFowEY2zNZiqVFCHOCYnQ9LX5URjdGA@mail.gmail.com>
Subject: Re: remote.<name>.merge missing from the git-config man page?
To:     Fabien Terrani <terranifabien@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Adam Sharafeddine <adam.shrfdn@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+adam +phillipe]

On Mon, Mar 8, 2021 at 7:11 AM Fabien Terrani <terranifabien@gmail.com> wrote:
> I was recently trying to understand the git-push command's behavior,
> especially regarding the configuration values's resolution. I read the
> following in the EXAMPLES section of the git-push man page:
>
> > git push origin
> >     Without additional configuration, pushes the current branch to the configured upstream (remote.origin.merge configuration variable) if it has the same name as the current branch, and errors out without pushing otherwise.
>
> I then had a look at the git-config man page and I was surprised to
> notice that there was no documentation at all about a
> remote.<name>.merge or remote.origin.merge configuration value. I am
> definitely not a git expert but this looks strange to me. Am I missing
> something? Is remote.<name>.merge used by git at all?

Yours is the second report[1] about this in a few weeks.

> (before mailing here, I tried carefully examining git's source code to
> see if there was a remote.<name>.merge value used somewhere. I can't
> be 100% positive since this was very complex to me, but I personally
> couldn't find anything referencing remote.<name>.merge, while I found
> code using other values like remote.<name>.push, push.default etc.)

I spent a bit of time going through the source code, as well, trying
to determine the correct name of this variable but didn't arrive at an
answer before having to turn to other tasks.

Hopefully, someone more familiar with this area of the project can
chime in with the correct answer and more useful response.

[1]: https://lore.kernel.org/git/CAAxrY9yjTKV8-K0AmO4fBmtDrSB4KkN_xKOMmtSb-dvixJNaEQ@mail.gmail.com/T/
