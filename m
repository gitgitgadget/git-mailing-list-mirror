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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212DCC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03149613D2
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFBBh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFBBh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 21:37:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D89C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 18:36:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso807249pji.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 18:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iCzQSPKVaMjPvIezTjJccDpd8fVNHkwzTdUqp0OPEJQ=;
        b=eTA1XJ0bFqnpINaTlXBiwzCy8xbeiVPKA8YdzWrEFaVYvVXI+UwkvcdWkUfIlyYPvU
         1b9W1A4RfYtYcaX4/RLgUQ+knqAGQDIfMTFk9FN6tYZpsb6ZjtqWB0BHyjm9kwQddvts
         2cGAaxMfnKiSeiM7Wn1AjXeyJDuyKmdH6Ca0ERez6uO91zRXfAtpxNPF2B5Nt2doB+uZ
         1i9m45L0e1w1Dl+ajHl0QSJbn8MD6Nzp39Tc9okcor/jCN/vm5YQr9koZbndGnO6Ewyz
         FI+FZtEMQfcv7xqCY0VDQNa/+qQRsJmFJLSsZczCVW4NcbujZ8aQIZZqH4KmZqxZfhC+
         aruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iCzQSPKVaMjPvIezTjJccDpd8fVNHkwzTdUqp0OPEJQ=;
        b=JlNrr7kaKX1jVZS2jKpPtRuLr/z6rjp0fVpQhF337lnLuuRiDtwQT6Hb3jyC/3O8zy
         ygMkhhBWCbgXgtDDuqhA6gMyWIBuLjwLa20sKrDLOiH2bt2QbGlpCCUFjG7o1olNOrHq
         RHF2O1jUX7HWlqbh9u9POiYYgMJB9vFiT7oRBL+1MrWPFPi6rSLiIOA5hYru94oM/vo4
         MT7oh7/oHopwOf5Jl9JrRFsX2kwK44qeJ236ypGB6rClc+EwVcpbdMcFr53Z7VahINyy
         pk+bflfpCrOL26vJdCDpkCBiRLWWwTjxu8Y0nY+p4cdTMI58ZS9uwm7gLe1kca6LAeM7
         o9Rw==
X-Gm-Message-State: AOAM531lkmDyqgVOMWtfA82PDANBBWbSElIiPWOgGDDpO2gBnHmVOfon
        0ToSxQ1FFChQMJkN12ClK50=
X-Google-Smtp-Source: ABdhPJyuV0rKtNXiAY6wtLZBy04H4XZultgA1p7KFBJfdqx1YLgaztAtmLepvL7dBlDIFPUlL6OMrA==
X-Received: by 2002:a17:90a:bd05:: with SMTP id y5mr27934606pjr.229.1622597774025;
        Tue, 01 Jun 2021 18:36:14 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id x1sm13921375pjk.37.2021.06.01.18.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 18:36:13 -0700 (PDT)
Date:   Wed, 2 Jun 2021 08:36:11 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Message-ID: <YLbgi0jQn8BJ1ue2@danh.dev>
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com>
 <871r9n2dlu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r9n2dlu.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-31 16:01:01+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Thu, May 27 2021, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Wed, May 26 2021, Matheus Tavares wrote:
> >
> >> t2080 makes a few copies of a test repository and later performs a
> >> branch switch on each one of the copies to verify that parallel checkout
> >> and sequential checkout produce the same results. However, the
> >> repository is copied with `cp -R` which, on some systems, defaults to
> >> following symlinks on the directory hierarchy and copying their target
> >> files instead of copying the symlinks themselves. AIX is one example of
> >> system where this happens. Because the symlinks are not preserved, the
> >> copied repositories have paths that do not match what is in the index,
> >> causing git to abort the checkout operation that we want to test. This
> >> makes the test fail on these systems.
> >>
> >> Fix this by copying the repository with the POSIX flag '-P', which
> >> forces cp to copy the symlinks instead of following them. Note that we
> >> already use this flag for other cp invocations in our test suite (see
> >> t7001). With this change, t2080 now passes on AIX.
> >>
> >> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> >> ---
> >>  t/t2080-parallel-checkout-basics.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
> >> index 7087818550..3e0f8c675f 100755
> >> --- a/t/t2080-parallel-checkout-basics.sh
> >> +++ b/t/t2080-parallel-checkout-basics.sh
> >> @@ -114,7 +114,7 @@ do
> >>  
> >>  	test_expect_success "$mode checkout" '
> >>  		repo=various_$mode &&
> >> -		cp -R various $repo &&
> >> +		cp -R -P various $repo &&
> >>  
> >>  		# The just copied files have more recent timestamps than their
> >>  		# associated index entries. So refresh the cached timestamps
> >
> > Thanks for the quick fix, I can confirm that this makes the test pass on
> > AIX 7.2.
> 
> There's still a failure[1] in t2082-parallel-checkout-attributes.sh
> though, which is new in 2.32.0-rc*. The difference is in an unexpected
> BOM:
>     
>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/A.internal 
>     efbbbf74657874
>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/utf8-text  
>     74657874
> 
> I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.sh also
> fails similarly[2], so perhaps it's some old/iconv/whatever issue not
> per-se related to any change of yours.

The 0xefbbbf looks interesting, it's BOM for utf-8.

> I tried compiling with both NO_ICONV=Y and ICONV_OMITS_BOM=Y, both have
> the same failure.

I didn't check the code-path for NO_ICONV=Y but ICONV_OMITS_BOM=Y only
affects output of converting *to* utf-16 and utf-32.

So, I think AIX iconv implementation automatically add BOM to utf-8?

Perhap we need to call skip_utf8_bom somewhere?

-- Danh

> In any case, I think AIX test failures (or other obscure platforms I
> test) are rather uninteresting per-se, I mainly test on these to smoke
> out bad assumptions elsewhere. E.g. non-POSIX code, perhaps in this case
> we're relying on some unportable iconv assumption, or maybe not...
>     
> 
> 1.
> Initialized empty Git repository in /scratch/avar/git/t/trash directory.t2082-parallel-checkout-attributes/encoding/.git/
> + cd encoding
> + echo text
> + 1> utf8-text
> + write_utf16
> + 0< utf8-text 1> utf16-text
> checking prerequisite: NO_UTF16_BOM
> 
> mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-NO_UTF16_BOM" &&
> (
>         cd "$TRASH_DIRECTORY/prereq-test-dir-NO_UTF16_BOM" &&
>         test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
> 
> )
> + mkdir -p /scratch/avar/git/t/trash directory.t2082-parallel-checkout-attributes/prereq-test-dir-NO_UTF16_BOM
> + cd /scratch/avar/git/t/trash directory.t2082-parallel-checkout-attributes/prereq-test-dir-NO_UTF16_BOM
> + printf abc
> + iconv -f UTF-8 -t UTF-16
> + wc -c
> + test 6 = 6
> prerequisite NO_UTF16_BOM ok
> + echo A working-tree-encoding=UTF-16
> + 1> .gitattributes
> + cp utf16-text A
> + cp utf8-text B
> + git add A B .gitattributes
> + git commit -m encoding
> [master (root-commit) 65fa7e8] encoding
>  Author: A U Thor <author@example.com>
>  3 files changed, 3 insertions(+)
>  create mode 100644 .gitattributes
>  create mode 100644 A
>  create mode 100644 B
> + git cat-file -p :A
> + 1> A.internal
> + test_cmp_bin utf8-text A.internal
> utf8-text A.internal differ: char 1, line 1
> error: last command exited with $?=1
> not ok 2 - parallel-checkout with re-encoding
> #
> #               set_checkout_config 2 0 &&
> #               git init encoding &&
> #               (
> #                       cd encoding &&
> #                       echo text >utf8-text &&
> #                       write_utf16 <utf8-text >utf16-text &&
> #
> #                       echo "A working-tree-encoding=UTF-16" >.gitattributes &&
> #                       cp utf16-text A &&
> #                       cp utf8-text B &&
> #                       git add A B .gitattributes &&
> #                       git commit -m encoding &&
> #
> #                       # Check that A is stored in UTF-8
> #                       git cat-file -p :A >A.internal &&
> #                       test_cmp_bin utf8-text A.internal &&
> #
> #                       rm A B &&
> #                       test_checkout_workers 2 git checkout A B &&
> #
> #                       # Check that A (and only A) is re-encoded during checkout
> #                       test_cmp_bin utf16-text A &&
> #                       test_cmp_bin utf8-text B
> #               )
> #
> 
> 2. 
> 
> avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t0028-working-tree-encoding/test.utf8.raw  
> 68616c6c6f20746865726521
> 63616e20796f752072656164206d653f
> avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t0028-working-tree-encoding/test.utf16.git    
> efbbbf68616c6c6f20746865726521
> 63616e20796f752072656164206d653f

-- 
Danh
