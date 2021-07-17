Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE3C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9199E610CB
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhGQWCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 18:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhGQWCY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 18:02:24 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89428C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:59:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so13880131otl.0
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2P9HNpRcYa9xFB2zy0Mu7B4TG+QIzrGXFCDdR/iZUds=;
        b=B6Ii+/wtkI1MyFO3wLCgq7b3Fy4FgPe4w8rapj4KL/XGs6fo0w4zm3x0miQXw4pYfJ
         LZlfmmGIqpYw3kXnKN2qUVCEiTw2ndy7wEQex3rf2iXzxZBhmuapTwJb8lVO0ylO/WRW
         kaFdFo8GL65DNi0/Irl6AZHry8q2/SswRhmolMvOWByk3cHUK8AmNnJbsELCKiYpqr/Z
         kcvaqJqbs5SOegF8tAiz8mg3nX7gS18ncK83Oi8tQRZ5xIsdTWPKwHI0N3gruyW9pqpl
         FQP42k+2S9eE0vY7jfycYY3cs50emv44N9rt7Kw0NIAN+5I6V8kSXwlUUlsUK7flZ83Q
         dwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2P9HNpRcYa9xFB2zy0Mu7B4TG+QIzrGXFCDdR/iZUds=;
        b=FXLWF/S6Pd45GLp4TM4bEbkiA2rTv678WPdt2nFOCynbbBAFO+pcuhMdMjEE6XzFX1
         /haI61g+LlZrBWZtZWwOFqj2ePEJNl9rW3SH6XOKqpmdqB/mkx9V1KLj4mYnUABiDNnn
         9y1iBeiSz7S7rsDDakTRb+avO5a6ezcAdhPz6b1DEPc84h9PCBhRX8rE1rCvMmg8bNO0
         bT76XlQzKZA6NEo4e/62IBxeFls5pDwCNnpcOhC2cFSQz68L41N9LAploVH2+4hv8CJr
         aduAYmVj+UBT4ZB1tKge01Au1ta+0twIaAHacbWJbXcoWuagQtQq3xKSuSuMXE6JnWUh
         tT+Q==
X-Gm-Message-State: AOAM532ddhNy3PeCZHfUlqecG3OAuJgLxAoSDLAQ82xC297il9pwLN+K
        A+B8ebyYjL2B797SiT74DCk=
X-Google-Smtp-Source: ABdhPJwiS1hImrift6HFqzG7KODJ/PRy42JpzIYpyIOzCH5jIlBkBmOUkU+QQTZINvPHMy4Jtqco2Q==
X-Received: by 2002:a9d:2d82:: with SMTP id g2mr13936868otb.30.1626559166750;
        Sat, 17 Jul 2021 14:59:26 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id o19sm2709529oov.36.2021.07.17.14.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 14:59:26 -0700 (PDT)
Date:   Sat, 17 Jul 2021 16:59:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Message-ID: <60f352bce4d53_554620882@natae.notmuch>
In-Reply-To: <xmqqwnpooctj.fsf@gitster.g>
References: <60f1daa896f69_330208b1@natae.notmuch>
 <c54fa084-75f4-b775-8ac2-6df3c7a36571@aixigo.com>
 <xmqqwnpooctj.fsf@gitster.g>
Subject: Re: When are you going to stop ignoring pull.mode?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:
> 
> >>>     pull.ff  pull.rebase  commandline            action
> >>> ...
> >>>       *          *        --ff-only              fast-forward only[1]
> >>> ...
> > What about
> >
> >          *       !false      --ff-only              ???
> 
> This is covered by an earlier entry ("*" stands for "any value"), I
> think; it should fast-forward or fail.  The reasoning goes like
> this:
> 
> The user configures pull.rebase to some kind of rebase; it could be
> just true (the traditional flattening rebase), or the one that
> preserves the shape of the history, or even the interactive one.
> With the configuration, what the user declares is: 
> 
>     I may have my own development on top of the result of my last
>     integration with the upstream I did when I ran "git pull" the
>     last time, and when the upstream has more commits, the way I
>     want my local work to integrate with their work is to replay my
>     work on top of theirs (as opposed to "merging their work into my
>     history").
> 
> But by passing "--ff-only" from the command line, the user tells us
> this:
> 
>     This time only, I want fast-forward update and nothing else.  I
>     do not remember doing any of my own development on top of their
>     history, and I expect that this update from the upstream would
>     fast-forward.  If that is not the case, please error out, as I
>     need to inspect the situation further and I do not want to see
>     conflicts in unexpected commits I thought I did not have.

No, this is what you think the user would be telling us, but that's not
what the user is *actually* telling us right now.

  git -c pull.ff=only pull --rebase

What the user is actually telling us right now is that while he normally
would expect a fast-forward, in this case he would like a rebase.

Today this is the equivalent of:

  git -c pull.rebase=true pull --ff-only

If you change this interpretation, it would break the symmetry between
configurations and command line arguments.

> So the "action" would be
> 
>  - If their history is a descendant of ours, that means that on top
>    of their history previously observed by us, we haven't added any
>    development of our own.  We just move to the tip of their history
>    and we are done.
> 
>    This is not so surprising anyway.  If we are doing any kind of
>    rebasing, what happens is to start from the tip of their history
>    and then commits from our own development are replayed on top of
>    that.  When their history is a descendant of ours, we end up
>    doing just fast-forward, as there is nothing to replay on top.

But --ff-only is not for rebases, the documentation is very clear:

	Specifies how a merge is handled when the merged-in history is
	already a descendant of the current history.  `--ff` is the
	default unless merging an annotated (and possibly signed) tag
	that is not stored in its natural place in the `refs/tags/`
	hierarchy, in which case `--no-ff` is assumed.

  With `--ff-only`, resolve the merge as a fast-forward when possible.
  When not possible, refuse to merge and exit with a non-zero status.

>  - Otherwise, because the user expects the command to fail if their
>    history is not a descendant of ours, we fail.
> 
> And "fast-forward only" in Elijah's table is a concise way to say
> that.

Yes, but it's taking us in the wrong direction by ignoring how the users
actually use --ff-only today, what the documentation actually says,
breaking the symmetry of configurations and arguments, and making
everything less intuitive.


On the other hand if --ff-only was mapped to pull.mode=fast-forward
instead, everything is clear:

  git -c pull.mode=fast-forward pull --rebase
  git -c pull.mode=rebase pull --ff-only

I don't even need to explain what these do.

-- 
Felipe Contreras
