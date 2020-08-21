Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E8C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E86B20724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHUViM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:38:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34348 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHUViL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:38:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id bs17so2759343edb.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB9k5LXlqccNPw+HV72uBu5C47R9sBb5wogQn1Oxe2s=;
        b=Ptpc+XR4oWXWR/Rp4JACZCL7Qk8516VU6Cp8B6fE3DxorXYyaeqcE7zQJvYmGdw0ao
         L9sIfWlXYS57sb4UAlAHjLQL/nZ2aVPI0q4NdJFDgD153IXYsoPH8Sz73npl2zj9O1Dl
         Uv9KbVBkyVsP8F1jB96ektW2xgNMa/mCUWWAFgOQGZZj77VLvleXy4c8nCuFvOHZAqHV
         VfTe375UNgbNxIWHHFAAOdOTDKGrqeT/rldop06ZQlhyg3sV/M7X++Szj/3vIZZz685m
         TkjPeVmnzt/0CL6tbvoCK/M5oK25IPSTClrB26GX3Xq5lZGXFY5uyTuj+tEE0iXrlThA
         Tzzw==
X-Gm-Message-State: AOAM532Urt6Pw4zM8HAakzdSuMLgIyqoP3YamhlfHfBc7CGMasZ9y9iV
        2D54L6Je+Fq0rM0oxGEgWYyIb3La797h6qMS8mM=
X-Google-Smtp-Source: ABdhPJwh33OxO9pRwJpZELbxGh/R/twLfzTbzzqlawdtz0GJEZBG7GdoGHhePwfUCjk5bPtYi2+QeXXO/VwcZDa2hpk=
X-Received: by 2002:a05:6402:1016:: with SMTP id c22mr369796edu.89.1598045889115;
 Fri, 21 Aug 2020 14:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
 <87ft8fvoow.fsf@igel.home> <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
 <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com>
 <xmqq5z9b91o3.fsf_-_@gitster.c.googlers.com> <CAPig+cR12i8KQjiWYm8DGuAc9BfJqanmNBZcZfwHGsrt2hW3Dw@mail.gmail.com>
 <xmqq1rjz8zy7.fsf@gitster.c.googlers.com> <CAOW=8D1nFgRRPyD7yxW2X7ZcAA3yaMzWJy7B3ykuPBJk3t8X5Q@mail.gmail.com>
In-Reply-To: <CAOW=8D1nFgRRPyD7yxW2X7ZcAA3yaMzWJy7B3ykuPBJk3t8X5Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Aug 2020 17:37:58 -0400
Message-ID: <CAPig+cSLxRVufZcnXa6JAbP-SYX486OebDS5hYjEhH7jaNgM5Q@mail.gmail.com>
Subject: Re: [PATCH] ident: say whose identity is missing when giving
 user.name hint
To:     Alvaro Aleman <aaleman@redhat.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 5:31 PM Alvaro Aleman <aaleman@redhat.com> wrote:
> One nit though: There is no `--committer` flag for `git commit`,

Indeed, that `--committer=` was a last-second edit (without checking
docs). How about this?

    If `user.name` and `user.email` have not been configured and the
    user invokes:

        git commit --author=...

    without specifying the committer, then Git errors out with a
    message asking the user to configure `user.name` and `user.email`
    but doesn't tell the user which attribution was missing. This can
    be confusing for a user new to Git who isn't aware of the
    distinction between user, author, and committer.  Give such users
    a bit more help by extending the error message to also say which
    attribution is expected.
