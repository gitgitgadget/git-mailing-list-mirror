Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294FDC7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 16:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjDUQuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDUQuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 12:50:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AE8CC0C
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 09:50:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso1835652b3a.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682095801; x=1684687801;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlC9ABpyUUdUqsXwx8i5g1aVpEF9pFW0pxjN7SFTorg=;
        b=WaW1xloBYWGq6/9kKvsnI2boqdiuvM/l83XtBOBo04+6vDPdq/XZV1jtkqTr5wHRJH
         /lr2nZAo8h7hTbO7pn5uYPSa6d3sX1sZcJFZBHB8XgdCwCdewZalbXAWjWNoMFy6rbpH
         tMrmkm96GRGDsr135Rvu8IJiiwfzECB4R2UYXKVoFcI/O15sGQRGcKDywmm/icWUnT+P
         Lc6ic0hLCsjZtU3wIRkG/f02zPPkBvVmedDc9S24oH7BENchJSZbuHDh/zBwQ0wkNw9A
         b3IgK4Qh/fpp6zEvP/c8sfR+vawlUWF8K1NmNNrGbAV0l0SxpzMf0DkIYFhZEsHxeUHL
         cqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095801; x=1684687801;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mlC9ABpyUUdUqsXwx8i5g1aVpEF9pFW0pxjN7SFTorg=;
        b=lIeDv8P0a14ci6Wk1V5KQ0GljOB1gnaYqUDw3V6CYTSl8oUw9JuJQzwfSI4ZPZUOmm
         0/qzNvK8KK5X5whhqhCAARpRYpIgkcsl5XFIWe6FQxi4pjvFMNSilEkWp5MHEsl7IG3K
         xlqRQhvqUKo7qjw++vmxt0jEDlvUa0hJ4Mu41WYJjOhA1j18RjwQYt4HszwOUgfEbUBH
         Jzj2E0JkXF3m7ku0inkVUoQlY0BDpBzQPNTrXPD36WdxC5iDjNqGrszZxqrYd4npppoK
         MXyFLuu77klGbiZn9FOb0mr2TBfBJNlZpPhcjOqM1YlO1BbxVydxU5U/QUQuI1QOqabX
         uFIA==
X-Gm-Message-State: AAQBX9dqgeOAA/oKJMwW2stKF0UcSJv1o7rbdfGjOVgUutjF/3orK+It
        GQF1N+O/R04yOHQ+Q4m98uxXgfa5veQ=
X-Google-Smtp-Source: AKy350Y6bSrDO9ddCfFOmJvonXgo1VBQjsVecJGY4H6OaSfs1qtsIcI48JQYe10qCcdULIkuHrSoiw==
X-Received: by 2002:a05:6a20:748e:b0:f2:b156:d217 with SMTP id p14-20020a056a20748e00b000f2b156d217mr1950550pzd.45.1682095801282;
        Fri, 21 Apr 2023 09:50:01 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b0063799398eb9sm3249235pfe.58.2023.04.21.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:50:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential: new attribute oauth_refresh_token
References: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
        <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 09:50:00 -0700
In-Reply-To: <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Fri, 21 Apr 2023 09:47:59
        +0000")
Message-ID: <xmqqildpkwnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Patch v2 adds an additional test

What we have below shows some differences outside the test, but the
range-diff I see locally does show that the change since v1 is
purely to the tests.

>  Documentation/git-credential.txt   |  6 ++++++
>  builtin/credential-cache--daemon.c |  3 +++
>  credential.c                       |  6 ++++++
>  credential.h                       |  1 +
>  t/lib-credential.sh                | 30 ++++++++++++++++++++++++++++++
>  t/t0300-credentials.sh             | 18 ++++++++++++++++++
>  t/t0301-credential-cache.sh        |  1 +
>  7 files changed, 65 insertions(+)

Will replace what I kept in 'seen'.

The original unfortunately did not see anybody interested enough in
the topic to review and comment.  Let's hope this time is different
;-)

THanks.
