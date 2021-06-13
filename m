Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD5C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9295A61245
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 15:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhFMPrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 11:47:31 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36492 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhFMPra (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 11:47:30 -0400
Received: by mail-ot1-f47.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so8390378otl.3
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=55+hnjqOwM0efz9asKb/wrllq6UldHxKBAKY585zHQ4=;
        b=S4X778cPYuKLhUB4AmyfHHPvWQSPEhBzI6/rog1ZLFhM/27rtGkezhb0HSjlfi8Irs
         jnbR/puBqPqOOezLnVgttN2jogk93yeRqfioGXab0GJ7nCqwgMWK//EM8y3qAV9yAEZO
         2HdXlA8B0cRkhbvCWW5Ly2thVzhbSsMzjHULHfL6KFTmCEA8SKpmtz5RoOaFau6jlVtH
         zKXOazBycZWPmkQP2Ymw/kHmMgDCucKL06amhsP5aFsWdn+RMJdKq5ViIbaq9/e6krS6
         YfZIr/i1jVBCF9r8qCVTRVST14aaz0i4GS17emcY8mnJmvfJy4MrYZBF16JTch8Nl5RI
         efDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=55+hnjqOwM0efz9asKb/wrllq6UldHxKBAKY585zHQ4=;
        b=RcqPNWQb63rcUV00m1MWLOeAtQBYY0ycRj4NMU12NSmiKYs9OXv1c8MoDrq/z/FbDN
         nS7WtFYm6edzkgUpNaytoZZheJoEi3BpcQV+ObdVXpIsDeszGNACqlAiBIAGzqWuj4IT
         PRMqJjcGl42EI+wc75nYcZttd3eu4YbnB3JCAzcJc3IhxRutHpU/IypZwY5Oj7oyVyC3
         9m8WTLOhrc8wzNDaPK60024ka4ZW0z1JElJwgXnrV9Oe2QKSyIBp0zGHptkKLtq3Hwlj
         vbPhq3qQNuimgKT88/5m1yPvXIMxC7HCXiVyneZd1K67Jmva54eKjmz+VLrHESVJNX06
         gjPw==
X-Gm-Message-State: AOAM530eOSja5YoLEt4VEdnM+Xvpqhpkgqhj6uYFLQPewi4BrawQpRUK
        pRTaxYE0Un/zwbdGWPoI5ak=
X-Google-Smtp-Source: ABdhPJyfHNNA31F5TFXwLecXTfJzsnqHqtL4B9p1snVgmpCFOQrWBSq1HaFSeg6AXgue+DUvkubeSw==
X-Received: by 2002:a05:6830:1208:: with SMTP id r8mr10672745otp.155.1623599052535;
        Sun, 13 Jun 2021 08:44:12 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id i15sm2724921ots.39.2021.06.13.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 08:44:11 -0700 (PDT)
Date:   Sun, 13 Jun 2021 10:44:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Q2FybG8gTWFyY2VsbyBBcmVuYXMgQmVsw7Nu?= 
        <carenas@gmail.com>, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <60c627cac29b3_41f45208a7@natae.notmuch>
In-Reply-To: <YMWMuDbctae7tF6J@coredump.intra.peff.net>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Jun 09, 2021 at 12:05:20PM -0500, Felipe Contreras wrote:
> 
> > The test_atexit unit test relies on the specific location of the
> > generated files.
> > 
> > When TEST_OUTPUT_DIRECTORY is unset, _run_sub_test_lib_test_common sets
> > it to pwd, which is two levels under the pwd of the parent unit test,
> > and the parent can find the generated files just fine.
> > 
> > But when TEST_OUTPUT_DIRECTORY is set, it's stored in GIT-BUILD-OPTIONS,
> > and even though _run_sub_test_lib_test_common correctly overrides it,
> > when the child script is run, it sources GIT-BUILD-OPTIONS, and
> > TEST_OUTPUT_DIRECTORY is overridden.
> > 
> > Effectively both the parent and child scripts output to the same
> > directory.
> > 
> >   make TEST_OUTPUT_DIRECTORY=/tmp/foobar GIT-BUILD-OPTIONS &&
> >   make -C t t0000-basic.sh
> 
> I agree things are broken when TEST_OUTPUT_DIRECTORY is set. We pollute
> /tmp/foobar in that case with trash directories, as well as its
> test-results/ directory with subtest results (mostly "counts" files).
> 
> > On the other hand we could follow the alternate path suggested in
> > 6883047071 (t0000: set TEST_OUTPUT_DIRECTORY for sub-tests, 2013-12-28):
> > pass the --root parameter to the child scripts.
> > 
> > The alternate solution works, so let's do that instead.
> 
> Unfortunately, this isn't a complete solution.

Software will never be perfect.

We don't need to wait for a perfect solution, all we need is something
better than the current siuation.

> Using --root fixes the
> trash directories, but we still pollute test-results. No tests in t0000
> rely on that, but it's still the wrong thing to be doing.
> 
> That's true before your patch, as well, though it does make things
> slightly worse when TEST_OUTPUT_DIRECTORY isn't set (before in that case
> everything worked perfectly, and now it pollutes test-results/, too).

True.

> I think solving the whole issue would require a mechanism for passing
> TEST_OUTPUT_DIRECTORY in a way that can't be overridden (whether in an
> environment variable or the command-line).

Why do we even have TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS? Looking
for a reason there's 2d14e13c56 (test output: respect
$TEST_OUTPUT_DIRECTORY, 2013-04-29), there it says it's for
valgrind/analyze.sh.

I don't know who uses that script, or how. There's no documentaion,
nothing on the mailing list, and nothing found on Google.

I think whomever usses that script *and* TEST_OUTPUT_DIRECTORY, can
simply do `TEST_OUTPUT_DIRECTORY=foo valgrind/analyze.sh`.

So maybe:

diff --git a/Makefile b/Makefile
index c3565fc0f8..2e25489569 100644
--- a/Makefile
+++ b/Makefile
@@ -2790,9 +2790,6 @@ GIT-BUILD-OPTIONS: FORCE
        @echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
        @echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
        @echo X=\'$(X)\' >>$@+
-ifdef TEST_OUTPUT_DIRECTORY
-       @echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
-endif
 ifdef GIT_TEST_OPTS
        @echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@+
 endif
diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
index 2ffc80f721..378d0a8daa 100755
--- a/t/valgrind/analyze.sh
+++ b/t/valgrind/analyze.sh
@@ -1,8 +1,5 @@
 #!/bin/sh
 
-# Get TEST_OUTPUT_DIRECTORY from GIT-BUILD-OPTIONS if it's there...
-. "$(dirname "$0")/../../GIT-BUILD-OPTIONS"
-# ... otherwise set it to the default value.
 : ${TEST_OUTPUT_DIRECTORY=$(dirname "$0")/..}
 
 output=

-- 
Felipe Contreras
