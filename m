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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0E1C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B25A61426
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhDUGjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbhDUGju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:39:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D474EC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:39:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mh2so40294707ejb.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+7481dbw68oXCftQRD+mVEe6zDh1PUffrQ6YA96sBlc=;
        b=M65VHZfwXkjy2Cs/pO5CCPg9haSj54lGEiITbsI5UOg6C/cv3Rip1++BsSvjXqj6DS
         RWgkZ9ojczRSFGkjZqr5vFMSle3p0MqcwXT/yF4qmslQgFhC3kwM1hpV4QzOTXXNNvbN
         WprNLP5PK9UOF13ybJnHJ6ggMAI950qvWMd577xlueqS/dU4cL567WugXxmrH3BCuTef
         iIcyPJvIqdTN6W4jbJaC2kDNqocPRmyCdCzJJNHVVOSkuqPP9JLDViMKTlBvw2wq4aIp
         9ThHo/FbwymVqgLp0REZGIM2lF+jTBW04HGi/Zt10jn+COpKNspl07hA5xv1uHyQbSlP
         MEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+7481dbw68oXCftQRD+mVEe6zDh1PUffrQ6YA96sBlc=;
        b=Da8sgPQ61dAQyRcHAbxjJmj1xxPhsqasjU2rIhX3N5C0dqHl4dhHHu/qDWrsiG5/qp
         HHPlizEDqur0BakhNyFDbdEaqbwfdQnm1zRc1qeqzoKAjPre4qV1AHbd+jy2yUOwd/cP
         lpuVaBmI+UUzqntVXp+eeBVs/QR2dLR3zqJvXMceqepob+/TExoHiLXNAJm3UcbZ6FQy
         X1u1tQiBN6s7xw2Ec365g2XnHsU7AZk7Bf7IaGAhCsDKotgw9VTGfQDLfUDQ98KAnoc1
         dJl9nRHDGtCKLZjjQWnd6kRdZdThfjSmqddFBcUXwjizeTDoJWx57Gbo+lSHTCJUsyrz
         wVkg==
X-Gm-Message-State: AOAM532FDf7c8YdVGulsDX75w5cElgkDCaXm5W+6gWWRFeePZMPVfrg9
        rnraJ+gQm1iBXA70V5gGiFrB8GZk5kwUJw==
X-Google-Smtp-Source: ABdhPJxqYVSNa6rC01rm8Oej1FKWA0o2zcSW8gQKowLh+LC95XD12nZvtMQQTx4hBjlkvRIl1KsflA==
X-Received: by 2002:a17:906:4004:: with SMTP id v4mr15687206ejj.278.1618987156351;
        Tue, 20 Apr 2021 23:39:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e20sm1297898ejy.66.2021.04.20.23.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 23:39:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 13/18] t2017: mark --orphan/logAllRefUpdates=false test
 as REFFILES
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <1ce545043846ee06070d1a4bc05fcd5221847eab.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <1ce545043846ee06070d1a4bc05fcd5221847eab.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 08:39:15 +0200
Message-ID: <87pmyo3zvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> In reftable, there is no notion of a per-ref 'existence' of a reflog. Each
> reflog entry has its own key, so it is not possible to distinguish between
> {reflog doesn't exist,reflog exists but is empty}. This makes the logic
> in log_ref_setup() (file refs/files-backend.c), which depends on the existence
> of the reflog file infeasible.

Okey, so I'd follow this if the test was doing something like "test -e
.git/logs" to test whether we didn't have reflogs for a specific branch
or something....

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t2017-checkout-orphan.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
> index c7adbdd39ab9..88d6992a5e1f 100755
> --- a/t/t2017-checkout-orphan.sh
> +++ b/t/t2017-checkout-orphan.sh
> @@ -76,7 +76,7 @@ test_expect_success '--orphan makes reflog by default' '
>  	git rev-parse --verify delta@{0}
>  '
>  
> -test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
> +test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
>  	git checkout main &&
>  	git config core.logAllRefUpdates false &&
>  	git checkout --orphan epsilon &&

... but in this test we don't end up doing anything that obviously
depends on ref files, right after this context we do (and this is the
entire test):

    test_must_fail git rev-parse --verify epsilon@{0} &&
    git commit -m Epsilon &&
    test_must_fail git rev-parse --verify epsilon@{0}

So either this is over-skipping of a test, or a summary like this would
be more inaccurate (I'm not suggesting to include it, just writing it
out to state/check my assumptions):

    [...]the reflog implementation leaks the implementation detail that
    it has no per-ref instance of the reflog all the way up to syntax
    like "rev-parse --verify branch@{0}", which is just asking for the
    Nth reflog entry for a branch[...]

But maybe I'm wrong about that, "man git-rev-parse" says, "This" is
reference to the @{<n>} syntax:

    [...]This suffix may only be used immediately following a ref name
    and the ref must have an existing log ($GIT_DIR/logs/<refname>).

In your v7[1] of the reftable series there's no patch to
Documentation/revisions.txt altering that blurb.

So it seems to me that between this & that series there's some closing
of the gap needed with how this "must have an existing log" even works
under reftable.

Per [2] I had assumed that this worked under reftable by abstracting
away the syntax to some query for the ref name, and faking up "file does
not exist" as "there were no records" to anything like rev-parse, but it
doesn't work like that?

1. https://lore.kernel.org/git/pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com/
2. https://eclipse.googlesource.com/jgit/jgit/+/master/Documentation/technical/reftable.md#log-record
3. https://lore.kernel.org/git/87sg3k40mc.fsf@evledraar.gmail.com/
