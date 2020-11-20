Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB8C56202
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 10:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8216C20888
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 10:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICDg82k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKTK71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 05:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKTK71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 05:59:27 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DDC0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 02:59:25 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lv15so6421516ejb.12
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oD1adnqVaI+nKTUaPq2KlAYKzXurp+Ew/CTloUBLK5E=;
        b=ICDg82k1EM471nhHeNE6T8KmD8NoWtuboGSLQfYJEaKwdVgBM7Wkq4kwkEaVh4db4e
         hV0VcvWDpgUTcB7lErHBhxgMnXj3n4FEkh7zftVbMyAJAhFyTl6lUlZIXHnY5YOA4IaN
         uk4RC/ppavztppFcqHxu9CjtmT9ZRBawgefPRdMYqGtG9keKQXjY72WOIEugOKJiExcU
         4ObEpnapHqXLJ/GCRKy7pKogYBrSNRwEqLKOorD2sOlr3pZBq56A/X5VaOTtI74gdmbu
         uj61JEAuBXtuHjqfTChXZN0lsJcItJN00fKSo4Z/xktyLalfb8qeJ3y3hAwjWAU9XE5Z
         s9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oD1adnqVaI+nKTUaPq2KlAYKzXurp+Ew/CTloUBLK5E=;
        b=SqBCZZ7N/TTdRTt4vuvClBBuexkIkga2zoaJunooNizRoLLNjxmiSkEbtesZPJWT3M
         FVnyOjURFEdrnACALFtl8chkRLOAfpGpzK6qx2qmJHzykfJFcydFBYXcHlCLjdHdtk9j
         tc7Xcbil+J9g92J8dQdvSGohZ7Rw1K/rTda+HzXifcjlKUTQa0M2/krD8aLT/G6Y7j6q
         oInPT23rh12zWX+dE1GYTUJm0doCespwQ8nVVFsZcXf+wW+WPcwKXGTefhfUdv2b75je
         gtY2zKWYckljL9OawUPHvauHrHOkjkLDy5Pc1CetnAM3MqFm9Tyl3oj/smlkw7tZW4GE
         z8hA==
X-Gm-Message-State: AOAM532S+YYMaHuKh33XQE+/89taeb5BopZyTplXTFAZqoXPUlz7daH6
        CEx8BO6MFXM8CCT24Qv+cj0=
X-Google-Smtp-Source: ABdhPJytP6daThnEafNM4pVp5xqJqzFHxfoO3P3j6eW4R7KIGkzS/7v/oN6wV/9hUKDqD3s02PvJmA==
X-Received: by 2002:a17:906:6987:: with SMTP id i7mr34577717ejr.18.1605869964204;
        Fri, 20 Nov 2020 02:59:24 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id g25sm903058edf.96.2020.11.20.02.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:59:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com> <pull.790.v4.git.1605819390.gitgitgadget@gmail.com> <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com> <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com> <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com>
Date:   Fri, 20 Nov 2020 11:59:22 +0100
Message-ID: <87sg94pa45.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 20 2020, Orgad Shaneh wrote:

> On Thu, Nov 19, 2020 at 11:23 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> On Thu, Nov 19, 2020 at 3:57 PM Orgad Shaneh via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>> > Let hooks receive user input if applicable.
>> > [...]
>> > This allows for example prompting the user to choose an issue
>> > in prepare-commit-msg, and add "Fixes #123" to the commit message.
>> >
>> > Another possible use-case is running sanity test on pre-commit,
>> > and having a prompt like "This and that issue were found in your
>> > changes. Are you sure you want to commit? [Y/N]".
>>
>> These use-cases really help readers understand the motivation for this
>> change. Good.
>>
>> > Allow stdin only for commit-related hooks. Some of the other
>> > hooks pass their own input to the hook, so don't change them.
>> >
>> > Note: If pre-commit reads from stdin, and git commit is executed
>> > with -F - (read message from stdin), the message is not read
>> > correctly. This is fixed in the follow-up commit.
>>
>> Rather than making such a fundamental change and having to deal with
>> the fallout by introducing complexity to handle various special-cases
>> which pop up now and in the future, I wonder if it makes more sense to
>> instead just update documentation to tell hook authors to read
>> explicitly from the console rather than expecting stdin to be
>> available (since stdin may already be consumed for other purposes when
>> dealing with hooks or commands which invoke the hooks).
>
> On the first revision I had several links in the commit message to
> users who solved it this way. This solution however is not optimal.
> I have a prepare-commit-msg hook that requires user interaction for
> choosing an issue. This hook must work from the terminal and also
> from GUI applications like IDE.
>
> Currently the hook always pops a GUI window, but when using it
> from the terminal this is inconvenient (and when running over
> remote SSH without X forwarding it can't work), so I'd like it to be
> usable also from the terminal.
>
> To achieve that, I created 2 classes - one for terminal and one
> for GUI, and trying to choose the correct class by checking if
> stdin is a tty. The condition looks like this (Ruby):
> client = STDIN.tty? ? Terminal.new : GUI.new
>
> At this point I was surprised to discover that Git closes stdin,
> so the condition is never satisfied, and I always end up with GUI.
>
> As I mentioned, I need it to work also when executed from
> GUI applications, so just reading from the console will not work
> in my case. I tried other ways to detect "running from terminal"
> without the tty condition, but couldn't. The environment variables
> are identical when running in a GUI terminal and in the IDE.
>
> Can you suggest an alternative way to determine if I can accept user
> input from the console or not?

Like Eric noted in his reply I can't think of a way to do that
particular thing reliably either, and agree with his comments that if
such a way is found / some aspect of this change is kept having this
explanation in the patch/commit message is really helpful.

I think what you're trying to do here isn't a good fit for most git
workflows. Instead of trying to interactively compose a commit message
why not change the commit template to start with e.g.:

    # You must replace XXX with an issue number here!:
    Issue #XXX:

That gives the user the same thing to fill out, but in their editor
instead of via some terminal/GUI prompt. They need to write the rest of
the commit message anyway in the editor, so even if you could why open
up two UIs?

Projects that have these conventions also typically settle on just not
trying to solve this problem on the client-side, but e.g. having a
pre-receive hook that does the validation, or do it via CI / before a
merge to master happens etc.
