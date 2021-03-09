Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BC6C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACE164F20
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhCIS7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhCIS7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 13:59:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C9C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 10:59:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so17804689wrx.9
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/F4bFj77AsK8H+0SxwIib2XWoN7AgAxj73qTJYN5nnM=;
        b=AdYR+jknp7LEunh65vtBgjneNIPngV4/qukq0n0TXFet5kJYVwZTPz7fxkj1s5zLb4
         yPN1+CYnSzlcSCv7F7MidQ3+ppf4dPkQWL6Vv0LJPv5EQ6NK+KzRUomIhKFc2FDI/HKC
         9TGnLp0JG9ETQFwwuMwPLtE6WMKzjSopTQX/1DlOAJGyQcP4YORV/ke/g5M4N8Zgemkc
         Ezab4tzt6WHQW5nKL9LMwu0wUUnT+Elt5WYfhDmp0uzco1kStTe7TgckDyCxQj/FQ2P/
         JKfblwY4vP76c3NcbBOXZjBNlhv65sdsPEx8aoseKOq1wOauAG1URXjsVOiBH3pjPUFC
         Yw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/F4bFj77AsK8H+0SxwIib2XWoN7AgAxj73qTJYN5nnM=;
        b=eDTL+UndjoN1+3hTfskIb77wXwbF7aJZ51NR5Rhfp2Pi8huhxPQYy3ajzsILzb4asq
         4T0+zJ5oQaDlwx72jWdL+0hCEywOkpo74CuL9sotbaX/x/ZbIh1Jeg6epbMyEgkBGdL9
         CemALg9OPVI458ZDx4Ni1knOa8fPCeyl1qZyRqHH+AW7u1PgTYWLF7CPBd4z9fjiWVrX
         rGg13hRci823sUJ362549ceOWp1a2r1kgJZ7hV+FMH17c5INazRTZ/cF60QKZbB5RN/U
         5hpXrWkBqnVXbzc17UTJuz88mteq/N1JvLtieUfmxXwwQqhlzXogFuGDIwJGtnzbXQAG
         2CkA==
X-Gm-Message-State: AOAM530IFw8PVG5IALM7Qcjn9uP8kQgNI66hfAyMSKBnTCbc1p4b6wgv
        PDzFZEzLj/7x/IMc9yrps+ME7yyU6aE=
X-Google-Smtp-Source: ABdhPJy8ee2qOkP7ONpvJ3kKY/uUxiUgeMOLDL02llCyAESvQjeI23UzB/hAsfplK+ne39gub5J4UQ==
X-Received: by 2002:a05:6000:1819:: with SMTP id m25mr29779562wrh.169.1615316353010;
        Tue, 09 Mar 2021 10:59:13 -0800 (PST)
Received: from szeder.dev (94-21-29-148.pool.digikabel.hu. [94.21.29.148])
        by smtp.gmail.com with ESMTPSA id l22sm25919147wrb.4.2021.03.09.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 10:59:12 -0800 (PST)
Date:   Tue, 9 Mar 2021 19:59:11 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
Message-ID: <20210309185911.GF3590451@szeder.dev>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309160219.13779-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 09, 2021 at 05:02:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Make the --verbose output be valid TAP, making it machine-readable for
> TAP parsers again.
> 
> Both the verbose and non-verbose test outputs were valid TAP back when
> I added support for TAP in 5099b99d25f (test-lib: Adjust output to be
> valid TAP format, 2010-06-24).
> 
> Sometime after that the --verbose output broke due to some tests
> emitting their own lines starting "ok" (or otherwise invalidate the
> TAP). That was noticed and fixed in 452320f1f5 (test-lib: add
> --verbose-log option, 2016-10-21) and "fixed" by simply turning off
> the verbose mode when we were running under TAP::Harness (e.g. under
> "prove").
> 
> That solution worked for running under Travis CI. After that fix it
> was made to use the --verbose-log option in 041c72de109 (travis: use
> --verbose-log test option, 2016-10-21), see 522354d70f4 (Add Travis CI
> support, 2015-11-27) for the "cat t/test-results/*.out" code that was
> aimed at.
> 
> But that solution and others discussed in 452320f1f5 closed the door
> on us having reliable machine-readable TAP output.
> 
> Let's instead revert the work done in 452320f1f5 and, as well as the
> follow-up commits 88c6e9d31c (test-lib: --valgrind should not override
> --verbose-log, 2017-09-05) and f5ba2de6bc (test-lib: make "-x" work
> with "--verbose-log", 2017-12-08), which were only needed to work
> around bugs in the the previous --verbose-log implementation.
> 
> Replace it with a simple method for ensuring that we have valid TAP
> both on stdout, and in any verbose output we write. When we detect
> that we're running under "prove" we prefix all legitimate TAP
> directives with "GIT_TEST_TEE_STARTED":
> 
>     $ GIT_TEST_TEE_STARTED=1 ./t5547-push-quarantine.sh
>     GIT_TEST_TEE_STARTED ok 1 - create picky dest repo
>     GIT_TEST_TEE_STARTED ok 2 - accepted objects work
>     [...]
>     GIT_TEST_TEE_STARTED 1..6
> 
> Then, instead of piping the output to "tee -a" we pipe it to a helper
> which first converts "ok" and other TAP syntax to e.g. "\ok", and then
> strips that "GIT_TEST_TEE_STARTED " prefix from the start of the line.
> 
> The end result is that we're guaranteed to have valid TAP syntax on
> stdout.
> 
> We can thus get rid of the --verbose-log special-case. Since that
> option was meant to get around the TAP issue let's simply make it an
> alias for "--verbose --tee".
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

After applying this patch series there is still one place where we
look at $verbose_log:

  $ git grep -C4 verbose_log -- test-lib.sh
  test-lib.sh-
  test-lib.sh-exec 5>&1
  test-lib.sh-exec 6<&0
  test-lib.sh-exec 7>&2
  test-lib.sh:if test "$verbose_log" = "t"
  test-lib.sh-then
  test-lib.sh-    exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
  test-lib.sh-elif test "$verbose" = "t"
  test-lib.sh-then

