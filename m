Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68C2C433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 05:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2EF61003
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 05:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhDXFvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 01:51:01 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:36830 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhDXFu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 01:50:59 -0400
Received: by mail-ej1-f47.google.com with SMTP id r9so76822807ejj.3
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 22:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Lp0oJciBqBBdF52Qrxo9mn+wJn9EA2QUt3+2xTwSJE=;
        b=b///2BKTEvVc361SYijgealwVEqRM2C+pyHmERVqlTLi24B0xgLaecxvAGWGEShvh7
         UBRh4J8GyrUusgF7u/oh8ubngnm5a7TFPVaYqjRzqoCZW+TNAcA5VPawC/wqwSrqcZzZ
         WhkYRfCylz6g9BYzDfNufUBi9BD1M8PesNed2BEefIsF+5QxmY2xZr7T0mSQJB2ut6Ce
         iNNaoP33DHd/muE8oSUjbAkgM4PqxGjIgdjf6814too1WYDWO5XeIvXBK4KiuqdbWr02
         7bHER1NCrKMXEoVYEE63AbzPxDFl3rYR6iUCFeBIWQzQwZAOGxsitfwCkss2kQE+IsqH
         CYwA==
X-Gm-Message-State: AOAM530i5TLV6WUtrrzq6oaCL3Hu+DxUlGk5+fzrUZZPQFUzyxaFccBz
        xgtXm2Xzlg9Y3rimv051rH9bN8B+vqf2MbNWJQU=
X-Google-Smtp-Source: ABdhPJyLXm0a7B9n7K9KZtxUuXaKgNdvyd5svWe3Za4FRDh6TqCD+CDjPxIsD1mqvxr05bUsLzti5MlbC9HumiJpwKo=
X-Received: by 2002:a17:906:cc46:: with SMTP id mm6mr8036426ejb.138.1619243419430;
 Fri, 23 Apr 2021 22:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-28-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-28-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Apr 2021 01:50:08 -0400
Message-ID: <CAPig+cTdTTq+W-QM3y60621GqqgXiHOueKF_Yk35=bL5p8o9uw@mail.gmail.com>
Subject: Re: [PATCH 27/30] subtree: allow --squash to be used with --rejoin
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> Besides being a genuinely useful thing to do, this also just makes sense
> and harmonizes which flags may be used when.  `git subtree split
> --rejoin` amounts to "automatically go ahead and do a `git subtree
> merge` after doing the main `git subtree split`", so it's weird and
> arbitrary that you can't pass `--squash` to `git subtree split --rejoin`
> like you can `git subtree merge`.  It's weird that `git subtree split
> --rejoin` inherits `git subtree merge`'s `--message` but not `--squash`.
>
> Reconcile the situation by just having `split --rejoin` actually just
> call `merge` internally (or call `add` instead, as appropriate), so it
> can get access to the full `merge` behavior, including `--squash`.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> @@ -324,6 +324,41 @@ test_expect_success 'split sub dir/ with --rejoin and --message' '
> +test_expect_success 'split "sub dir"/ with --rejoin and --squash' '
> +       [...]
> +               SPLIT=$(git subtree split --prefix="sub dir" --annotate="*" --rejoin --squash) &&
> +
> +               ! git merge-base --is-ancestor $SUB HEAD &&
> +               ! git merge-base --is-ancestor $SPLIT HEAD &&

It's preferable to use `test_must_fail` rather than `!` for Git
commands (but not for non-Git commands) since `test_must_fail`
correctly distinguishes between an expected failure and an unexpected
one such as a crash, whereas `!` can't make that distinction and would
even consider a crashed Git invocation to be successful.

Existing tests in this script already employ `test_must_fail` rather
than `!`, so using `test_must_fail` would also match precedent.
