Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB000C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75F26102A
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 15:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhDQPmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbhDQPms (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 11:42:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0FC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 08:42:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s15so35716541edd.4
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PtVavlY5RfU5XmZzD6PO1cKYvoILWybIFIYZ1iHOGkI=;
        b=ZAj6O04VbyrGO3P1f+oibnXeJPYtbTkPHRIBMjH9PIIbKyQ6L3pokBlnLL9Ioi+ymv
         npkwpYw/8mB9Mi0Sb9zT7aDHCAlsRNAzxth6rYwXVZJGqQg3cBuNZ18M4FyHkB5fDl28
         G1fxoYYHJYONmtZ3BqXusw/6IQjaiuq/AJ8oreG3LRtuW34U8bPldrRcIQH92kxURACj
         vP61IOG60uuIXXpBuoOWR9WySj9Ht7KFl/Cccl/2uciJ3iNz+7xgiYa4NjGGGLVmzCVs
         Y+oGRiv6FD9ODUrU2JHyFvL8lwKmxrTJODz/PqOZ8FpmmnwCRP1cXnIrzBtLUWMJK3jp
         lAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PtVavlY5RfU5XmZzD6PO1cKYvoILWybIFIYZ1iHOGkI=;
        b=Tv0u4xWjfmoO8+YXABMFlzh5cdoADIvHpR1YbAheHZ9SUj8vzHOEwGClFeYZ/n86fX
         Mqk/IeRieIFk6GnoNbRUrGStcae2hR1k9J+0qSsFgY0AMevEncFZQDTxnO45o7cH+SND
         sB4Bvq/b1dVgNlDO9gbzW/tza0En+R+UW7bfkSFzSBXq6OE42YmXdlB9WidziUeyyqy4
         6+b+rC0JZh1RprRJxyRHekWGXRbyrxzSHgvDCVnMPD9FSmY53z+tBecNDKin3on0mR35
         JvjUhK6buiEeNlQ/O1PYvCtnsT94Ydb0AXKGfMisqXPBP/yEckN6z8iNsXrejO0uv2uI
         cilw==
X-Gm-Message-State: AOAM532Bnr0zbhtaqhztKhhXhecgR1Au3k74D52xkR90Jgy2TH8f1+LO
        V6EKoqdsO353SexOhs8msTb7HkCDy68=
X-Google-Smtp-Source: ABdhPJwhpd80Oo3zjUtorhWhP/B+1mBPa+j/o/zC7uFFVf6CcbGmo7JKfDTe0ArOd1ebS1YqWH5S0w==
X-Received: by 2002:a05:6402:254c:: with SMTP id l12mr15940084edb.119.1618674140850;
        Sat, 17 Apr 2021 08:42:20 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id gn19sm6380213ejc.68.2021.04.17.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 08:42:20 -0700 (PDT)
Date:   Sat, 17 Apr 2021 17:42:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 12/12] test-lib: split up and deprecate
 test_create_repo()
Message-ID: <20210417154218.GS2947267@szeder.dev>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <patch-12.12-a3e20ef18f7-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-12.12-a3e20ef18f7-20210417T124424Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 02:52:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Remove various redundant or obsolete code from the test_create_repo()
> function, and split up its use in test-lib.sh from what tests need
> from it, leaving us with a pass-through wrapper for "git init" in
> test-lib-functions.sh
> 
> Reasons for why we can remove various code from test_create_repo():
> 
>  1. "mkdir -p" isn't needed because "git init" itself will create
>     leading directories if needed.
> 
>  2. Since we're now a simple wrapper for "git init" we don't need to
>     check that we have only one argument. If someone wants to run
>     "test_create_repo --bare x" that's OK.
> 
>  3. We won't ever hit that "Cannot setup test environment"
>     error.
> 
>     Checking the test environment sanity when doing "git init" dates
>     back to eea420693be (t0000: catch trivial pilot errors.,
>     2005-12-10) and 2ccd2027b01 (trivial: check, if t/trash directory
>     was successfully created, 2006-01-05).
> 
>     We can also see it in another form a bit later in my own
>     0d314ce834d (test-lib: use subshell instead of cd $new && .. && cd
>     $old, 2010-08-30).
> 
>     But since 2006f0adaee (t/test-lib: make sure Git has already been
>     built, 2012-09-17) we already check if we have a built git
>     earlier.
> 
>     The one thing this was testing after that 2012 change was that
>     we'd just built "git", but not "git-init", but since
>     3af4c7156c4 (tests: respect GIT_TEST_INSTALLED when initializing
>     repositories, 2018-11-12) we invoke "git", not "git-init".
> 
>     So all of that's been checked already, and we don't need to
>     re-check it here.
> 
>  4. We don't need to move .git/hooks out of the way.
> 
>     That dates back to c09a69a83e3 (Disable hooks during tests.,
>     2005-10-16), since then hooks became disabled by default in
>     f98f8cbac01 (Ship sample hooks with .sample suffix, 2008-06-24).
> 
>     So the hooks were already disabled by default, but as can be seen
>     from "mkdir .git/hooks" changes various tests needed to re-setup
>     that directory. Now they no longer do.
> 
>  5. Since we don't need to move the .git/hooks directory

Since we don't change directory anymore...

> we don't need
>     the subshell here either.
> 
>     That wasn't really needed for the .git/hooks either, but was being
>     done for the convenience of not having to quote the path to the
>     repository as we moved the hooks.

And then this dubious explanation will not be necessary.

>  6. We can drop the --template argument and instead rely on the
>     GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh. See
>     8683a45d669 (Introduce GIT_TEMPLATE_DIR, 2006-12-19)
> 
>  7. We only needed that ">&3 2>&4" redirection when invoked from
>     test-lib.sh, and the same goes for needing the full path to "git".
> 
>     Let's move that special behavior into test-lib.sh itself.

Quoting myself from my review of the previous version of this patch:

  PATH is already set up to start with GIT_TEST_INSTALLED and/or
  GIT_EXEC_PATH before 'test_create_repo' is called to init the repo in
  the trash directory, so we could simply run 'git' and rely on PATH
  lookup choosing the right executable.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9ebb595c335..f73c3c6fc72 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1364,7 +1364,10 @@ rm -fr "$TRASH_DIRECTORY" || {
>  remove_trash=t
>  if test -z "$TEST_NO_CREATE_REPO"
>  then
> -	test_create_repo "$TRASH_DIRECTORY"
> +	"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" \
> +		init \
> +		"$TRASH_DIRECTORY" >&3 2>&4 ||

So this could be just:

  git init "$TRASH_DIRECTORY" >&3 2>&4 ||

> +	error "cannot run git init"
>  else
>  	mkdir -p "$TRASH_DIRECTORY"
>  fi
> -- 
> 2.31.1.722.g788886f50a2
> 
