Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C76C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAC72078B
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 10:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/FzD+5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKVKVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 05:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgKVKVU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 05:21:20 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841FC0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 02:21:20 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so14789613ljj.6
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ghzi61eHS3W+fOQVEvy0UM24hqQVZxjLEJAxijx6PvU=;
        b=a/FzD+5Ky1lhYaAu7SXyuAgaqXUQkRoIM8ut35+h4T/0VkFDz3J2gKjbMs/vk07ezF
         ywFFYAq/DC6oIESd5BgDR+UhLOb3c0mKmf6Roe2B8HVLhb5WIDYYlVhhEZRPNeNlE/+p
         8uGd1Ao2AHowxIWwyZEN0k48Wegi6XgjaOJ8Mw4RW0qiymhkevay+66CQKQK0DPCFTMp
         0xLG4KTvNRVVIHVvLEiXFnWhTETQLj744H26cuTqi+MzmDsaMnwcTU5dg03yKg/s6RFh
         Klvj8Vpbje8+y1L3xQKR9RIxEvsVLk7jho+RtNEJE9ce8nZfAQBz5iIVhyrwGZysUEvj
         h/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Ghzi61eHS3W+fOQVEvy0UM24hqQVZxjLEJAxijx6PvU=;
        b=KSQWAONxMqsLLNHBHbtZmXBp292zM7ylqfP9GxB8J/YztphevFt0b9QQOVcqMHB65b
         +KORBpH9ZG76KieCMALVAWSFygga3Ki4eOfTeLlZyLt95fB7OM4IBUyE4TMUAHw2Imai
         Vac5bzXjeDNGhL2+zqzyY2qIDq8EFDQvgL7hJ1C/cmjv8vBFb4vuKyhGSraiL+QjZazQ
         tGWrbPJjpoi+6JoIwUWUyGraDKSN5OEMoz3jGkZSTsKGKoOXSqIM+q2H3XPNRXMwNdjH
         Pja+FJKo4OgUbUAbGSakH2TlxRMUJ5spyiiYdcLe1eZLtadjJlhyzV494HRtC5xMO9Zg
         SqZQ==
X-Gm-Message-State: AOAM531iFel3YTjXSdfyUtu8vatbUPfbAj+6al2B7bmo8hgbMhNqM0DF
        M3yDpDGRDNVeufacSC2BNv2I6vwilOw=
X-Google-Smtp-Source: ABdhPJyc+VV0zIZ3mhIM6p85jnwoDn/+rvJFzpADYAI0QloNsnr5FzjeJLxJXOoNfGgLIAtEaGZ78A==
X-Received: by 2002:a05:651c:118f:: with SMTP id w15mr11709883ljo.225.1606040478826;
        Sun, 22 Nov 2020 02:21:18 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 187sm999888lfl.117.2020.11.22.02.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 02:21:18 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
        <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
        <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
        <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email>
        <871rgpr497.fsf@osv.gnss.ru> <xmqqpn46qppl.fsf@gitster.c.googlers.com>
Date:   Sun, 22 Nov 2020 13:21:17 +0300
In-Reply-To: <xmqqpn46qppl.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 21 Nov 2020 15:01:42 -0800")
Message-ID: <87y2it8zfm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> To me "not on a branch [tip]" is also confusing, as in fact you are, as
>> is easily seen after you perform a few commits, and now HEAD points
>> directly to the tip of the branch (that has no other references).
>
> Aren't you confused about what "on a branch" means?

I believe I'm not.

>
> After either of these two operations, your HEAD may point at the
> same commit, but the former is on a branch (the master branch), and
> the latter is not.
>
>     git checkout master
>     git checkout master^0
>
> The difference between these two states does *NOT* come from which
> commit HEAD points at.

Sure.

>
> The difference comes from what happens when you make a new commit
> starting from that state.  The former (i.e. you are on a branch)
> grows the branch.

Sure.

> The latter (i.e. you are not on a branch) does not grow any branch.

That's one way of looking at it, resulting in this "detached HEAD"
thingy that is too technical for the git user proper, I think. Moreover,
it immediately raises the question: if it doesn't grow any branch, /what/
does it grow?

Another way of describing it, that I prefer, is that you /are/ on an
/unnamed/ branch and new commits grow this particular /unnamed/ branch.
No need not only for "detached", but even for "HEAD" to be known to the
user to get the idea, I think.

>
> This is an unrelated trivia, but did anybody know that we were
> pretty much on the detached HEAD all the time for more than a month
> of early life of Git, until cad88fdf (git-init-db: set up the full
> default environment, 2005-05-30)?

I was not aware, and it seems that in my terminology it'd sound: "Git
didn't have named branches until cad88fdf".

-- Sergey
