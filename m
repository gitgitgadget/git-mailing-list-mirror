Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225DAC433E9
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F0164DDB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 04:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhA3EVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 23:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhA3EGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 23:06:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3871C061353
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 19:55:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e62so8811517yba.5
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 19:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VFkGknF254jClig2lt7grrqnfYkFR7fHscPama6QOWw=;
        b=MnvPvwCfjDkYbcOjypAwMTUB9du8UG7briYRHzxlQKTQ8ESXAvCOFMYBG92WLhMOqs
         ylhD0V8qDfrX5A1T1qC/m09no2L4k9h6fzeGdJ0bKqQ9AV2vwRs8UqmA22Nb1dkNKho/
         piZ5SdJc8WheJVN5e7+TrCY0FvLx0Z+I96lQChpMtLG9qeutueg8BdCKflL8Fym+JXmG
         ELosy0EfKGJZmlwFVMNCWoQDfjRGCakdtsNggCjp6gXQcvUcVBvLcTkIjp7k0ZUrM3fD
         vb7cvFmMJr+/sP+sESS5gAQb3lerVkqAwMQe08cGUJA7S5fzyjq6VhRhn0u0A84/PUsV
         klhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VFkGknF254jClig2lt7grrqnfYkFR7fHscPama6QOWw=;
        b=pzUxgOztTaJ0R6GhXXWSYBvYwFjEO3siuFkpaTWjacJznN5syuITSOTRmreNEJEusk
         HbFzoApHujRRwFTeZGSDktwFDIfQli4Jv0bxHy8bxhJbT0rw6GZyNDdJHYzqrDXytt2D
         kLf3HsMslSfkY3mDOIv7D4ALaOF8gSdy2Sr9rs85MdxF/APPt9TnzXJtP0nOUfpoJ+n7
         VGwbyos7qsFdmPhubp5qM6dawxobhB7aCIdASzlP6L5YnGnXUXD1qR1/3iJDnGJN86/S
         59nLJ9ZjKYC2baOmdsIFIZeH7bABPzLFVT84aAR2vA2yCJDYbOk8baSw0U7hZpWWBZrh
         evRw==
X-Gm-Message-State: AOAM530/nirNVBTVEkfiajWSiQXBXALkGzxgrmxfDkLBaBsH/KrfWtAE
        PN9wPNB+R/+1opN6sTgpYjQPGN1bfpym5aSHhLa6
X-Google-Smtp-Source: ABdhPJzMEvlGXOzBuvwI2QpiVBxzbVkPzFflaGaX5vg5orfd7/7cIxZ3+SufkjXFHLlADY7yyJLPRbLaisa4Jj5eb/e2
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b116:: with SMTP id
 g22mr9858373ybj.147.1611978957862; Fri, 29 Jan 2021 19:55:57 -0800 (PST)
Date:   Fri, 29 Jan 2021 19:55:56 -0800
In-Reply-To: <xmqqmtwvz4g9.fsf@gitster.c.googlers.com>
Message-Id: <20210130035556.796250-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqmtwvz4g9.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It feels somewhat brittle that we have to read the same variable and
> > apply the same "default to true" logic in two places and have to
> > keep them in sync.  Is this because the decision to advertize or not
> > has to be made way before the code that is specific to the
> > implementation of ls-refs is run?
> >
> > If ls_refs_advertise() is always called first before ls_refs(), I
> > wonder if it makes sense to reuse what we found out about the
> > configured (or left unconfigured) state here and use it when
> > ls_refs() gets called?  I know that the way serve.c infrastructure
> > calls "do we advertise?" helper from each protocol-element handler
> > is too narrow and does not allow us to pass such a necessary piece
> > of information but I view it as a misdesign that can be corrected
> > (and until that happens, we could use file-local static limited to
> > ls-refs.c).
> 
> After giving the above a bit more thought, here are a few random
> thoughts around the area.
> 
>  * As "struct protocol_capability" indicates, we have <name of
>    service, the logic to advertise, the logic to serve> as a
>    three-tuple for services.  The serving logic should know what
>    advertising logic advertised (or more precisely, what information
>    advertising logic used to make that decision) so that they can
>    work consistently.
> 
>    For that, there should be a mechanism that advertising logic can
>    use to leave a note to serving logic, perhaps by adding a "void
>    *" to both of these functions.  The advertising function would
>    allocate a piece of memory it wants to use and returns the
>    pointer to it to the caller in serve.c, and that pointer is given
>    to the corresponding ls_refs() when it is called by serve.c.
>    Then ls_refs_advertise can say "I found this configuration
>    setting and decided to advertise" to later ls_refs() and the
>    latter can say "ah, as you have advertised, I have to respond to
>    such a request".

Usually the advertising is in the same file as the serving (true for
ls-refs and fetch, so far) so I think it's easier if they just
communicate on their own instead of through this "void *". I agree with
the communication idea, though.

>  * I am not sure if "lsrefs.allowunborn = yes/no" is a good way to
>    configure this feature.  Wouldn't it be more natural to make this
>    three-way, i.e. "lsrefs.unborn = advertise/serve/ignore", where
>    the server operator can choose among (1) advertise the presence
>    of the capability and respond to requests, (2) do not advertise
>    the capability but if a request comes, respond to it, and (3) do
>    not advertise and do not respond.  We could throw in 'deny' that
>    causes the request to result in a failure but I do not care too
>    deeply about that fourth option.
> 
>    Using such a configuration mechanism, ls_refs_advertise may leave
>    the value of "lsrefs.unborn" (or lack thereof) it found and used
>    to base its decision to advertise, for use by ls_refs.  ls_refs
>    in turn can use the value found there to decide if it ignores or
>    responds to the "unborn" request.

lsrefs.unborn = advertise/serve/ignore was how it was in version 2 [1]
(with different names) and I changed it due to Peff's suggestion, but
perhaps I landed up in the unhappy middle [2]. I think we should just
pick a standard and use it for this feature and whatever future features
may come. The distinction between advertise and serve ("allow" in my
version 2) is useful in some cases but is useless once migration has
occurred (and thus clutters the code), but perhaps it could be argued
that all servers need to do the migration at least once.

[1] https://lore.kernel.org/git/cover.1608084282.git.jonathantanmy@google.com/
[2] https://lore.kernel.org/git/YBCitNb75rpnuW2L@coredump.intra.peff.net/
