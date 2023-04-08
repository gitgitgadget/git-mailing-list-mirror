Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8771C7619A
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 22:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDHWp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDHWp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 18:45:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1659758
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 15:45:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ke16so1742271plb.6
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680993956; x=1683585956;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4COKfAs+f3sBves23C+0KZXVDdBF/nTmVvizeHhX6Zc=;
        b=ouY0LCTLj5hk41rG5xM2p1hjGnDzXqe/AmRg41s+fF688dJfvvrlUYFZJeiJQAJ7Bt
         r4XZ8+/E3atZm+Jy2nLBFGORUxpUQGYF1eZKam9L2PTtgIAZahUishqQgrzmA6y4F1Os
         eUI7CqKodth017eU9dqLlp/Jm5/c1y+WUbnGVRRpCCf0aWddgoDcr+Fd7AL5+x8zreQj
         7PJ5utf29HWOPLx+a7tkg3TQ3qGesYV8iz61unZg8/bYNanh3p9XD3gxk0fYI90Z9uxK
         vApgIQDZI6lwbWC4W83e88dnciRwdY+/PgUXHLK1xRqt96Doldod80SsYr2Ui7dCvBWg
         TusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680993956; x=1683585956;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4COKfAs+f3sBves23C+0KZXVDdBF/nTmVvizeHhX6Zc=;
        b=hNI+Jc93zcIPHb/mBG4dQF6LBxbqSn5kE5kGpr+HWYSPTvzWabvbEGyByRCEQ/o5dh
         0wubqdGNfoPWSvypneP9jSiHBrEICnZwRN0akJyqflHBbKmM7w+5l+mZwRUUOdT94h4W
         gQ5YNVEEb0kbUqY2YVmF5J6lMqqKN9gk7fegC7TWkpwtb3HoOv9M2xRXFntoPxohpHsC
         Xvvdd+wbiLdRPup8WzMSa2DaOcrOfITvz1MkV/2ePnwQyUgUD3NkT11wbiXnuyTym9LR
         OtTdF1SB/8UzBmWn4jjGtPweQeHngTeDtqMw0DzsInftw6PHGNuc7ymVQo1roDL+SzGZ
         M+sA==
X-Gm-Message-State: AAQBX9dXdthVy0X5C3mHryp0ZrvFgtcGdWUFz+Q4xlpoOsavLSVAuH+C
        cDvlYedQi6j0+mf98XR1ad4//5EUY98=
X-Google-Smtp-Source: AKy350aIvSz/MxkwfufS/QERYVoV+lOUTMxAbKBTXUTCD0qLDfQJxuT9r5BPEs93C47LYT5jV2WuEw==
X-Received: by 2002:a05:6a20:6c88:b0:d9:6c8b:e9aa with SMTP id em8-20020a056a206c8800b000d96c8be9aamr2923749pzb.0.1680993955659;
        Sat, 08 Apr 2023 15:45:55 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id k23-20020a635a57000000b0051806da5cd6sm1362321pgm.60.2023.04.08.15.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:45:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] coccinelle: add and apply branch_get() rules
References: <4cb4b69c-bd14-dfbd-6d06-59a7cd7e8c94@gmail.com>
        <xmqqjzynlm9i.fsf@gitster.g>
        <376aca6d-1b09-9bf9-c258-81e8ed2443c2@gmail.com>
Date:   Sat, 08 Apr 2023 15:45:54 -0700
Message-ID: <xmqqjzymf0wt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> On 07-abr-2023 08:55:53, Junio C Hamano wrote:
>> Rubén Justo <rjusto@gmail.com> writes:
>> 
>> > There are three supported ways to obtain a "struct branch *" for the
>> > currently checked out branch, in the current worktree, using the API
>> > branch_get(): branch_get(NULL), branch_get("") and branch_get("HEAD").
>> >
>> > The first one is the recommended [1][2] and optimal usage.  Let's add
>> > two coccinelle rules to convert the latter two into the first one.
>> >
>> >   1. f019d08ea6 (API documentation for remote.h, 2008-02-19)
>> >
>> >   2. d27eb356bf (remote: move doc to remote.h and refspec.h, 2019-11-17)
>> 
>> Citing commits in the past is not an optimal way to justify a
>> recommendation, though.
>
> Well, my intention is to state that the recommendation is not recent.
> Perhaps it is confusing to not state clearly that it is also current.

No matter how long ago the recommendation was originally written, we
should by default consider that anything that appears in the current
set of sources is still current.

If it is stale and there is a better recommendation, you of course
are welcome to update it, and if you were writing such a patch, it
may make sense to explain the situation like:

    In the comment for "struct branch" in remote.h, we recommend to
    use branch_get(NULL) to find out the branch currently checked
    out.  This recommendation dates back to f019d08e (API
    documentation for remote.h, 2008-02-19) in a separate
    documentation but later moved by d27eb356 (remote: move doc to
    remote.h and refspec.h, 2019-11-17) to the current location.

    However, the recommendation is out of date because ...

or something.  But that is not what this patch is about, is it?

I do not think you really gain anything by showing that they date
back long time, without making your position clear between "yes, it
is a very long-standing tradition and majority of the existing code
conforms to it" and "this ancient recommendation is iffy, and I
think it should be updated".

What you need to justify this change is to say that the
recommendation _is_ current, anyway, so I do not know why you are
arguing against my suggestion to improve your proposed log message.

>> Stepping back a bit.  What is the ultimate goal for this change?
>
> Of course, as you pointed out, there are usages where a computed value
> is used, perhaps coming from the user, which might end up specifying
> "HEAD".  Those usages of branch_get() are not considered here.  Not even
> indirect ones.

That is what I found problematic, because I do not think this
particular change will get us closer to the endgame of not feedling
"" or "HEAD", if ...

> I have to admit I have this change in mind, not in the current form, but
> in the same direction, since my patches for builtin/branch.c, a few
> months ago.  When, reviewing the use of branch_get() I was a bit
> confused.

... it is the ultimate goal.  These Coccinelle rules would not help
us fish out existing callers that receive string "HEAD" from their
callers and pass them unmodified to call branch_get() and convert
them to pass NULL, for example.  And for doing something like that
and encode that into another set of Coccinelle rules, it would take
auditing more and more indirect callers that reach branch_get(), but
if we were doing that, we can do the "passing HEAD or empty is a
BUG" patch to protect the function from future callers mistakingly
passing "HEAD" or "" without Coccinelle rules that are rather costly
to the CI.

The above assumes that it is a good thing to declare that NULL is
the only permitted way to ask for the branch currently checked out.
I am a bit skeptical about that, though.
