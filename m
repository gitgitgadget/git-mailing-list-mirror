Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0517C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C65613B0
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbhDWUUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:20:20 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37768 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbhDWUUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:20:18 -0400
Received: by mail-ed1-f51.google.com with SMTP id s15so58781246edd.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UH49zJ86uxexCxF/8B4xhNymF9uV2yVRGYUAi2nLUvA=;
        b=rFDTejzFrZNkEx29P7ueRKXOWBG1YUn2IGEGw0KYJHA3Esc+4hfZPDiLzRrt0rBuam
         aajvaiJNQir6c6QmDY3+twVv3xngv565l3sdhjD9JTP9qQmK1GrhxycETVi61zcSYSy2
         dgQbBi5xAbbWhGoS9UikI22pVfrWXItH8un16DH0Yzg4ZDfQpvL09dadoWlFUJDaOH+l
         VvsUUQH3XVCUIQzjPoo6VJcAMxa3nizSNWd/yKaTSg/bewyMqePHfkSCZdQdzvl/QSej
         QOrT8vJ5Zv7mXX3i10C6GABxWdqB/gAUzl15959+9NZsicVdNAM/OJZUhguIqZ3iN6Sj
         bNzw==
X-Gm-Message-State: AOAM533dtyH/LbpqT3NOSRWSUt7BH+l54YlmQ9mNbwchE4PKEE1ZAv2H
        me66+PyrBV72bkIqc79DeC13eaXGa8uSnsgOKow=
X-Google-Smtp-Source: ABdhPJzWjsx71d4Ehp7NhDuKFyZ+fNSqpgk8jtVLCc8LabmzL6ePrs5+MLixh8MZZU6JdEDNCWcut3+gt3gu8sg/yF0=
X-Received: by 2002:aa7:cb4c:: with SMTP id w12mr6470442edt.181.1619209180093;
 Fri, 23 Apr 2021 13:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-12-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-12-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 16:19:28 -0400
Message-ID: <CAPig+cRoxCUcVkLch70x+nUzJbTiyT4KtLDsJ0vZNJD1NboyYQ@mail.gmail.com>
Subject: Re: [PATCH 11/30] subtree: t7900: add porcelain tests for 'pull' and 'push'
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
> The 'pull' and 'push' subcommands deserve their own sections in the tests.
> Add some basic tests for them.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> @@ -202,8 +202,8 @@ test_expect_success 'merge the added subproj again, should do nothing' '
>  test_expect_success 'merge new subproj history into subdir/ with a slash appended to the argument of --prefix' '
> -       test_create_repo "$test_count" &&
> -       test_create_repo "$test_count/subproj" &&
> +       subtree_test_create_repo "$test_count" &&
> +       subtree_test_create_repo "$test_count/subproj" &&
>         test_create_commit "$test_count" main1 &&
>         test_create_commit "$test_count/subproj" sub1 &&

This change doesn't seem to be related to the stated purpose of this
patch. Was it included by accident or is it just a drive-by "while at
it" fix that seems somewhat related since you're using
subtree_test_create_repo() in the newly-added tests? It might deserve
mention in the commit message.

> @@ -427,6 +427,133 @@ test_expect_success 'split "sub dir"/ with --branch for an incompatible branch'
> +test_expect_success 'pull requires path given by option --prefix must exist' '
> +       test_create_commit "$test_count/sub proj" sub1 &&
> +       (
> +               test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" HEAD >out 2>err &&
> +
> +               echo "'\''sub dir'\'' does not exist; use '\''git subtree add'\''" > expected &&
> +               test_must_be_empty out &&
> +               test_cmp expected err
> +       )
> +'

The use of single-quotes and escaped single-quotes within the
single-quoted test body is breaking my brain. Perhaps take advantage
of SQ from test-lib.sh and interoplate it into the string rather than
dealing with raw single-quotes?

    echo "this $SQ is a single-quote"

(After writing the above, I now see that you are just mirroring
existing practice in this test script. The single-quotes are
confusing, but following existing style may be important -- or not.)

> +test_expect_success 'pull basic operation' '
> +       subtree_test_create_repo "$test_count" &&
> +       subtree_test_create_repo "$test_count/sub proj" &&
> +       test_create_commit "$test_count" main1 &&
> +       test_create_commit "$test_count/sub proj" sub1 &&
> +       (
> +               cd "$test_count" &&
> +               git fetch ./"sub proj" HEAD &&

I was going to comment on the unusual:

    ./"sub proj"

rather than the more typical:

    "./sub proj"

but I see that that also is mirroring existing practice in this
script, so... [intentionally left blank]

> +test_expect_success 'push requires option --prefix' '
> +       subtree_test_create_repo "$test_count" &&
> +       subtree_test_create_repo "$test_count/sub proj" &&
> +       test_create_commit "$test_count" main1 &&
> +       test_create_commit "$test_count/sub proj" sub1 &&
> +       (
> +               cd "$test_count" &&
> +               git fetch ./"sub proj" HEAD &&
> +               git subtree add --prefix="sub dir" FETCH_HEAD &&
> +               echo "You must provide the --prefix option." > expected &&
> +               test_must_fail git subtree push "./sub proj" from-mainline > actual 2>&1 &&

Style: There is an inconsistent mix of "> foo" and ">foo" formatting
in the newly-added tests. These days, we prefer ">foo".
