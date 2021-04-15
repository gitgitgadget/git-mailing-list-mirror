Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF59C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B397B6115B
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhDOPaC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 15 Apr 2021 11:30:02 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35401 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhDOPaA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 11:30:00 -0400
Received: by mail-lj1-f175.google.com with SMTP id a1so27591146ljp.2
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NzVIJ2Fu9zBQj+F7HhJ9v2MFocoSFIo3Fh632G45T8=;
        b=rTTWIygD94zYypctTZc/SyDjEFaDgd07nKtOamcoFHod4SyHx+u0kwkPqJ5wE4DvLX
         G++ubk1MyP2LDn+4JGFIJtQk1RuVJO4LRmuZm0ognUgbNj9+BgwA9C7zLdjXc3mcdJpV
         jYJGR+v/fjiYxADGA8toY8+WHItQk1dT6ArLNY3AEKd3GPG7129jx4P1W3/uMoAJvgdv
         UvdeY4IAsK1z67MN0z/bwFObpPhH6jJyYgZL8CRpHq8JacfgTqPk1NFxs9GMKOGUslLP
         qMh/EKpyjd4KLbKnL9GtQ2PIiUOP1irvIDKXzlZ+CFMRdYS4gsW+hse+pEo6ioy050pB
         ojfw==
X-Gm-Message-State: AOAM533krLsfDIvkdEeZvEnatlDFLQ5JJqKIsK5E0HtsKIoy2Cqp1cEC
        5nntdF60i3sKztnX0w6ZfNLh9GkjcsUgXW7mDm4Ss21wxFc=
X-Google-Smtp-Source: ABdhPJxRJZkVxIk0KtMFkPk04oMrQzFga6u/kAsmJjw8hK0DhoVwxCV9P9N0RpJGNHQQEyxLxfVZah5bcIvp9k/63ck=
X-Received: by 2002:a05:651c:312:: with SMTP id a18mr2176889ljp.52.1618500576717;
 Thu, 15 Apr 2021 08:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210415123353.14686-1-oystwa@gmail.com>
In-Reply-To: <20210415123353.14686-1-oystwa@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Apr 2021 11:29:25 -0400
Message-ID: <CAPig+cSGDULOmqqpxe4b+r0ML-dMqjzgOjqgk++9E2oW-pz+9A@mail.gmail.com>
Subject: Re: [PATCH] transport: respect verbosity when setting upstream
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 8:34 AM Øystein Walle <oystwa@gmail.com> wrote:
> A command such as `git push -qu origin feature` will print "Branch
> 'feature' set up to track remote branch 'feature' from 'origin'." even
> when --quiet is passed. In this case it's because install_branch_config() is
> always called with BRANCH_CONFIG_VERBOSE.
>
> struct transport keeps track of the desired verbosity. Fix the above
> issue by passing BRANCH_CONFIG_VERBOSE conditionally based on that.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> @@ -119,4 +119,11 @@ test_expect_success TTY 'quiet push' '
> +test_expect_success TTY 'quiet push -u' '
> +       ensure_fresh_upstream &&
> +
> +       test_terminal git push --quiet -u --no-progress upstream main 2>&1 | tee output &&
> +       test_must_be_empty output
> +'

I wondered why you used `tee` here since it adds no value (as far as I
can tell), but I see that you copied it from the test preceding this
one. So... [intentionally left blank]
