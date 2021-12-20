Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BD9C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 20:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLTUyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLTUyT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 15:54:19 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADFC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 12:54:19 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o21-20020a17090a9f9500b001b105598e71so553024pjp.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sAIkH8p1IcIUTPwugEmO5rCOsMEK/fPlFs1IkW9ExXA=;
        b=pJ+KPFpvnTan9/D3Qih6uPFOxiz8AHsV97Ar5/etZfBwOF5T8e82uCTg9C8ow0m/Vx
         m4uG7YsUddOrIOk86RO3tx6vrrJDsuSecrxE7jYFDDrGXLSXBDSq1+Cm2Fy+i9TQJv3E
         Y0HAd1Ktvhjt9fKFWUbMYCLh9wiG5Jte6E2f8rWCH8W7HG3+9ZNSMoXV5lKcRoIv895J
         789EyeltHGtqQjxt+VmgvLUQAS8YI4g74+tBmKvOKFna9Yt30FuUJcMd2ghAcIAYGUW5
         AecUpdl6KqV8UqHQ/Kl3LGITcA/cZh3bcaSIbe3eDd8SMtHhFedJ1fowRLtC4VcLcqLs
         x4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sAIkH8p1IcIUTPwugEmO5rCOsMEK/fPlFs1IkW9ExXA=;
        b=2CNhz9WWbDt9biPaXFsgw7+4AryLy9V0WQt0pbOImATPKwgUTWfC0dXeWFMibHpTLb
         7rY33Xo3DsjEoW656tUbYrdN7bu+iidO89bwYUaqZiTqXUQ2H3Qq7ANpupHFFuA2jG0W
         h/4ixjJexaXmNQlvhCPIm6FsbOdmgWX7APffhUJ9L+Sa6Ypdp2H3gP4pJYDcG+c7doMH
         5yRQG9iDID93hMB9kjGSoWzH63UArp/O5vB4WYWkZ+1rbE5cQVhzGTKkpfHsdozmL7pL
         QLkPQK0Cmy5d6B+B1PEbzBeCi0naaETIdBlHexKdbl5Gq1eUTNsjd8bEicbAk1GJcGJP
         hjdg==
X-Gm-Message-State: AOAM532Ep13M+47WhHcLPJ5RAxj4i2AYyjRVEryrEUZiPS3KhItgt2+5
        Iqlr4CZY38sXEtgyvwRlSvawKyDKcA8crA==
X-Google-Smtp-Source: ABdhPJxvOHNdgIfFQuXkQjufT+vYhSL1dlDqZG9gGJbVg67fvjVNmczBnlj1AFoUa1rnbm4yHVwyEBTOPeXdVA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3b4d:: with SMTP id
 ot13mr945671pjb.196.1640033658544; Mon, 20 Dec 2021 12:54:18 -0800 (PST)
Date:   Mon, 20 Dec 2021 12:54:16 -0800
In-Reply-To: <xmqq4k73vymp.fsf@gitster.g>
Message-Id: <kl6lo85byp3b.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211207192925.67680-1-chooglen@google.com> <20211217000235.68996-1-chooglen@google.com>
 <xmqqilvm24bb.fsf@gitster.g> <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq4k73vymp.fsf@gitster.g>
Subject: Re: [PATCH v2] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>>> By the way, do not move the check about the number of negotiation
>>> tips from the original location.  That check, or its location, have
>>> nothing to do with what you want to do in this patch, which is "do
>>> not gc or update the graph file if we are not fetching".  It is
>>> better to leave unrelated changes out of the patch.
>>
>> Ah, I see that it's not easy to tell whether or not the behavior is
>> correct after that line is moved. I'll avoid doing this in the future.
>>
>> I still think that it is cleaner to move the negotiation_tip.nr check.
>> Should I do this in a follow-up patch?
>
> I am not seeing what makes it cleaner to have it early or at the
> current position, but with "It is cleaner to do tip.nr check early
> because ...", in a separate patch, it may become obvious.  But let's
> not do it in this patch.

Noted, thanks!

>> I hope Jonathan can chime in to confirm whether or not users want/need
>> to invoke "--negotiate-only".
>
> Yeah, I knew that this was "internal implementation detail", but
> then perhaps we know that a sane developer who knows what they are
> doing will never write combination of it with recurse-submodule
> option?  If so, we'd catch a notice developer breaking the system by
> having a sanity check by detecting it as an error, no?

Hm, I suppose that is true, though I have some reservations. In
particular, I'm not sure if the argument you are making is intended to
be specific to this combination of options, or all incompatible options
in general.

I think it might make sense to check for this specific combination of
"--negotiate-only" and "--recurse-submodules" because where the stakes
are low and behavior is reasonably simple to understand, though the
payoff is also pretty low.

In the more general case of "Does it *always* make sense to check for an
invalid combination of options?", I find your argument a bit troubling
because it seems to imply that anything we add to the Git CLI should be
treated as if users will depend on it. This seems like a needless burden
(or even an antipattern) if we need to fork a Git process purely as an
implementation detail, but we have to treat these internal CLI options
as user-facing.

But maybe I am misunderstanding how Git treats CLI options in general?
We don't ever really hide CLI options, even if they are only
internal. There is PARSE_OPT_HIDDEN, but those still show up in usage
and documentation [1]. So we actually do want users to know about these
implementation details?

Presumably, the thought process goes something like this: if we add an
option, a user *could* find a use for it (or it might accidentally
conflict with a user's flags), even if we never intended it for end user
consumption. Thus we need to treat all CLI options with care.

Is this a more accurate description of how we think about CLI options?

[1] This statement doesn't apply to the -- commands (like
submodule--helper). Those are 'truly' hidden because they don't have
public docs AFAIK.
