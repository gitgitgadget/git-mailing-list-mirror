Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76523C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEAC61378
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhHWTio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhHWTii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 15:38:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF5C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:37:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so719192pjt.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iu9K1gqv48UMXrkcHr6H00GYLZ/jgo5Fl00Wj2yrxdI=;
        b=L6e7urxjGGOupOmlv7TGx3CmTi3AOMzYfjqnBohDmgJTtUEY9SoPjGoN9pdQdoJFi4
         jfHArV/hrh9bIQSXt0iqb8KdWi/3SZEjj2kxZE/LTodDUZ0b7CCX6oiSmpvKYI+Z5b7c
         JsGTwcB7XPVDdyRFvvaj8zk84OMe9HrLFQhMaNUqEfldHzWu3qCS2yukkJqUIgOqYkmD
         TnN02SUMw+aMmKS99/7vgTAmyc7lWv1lRAOH8G8cs0Zcy8gxIBkOF9iJci08wufX8IvA
         aI0+ckdp2U34P87Z33p2a8dAs8wk/kuSMiYqtyA83bRe8kL9S2qT5jA+oob1gUtQyzh8
         b6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iu9K1gqv48UMXrkcHr6H00GYLZ/jgo5Fl00Wj2yrxdI=;
        b=qJsSHB0xe7cbbkP1Is1DZki0JcdfGPXw70X7KABSUo8AuJc9hxKqGKvEeB3Qp0BqDL
         lH3vz7Ce7WdebZsRX2I/b4fFnLX/pwF2EKpWR9/FYiir8B/nQLX5HeVC93oTXjVP+zEn
         smqampFYx/UAWHPk80BiAAV6riKk3vnXYpCmsg1tlQ2fiknSXDMTErVy4FnXkKP3r2oD
         BWXB5LJtTfZGBCMXJAKD2L7OqW0Jnec4sdGbE10DfJ0feIvIg2XtOWq/kaDn+SGeFwdM
         5J0rPnR4eR7BC3vdc4ugVYhw/PTXvO2j0LOLOTWnvEL2hVYOmztejQFWRwFRzfLjDi31
         Othg==
X-Gm-Message-State: AOAM532z8M9a1zEqngN3Lc5Oh59z5smPgoSQEtTuIYcr2Iq79zM2hpmn
        233VTiOEqCs0Zgd7ZjpduQ9CYUz+TnZrC3sUak4=
X-Google-Smtp-Source: ABdhPJz5Y9IV2pQuPcBEOWTMdaT9uLY56WYcn3ks5YAIlek01A1w5Ylwkt0VVVPvZdwEsISLgVHro/DztbhBf6b/6F8=
X-Received: by 2002:a17:903:310a:b0:133:9bb6:98bd with SMTP id
 w10-20020a170903310a00b001339bb698bdmr7983656plc.19.1629747475050; Mon, 23
 Aug 2021 12:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
 <YSPuq/HmF3tnYHCA@coredump.intra.peff.net> <CAMJzOtz_h0iEL1VQCFvvLzw3XnL+qM=f+BvkmsTU=ps+0VA7RA@mail.gmail.com>
 <xmqq5yvwq7w5.fsf@gitster.g>
In-Reply-To: <xmqq5yvwq7w5.fsf@gitster.g>
From:   Nikita Bobko <nikitabobko@gmail.com>
Date:   Mon, 23 Aug 2021 21:38:40 +0200
Message-ID: <CAMJzOtwwxKz3_cgpOOOx-tYE-qHUyMWfXu+dKEBHhz2Aov4MyQ@mail.gmail.com>
Subject: Re: git read-tree doesn't accept tree-ish
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Have you tried `git restore --source=<hash> -- <path>` ?

At a glance, it looks what I am looking for

> Look for "--no-overlay" option in "git checkout", perhaps?

Oh, and it works too. So many ways to do almost exactly the same thing...

Anyway, thanks everyone for the help! My issue may be considered as
resolved. Now I will dig into manpages and experiments to see which of
the suggested variants suits me best

On Mon, Aug 23, 2021 at 9:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nikita Bobko <nikitabobko@gmail.com> writes:
>
> > `git checkout <hash> -- <path>` also doesn't work in my case because
> > if any file is removed in `<hash>` but not in my HEAD then `git
> > checkout` doesn't remove the file in my HEAD
>
> Look for "--no-overlay" option in "git checkout", perhaps?
