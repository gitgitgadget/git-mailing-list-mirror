Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38243C6FA99
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 00:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCHAOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 19:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCHANs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 19:13:48 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A146C58B64
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 16:13:43 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v15-20020a17090a458f00b0023816b2f381so5770678pjg.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 16:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678234423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdGpg+VHfblZTyhARJ7GTgI2+UwswrpREOPBsI218zk=;
        b=rWuuEv3BDH0viww3KAhVHxFWOWdEcKUlhxehQEDBAJ01hg/ykoYkk1ODwxwDqpVkS6
         mqh+zfKSxrC5R7V6trYM623KufJh+2Liz+BNAPD+vW3P25XlbhRKnL505SqQtRoW2+T8
         P7OfDeSmulobT8XTLSpp4aOLImIR2KSMeJOJO479wYR7p1OtZ9Zo9HZUFYPVrYNIE+i2
         7MHRpZiBMSJ7slJ+Rbduzgn2sOJ5MpfiYk5zQzOFVw2vODCywkMNo/ggfwTjGVCuMQur
         TFFst8WuYddso9oWYfyU0zf1YtDBKOwuDvVH0Hgbd+csFxdEeHjx2YAflQw/7BRJYcA8
         CecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdGpg+VHfblZTyhARJ7GTgI2+UwswrpREOPBsI218zk=;
        b=Q0wWPsjax9FwrJ3Siut6DRw3k/muRViu9K15KRH1g3OGW/1sdk7mOCMhsM3Ce5I3bq
         ELfph2MdH+b5KKlPRP1HC9kNaTr0Jt387enwfsgIrCxtuTfBkyQ8qODzULXwQneg4nLA
         WXukF3VV8cgdKuWHDE6siNVqPWLCRF8FVIospY5tc0Y77KbW9Xw77s6ma2ELA+olS6fa
         H6BySs5STemtI6cgjmsYGuzrwsayMeqkrqyOXc3abFTuOHZIfgev/Y2LOBOvEp7Zg9Ei
         drbrkEKGOrONPDSbzMiZDrNVDzEWMQN5H4TsqrcYApyiGYVlnGBFfgynD6iwtX7E3G9U
         jO8w==
X-Gm-Message-State: AO0yUKWAN0+ZPUwFxi7/wL98n228vQ3SaMhuSvFk6wmORdrUzBXpFSKd
        RD1UtrmGfi23gYBYqj5b9CriCEK8LOYdLA==
X-Google-Smtp-Source: AK7set9z9SRwceOnB1P65RjunIKg8T0/ZjbLFfcaRPh5jjmCzDnYWESn6aK1gYTFFkHtWQz6kP5/T+M6vD44mA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a62:ce43:0:b0:593:dc61:2161 with SMTP id
 y64-20020a62ce43000000b00593dc612161mr6798609pfg.2.1678234423118; Tue, 07 Mar
 2023 16:13:43 -0800 (PST)
Date:   Tue, 07 Mar 2023 16:13:41 -0800
In-Reply-To: <20230305050709.68736-1-alexhenrie24@gmail.com>
Mime-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com> <20230305050709.68736-1-alexhenrie24@gmail.com>
Message-ID: <kl6l1qm0hzgq.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a config
 option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Changes from v5:
> - Add commit message note about --no-rebase-merges having always worked
> - Add commit message note about the test for --no-rebase-merges being
>   somewhat contrived
> - Rephrase the documentation to avoid using the phrase "By default" with
>   two different meanings, and in so doing clarify that --rebase-merges
>   without an argument is not the same as --no-rebase-merges and not
>   passing --rebase-merges is not the same as passing
>   --rebase-merges=no-rebase-cousins
> - Add commit message note about keeping --rebase-merges="" for now out
>   of an abundance of caution
> - Rephrase the warning about --rebase-merges="" to recommend
>   --rebase-merges without an argument instead, and clarify that that
>   will do the same thing
> - Remove the test for --rebase-merges=""
> - Rename the config option from rebase.merges to rebase.rebaseMerges and
>   explain why in the commit message
> - Add commit message note about why "true" is a valid option for
>   rebase.rebaseMerges and why --rebase-merges without an argument does
>   not clobber the mode specified in rebase.rebaseMerges
> - Rephrase the documentation to clarify that --rebase-merges without an
>   argument does not clobber the mode specified in rebase.rebaseMerges
> - Add another test for incompatible options

This version addresses all of the concerns I had with the previous
version. Thanks!

Besides the concerns that other reviewers raised and a possible
mechanical error, I don't have any outstanding concerns. I'd be happy
to see this merged when those are resolved :)
