Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F44C2D0E8
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13EF20721
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsUCveVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbgDCNSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:18:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38075 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgDCNSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 09:18:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5so9229088edq.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TN1nopduCch1BFQNLC7jwQ+L8je02dEf1DAJkqgAiB0=;
        b=jsUCveVBvVWU39oCrP0M73afD6i4XCEpQ0xRN9L5IozDAotd4f6TiFHnv7n4rse5eu
         Cdg48bHOJM3fSLBNmf8d831gHDWxaHynpUjdTyuoSegjlgAyY+XvEYrjvdqmA0rPmAsi
         vwONSKgOkqBq2KZFtuVav6SlYz3v6hpN2ukpPMjPjB7OK2YZShdI1HY6Cn198/NcOnCP
         +CJIKnEVBuecuBUPxDITM0zBTWmKSGbWU+4vbZ+0nekEZ4LARqJYWO1GykzQUUaf8iX5
         O1/npq7Xg0zn24Ij0J+XFq9ppZVZkTOfszsItO8W9S9piAO071DIm0XrGuw2pB+7Ke0H
         uckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TN1nopduCch1BFQNLC7jwQ+L8je02dEf1DAJkqgAiB0=;
        b=sLhcTqD2NqBjoLARI1pbyxHgDTTAd9/k7vLgeSEL3U51PJnoXH01EbDLyTlF6R30/2
         GWNvMXEUwdjDOPqgGMiXyAFvwdXlGLbTSMNqx9QHEss7TLL2mujrKwWamrMbPmFug+Yw
         Z9nUawpenUanfi0rK/PP6acYMovMLfqlzrjO1UN5urwtxmSw7yzjViMhArJiRCbjMhk7
         wXoWs2v/xrV3tYvEbXJmzUwPxFrVQ6/UQlJ3h1pK21ZccBt5f4+kJN41/b4c0hst2czJ
         PtqsylDX+aaEUsviGr4JBTMDMu2DL1MXM8/JAqbFnijhlHwabXFHJ/vIJyXEnqTR9KeK
         OF0g==
X-Gm-Message-State: AGi0PuZK+uboy2t4EPzKOul7nKrRPCgVl2N4qAcPEYktmTbaL6bznitf
        r6dUVpSbn0+/aRPHzXN8a7MbYsKD0Ku2XmVwxCQ=
X-Google-Smtp-Source: APiQypIjelL/50ccmT7qvobBirb6gdJ21IXG8FHlm5PhhgdOqNAkcgJk6/l79ZalTQHi0nNJsThpfGY3VZENbG6/+ac=
X-Received: by 2002:a17:906:fc3:: with SMTP id c3mr3385539ejk.28.1585919886169;
 Fri, 03 Apr 2020 06:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200321161020.22817-1-mirucam@gmail.com> <20200321161020.22817-2-mirucam@gmail.com>
 <xmqqk12x17za.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk12x17za.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 3 Apr 2020 15:17:54 +0200
Message-ID: <CAP8UFD3t5ZukXqfEr9W8FFror=SemmoB0hokri2BK6ZYcq619Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] bisect--helper: fix `cmd_*()` function switch
 default return
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 3, 2020 at 6:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > In a `cmd_*()` function, return `error()` cannot be used
> > because that translates to `-1` and `cmd_*()` functions need
> > to return exit codes.
> >
> > Let's fix switch default return.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  builtin/bisect--helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index c1c40b516d..1f81cff1d8 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -711,7 +711,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
> >               res = bisect_start(&terms, no_checkout, argv, argc);
> >               break;
> >       default:
> > -             return error("BUG: unknown subcommand '%d'", cmdmode);
> > +             res = error(_("BUG: unknown subcommand."));
>
> The return value from error() is *NOT* taken from "enum
> bisect_error"; its value (-1) happens to be the same as
> BISECT_FAILED, but that is by accident, and not by design.

In bisect.h we have made sure that BISECT_FAILED would be -1, so it is
not by accident:

enum bisect_error {
        BISECT_OK = 0,
        BISECT_FAILED = -1,
        BISECT_ONLY_SKIPPED_LEFT = -2,
        BISECT_MERGE_BASE_CHECK = -3,
        BISECT_NO_TESTABLE_COMMIT = -4,
        BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND = -10,
        BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
};

> So the above code is accident waiting to happen, while
>
>         default:
>                 error(_("BUG: ..."));
>                 res = BISECT_FAILED;
>
> would be a lot more correct (by design).

I think it is very unlikely that we will ever change the value
returned by error(), so I don't think there is an accident waiting to
happen.

Maybe we should make it clearer though in bisect.h in the comment
before the enum, that we chose -1 for BISECT_FAILED so that it is the
same as what error() returns. Maybe something like "BISECT_FAILED
error code: default error code, should be the same value as what
error() returns."

> After this part, there is this code:
>
>        if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
>                        res = BISECT_OK;
>
>         return abs(res);
>
> This is not a problem with this patch, but the use of abs() is very
> misleading, as res is always non-positive, as it is (after fixing
> the patch I am responding to) taken from "enum bisect_error"
> vocabulary.  "return -res;" would make the intent of the code
> clearer, I think.

I am ok with using "-res" here. There are other places where
"abs(res)" is needed though, so code could look a bit more consistent
if "abs(res)" was used here too.

> By the way, under what condition can the "BUG:" be reached?  Would
> it only be reachable by a programming error?

It could happen if a user would try to directly use `git
bisect--helper <cmd> ...` with an unsupported <cmd>. Users are not
supposed to directly use bisect--helper though.

It could also happen if a developer uses `git bisect--helper <cmd>
...` in a script, program or alias if <cmd> is not properly spelled or
is unavailable for some reason.

> If so, it would be
> correct to use BUG("...") and force it die there.  If it can be
> reached in some other way (e.g. an incorrect input by the user,
> corruption in state files "git bisect" uses on the filesystem), then
> it is *not* a "BUG".

In this case I think it's difficult to tell if it will be a bug or not.

> I think "bisect--helper" is *not* called by end-user, so an unknown
> command would be a BUG in the calling program, which is still part
> of git, so it probably is more prudent to do something like the
> following instead.

I am ok with both ways.

Thanks,
Christian.
