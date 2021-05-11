Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55FBC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7654161879
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEKUPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKUPb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:15:31 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1DFC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:14:24 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso18561524otb.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ao6wJ6bV4L4XzDJ9Bmp7ok5dV1tT7q/UlIXg0gDCnqw=;
        b=WuFhs0bq/Uh/4mh6y2OYgc1eprNWzaDKzNR/DQYVsIF2oP37aw7ZpgwlN9CQtWc6d3
         LQJJ9QyD/IfkwHQ/Y84ggGAovYszKbVpbNfGZ25hfskNjLLO6BlxrXHDOyhLgIwQsmLn
         s6uYWNIXz5A25CKKgE+8sIEgc+IwIT1O7J93BtPPfD6R48xzpQKcoOuH+FtmQT1PbqP9
         bP02cxwaz5LRyuKulPmjClFQIw0LuauXhlFjK0+bCACrgE4/D+bzIFxTh4vAbw389aJm
         WWBK621e+/v/NmgAYV1O5ZBbTtHkfqShOscl3f3SaaQ6XefSSTOx6n/RSZsz5L4oYwoj
         DoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ao6wJ6bV4L4XzDJ9Bmp7ok5dV1tT7q/UlIXg0gDCnqw=;
        b=nvx8dY+URZYKx5ZhpNRsN1DKAnwS/95V9IiVvxrpcL0O89jtTfxQXuSDqKxFve5pRG
         1cQ4uTXhZuGNewnKo28KlB5Bvci6LviuzWiSQbXL6cfWTWDUKGzvR7jQJ5uawEzafj/9
         oVeqaaXt+DYnxzNgEBlxi8NQ1V4aDzaEywDfO7BmXFSjrhJqCZd4q1AxexzRcaF/y3jt
         elh+CmzGfoYPrVgzyMpUq3cznyTM76FV3h3cjKsM3aG0VlkiTnUKA/fLNgEEBS/Z2SB2
         7u/qztAsbCvWeHtKyvenDxAtOCGDqBEE+TH97lpwH6FedTj39sFNcj502EtW8orp0CIz
         pCqg==
X-Gm-Message-State: AOAM530MMAZgMauYTz52ewzC6MCLQ6MmSsqIhAesS/ApkVXPp2N+Vdzo
        f2rcRV7jHIUpmMTS2HOH1is=
X-Google-Smtp-Source: ABdhPJzCYmlXLIqPxsOjbwQxR/U5UbX+sfTL04ddUDYcdJb4vU0GKXRHO+5bWueblFJW/5207cIN9w==
X-Received: by 2002:a9d:664c:: with SMTP id q12mr28124277otm.76.1620764064131;
        Tue, 11 May 2021 13:14:24 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id a11sm3400917oif.52.2021.05.11.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:14:23 -0700 (PDT)
Date:   Tue, 11 May 2021 15:14:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <609ae59dc3f0c_60649208b8@natae.notmuch>
In-Reply-To: <YJrV52HOv0mlbJB1@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <CAN0heSp6uw7yqNZLD5w13xJUgnUtgHM0OYw9KQ6Z-FKk+x4OPA@mail.gmail.com>
 <YJrV52HOv0mlbJB1@coredump.intra.peff.net>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> The worst case is just making things slightly more inconvenient for
> Git developers on older systems, because because they might have to
> install an updated gem rather than using the system package (you
> sometimes can end up in dependency hell for a gem upgrade with
> versions of ruby, system libraries, etc, but I haven't found
> asciidoctor particularly needy in that respect).

The asciidoctor gem has *zero* dependencies. If you end up in a
dependency hell, it wasn't the fault of asciidoctor, and it won't be
affected.

I've been using Ruby for at least 15 years, and I've never found myself
in a dependency hell, so it would be interesting to see how anybody
could end up there. Sometimes the mix between system and user gems is
confusing, but they work fine. I wouldn't call that a "dependency hell".

And of course you can always just `rm -r $GEM_HOME` and start fresh.
Most gems install rather quickly.

-- 
Felipe Contreras
