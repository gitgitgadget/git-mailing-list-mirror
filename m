Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC44AC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBABA2075C
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfK0QyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:54:06 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43941 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0QyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:54:06 -0500
Received: by mail-il1-f194.google.com with SMTP id r9so21572373ilq.10
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 08:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VzZbmT7AIFxX9CdBdLA0pf73DvCRINY/ORbCjmzohY=;
        b=k9W0ePCTE9Z8GFxzQAKhgZxlwFfbRDuXKBzwqCh4x44lUwxay8Fqo/XpGOmES0VzhS
         pUK6UP2kw4yHmtgMG/G/2Prt6kQbpmaVGvzJ4CWOUgOmTASl+4dnQ+quzbVE7OtBDQF3
         XFHRjGoBNvJoKRqU1R6Yw5WEFRielda0+cvRhyl7J2RoH/lkO2DexsLM6scEOL6LxH2r
         S7QxBP8LyXv6YwmP6N2c99VyAkbcxr7S5lINcoiCfqvThH492/oG8pYxLWg/txXtAmZY
         y3qpNIqeuV6C9fQb8IP3UEOypvZSK717y/sX0XajA21n9mt1/HFB7/knMwhbqmJqXN3N
         +TkQ==
X-Gm-Message-State: APjAAAXRWvBA7oXhirvU1iW27B2HNOjN/J6eN+i2rTP79xLPSvV8GOcz
        ognxLeGLXr8SeIcwsgT1PAuLMKSJc2sTxywW3gk=
X-Google-Smtp-Source: APXvYqxoNOHR8IywUILSSGp9dPFnKOoIkPshZhXvPJkHJCWwH77DKqMaXBtmbzY+4aHqEcUmzUsG1v3O92xjxWF5row=
X-Received: by 2002:a92:3ad4:: with SMTP id i81mr43287914ilf.18.1574873644044;
 Wed, 27 Nov 2019 08:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20191127151708.50531-1-emaste@freefall.freebsd.org> <20191127162416.GB30581@sigill.intra.peff.net>
In-Reply-To: <20191127162416.GB30581@sigill.intra.peff.net>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 27 Nov 2019 08:07:30 -0500
Message-ID: <CAPyFy2AyQGhFxzd2AEGhtU5u6OHZD-mJy4duXCs5-YYVbvkYFA@mail.gmail.com>
Subject: Re: [PATCH] t4210: skip i18n tests that don't work on FreeBSD
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Nov 2019 at 11:24, Jeff King <peff@peff.net> wrote:
>
> > Extend test-lib.sh to add a FREEBSD prereq (akin to MINGW) and add !FREEBSD
> > to these tests.
>
> Before we start growing more system-specific prereqs here, can we add a
> layer of indirection? Convert this test to use a REGEX_ALLOW_ILLSEQ
> prereq (or maybe there's a better name), and then set it for both mingw
> and freebsd?

Thanks, and that makes sense, but should we make the sense the
opposite way - set REGEX_ALLOW_ILLSEQ only for glibc (including
Cygwin, I guess)?

This also applies only to two cases ("latin1 + locale" and "latin1 +
locale + invalid needle"). There are other !MINGW tests in
t4210-log-i18n.sh which do not use invalid UTF-8 and work fine on
FreeBSD.
