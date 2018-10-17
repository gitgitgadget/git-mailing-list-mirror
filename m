Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672461F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJRCLg (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:11:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33172 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRCLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:11:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id 84-v6so17122955qkf.0
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 11:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7P7lbHjNFTLd3aBZP5y3nDOiu9M78MrMDEsnmIj8hE=;
        b=t6Ca2I6KZYoAaCmYjWNYpC+4dpTnmrqXKd/DN462/NSG1ChQ5aYDHDfP5DtDpuuCoy
         dGkuCtrwzWyVl433UwySsreAco1OmKJPVTsSfv/XprOyFheBRwUnmEL8bL34O8Rm09j6
         zctT97mw+kN8Q7xHYTmfDxagvLqTh6Y4an0vqWbgyH3pbyTR6khnBeOhJlSaIKzOGHjp
         xLLXg2XFmBrNIZ5p5E7YUhsU70VFwQtYunlEZu0Cg4zEPFEw49ZuHwDBwdQoF16WFS3q
         m8VotK3MY5IsDeiPTaRmhrY0r42ReocPiyFqkCj/fi11JKxumQuZvj0CWn+CYpo9ol9b
         vFBA==
X-Gm-Message-State: ABuFfogRpT7kd9YOciHm18SYZaPnxBZHfT5lPE32UftBzBXCzV+cKGz8
        akK7LA+aQmrIfd3g1HsHQ6MBX2JCGUTY7EXVx1E=
X-Google-Smtp-Source: ACcGV61vpaLU9fJnICqii7rQiF9fbreXNkFWj4ss6cnXS61hA2IvwXrC1OcFIhvL1usiMCVHh/kPg2zaGqTy5c0t2VI=
X-Received: by 2002:a37:9f90:: with SMTP id i138-v6mr25086174qke.152.1539800084240;
 Wed, 17 Oct 2018 11:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181017164021.15204-2-peartben@gmail.com>
In-Reply-To: <20181017164021.15204-2-peartben@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 17 Oct 2018 14:14:32 -0400
Message-ID: <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset
 when --quiet
To:     Ben Peart <peartben@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 12:40 PM Ben Peart <peartben@gmail.com> wrote:
> When git reset is run with the --quiet flag, don't bother finding any
> additional unstaged changes as they won't be output anyway.  This speeds up
> the git reset command by avoiding having to lstat() every file looking for
> changes that aren't going to be reported anyway.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> @@ -95,7 +95,9 @@ OPTIONS
>  --quiet::
> -       Be quiet, only report errors.
> +       Be quiet, only report errors.  Can optimize the performance of reset
> +       by avoiding scaning all files in the repo looking for additional
> +       unstaged changes.

s/scaning/scanning/

However, I'm not convinced that this should be documented here or at
least in this fashion. When I read this new documentation before
reading the commit message, I was baffled by what it was trying to say
since --quiet'ness is a superficial quality, not an optimizer. My
knee-jerk reaction is that it doesn't belong in end-user documentation
at all since it's an implementation detail, however, I can see that
such knowledge could be handy for people in situations which would be
helped by this. That said, if you do document it, this doesn't feel
like the correct place to do so; it should be in a "Discussion"
section or something. (Who would expect to find --quiet documentation
talking about optimizations? Likely, nobody.)
