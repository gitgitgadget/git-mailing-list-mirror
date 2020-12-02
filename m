Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E76C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372F22086A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgLBLu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgLBLuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 06:50:55 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B665C0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 03:50:15 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so4135942lfe.12
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 03:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u5BYeSxeOb+zpjDu7PMQpGVi92H6GVJiuNINqL/BeBE=;
        b=aMIo+WsNwoVNlbQd1kXHO0gbQn/RH/69MxuhUA4Ks5lm+JZEuSb08y7cYDDUhEN08h
         wjDUkaMV6ucBbK1rlnFJwi6Xcg1J8r0xBsO4yvV9eQNLfDyNomgFyopLn3nur2I3VP5Z
         GhZVNtfSVTYeewbt+xQMu5S/SdBhP2orvWow2zbvJe/2MTmnjPhpXZOT61AhMSHaM1uI
         9qBfaEmAptA8P5DNaBr02/OtCDdnghaWROIx/srDlwa8HBkFWdvwdD8ywHYRm78FVDp8
         QfAQlLOqBBBJpuBEO5q3roA3t5uCK0pH+sUaAPIl3bY4Z/uN4WmHhTEEqUH/jTpI4l/i
         u/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=u5BYeSxeOb+zpjDu7PMQpGVi92H6GVJiuNINqL/BeBE=;
        b=osha8fVhpwrISWPPaqEh82DJoWksAVlHYk8StHh1IL21FzUxqNdsm0zr1rBGT8Fupl
         39/wWqa1BS5jysJdTCO+rMYG8edNyrGTO7vhy1rG3I8jTrfTkfdVV7aY5mX2MxUzVqVK
         LWXQN/ub0fjt0EFEqPXftp9Lwgn4wkulMDPWD2oNivKR3g4cATsU7BAEpOohln+s1uyL
         VI9mE5xZ8HNEAUF2Y/iBT45dwtViLGKoomTtEFq3qCwkzL9m5oVF33pD8bLs87Kd7kre
         /WrmmqWMA3j/4c240U/PMCx3U/6JMzKp08K88MuyPGamnpGA6rgLXEP8tL20fuduHC4H
         TTvQ==
X-Gm-Message-State: AOAM5300JFOwOFxKhcp5Es1tZAgDlhTaO6HWhSs8koKCwDIwIOrOHxtO
        XAElZ0MUr0HB8c0HY/ZruGQ2e8t9cb8=
X-Google-Smtp-Source: ABdhPJy1pM0iZ//ghVz1q2VlTocAqvFLqSacDyQMN2pqwVPOuS0tYV6pkZ0GjmoAgfDEmeOlUVe5eA==
X-Received: by 2002:a19:cc2:: with SMTP id 185mr1090330lfm.318.1606909813622;
        Wed, 02 Dec 2020 03:50:13 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 84sm386125lfa.39.2020.12.02.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:50:12 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: improve "branch" definition
References: <87blfnhm8w.fsf@osv.gnss.ru>
        <xmqq7dqbn1nl.fsf@gitster.c.googlers.com> <87im9vekzf.fsf@osv.gnss.ru>
        <xmqqr1ojlkng.fsf@gitster.c.googlers.com>
Date:   Wed, 02 Dec 2020 14:50:12 +0300
In-Reply-To: <xmqqr1ojlkng.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 23 Nov 2020 15:26:43 -0800")
Message-ID: <877dq05swb.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> But do we need to say "a separate line of development", instead of
>>> just "a line of development"?  What is "a line of development" that
>>> is not separate?  What extra pieces of information are we trying to
>>> convey by having the word "separate" there?
>>
>> I think it tries to convey a notion that 2 branches represent separate
>> lines of development. I.e., that the whole purpose of branching is to
>> provide support for independent, or parallel, or /separate/ lines of
>> development.
>
> So in the context of talking about a branch, there is no need to say
> "a separate line".  It only starts making sense to use the word
> "separate" whey you say "this is a line of development.  By the way,
> there is another line of development that is separate from the first
> one".

[...]

> In the mental model of Git about branches, I think the only one
> thing people can agree on is that a branch points at a commit, and
> checking it out and making a commit on top of it will change that
> branch to point at the newly created commit.  And this view supports
> the word "separate"---whether you have two branches pointing at the
> same commit or a different one, building a new commit on and
> advancing the tip of one branch does not affect the other branch.

So, what do we finally do? Just remove "active", or replace it with
"separate"?

It's fine with me either way. Will you just fix it yourself, or should I
re-roll if "separate" is not accepted?

-- Sergey
