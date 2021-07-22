Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77130C6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 01:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5284560698
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 01:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhGVAnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhGVAnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 20:43:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E822C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 18:24:28 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c197so4903637oib.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 18:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FC149rhDyUhPFhWJAQ5URNMd2GywkdujlIYR5w78wFU=;
        b=ZziQCo64OBkZbOXlNY4C/4Kx9IHV5QpKnv/uBR4ytFf0sK1uzHBPS845onHBIOjD68
         z3hQ02ZJFNJQ78jBlS52Y1Wu9bSy6R4OBWteSJCJQRrHwLSnIy/Xvpj2+ok4QoYH2Kwr
         UDHmpJ+gEto5C+6G7vB9++cG7tMT7jsqFXa9c7ggJmH/ZJyWF1VxixDA9ir2N4i/IV0R
         9S8f613/emG/8Cu63lEnFcoFpYsu164Zhh9fn/Nqsj9JVgVFRwyO3mOhB2aXS+PHPjFL
         /vaOJhwc/NfqVCqJo/Ti2zJbo8vP2O85BEL+x55OoVMb3sceUINF8M6MKaOWtTHVme41
         V5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FC149rhDyUhPFhWJAQ5URNMd2GywkdujlIYR5w78wFU=;
        b=Pu7yuTVQMumrVVk7eM3ThupgoZmiWj1XgQ6A5MSX+jO+NRQWCY72w8vA1j65Yu9AN7
         v3K7V1GUDKHyKCoF1fDSMfF4g0TfjJ5V0fV7m1iKFGAF4lDjN+owh9HJ8qI50UNCchbl
         D0knyGCJ1kfAio4uIE9EH/pRht9KuY2v9gIxop1sASiMFCfu4ovwkaDFMJyGyuC0jBRy
         fdAg052yneMBsvgEjOJjGsdhWr3eun93ein8vyEcjyd/a4jj+rEofci8nGWOgYFZJhmq
         ZiFkNZt6KSitbYhkWxvPsF1Av6xtjC9OFhPdYvjt9oLS7q6AS7NocAHyfE6XItfpBcHj
         lJOg==
X-Gm-Message-State: AOAM531J1fIK7Qm7fu1vZ0aTTUb2J36U5dqFgXrzLlXhF08myeTUdRMn
        NIGDUbDWRi1ux8rkoOHCCmc=
X-Google-Smtp-Source: ABdhPJxNEdK7kZ+Gk0ARqdqDj3hvGLDdzfuoOS4ciyqlbrdQj5oaYEycIbHdxavcRR1FwWdtxEHolQ==
X-Received: by 2002:a05:6808:d53:: with SMTP id w19mr2869087oik.48.1626917067421;
        Wed, 21 Jul 2021 18:24:27 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s24sm3681204ooq.37.2021.07.21.18.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 18:24:26 -0700 (PDT)
Date:   Wed, 21 Jul 2021 20:24:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Message-ID: <60f8c8c92a215_1d0abb20859@natae.notmuch>
In-Reply-To: <xmqqtukn9p0g.fsf@gitster.g>
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
 <xmqqy29z9r94.fsf@gitster.g>
 <xmqqtukn9p0g.fsf@gitster.g>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> >> index 5c3fb67c01..7f4b2d1982 100644
> >> --- a/Documentation/git-pull.txt
> >> +++ b/Documentation/git-pull.txt
> >> @@ -117,7 +117,7 @@ When set to `preserve` (deprecated in favor of `merges`), rebase with the
> >>  `--preserve-merges` option passed to `git rebase` so that locally created
> >>  merge commits will not be flattened.
> >>  +
> >> -When false, merge the current branch into the upstream branch.
> >> +When false, merge the upstream branch into the current branch.
> >>  +
> >>  When `interactive`, enable the interactive mode of rebase.
> >>  +
> >
> > Looks correct.  Will queue.  Thanks.
> 
> By the way, I'll update the proposed log message to say only that
> the documentation needs to be fixed as it does not say what the
> command does.

Fine by me, although I'd appreciate if you minimize the use of your
words and maximize the use of mine.

  The documentation says --rebase=false merges our current branch into
  the upstream branch, and while many people think that's what should
  happen, that's not what actually happens; it's the *opposite*.

  Fix the documentation so that we explain what the code actually does.

> We should be able to fix the inaccuracies in the
> documentation quickly without advocating different behaviour or
> trashing the current behaviour in the proposed log message.

I'm not trashing the current behavior, I'm explaining what the consensus
is. I spent several man-days re-reading old threads, and this is the
consensus of what should happen:

  1. git pull              # merge HEAD into upstream
  2. git pull origin topic # merge topic into HEAD

Of the people that expressed an opinion, 100% of them stated that what
`git pull` does in the first case today is not desirable.

> I also happen to think that "flipping the merge order" is not a good
> thing to do anyway [*1*]; keeping the log message to state just "the
> description does not reflect reality-fix it" has the added benefit
> that we do not have to debate it.

But people have spent many hours debating it already.

Yes, you are correct that if *everyone* followed the topic branch
workflow, everything would work correctly, but that's not what happens
in reality, in reality people do all kinds of workflows, and wrong
merges are pervasive.

Everyone--including Linus, Jeff, and you--agree that there's two
different ways of using `git pull`: integrator versus developer.

When a user is doing `git pull` to synchronize changes to push to the
same branch, that's a centralized two-way workflow, so he is acting both
as an integrator and as a developer, and it's in that particular case
that the order of the parents should be reversed. Everyone agrees on
that.

When the user the opposite explicitely: `git pull origin master`
Linus calls it a "back-merge" [1], and in that case the order of the
parents should not be reversed.

This has already been discussed many times, and the problem remains.

[1] https://lore.kernel.org/git/CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com/

-- 
Felipe Contreras
