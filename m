Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69A9C4708A
	for <git@archiver.kernel.org>; Thu, 27 May 2021 13:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94D7613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 13:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhE0OA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhE0OAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:00:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B376C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 06:58:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i13so947817edb.9
        for <git@vger.kernel.org>; Thu, 27 May 2021 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VLZOa776GOuVMKskVxdjHXZmHFVTKX6fNTuia9t4LbY=;
        b=cTd9cQ9PgiKe1bu1sMJEJlpiAHX2KQVpgW7f10wCQmzZhSJGVNbPSu82UEfUfda15n
         pDOKHb29Bxk0C1FDPTTSV+psWpAhQqdgpBkiHHBj10GM2BqOrVqBETfpcXE3O0iils6s
         8tH2u6+JuHh/q7xvn7DgQKYSopp0SXl9hh7UnxPzvCSEwzTpaJglbKKKH5GoWxIoTId6
         uoW4OWTQxl2zSypWG3AX5py1qeuHu9LK1eM9tRilrHxV89OkkosBWQOVfcAA49tVGXg0
         +E7rTU7uTcq2nN5AaPyq7Otd8o/jqkPbJkjDY/VnJIweRu9Up+VLbimFjc1Feb9JmNrq
         UwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VLZOa776GOuVMKskVxdjHXZmHFVTKX6fNTuia9t4LbY=;
        b=jHOMeqtX4O9b6Cgz1v7mtWjyCfNx8/C0bv9/057u2UZWXP2KMVu2xxEVaDptXx+VpC
         PMQGcgcpJv5FiSZPd9jATIvT2rT8K9Y0LN40FuT9JIrGkM5dIT2XcW/eejlkWqnNMdko
         RaLBfF4e/8Xo+RvMGCuagDZAtQywVuL5iaP3TCeoG+lVrZGOOud2WUiqNOZbV1eSwPxe
         ASPoZgJauax0KRb5+LAhLE+SHU9d4mjJRlEfMBOZgVTHc//8Bc+PzbE8hfWPmExLVhTz
         feqcPMa7gUAJcZRla+3eSnmznzGiyEBM9R0rtTgXxO0nr8nG+z2L/Mm/P6Ye3tbu82rt
         UwEw==
X-Gm-Message-State: AOAM533FQJvhOQ0QC4VtWdb0wnT77v+6fpIHzmx2sOJfqizyd6D94asS
        Qou0yo5qvE5I2fNE89a53xQV6ZQKBBIyVw==
X-Google-Smtp-Source: ABdhPJwTpfJNWMVIl1Kq1msF1HvgO+h9F1wTomhYtDAV/zqzEILtNxJvsugHM1gZrsdZOlXgCJxvDA==
X-Received: by 2002:a05:6402:4c5:: with SMTP id n5mr4180213edw.322.1622123922572;
        Thu, 27 May 2021 06:58:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id sb14sm1041632ejb.106.2021.05.27.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:58:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v9 00/37] propose config-based hooks
Date:   Thu, 27 May 2021 15:36:04 +0200
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210527000856.695702-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527000856.695702-1-emilyshaffer@google.com>
Message-ID: <87lf80l1m6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Emily Shaffer wrote:

> After much delay and $DAYJOB, here is v9.
>
> - Addressed nits in reviews on v8
> - sendemail-validate hook becomes non-parallelized; updated to use
>   =C3=86var's updated system_or_die() function
> - changed strbuf to char* in hooks_list
>   - Attempted to do so in run_command's stdout callback, but this made
>     length protection difficult, so stuck with strbuf there.
> - test_i18ncmp -> test_cmp
> - Stop doing i18n lego in run_hooks()
> - Checked that run_hooks_opt_init() is always separated by a space from
>   variable decl blocks
> - Checked for early returns which may skip run_hooks_opt_clear(); this
>   resulted in minimizing the scope of run_hooks_opt in most places
> - Got rid of native-hooks.txt. It was a nice idea, but not attached to a
>   large and slow series like this one.
> - In traces, log the name of the hook (e.g. "pre-commit") instead of the
>   name of the executable (e.g. "/home/emily/check-for-debug-strings");
>   the executable name is tracelogged as part of argv anyways, and we
>   want to be able to tell which hook was responsible for invoking the
>   executable in question.

In v8 I had some comments about the overall approach here. I've got to
say I'm disappointed that that's neither been replied to or in any way
addressed:

    https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/

Also referenced in several follow-up discussions, including Junio's
comment of "OK, Emily, I guess the ball is in your court now?":

    https://lore.kernel.org/git/?q=3D87mtv8fww3.fsf%40evledraar.gmail.com

Basically I think that this very large series could be easily split into
much more digestable chunks if it were re-arranged. Right now it's
essentially a 37 patch mix of, in order:

 1. Design doc
 2. Add "git hook" with "run", "list" etc.
 3. Make that more fully featured, support config, legacy hooks et.c
 4. Implement parallel hooks
 5. Go through N existing hook callers and migrate them to "git hook run"
 6. Some misc updates, e.g. to docs

If it were instead:

 1. Add "git hook run", only supports "old/legacy" .git/hooks/ hooks
 2. Go through N existing hook callers and migrate them to "git hook run"

That would be at least half of this series, and it would be much more
narrow change that would demonstrably retain all existing
semantics. We'd simply call our hooks via a command wrapper instead of
via run_command(<path to name>) as we do now. So we could have that land
and then focus on the actual behavior changes later.

In earlier rounds/the above E-Mail I asked something to the effect of if
you thought that was a good approach, whether disagreed, or just thought
you didn't have time for it.

I'm still keen to help get this in, but given the non-responses don't
know where you stand on it. I suppose I could re-arrange this myself and
submit an alternate "prep" series to rebase this on, but wanted to get
your take first.

Aside from the suggestion of splitting it up:

In the above referenced correspondence I expressed concerns that the
config layout you're proposing needlessly creates complexity requiring a
"git hook list" etc. command to solve, as opposed to not having that, or
have it by a trivial synonym for a "git config --show-origin --list"
invocation.

I'm still interested in what you think of that, as being able to
normalize that more invites getting rid of more complexity without
impacting the end-goal of hooks via config.

But in any case such a discussion could be had later and on a smaller
series if the refactoring of existing hook running was split up from the
big semantic changes here, which are currently tied up with that
refactoring.

Thanks!
