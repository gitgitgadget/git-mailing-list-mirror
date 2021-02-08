Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402FC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F0964E6F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhBHVXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhBHVXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 16:23:25 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27264C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 13:22:41 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d85so16004727qkg.5
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 13:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C+2X6GraB3bfqBK4PEhuP5CDe6NCtvjMoUJ3NTE6DR4=;
        b=BW0f5LAKJiem1cO1TAvyHb+1P9dkSq9nvQpNSyrvUMfF6SotrgXliXp/LcpVbn4/bz
         /KNHyeMqthTpNuvJ/hWdHUb8p38Xj6+f2qChsBDIdDbhnx79g3ofPRnHtyxWMRtoNOOt
         cyCNOwNf4wTBiO8+Mc2CwJsJYXQeM0tsKaXd4nvEipvJj2D9OxA0aMCqmVg+DKEmtWTS
         1mEle5mHo5nLXOCYjKxGH+Xk+Bu/kNXFEUrL4l+eD+UKtVs77LYrTS/Nw8sm3Onz6M9M
         YqSG9LHtGC4GXZWI8NPBG9nhQ1mmjNH9naUPk/oBQH4nQXC6GSezg8/nBURlIQOuXvyX
         Sh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C+2X6GraB3bfqBK4PEhuP5CDe6NCtvjMoUJ3NTE6DR4=;
        b=BRQ230arct+IBNurNdP6MLeHBqLWzpAetqZpql297oI7WKxHhd5iydjrA6zhXQefQz
         jH/5ckTkWxTMCh5d84nTbOBK2WJhc8RK+Lg4aQFPpSgOpZjTKbGqVY8SjTMVIUyb5iYD
         PxMW15Yrrs1UHi955Mipdae3VXit6yezyOn1fwJOoeh/3FSVUFYM2FtZjb3ZyrtA9XO8
         6XkGdLrpe5mh8YDPRJMbc1WRjpr4dsAA+etqYDLfXJLZ8g0JssBOYzmhphbna1RE4dIp
         jlZMAulZk2yuDQBrSE7H2jA5ZUnHxQQswOtqUI7zHSfl7dhsbTjDu8hnKKDda47NZ/Ty
         epfQ==
X-Gm-Message-State: AOAM5338T6pysw2+CqyvfcnPE1dy9wvlMV7R84kqJEONrTPymbiqoi/r
        1OLl37eyP3nL4NmUFkV/V5GMDw==
X-Google-Smtp-Source: ABdhPJxyWAG9op04C5gceSysGNXGuMOOFTZUTqlid4Ne9JjQGAHvd1ePleJanUa1ot8wl7WhwkwWyg==
X-Received: by 2002:a05:620a:118e:: with SMTP id b14mr2070081qkk.438.1612819360323;
        Mon, 08 Feb 2021 13:22:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:65b:f1e7:ac0e:a3a2])
        by smtp.gmail.com with ESMTPSA id b82sm602592qkc.34.2021.02.08.13.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:22:39 -0800 (PST)
Date:   Mon, 8 Feb 2021 16:22:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [rfh] where is coccinelle these days on Ubuntu?
Message-ID: <YCGrmsg8J7XT32TM@nand.local>
References: <xmqqeehv2t71.fsf@gitster.c.googlers.com>
 <YBylBKMG4G4dbiOW@nand.local>
 <xmqqr1lt9gm3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1lt9gm3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 06, 2021 at 10:49:08AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > From a quick search, it looks like coccinelle was moved to the
> > "universe" repository, at least in the Azure mirrors (which is what
> > GitHub Actions uses):
> >
> >     http://azure.archive.ubuntu.com/ubuntu/pool/universe/c/coccinelle/
>
> Unfortunately the pool/ system does not tell us which suite a
> package is available in (that's the whole point of it, as it lets
> them share the packages across suites without moving things around).

OK. I'm learning about this as I go, so this is helpful to know it's not
good practice to pin a specific suite.

> Looking for the package availability
>
>   https://packages.ubuntu.com/search?keywords=coccinelle
>
> seems to tell me about these:

It seems that there isn't a coccinelle package available for focal yet.
That's odd, since (1) focal is a LTS release, and (2) there *is* a
coccinelle package on groovy, which is newer than focal. Here's a piece
of mail from the coccinelle list that says there's no release yet.

    https://systeme.lip6.fr/pipermail/cocci/2020-June/007768.html

Our static-analysis build runs on 'ubuntu-latest', which I understand is
in the process of being upgraded from bionic to focal (I was pointed to
https://github.com/actions/virtual-environments/issues/1816 internally
as a spot to learn more about this.)

Double checking the latest successful static-analysis build, indeed it
was on 18.04:

    https://github.com/git/git/runs/1811069070?check_suite_focus=true

> Hmph...

So, I guess we could continue to run on 18.04 until there is a focal
coccinelle. Below would be the way to do that...

Thanks,
Taylor

--- >8 ---

Subject: [PATCH] .github/workflows/main.yml: run static-analysis on bionic

GitHub Actions is transitioning workflow steps that run on
'ubuntu-latest' from 18.04 to 20.04 [1].

This works fine in all steps except the static-analysis one, since
Coccinelle isn't available on Ubuntu focal (it is only available in the
universe suite).

Until Coccinelle can be installed from 20.04's main suite, pin the
static-analysis build to run on 18.04, where it can be installed by
default.

[1]: https://github.com/actions/virtual-environments/issues/1816

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f6885e88ee..a3fbbe6398 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -340,7 +340,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
       jobname: StaticAnalysis
-    runs-on: ubuntu-latest
+    runs-on: ubuntu-18.04
     steps:
     - uses: actions/checkout@v1
     - run: ci/install-dependencies.sh
--
2.30.0.667.g81c0cbc6fd

