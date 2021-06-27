Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8743C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D74F613BC
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 07:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhF0Hqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhF0Hqs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 03:46:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7CC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 00:44:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot9so22353178ejb.8
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hpHtS5x6Ko1AQgZvVwRYhFd5Eb9FXDDWW1CUSX0aWGo=;
        b=aJaHe3Afea9o9UNMPdw6rYXrXM2uXFIdMJxhhyxdC7yY/zghC93oElUUYlszsalXoD
         8WrBS+kOdsfeFp/boEqYy2zTENR70yzqkVPcX2eaPSpO5KcaODV5k//lycYr1WXRHN8W
         WVq/4GNnU9sejeqXop9IA0D4ffc60GT9KAYyXXNhCwIRoDJkIgjU2G7SLXTS+qkgEwdS
         mX3IsB0e/vMyddQsa4hDbFVLWNnkKgJGsCfVhHtqBLHfOhDZ2b1NGIRhv4JZJbN+B6Oh
         YEAiMBb3FCg1ulHhpBnqR09M1EYR6l/K0pNao3Gj0oVIQHcTittfbSlfXrIi7TmC4vUC
         L3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hpHtS5x6Ko1AQgZvVwRYhFd5Eb9FXDDWW1CUSX0aWGo=;
        b=IO2spQYrGgdGjdLpBW1EVyihbDtsCpfHkN05fVS+GuCuRgja2BeldRyPptLuI4qMSI
         K7FZfhy7PlsV7+H5BtkB70CH1BKAYIquuAwBxuXyiK/+pUb8UF8kdSRTTFS6aqpAJWx5
         mJbay0hs+oxzGZCSsVB4AuHI6vkuhxtJG3ie4tAlBV7k+A0i9kp4FmjsjcBduQddGF3w
         F7aGGdmBmvMb/GWNA5xtiGxMgEVoG+J65NXiktnoi9QQchwMhOyEKf4xF9lVl8eeTR9A
         ZE7pHLvT4F/ZdnsZqZKSSAQzVrP5oUwLtNmc5yRHDoXZnf5BOYSch59tkxiQjaPHSUuT
         QDYQ==
X-Gm-Message-State: AOAM531ymrxpPSJbKQwzxf8ITSInlIowvyDxgmu3j7X7VadhUt9nyHHd
        qStzB8X+aEPgFHbxjMhuZns=
X-Google-Smtp-Source: ABdhPJyXklxVp7fYyVT2+qSWmOUWGEoMWegCIXOCLaf2uCwNrBqLZBtkqG0Qxg63lB7oAXp0oNvS8w==
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr19669561ejc.80.1624779862074;
        Sun, 27 Jun 2021 00:44:22 -0700 (PDT)
Received: from szeder.dev (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id ee47sm7399324edb.51.2021.06.27.00.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 00:44:21 -0700 (PDT)
Date:   Sun, 27 Jun 2021 09:44:19 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib.sh: set COLUMNS=80 for --verbose repeatability
Message-ID: <20210627074419.GH6312@szeder.dev>
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
 <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 12:19:31PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Some tests will fail under --verbose because while we've unset COLUMNS
> since b1d645b58ac (tests: unset COLUMNS inherited from environment,
> 2012-03-27), we also look for the columns with an ioctl(..,
> TIOCGWINSZ, ...) on some platforms. By setting COLUMNS again we
> preempt the TIOCGWINSZ lookup in pager.c's term_columns(), it'll take
> COLUMNS over TIOCGWINSZ,
> 
> This fixes the t0500-progress-display.sh test when run as:
> 
>     ./t0500-progress-display.sh --verbose
> 
> It broke because of a combination of the this issue and the progress
> output reacting to the column width since 545dc345ebd (progress: break
> too long progress bar lines, 2019-04-12). The
> t5324-split-commit-graph.sh fails in a similar manner due to progress
> output, see [1] for details.

This issue is not progress-specific.

I run the test suite with 'export COLUMNS=10' in 'test-lib.sh' and
got:

  t0500-progress-display.sh                (Wstat: 256 Tests: 12 Failed: 10)
    Failed tests:  1-5, 7-11
  t4012-diff-binary.sh                     (Wstat: 256 Tests: 13 Failed: 1)
    Failed test:  13
  t4052-stat-output.sh                     (Wstat: 256 Tests: 78 Failed: 14)
    Failed tests:  3-5, 13, 17, 21, 38-41, 49, 52, 55, 57
  t5510-fetch.sh                           (Wstat: 256 Tests: 181 Failed: 1)
    Failed test:  175
  t5324-split-commit-graph.sh              (Wstat: 256 Tests: 36 Failed: 1)
    Failed test:  22
  t5150-request-pull.sh                    (Wstat: 256 Tests: 10 Failed: 1)
    Failed test:  6
  t4016-diff-quote.sh                      (Wstat: 256 Tests: 5 Failed: 1)
    Failed test:  5

Then with COLUMNS=238:

  t0500-progress-display.sh                (Wstat: 256 Tests: 12 Failed: 4)
    Failed tests:  3-6
  t4012-diff-binary.sh                     (Wstat: 256 Tests: 13 Failed: 1)
    Failed test:  13
  t4052-stat-output.sh                     (Wstat: 256 Tests: 78 Failed: 3)
    Failed tests:  3-5

From these only the failures in t0500 and t5324 are caused by the
progress display, the rest fail with things like:

  --- expect      2021-06-26 17:07:58.489958439 +0000
  +++ actual      2021-06-26 17:07:58.957964694 +0000
  @@ -1,2 +1,2 @@
    binfile  |   Bin 0 -> 1026 bytes
  - textfile | 10000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  + textfile | 10000 ++++++++
  
  --- expect80    2021-06-26 17:07:58.321956193 +0000
  +++ actual      2021-06-26 17:07:58.333956354 +0000
  @@ -1 +1 @@
  - ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
  + ...aaaaaaaaaaaa | 1 +
  
  --- expect      2021-06-26 17:09:05.198849586 +0000
  +++ actual      2021-06-26 17:09:05.194849532 +0000
  @@ -1,2 +1,2 @@
  -main                 -> origin/main
  +main       -> origin/main
   looooooooooooong-tag -> looooooooooooong-tag
  
  --- expect      2021-06-26 17:14:31.819199273 +0000
  +++ request.fuzzy       2021-06-26 17:14:31.951201026 +0000
  @@ -16,4 +16,5 @@
   ----------------------------------------------------------------
   SHORTLOG
  
  -DIFFSTAT
  + ...nic.txt | 5 +++++
  + 1 file changed, 5 insertions(+)
  
  
  --- expect      2021-06-26 16:55:41.632510754 +0000
  +++ actual      2021-06-26 16:55:42.052516149 +0000
  @@ -1,2 +1,2 @@
    binfile  |   Bin 0 -> 1026 bytes
  - textfile | 10000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  + textfile | 10000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  
  --- expect80    2021-06-26 16:55:41.416507979 +0000
  +++ actual      2021-06-26 16:55:41.436508236 +0000
  @@ -1 +1 @@
  - ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
  + aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +

So there are more diffstat-related failures than progress-related.

> A more narrow fix here would be to only do this in the --verbose mode,
> but there's no harm in setting this for everything. If we're not
> connected to a TTY the COLUMNS setting won't matter.

This is wrong, we check the terminal width even when not connected to
a TTY, therefore COLUMNS definitely matters; all the failures reported
above were with '--verbose-log'.

> See ea77e675e56 (Make "git help" react to window size correctly,
> 2005-12-18) and ad6c3739a33 (pager: find out the terminal width before
> spawning the pager, 2012-02-12) for how the TIOCGWINSZ code ended up
> in pager.c
> 
> 1. http://lore.kernel.org/git/20210624051253.GG6312@szeder.dev
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> This replaces a more narrow fix in
> https://lore.kernel.org/git/patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com/,
> which as SZEDER points out was also needed by another test using the
> progress.c code.
> 
>  t/test-lib.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 54938c64279..1a6ca772d6c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -406,14 +406,15 @@ LANG=C
>  LC_ALL=C
>  PAGER=cat
>  TZ=UTC
> -export LANG LC_ALL PAGER TZ
> +COLUMNS=80
> +export LANG LC_ALL PAGER TZ COLUMNS
>  EDITOR=:
>  
>  # A call to "unset" with no arguments causes at least Solaris 10
>  # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
>  # deriving from the command substitution clustered with the other
>  # ones.
> -unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
> +unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
>  	my @env = keys %ENV;
>  	my $ok = join("|", qw(
>  		TRACE
> -- 
> 2.32.0.605.g06ef811e153
> 
