Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F9C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C21613F0
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhFXKqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhFXKqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 06:46:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8AC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:43:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t3so7817037edc.7
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tTsOMzxzkdhNKTD4DT//qZWFK+cbGaliXM4MWOJpOaA=;
        b=qm1RZDc4ww6yPOvZoeqPHCf1Og70BkBHeTmRKg6/kAY7CfgnYCl2UQ7mdsDH0TQgrW
         FkXDWcsYkAVueq6ZOKcPsCWp7/6/0Tog2znftZVu9qMsniePNWPBjM9BB8g/fprRhBEy
         5eYsmn6uSBez7359TB3dQ/N3y9RNmVnepa5dEu3kHcQdKgYk3aZrYuc1Gsf+dLKC1cuW
         0qf1OTDZYIf54X0YeKJb9Y/P6NfySGvBTErh9jdF3v3pRx6ZVl7+lsP/dK/ApMIE6Yef
         w3yWdtDa2PMwOrGRfv3dJpZvrN9XQ1Xv6Kmz+NMLVX59ajbanYyjVOq35lmjMMJ72MU+
         HSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tTsOMzxzkdhNKTD4DT//qZWFK+cbGaliXM4MWOJpOaA=;
        b=KQaympuQQXz/QKrIWv2fzTjZgj7hxv+MMvjkDGIOAk7zGxlBu5zifrYcYrrB2kXIej
         kTxyw1Piq5gGYgq4IGKRuM06d0uC8cfozPEhUAVFGGoKACHOp9/vz56xA096eyoK7OoU
         IJN43TMMOkOZZoRtMmJW1ajf1BlqDHrg8H2ibI2mr17jY2DxzvIGvz4WMwE1Oj+hp8Ii
         l0ZSUpJ2VVT6C6ky5wvJpAzaQ9KNJ2PHMvW/iIOBEAGG2envz2D+/hdR4qJ/6t/7yWw6
         GBuTFmUm35olUWfNTTReI4Vk6C5W0/sFjIpw8YI85hPq/fm9faE+CpdWMIoUoJ3x5aeq
         qPuQ==
X-Gm-Message-State: AOAM531JklHWT4xb9Z6foKsRuVlAwpL4Ft3yzyhb109Dh6agpK7vqzMC
        OlxkyIwwF4MsSeL7DLx8e+0=
X-Google-Smtp-Source: ABdhPJyvz3tMh1HB1Tmhg+4hyDt7YB5+E0NtVFTBQz7xuPb4evC5RcnmIZ+DeNmQYsjQobfTlamTNg==
X-Received: by 2002:a50:b2c5:: with SMTP id p63mr6152944edd.5.1624531436507;
        Thu, 24 Jun 2021 03:43:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z27sm1015008ejl.113.2021.06.24.03.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:43:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/4] WIP/POC check isatty(2)-protected progress lines
Date:   Thu, 24 Jun 2021 12:43:30 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210623215736.8279-1-szeder.dev@gmail.com>
 <20210623221152.GF6312@szeder.dev>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210623221152.GF6312@szeder.dev>
Message-ID: <87a6nf1r10.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Jun 23, 2021 at 11:57:32PM +0200, SZEDER G=C3=A1bor wrote:
>> I just wanted to see whether it's possible to check all progress lines
>> and whether it uncovers any more bugs; and the answer is yes to both.
>
> Oh, and there is another one:
>
> test_expect_success 'test' '
> 	git commit --allow-empty -m 1 &&
> 	git commit --allow-empty -m 2 &&
> 	git commit --allow-empty -m 3 &&
> 	GIT_PROGRESS_DELAY=3D0 \
> 	git commit-graph write --progress --reachable --split &&
> 	git commit --allow-empty -m 4 &&
> 	GIT_PROGRESS_DELAY=3D0 \
> 	git commit-graph write --progress --reachable --split
> '
>
> The last command's progress output ends with:
>
>   Writing out commit graph in 5 passes:  80% (4/5), done.
>
> This is because since 53035c4f0b (commit-graph write: add "Writing
> out" progress output, 2019-01-19) we have assumed that the work done
> while writing each chunk is proportional to the number of commits in
> the graph, but with the arrival of split commit graphs and the BASE
> chunk in 118bd57002 (commit-graph: add base graphs chunk, 2019-06-18)
> that's not longer the case.

Ah, I encountered the off-by-something in that "writing in N passes" but
didn't find the root cause, thanks.
