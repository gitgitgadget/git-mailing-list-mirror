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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4D8C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475A76141C
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbhDUG5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhDUG5i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:57:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8C6C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:57:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so61942163ejc.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=aP5IOGxq3g2GRm1PVraY0hew5qxegfReQxFTeFVqmHE=;
        b=ValQhfHpEWVLhX0/LJY9Xh7+/XhFxD194VSHidFqFg5o8bbFLHnpAUa//imOTPFE5M
         W7wuF7vd/J5jmaKO+aQmaP6aFFtR1s4F3A5sArkG83/34Sw9BLFlasHhfyM28oVWUGbt
         qCkCoBHhXR7BbdagzTA5EVvAzO9x54u7WWJdcblG6tZbWATn9Fz4IF80gVQPRR6PqdIL
         nlSIBwCp8PO1J0gboiczErhoucIeUx1ks/WSoH7NTDJhfgp+pTg+cz/PIKwGkKy9qA9E
         kISQBqdPBENMC1ggOiScSfxRbT7PUMBUqgkrZl0jsbkAxEEw935S07NT1U2pNOHifsZI
         UoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=aP5IOGxq3g2GRm1PVraY0hew5qxegfReQxFTeFVqmHE=;
        b=WjTSisLZ0wf6GFhHanprT6s/fQxfelxaNISdpg7Wd8UvlUxNMT/20vEa6kzWxkg3b3
         3531ejKAzCwLlsm9J3sdERCXUB9eXTr/tSvx9nOjalObAO+AsPk+CQIHl+o9hshzpNkz
         uUFbXjWRUJLQLhbLIvCH1B//eHZrnju9oFKQfBZnmMK/DykxR6jKv5+AeD/3B3QihYzK
         2ccIMcy5TrrDgBOEwxZARjayUMX5mQ+L+N3Pjy7/Su1zjL8STTG+O3BCaYEh5gZoIXqH
         Gr8S3J7XD9DJ58x4sJwHH557/WoQFUJSmZQUcEFyDpJ6y6dfdHrEnxhnHxPgRR0Iwd28
         NsDQ==
X-Gm-Message-State: AOAM532f1aGuPO6FJhK4BSb9LlSNzZupP/H/CUyFJCV1fxDZM0XIVULG
        3Z+H/tksgG2+Bj9MsIDOrNGDPADcSy2pmA==
X-Google-Smtp-Source: ABdhPJyA3ndqXD8rmgVe/vsPzmwovMyW6PevpDjaLUlg5b3I9XWpgX6/rV8IRA7fI3u/v9eZxAff2Q==
X-Received: by 2002:a17:906:b353:: with SMTP id cd19mr31475540ejb.253.1618988222523;
        Tue, 20 Apr 2021 23:57:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x7sm1910869eds.67.2021.04.20.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 23:57:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 14/18] t1404: mark tests that muck with .git directly as
 REFFILES.
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <a3abc4f70e7d6bd833024f2c9b42ff731896e14d.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <a3abc4f70e7d6bd833024f2c9b42ff731896e14d.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 08:57:01 +0200
Message-ID: <87mtts3z2a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>

Some commit message summarizing why we won't need this at all would be
better e.g. maybe:

    [...]Most of the tests being skipped here were added in 19dd7d06e5
    (t1404: demonstrate a bug resolving references, 2016-05-05), as the
    subsequent 5387c0d883 (commit_ref(): if there is an empty dir in the
    way, delete it, 2016-05-05) and e167a5673e (read_raw_ref(): don't
    get confused by an empty directory, 2016-05-05) show the code is all
    specific to the files backend, and the scenario of an "empty
    directory" "refs/heads/foo/" existing, and us wanting to create a
    "file" under "refs/heads/foo/bar" is impossible under reftable.

But:

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1404-update-ref-errors.sh | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> index 8b51c4efc135..b729c1f48030 100755
> --- a/t/t1404-update-ref-errors.sh
> +++ b/t/t1404-update-ref-errors.sh
> @@ -189,7 +189,7 @@ test_expect_success 'one new ref is a simple prefix of another' '
>  
>  '
>  
> -test_expect_success 'empty directory should not fool rev-parse' '
> +test_expect_success REFFILES 'empty directory should not fool rev-parse' '
>  	prefix=refs/e-rev-parse &&
>  	git update-ref $prefix/foo $C &&
>  	git pack-refs --all &&
> @@ -199,7 +199,7 @@ test_expect_success 'empty directory should not fool rev-parse' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'empty directory should not fool for-each-ref' '
> +test_expect_success REFFILES 'empty directory should not fool for-each-ref' '
>  	prefix=refs/e-for-each-ref &&
>  	git update-ref $prefix/foo $C &&
>  	git for-each-ref $prefix >expected &&
> @@ -209,14 +209,14 @@ test_expect_success 'empty directory should not fool for-each-ref' '
>  	test_cmp expected actual
>  '


[Snip a few tests that are all of the same "empty directory form]

So far this looks good / all covering that bug

> -test_expect_success 'broken reference blocks create' '
> +test_expect_success REFFILES 'broken reference blocks create' '
>  	prefix=refs/broken-create &&
>  	mkdir -p .git/$prefix &&
>  	echo "gobbledigook" >.git/$prefix/foo &&
> @@ -504,7 +504,7 @@ test_expect_success 'broken reference blocks create' '
>  	test_cmp expected output.err
>  '

This doesn't seem specific to the files backend at all. I.e. if you grep
for "reference broken" in the file backends you'll find EINVAL and
REF_ISBROKEN handling, and your refs/reftable-backend.c has the same
exception handling, so presumably we can end up with broken refs.

Maybe not "gobbledigook", but isn't this losing coverage for other invalid ref handling under reftable?

> -test_expect_success 'non-empty directory blocks indirect create' '
> +test_expect_success REFFILES 'non-empty directory blocks indirect create' '
>  	prefix=refs/ne-indirect-create &&
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	mkdir -p .git/$prefix/foo/bar &&
> @@ -524,7 +524,7 @@ test_expect_success 'non-empty directory blocks indirect create' '
>  	test_cmp expected output.err
>  '
>  
> -test_expect_success 'broken reference blocks indirect create' '
> +test_expect_success REFFILES 'broken reference blocks indirect create' '
>  	prefix=refs/broken-indirect-create &&
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	echo "gobbledigook" >.git/$prefix/foo &&
> @@ -543,7 +543,7 @@ test_expect_success 'broken reference blocks indirect create' '
>  	test_cmp expected output.err
>  '

Here we seem to be back to truly file-specific thing (or maybe we were
all along):

> -test_expect_success 'no bogus intermediate values during delete' '
> +test_expect_success REFFILES 'no bogus intermediate values during delete' '
>  	prefix=refs/slow-transaction &&
>  	# Set up a reference with differing loose and packed versions:
>  	git update-ref $prefix/foo $C &&
> @@ -600,7 +600,7 @@ test_expect_success 'no bogus intermediate values during delete' '
>  	test_must_fail git rev-parse --verify --quiet $prefix/foo
>  '
>  
> -test_expect_success 'delete fails cleanly if packed-refs file is locked' '
> +test_expect_success REFFILES 'delete fails cleanly if packed-refs file is locked' '
>  	prefix=refs/locked-packed-refs &&
>  	# Set up a reference with differing loose and packed versions:
>  	git update-ref $prefix/foo $C &&
> @@ -616,7 +616,7 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
>  	test_cmp unchanged actual
>  '
>  
> -test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
> +test_expect_success REFFILES 'delete fails cleanly if packed-refs.new write fails' '
>  	# Setup and expectations are similar to the test above.
>  	prefix=refs/failed-packed-refs &&
>  	git update-ref $prefix/foo $C &&

Anyway, much of reviewing this commit was trying to rediscover thing
that should really be in the commit message. Presumably you had to run
blame, log etc. to find the commits from Michael Haggerty and dig into
if they were relevant to reftable. Having that information in the commit
message would be *very* helpful.
