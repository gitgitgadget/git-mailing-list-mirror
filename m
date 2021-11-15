Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5D9C433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB9C63238
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351808AbhKOUhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350362AbhKOUXk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 15:23:40 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9138C06122E
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 12:09:02 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m15-20020a170902bb8f00b0014382b67873so5860294pls.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 12:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iri7lDV5AXRuWj/drzIobBG+5lgyo30REzcFzmhJvRc=;
        b=NQntJOsAPTJAmM42Q5I5hjezZni5g3z3mnGPHHfA0Xk24wgAjSTpJjd5LtH/EMjpiy
         qUUFc5F0YG/rAg7pTWrPZaCZsrjoSnojvB/mWkvUYLKKcauKu8+VrS63nL9st0UZojj3
         y2u3m8GuAlolPyy5hbheOInb0aJrkp3tLnRjsBeOp83/Nk1DqRP5Ezlbco4ak+9oVHjB
         IlF92nqtIY0d1+pAzwyRxqQvkum5Q9+K5xV7lgfHh9QQs5sKVd319dBEbytVg9a4iwbv
         mh+nUF+vmPmb5Lw+yT4sm9SvJ64DrAuzNHbbK1d7fwyuFsqc3BFK9rGi2G6PChu3fd1Q
         41Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iri7lDV5AXRuWj/drzIobBG+5lgyo30REzcFzmhJvRc=;
        b=4X0R2rS/BIQ3ShN2i8qg9Y0MuV4OUtDvew1r3cEaD9j2701kputMP78CIbtpDTd5Y5
         k+738pC8YE0T/Qxc2VYyBXu7VnsVVo6Hi4ieAEE9UuOkcgLuBRJKHnxvg1EBO+ZRBtZZ
         SNN6alUWCbZ0d8fvSaXcCai6y+0vHar1/mTfGuOQqRQruTVEmCddsdtPz6oeJHLVhtDS
         WY/aJSKiSCSx/WVLkKXheAIp3v1qWgn7fkamD0m98XyD7DC2PSqNdT/TKnYObico4dIv
         9UaQUUxhOV2diT/O2Rxw6jaHXbLVggZ6oOcS9eBbx6non2ff5EYuRPwXZVwh9kUwQs1o
         y+iw==
X-Gm-Message-State: AOAM533zSykhNv6Vl5bLyNxq0eY5VZbFuYj4nA76SScEgbfOCZSoiyJG
        Sh5zIMIvthtqlfDiPrcG+XdzURjO++zfNQ==
X-Google-Smtp-Source: ABdhPJyWUHLNOpQD7TfVV3EbwqIrWqCEBr9kro812Rn7KWvRKvrUkNCytiP/bbHVau6x3Z2Prb9sZjpdGJPjSQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:10d1:b0:47b:aa9b:1e7a with SMTP
 id d17-20020a056a0010d100b0047baa9b1e7amr35083248pfu.57.1637006942158; Mon,
 15 Nov 2021 12:09:02 -0800 (PST)
Date:   Mon, 15 Nov 2021 12:09:00 -0800
In-Reply-To: <20211115184252.1077901-1-jonathantanmy@google.com>
Message-Id: <kl6llf1ptc4j.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211028183101.41013-2-chooglen@google.com> <20211115184252.1077901-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 1/6] t5516: add test case for pushing remote refspecs
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is technically true, but reading the documentation, it seems that
> this should also happen when we're not in detached HEAD. Maybe write:
>
>   "git push remote-name" (that is, with no refspec given on the command
>   line) should push the refspecs in remote.remote-name.push. There is no
>   test case that checks this behavior in detached HEAD, so add one.

Ah, you are right. I was under the wrong impression that refspec
defaults to HEAD if HEAD points to a branch.

I will adopt your wording, thanks.
