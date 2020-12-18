Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E61C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC992151B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgLRGP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:15:59 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:36607 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732303AbgLRGP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:15:58 -0500
Received: by mail-ej1-f46.google.com with SMTP id lt17so1564213ejb.3
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecjYp6d50zEI0BRIe0zf46VPZ1YeM36DrF1ZO8sKscw=;
        b=qN2/OBXbhkxU+/nxrxDPPNGZwJzF2r0fq7UINjfBQVKYlOlXqZxiQjKo/zSJa1Zvdh
         PmD64b5tiI1l+7ZgWzR78WIgthCDOTfgLCWnTsTGCzROEWCr567d2OklPibBOgZymWUM
         8q+L68EIiRRkhuJZOojeprMAquZ78fpfkHZMtshpDtp5vOVd0caOdmAREdHnKQfv+jKG
         Slh8bJ9/GoFG2EjFpYdPe6OXr9d2xJ7xi/wyvSrHjeMKwA2EUuchUh9UQZ7ZE1cuMNWi
         0DRcUY8yNQ7+OT//Yr1TBan3+JMhqwpbZV5AXnzeybFPPy5XlQHOP7T58uK8ffIWCP52
         Qwkg==
X-Gm-Message-State: AOAM532rtCO0ZSzvxkfuM9+GOIJx45RO0Kue0PuMeSmLkuKBc7ubnrJV
        KZgPKXJHN7cjuXfSohfnRKx6+r3Dz5ZrP5IQ34b+EooY
X-Google-Smtp-Source: ABdhPJyF3qxhg9MUIblMLvDNp+/sLednHgWiHKNS20BT4aiM2SDIE8k4ZIKhkUU+VAuyv7MLIjuLhRtBwTan/fYvOz4=
X-Received: by 2002:a17:906:608:: with SMTP id s8mr2452586ejb.371.1608272116722;
 Thu, 17 Dec 2020 22:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20201216073907.62591-1-sunshine@sunshineco.com>
 <xmqq5z514lj5.fsf@gitster.c.googlers.com> <CAPig+cR+4Wh4Sgk6UhUML4SHqaQsvYmw_77ih+oec2YmqQJCCg@mail.gmail.com>
 <X9xBRXW7/tXsqLT5@coredump.intra.peff.net>
In-Reply-To: <X9xBRXW7/tXsqLT5@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Dec 2020 01:15:05 -0500
Message-ID: <CAPig+cQvaOBo=zx=f2ZsPy7QnPXgcdc0SUZyGWaZPZ31FUUwZg@mail.gmail.com>
Subject: Re: [PATCH] t/perf: fix test_export() failure with BSD `sed`
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sangeeta <sangunb09@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 12:44 AM Jeff King <peff@peff.net> wrote:
> On Wed, Dec 16, 2020 at 02:29:26PM -0500, Eric Sunshine wrote:
> > Perhaps a test_unexport() might be handy in the distant future, but
> > presently there is only a single call to test_export() in the entire
> > suite, so it's probably not worth worrying about now.
>
> I actually wonder if we could drop test_export entirely. I assume you
> mean the call in p0001. It is inside a test_expect_success block, where
> we don't need to do anything fancier than just "export". It is already
> running in the main script's environment, just like a normal test. If it
> were in a test_perf, then we would need to take special care to get it
> back into the main script.

Considering that test_export() hasn't seen much use since its
introduction nine years ago and that the one and only existing call
doesn't even need the special subprocess magic, retiring the function
is certainly an option. On the other hand, aside from this one minor
portability fix, it hasn't been a maintenance burden and may actually
come in handy someday if people start writing more "perf" tests. So, I
don't feel strongly one way or the other, though I lean somewhat
toward keeping it around.
