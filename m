Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC5C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E598D61420
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhDUGCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUGCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:02:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D323C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:01:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so7707020edb.2
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8lm9n0Hcah0FyJ1IWRH5Sy/d9oOT+fje4ij2UXp74UM=;
        b=E97H/wAQt1JXeeszcm8LNLcr7mn/Stk4jQInee46iGIoD977a144BaPTBlRY3MvmyP
         Qb3PlA7vi00EdZ6BbDolfHzEW1twrfyjUnj+3GxLHUh7t2usN2RW+WYsQaaY+mjA6SmM
         s1JpODYXN+pdzXYk4OmUT+DaMyMFXvrj6EqzonY0bBGdJQB1wBuOJ6H3LhPr3XRCOQQo
         nppl9YWGTjP4GIiLS0Kz9c9ffa049CSx0G9vPljh7AlJJIEJSc6vscXr+GchOaDwL9Gj
         WaF9q2qXDfcs+F5FnywPROKCZHPIk22IQh8yyCdGUeSyjFJABYhKW9Apbae53xyRWQ6k
         jx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8lm9n0Hcah0FyJ1IWRH5Sy/d9oOT+fje4ij2UXp74UM=;
        b=WmoPgLVf/tWOEOGBzzjFRBiLqza8KCOYgo1jNWc90tHsL2fM2EwbEU4rLT9xLmd8dh
         F9x7cKCq7oF42cCFHE9eJILMbGnM+0cRVoCZy1nXoC/we4dcPRy+og2WYa4ooKUgTYFl
         pGssoAzMS0JXMEjVmon99nmg9OODSABAlqIUjAVBTSONZ/0vWTLvXefzuisyB0i2bMpw
         /XW6d2DZMv0vbma3kpxujwYdhK1e7+2t8BIp6zp0GmNDCH01KfXzCtaHFGRLb8SjhKF1
         Bh5GCilywu6nG68SmtQPt/gywzjQvE0V+d5NZbaxztpYleK9tBH85uw8sWi7az6nIFMq
         1eiQ==
X-Gm-Message-State: AOAM531rHrQzdRSiqF3XolCS4DccdpzbZSlxnC8eN8KFHEhBnYpUl4zi
        wBcusGa8FaJ4MxmFcwntl5o51KUQjdIkwg==
X-Google-Smtp-Source: ABdhPJxp/tbzKSf0AoR3qdI9SByYAUoAm356IlfL5dsoc8iYu08IpTm3zrtsBFZ7aG7AAPeV9ibKJw==
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr7774430edv.87.1618984895877;
        Tue, 20 Apr 2021 23:01:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k5sm1913002edk.46.2021.04.20.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 23:01:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 02/18] t9300: check ref existence using git-rev-parse
 rather than FS check
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <ccc26a8950be41e5be4dc78295c66ecbade8a50e.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <ccc26a8950be41e5be4dc78295c66ecbade8a50e.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 08:01:34 +0200
Message-ID: <87k0ow2n29.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t9300-fast-import.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 5c47ac4465cb..087ddf097036 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -392,7 +392,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
>  		git gc
>  		git prune" &&
>  	git fast-import <input &&
> -	test -f .git/TEMP_TAG &&
> +	git rev-parse TEMP_TAG &&
>  	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
>  '

It seems to me that this breaks the test, to the extent that it's
testing something we care about at all.

I.e. reading ea08a6fd19 (Actually allow TAG_FIXUP branches in
fast-import, 2007-08-02) the whole point is to test that a "TEMP_TAG"
ref is accepted by fast-import, as opposed to "refs/heads/TEMP_TAG".

So we're trying to check that the refstore accepts a concept of a name
like HEAD called BLAHBLAH or whatever, that lives at the "top-level".

For something unrelated I was trying to figure out how to detect that
the other day and couldn't come up with anything I was happy with,
e.g. this seems to work:

    # Rely on for-each-ref not listing it...
    git for-each-ref >gfe &&
    ! grep TEMP_TAG gfe &&
    # ... but rev-parse grokking it
    git rev-parse TEMP_TAG

Or, rely on rev-parse emitting a warning about it:

    $ git update-ref refs/heads/TEMP_TAG HEAD
    # A bug? We emit both an error and a warning with
    # --symbolic-full-name?
    $ git rev-parse --symbolic-full-name TEMP_TAG
    warning: refname 'TEMP_TAG' is ambiguous.
    error: refname 'TEMP_TAG' is ambiguous
    $ echo $?
    0

IOW re my
https://lore.kernel.org/git/87wnt2th1v.fsf@evledraar.gmail.com/ this
seems like exactly the sort of edge case where we want to dig a bit more
and assert that we support (or explicitly don't support) this "mode"
under reftable.

In any case, if we're not testing for .git/TEMP_TAG anymore I think your
addition of "git rev-parse TEMP_TAG" is entirely redundant to the ad-hoc
"test_cmp" that comes after it, when would we not be able to rev-parse
FOO, but succeed with FOO^ ?
