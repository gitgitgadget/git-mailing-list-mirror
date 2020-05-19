Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A720C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2722620758
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="ihCkAVjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgESTLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgESTLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 15:11:14 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC1C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 12:11:13 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id 134so121674vky.2
        for <git@vger.kernel.org>; Tue, 19 May 2020 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=f5x47XPm+ngbc3HcAO8mrZB1RaQzZiHw3uawsD4J9w8=;
        b=ihCkAVjFVIsajLY41Pn2RTBCaR7nLCOzkind9xFF5uFtUTEGdUw/HOQWSUWb04ZYzZ
         pgJtH33W4KuvlTs1LMONHSmhT7TMrXGA9USP7LegIHfYn+UJpblZ2KF02zTAohwyuR9x
         xQnPN7vgTZB6JTFi1aDpWXw93/zUPMYzFrQrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=f5x47XPm+ngbc3HcAO8mrZB1RaQzZiHw3uawsD4J9w8=;
        b=nujzeMJIBT6FIkNjaQgMYlcBj7jkE63T16Z59C8vut2KxNyBF/SLYJuNjr9EH3Y6dJ
         9dcTAh1URhqzG1hXXKw9OczY+B0WYNR/7Wtm/AGecg6g5HxGThHZsUCKv6ZMztZAhstt
         Yu1IgqqbCemB9DhfgTWpH22LsaeviMlRcHtzE6u0KAgxxfIHnn4L4GArLjoGdgMUqjZu
         RouVwDrncjXzH86mtF3ei1M+pjvLE8LV8gSSksOvlxvF8e6pbN0FH9lyX6v8/zvN1sdE
         exay6gt6aAoz6+D6XzCg2UTJCSuSdX+qASq8ZhZD3z5WnOPwU9cfW6j835Z1VMhx76D3
         nuuw==
X-Gm-Message-State: AOAM5305Wndj7T4SqWFncn3Oa5r6AEOH1kYKaZibKLgqCDfb/c+rvoR/
        As5t2OBBQkWxuGaJtxTuFG6umHhsrxWh4Dbf1uQ2xg==
X-Google-Smtp-Source: ABdhPJzL1JjRQ/FlKX+IMrxJ7nKl4g29mq3iC3EOcyVHLEEPRM7apQ7ajuyuLX8cNH91P7RA9D32zQ9I1T53/H/Vjxo=
X-Received: by 2002:a1f:254:: with SMTP id 81mr1119577vkc.47.1589915472854;
 Tue, 19 May 2020 12:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2punll7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2punll7.fsf@gitster.c.googlers.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 19 May 2020 20:10:37 +0100
Message-ID: <CA+kUOanbgUPgCer-sBjX6YROYvZAhzBTUtCnFvuYP1EWvo3VEA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.27.0-rc0
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 May 2020 at 00:27, Junio C Hamano wrote:
>
> An early preview release Git v2.27.0-rc0 is now available for
> testing at the usual places.  It is comprised of 479 non-merge
> commits since v2.26.0, contributed by 53 people, 16 of which are
> new faces.
>
> <snip>
>
>       tests: when run in Bash, annotate test failures with file name/line number

At least on Cygwin, this breaks the test output parsing of failures
when running with prove.

Compare the expected behaviour, prior to this commit:

~~~
$ make -j17 && ( cd t && prove t4210-log-i18n.sh )
GIT_VERSION = 2.26.0.131.g6081d3898f
...
t4210-log-i18n.sh .. Dubious, test returned 1 (wstat 256, 0x100)
Failed 6/17 subtests
        (less 3 skipped subtests: 8 okay)

Test Summary Report
-------------------
t4210-log-i18n.sh (Wstat: 256 Tests: 17 Failed: 6)
  Failed tests:  6, 8-9, 11-12, 14
  Non-zero exit status: 1
Files=1, Tests=17,  3 wallclock secs ( 0.05 usr  0.02 sys +  0.77 cusr
 1.80 csys =  2.63 CPU)
Result: FAIL
~~~

with the new behaviour as of this commit:

~~~
$ make -j17 && ( cd t && prove t4210-log-i18n.sh )
GIT_VERSION = 2.26.0.132.g662f9cf154
...
t4210-log-i18n.sh .. Dubious, test returned 1 (wstat 256, 0x100)
Failed 6/17 subtests
        (less 3 skipped subtests: 8 okay)

Test Summary Report
-------------------
t4210-log-i18n.sh (Wstat: 256 Tests: 11 Failed: 0)
  Non-zero exit status: 1
  Parse errors: Tests out of sequence.  Found (7) but expected (6)
                Tests out of sequence.  Found (10) but expected (7)
                Tests out of sequence.  Found (13) but expected (8)
                Tests out of sequence.  Found (15) but expected (9)
                Tests out of sequence.  Found (16) but expected (10)
Displayed the first 5 of 7 TAP syntax errors.
Re-run prove with the -p option to see them all.
Files=1, Tests=11,  3 wallclock secs ( 0.02 usr  0.03 sys +  0.74 cusr
 1.83 csys =  2.62 CPU)
Result: FAIL
~~~
