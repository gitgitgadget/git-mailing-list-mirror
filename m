Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9DC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 07:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2942923AC0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 07:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbhAPHOM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 16 Jan 2021 02:14:12 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:32985 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbhAPHOL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 02:14:11 -0500
Received: by mail-ed1-f42.google.com with SMTP id c6so4882029ede.0
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 23:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kmlZ0PWNB3tGjiIJq25/8ttvCtU4YkMi0CooSnizvRg=;
        b=LTOsL/1wIiQqKnWbBO9k4msTEClLEHla1mtmFIZ5uabq/IcaBUy3bNzEo1J1/AM304
         d7D1iJ/00ZkX/kOMfbpfhdCXawSmy7+3qxOOjK5pn0dtxA4/Bnj20nlGtTlscZ7hxtMS
         sKEBwxuI2XHfytX4XNBOF8GIj1oTLDSQjYb1HIFA0zHoSSksrjYUiWa50mh4MBbd1Dx1
         3/UdW/NaMRq+ErteSJTlXWigYVnfDm/YB9IDqhwiOGU5TgFpCRbC/SL/gL7OYzg8hfxM
         eE8GWEDLl5Qj2c6pSiF+Z4T2SGzIMnwpAF73eOkYh8jelm5lFJl+fkCdcWeQYkGKEBq6
         pUKg==
X-Gm-Message-State: AOAM531bE2SF4W9VeDj8HUwSUiEEaN5AT8MDNxVT4njHz6XLJ6O5vbNi
        QI/GGpw/ybWmBhBMnsWJtOzpWgex35wJ3tBwzwkfJJAnjzwriaL+
X-Google-Smtp-Source: ABdhPJyoxX9AUr5YUwOi3mu/65HqilYjj14EF1fL8apYltutxfK/PhC5rLnPRVcR/6Zm9Bcjlx5SSS9+qBrbalZP4SM=
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr12271798edb.233.1610781209289;
 Fri, 15 Jan 2021 23:13:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com> <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Jan 2021 02:13:18 -0500
Message-ID: <CAPig+cQBi7jdq64==U630Ht1YDcH+9komLNv-hZMnEhQ1Q-V9A@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files.c: add --dedup option
To:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 7:22 AM 阿德烈 via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In order to provide users a better experience
> when viewing information about files in the index
> and the working tree, the `--dedup` option will suppress
> some duplicate options under some conditions.
> [...]

I have a few very minor comments alongside Junio's review comments...

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
> diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
> @@ -0,0 +1,54 @@
> +test_description='git ls-files --dedup test.
> +
> +This test prepares the following in the cache:
> +
> +    a.txt       - a file(base)
> +    a.txt      - a file(master)
> +    a.txt       - a file(dev)
> +    b.txt       - a file
> +    delete.txt  - a file
> +    expect1    - a file
> +    expect2    - a file
> +
> +'

This test script description is outdated now. Perhaps shorten it to:

    test_description='ls-files dedup tests'

Or, it might be suitable to simply add the new test to the existing
t3004-ls-files-basic.sh instead.

> +test_expect_success 'setup' '
> +       > a.txt &&
> +       > b.txt &&
> +       > delete.txt &&
> +       cat >expect1<<-\EOF &&

Style nits: no space after redirection operator and a space before
redirection operator:

    >a.txt &&
    >b.txt &&
    >delete.txt &&
    cat >expect1 <<-\EOF &&

> +       cat >expect2<<-EOF &&

Nit: missing the backslash (and wrong spacing):

    cat >expect2 <<-\EOF &&

> +       echo a>a.txt &&
> +       echo b>b.txt &&

Style:

    echo a >a.txt &&
    echo b >b.txt &&

> +       echo delete >delete.txt &&
> +       git add a.txt b.txt delete.txt &&
> +       git commit -m master:2 &&
> +       git checkout HEAD~ &&
> +       git switch -c dev &&

If someone adds a new test after this test, then that new test will
run in the "dev" branch, which might be unexpected or undesirable. It
often is a good idea to ensure that tests do certain types of cleanup
to avoid breaking subsequent tests. Here, it would be a good idea to
ensure that the test switches back to the original branch when it
finishes (regardless of whether it finishes successfully or
unsuccessfully).

    git switch -c dev &&
    test_when_finished "git switch master" &&

Or you could use `git switch -` if you don't want to hard-code the
name "master" in the test (since there has been effort lately to
remove that name from tests.

> +       echo change >a.txt &&
> +       git add a.txt &&
> +       git commit -m dev:1 &&
> +       test_must_fail git merge master &&
> +       git ls-files -t --dedup >actual1 &&
> +       test_cmp expect1 actual1 &&
> +       rm delete.txt &&
> +       git ls-files -d -m -t --dedup >actual2 &&
> +       test_cmp expect2 actual2

We usually don't bother giving temporary files unique names like
"actual1" and "actual2" unless those files must exist at the same
time. This is because unique names like this may confuse readers into
wondering if there is some hidden interdependency between the files.
In this case, the files don't need to exist at the same time, so it
may be better simply to use the names "actual" and "expect", like
this:

    ...other stuff...
    cat >expect <<-\EOF &&
    ...
    EOF
    git ls-files -t --dedup >actual &&
    test_cmp expect actual &&
    rm delete.txt &&
    cat >expect <<-\EOF &&
    ...
    EOF
    git ls-files -d -m -t --dedup >actual &&
    test_cmp expect actual

(It also has the benefit that the "expect" content is closer to the
place where it is actually used, which may make it a bit easier for a
person reading the test to understand what is supposed to be
produced.)
