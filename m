Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1946EC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED8F20882
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+2BSVQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgIJTKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgIJTIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:08:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833CC0613ED
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:08:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so5225055pfd.5
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UavVehlLswWHjBKazZr9j5bzQoUR8uAT7OqKNG/itRA=;
        b=S+2BSVQO5uQRZtRV4F1dqgl/YlEkXccR0CI22EBFfESe2chJG6aXp0rz0yHXe4vG6G
         u0Mk5nLdpKgxaW8K/Yv/9Zf4ODbQ92fKhhNALIaq+v+1E8m6XnWCKx6BH9PFyLc6fWj4
         rQpiZ9FZuti0LfZHe7OC5soCIPNHBLlHCsfXgHAQFeAsdBO/hVkrbk8DCRh59qSTMmsd
         zxsR8KNI2wKI8YO6MPr3eryV/nLS7Nfg20r6h2utMB7IvkH8QVs14UJ0QV4u7s4vtU9c
         8+tnUd+4gtCvMTRHXUD+Gun5Xzq6j/HCatC+Pt6U0tctFEBcCLtuP/H2wY1sGIDq6C7y
         nK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UavVehlLswWHjBKazZr9j5bzQoUR8uAT7OqKNG/itRA=;
        b=nlSDgRnmx0NWPA35CiDJV/zucPsdQ/JcKD35w8iIfwgZctBGgebEHTDD4ClV1+Ug95
         oHE+CYwOQVq0zIVaGZbxXdx0nDjQvJoKt4tcbA3JoDkdGYS/wwLs0VC7uRyWtZjn/RXZ
         nrO5oORqwzqEEctJHoWfh5oUv2ORqxE90YT+vReq4sXMa+oLOemK5efxXEYhi6veiryJ
         mOD2JNcelKS15flalfuHmaYkkdIPong5Ae+O7hvQXHrPXYRfbDo/kupY/0xZc2r64HJh
         MaPfG6xFgZAQU9+/lTd1Z1rIiR5c50uFFdAI8fl1od9pe638jA3ARKW20+nWv2Wkdihp
         65cQ==
X-Gm-Message-State: AOAM530hNiqcpzcXzMhwYeaU0tkrl3imvvtIUGPH7pXLhXtC/0bXestg
        xKE45PTOynCrRbqoIJnIGI3cWg==
X-Google-Smtp-Source: ABdhPJzNSXlC1udp+fDxLl6T0mDgBSsR6mq4x+Y6kVzc3b3gvLQQqoJARTTeSSFX6RLgr2yOHbfSxg==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr6018058pgj.210.1599764921919;
        Thu, 10 Sep 2020 12:08:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id mt8sm2662869pjb.17.2020.09.10.12.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:08:41 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:08:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 7/9] hook: replace run-command.h:find_hook
Message-ID: <20200910190836.GD331156@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-8-emilyshaffer@google.com>
 <xmqqwo12u1wz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo12u1wz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 01:32:12PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Add a helper to easily determine whether any hooks exist for a given
> > hook event.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  hook.c | 9 +++++++++
> >  hook.h | 1 +
> >  2 files changed, 10 insertions(+)
> 
> Should we consider the last three patches still work-in-progress
> technology demonstration, or are these meant as a proposal for a new
> API element as-is?

The former. I'm irritated with myself for spending a long time fidgeting
with the wording on this reroll and still forgetting to mark the last
three "RFC" as I had planned to do.

> It is perfectly fine if it is the former.  I just want to make sure
> we share a common understanding on the direction in which we want
> these patches to take us.  Here is my take:
> 
>  - For now, a hook/event that is aware of the config-based hook
>    system is supposed to use hook_exists(), while the traditional
>    ones still use find_hook().  We expect more and more will be
>    converted to the former over time.
> 
>  - Invoking hook scripts under the new world order is done by
>    including hook.h and calling run_hooks(), not by driving the
>    run-command API yourself (I count run_hook_ve() as part of the
>    latter) like the traditional code did.  We expect more and more
>    will be converted to the former over time.
> 
>  - From the point of view of the end users who have been happily
>    using scripts in $GIT_DIR/hooks, everything will stay the same.
>    hook_exists() will find them (by calling find_hook() as a
>    fallback) and run_hooks() will run them (by relying on
>    hook_list() to include them).
> 
> I am guessing that the above gives us a high-level description.

Yes. I am also working on a patch locally to include a config -
optionally users could shut off the $GIT_DIR/hooks, but I don't see us
making that the default behavior any time soon (or ever).

> 
> The new interface needs to be described in hook.h once the series
> graduates from the technology demonstration state, in order to help
> others who want to help updating the callsites of traditional hooks
> to the new API.  And the above three-bullet point list is my attempt
> to figure out what kind of things need to be documented to help
> them.

Sure. Agreed. Thanks for pointing it out - I had planned on updating the
`git help hook` manpage but adding API comments in hook.h had slipped my
mind, so the reminder is useful.

> 
> I am not seeing anything in run_hooks() that consumes input from us
> over pipe, by the way, without which we cannot do things like the
> "pre-receive" hooks under the new world order.  Are they planned to
> come in the future, after these "we feed anything they need from the
> command line and from the enviornment" hooks are dealt with in this
> first pass?

I included this conversion to demonstrate the tech and give people
something to look at (and shout to stop if so needed). I do plan to
include hooks which need piped input; in fact, I'm hoping to target one
such for the next conversion I do. The todo list looks like so:

 1. semantics for checking hook.runHookDir config
 2. convert all the hooks which take input in interesting ways (or, just
 all the hooks)
 3. add user friendliness via 'git hook add', 'git hook edit', etc

 The config semantics are in progress and I'm hoping to send this week.

 As for submission plan, I don't mind including new architecture (if
 unused) except for the code bloat; I'd rather push all the
 "conversions" simultaneously, so users don't have to wonder "is this
 hook a new and supported one, or not?".  I don't mind adding the
 niceties ('git hook add' etc) later as the config is a little annoying
 for a human to write themselves, but not impossible.

  - Emily
