Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E6C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4743A61002
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhJZUZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhJZUZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 16:25:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E397C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 13:23:17 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h2so528612ili.11
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q+EoJY0mBgrpNlGNggSPqvoMwnAzvzZfusYYNmeHtqM=;
        b=xgZyFtzc7qha01M7SzSCxmWrEu88cPUi5aC1vTtiAp+AdfOnHrt8Z4k+/bJO3ETDpZ
         PnO59aNo0QVjJJ5WZks9TZGGvENPTlP/Q+M5BDkCZVSigPeVTiIdk4ioarlnZQ+bmr8w
         GReApaHI9Rn8Bd1INdbCyiebDmPNU1/NnGW59EDvBtiXur/KYT/Tq5It5kNEGe3PcutG
         EEGDMRIYSk3ikQK5EdAqG+eLB2x3MvcT58Bgee+lssmX0NHG07m6ry7vHGVRsLtwCZGg
         cfUuCJVZObgt3y0zb5tgK4sp+bVNavcKBMixZ8iEDkIQ/qNnai5hib41/xZkxMn90csz
         xBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q+EoJY0mBgrpNlGNggSPqvoMwnAzvzZfusYYNmeHtqM=;
        b=LIgrLT8LV31HcEDyPtAIqKbRdaywaCbOwU5IcRwPkeu6AtyDgUS5HEO7XJxzBx/Y/1
         +fzMfqapxxlIfDjPr50DqNA/SOYlT/alSSjtC4hLmrxmazJrK/uSTbJfgNrePCg37vmN
         PvGLQdQzlqPXmy+pI0HvCaQ0wFmaxvyMFo7XapIcWvK7Hryw8cNEMDSQwYt090l1qZ+X
         MWRORClYPja5VjXU9qxZCicbgRmnPDNr0v9zLJQkom62dFL1C8xQKecsijGYL5H2B35c
         +roz6dDzxQOkz+QyLgpdIVVEGTpoOnhlbDPT7wxFATVgrSgAPqw6NwMwtY90xF1RprgK
         kqzQ==
X-Gm-Message-State: AOAM532hfZSc/+R8nycCOoFQ/l25QB9GQdtsn8Vn7rbnLa9lvBdflGsZ
        LRUu9xPg1NkwOgXCfgc3ZA+K5A==
X-Google-Smtp-Source: ABdhPJxccsuu6Tj/UQHg1GhoumAVcxBislp8h4u6q1irl7X7voM2C3gki0ZgvjOUsetxZPg8BDR1Hg==
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr12758721ili.249.1635279796611;
        Tue, 26 Oct 2021 13:23:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c16sm1074654iow.24.2021.10.26.13.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:23:16 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:23:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Message-ID: <YXhjstW2XAnixEqh@nand.local>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 12:32:17PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Extend the SANITIZE=leak testing mode added in 956d2e4639b (tests: add
> a test mode for SANITIZE=leak, run it in CI, 2021-09-23) to optionally
> be able to add a "suppressions" file to the $LSAN_OPTIONS.
>
> This allows for marking tests as passing with
> "TEST_PASSES_SANITIZE_LEAK=true" when they still have failure due more
> general widespread memory leaks, such as from the "git log" family of
> commands. We can now mark the "git -C" tests as passing.
>
> For getting specific tests to pass this is preferable to using
> UNLEAK() in these codepaths, as I'll have fixes for those leaks soon,
> and being able to atomically mark relevant tests as passing with
> "TEST_PASSES_SANITIZE_LEAK=true" helps to explain those changes. See
> [1] for more details.
>
> 1. https://lore.kernel.org/git/211022.86sfwtl6uj.gmgdl@evledraar.gmail.com/
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> On Fri, Oct 22 2021, Ævar Arnfjörð Bjarmason wrote:
>
> > On Fri, Oct 22 2021, Taylor Blau wrote:
> >
> >> On Thu, Oct 21, 2021 at 01:50:55PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>>
> >>> On Wed, Oct 20 2021, Taylor Blau wrote:
> [...]
> > If you want to pick that approach up and run with it I think it would
> > probably make sense to factor that suggested test_expect_success out
> > into a function in test-lib-functions.sh or whatever, and call it as
> > e.g.:
> >
> >     TEST_PASSES_SANITIZE_LEAK=true
> >      . ./test-lib.sh
> >     declare_known_leaks <<-\EOF
> >     add_rev_cmdline
> >     [...]
> >     EOF
> >
> > Then pipe it through sed 's/^/leak:/' and have it set LSAN_OPTIONS for
> > you.
> >
> > Doing it that way would be less boilerplate for each test that wants it,
> > and is also more likely to work with other non-LSAN leak appoaches,
> > i.e. as long as something can take a list of lines matching stack traces
> > we can feed that to that leak checker's idea of a whitelist.
>
> I just went ahead and hacked that up. If you're OK with that approach
> it would really help reduce the work for leak changes I've got
> planned, and as noted gives you the end-state of a passing 5319.
>
> I don't know if it makes more sense for you to base on top of this
> if/when Junio picks it up, or to integrate it into your series
> etc. Maybe Junio will chime in ...

Hmm. This seems neat, but I haven't been able to get it to work without
encountering a rather annoying bug along the way.

Here is the preamble of my modified t5319 to include all of the leaks I
found in the previous round (but decided not to fix):

TEST_PASSES_SANITIZE_LEAK=true
. ./test-lib.sh
todo_leaks <<-\EOF
^add_rev_cmdline$
^cmd_log_init_finish$
^prepare_revision_walk$
^prep_parse_options$
EOF

So running that when git is compiled with SANITIZE=leak *should* work,
but instead produces this rather annoying leak detection after t5319.7:

  =================================================================
  ==1785298==ERROR: LeakSanitizer: detected memory leaks

  Indirect leak of 41 byte(s) in 3 object(s) allocated from:
      #0 0x7f2f2f866db0 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:54
      #1 0x7f2f2f64b4aa in __GI___strdup string/strdup.c:42

  -----------------------------------------------------
  Suppressions used:
    count      bytes template
        1        576 ^add_rev_cmdline$
  -----------------------------------------------------

  SUMMARY: LeakSanitizer: 41 byte(s) leaked in 3 allocation(s).
  Aborted

Huh? Looking past __GI___strdup (which I assume is just a
symbolification failure on ASan's part), who calls strdup()? That trace
is annoyingly incomplete, and doesn't really give us anything to go off
of.

It does seem to remind me of this:

  https://github.com/google/sanitizers/issues/148

though that issue goes in so many different directions that I'm not sure
whether it really is the same issue or not. In any case, that leak
*still* shows up even when suppressing xmalloc() and xrealloc(), so I
almost think that it's a leak within ASan itself.

But most interesting is that those calls go away when I stop setting
`suppressions` in $LSAN_OPTIONS by dropping the call to your todo_leaks.

So this all feels like a bug in ASan to me. I'm curious if it works on
your system, but in the meantime I think the best path forward is to
drop the last patch of my original series (the one with the three
UNLEAK() calls) and to avoid relying on this patch for the time being.

Thanks,
Taylor
