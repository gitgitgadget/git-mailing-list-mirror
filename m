Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101BFC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFC1207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgAGMuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:50:54 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40842 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGMuy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:50:54 -0500
Received: by mail-wm1-f51.google.com with SMTP id t14so19236438wmi.5
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 04:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+PA3/MmBiZfLrlpXammFMz5QhXgXfINzYb8XXwI3KQ=;
        b=ouTiT4HlRLVbqIeG3rbZPC75r9FWAWNXgRBhRfPBp/eZ5zaRLIfHrsDzmRClhU+a5F
         EImLarfjBqeBRq+HQzj7MywWQxCD7Nif3q68j3vnOLkUNfJ9j8WcFcurebRqkljWCHqk
         PsTHAR1kugimDRfIO/xXT+vaGNTZWfPiCbShyQ/FIaeMPliZiZMSxxdGSH1iYXhs4Sza
         /UxCOyDUTlbBhAysVHEVxduyDnW1SoyhvjEdPzpRhnDWu9h6y5+q2hQTz96sp9svKB21
         TqQ/plhffBJuKTKNkGeQgeyrk2kcG8DD+DJ5KnQqB6sPvyDZPHYgkUF2axEdXSLwyNWV
         G2ng==
X-Gm-Message-State: APjAAAVPFW0eWi8zFefsH1z2+ni6FjOrN9BZ/fTrgnI7zdZvA7iILDKT
        9p86lnYnmAuz/17HkdzUNK9LZ/2mTTAVGkC3COs=
X-Google-Smtp-Source: APXvYqy8vn0O2cIsr5zH3hf57qmP12bzI0Ub5cMsKej0w8Kzx2ztH3UJWl19YIwDIfVBvxybN8/aP615n2qoooBC09o=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr39522409wmj.75.1578401452892;
 Tue, 07 Jan 2020 04:50:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net> <d694a5b5-9c88-0a34-b9fd-050e5e02c312@gmail.com>
 <fe1cd838-d390-96ab-d3b4-72df5aa61947@gmail.com>
In-Reply-To: <fe1cd838-d390-96ab-d3b4-72df5aa61947@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Jan 2020 07:50:41 -0500
Message-ID: <CAPig+cRH-yeHmeikf=cbTTMDom+7SLtT2dmya=WP7fsy8tTY3g@mail.gmail.com>
Subject: Re: Assertion in git log graphing [regression in v2.25]
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Bradley Smith <brad@brad-smith.co.uk>,
        Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 7, 2020 at 7:42 AM Derrick Stolee <stolee@gmail.com> wrote:
> Here is a a patch that reproduces the test failure. It hits the
> assert, so it definitely fails.

What happens if someone builds the project with NDEBUG? Then the test
won't fail as expected. Perhaps this patch ought to also change those
asserts() to `if (...) BUG(...)` to ensure consistent behavior.
