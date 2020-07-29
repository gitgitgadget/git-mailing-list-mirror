Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94DFC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A93E2082E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596051915;
	bh=dLh6Q+HSyi1wyFuxupa7Vg0L7fnXCo0taizAyhS1GgA=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=crfwfD66JlfULjKXlYnOArDX4YU4HC5yl5Z0UNdo3HQCJvW4Q3hVuFuL/32cZqhd1
	 yorUIp1klx7oNidca7GdS83CgcLcISK0W7yE7/F+V9z039xVjuXIHljrkf66djaA47
	 ntBEfucHsbh4pr8KlvgSSL/So1HZrx/3vzgmSeZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2TpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2TpO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 15:45:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744BC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 12:45:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q7so26359441ljm.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hZayYGqdabUcEOOrGc9wNwF/Ij3PuDS3VRuTkhuYxcs=;
        b=QlzMR3mpluHyDcz8miSxki0O56wK4Is99pvuWzyQjEh9qh7AavPu8fqWAY/sokdqUT
         /R/MwQ+MQTl+UvOu3npXv7gYkg08DD0jvZJMnSg1vv85OFWpK8QFEhFmiAJ9sJzm3H9P
         5uyo/VlfIUtttddjnHFoHaQykioNvXslk9Hqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hZayYGqdabUcEOOrGc9wNwF/Ij3PuDS3VRuTkhuYxcs=;
        b=okhVv0ElPj5BHtSBSsHtqyixLmkH6XXlPvRw4Qf0FJ8wXiXDpc4BYxVl5zYWIn5gdE
         VQjXpXYIWacxNNOyMrqeUqGrnOCAQUukewznKwhIDy3Wg8y5siDzCvYV8TjUzy8nJfiG
         eIjYUOtagdikXu2PgIr1OuR1kGs1iYwbU/70wjpFUUPxReS/fv0JP6Yoi4bfqdzbOxJM
         qkpgw2jL0z3PiHgYYPH8AmcuaGe+nrU4zo2rMKAowiY/C7rRtyeH8+1kka/kN0xCHP3B
         InZryJHmSzwjplIOnTOzNPcWpYYqjvBNK+1KwU9q34aoQbMBFD5SYeCj8Wm2CD5Nv6UP
         w5oA==
X-Gm-Message-State: AOAM533l7X8h+NJGhQIbeQz/cuhxjwC4ako/Mc6sqTWxMcZa07VNNTW0
        KM3ejUvpli07Scz8ejnvwZSk3UTwii4=
X-Google-Smtp-Source: ABdhPJy7kTSOUIDzX9S3Icd342hFHK90vFDcqgiByG1QW6+4TRhictKhiSSBcw93eg6ZLU7FACDYdg==
X-Received: by 2002:a2e:9bc1:: with SMTP id w1mr21696ljj.288.1596051911374;
        Wed, 29 Jul 2020 12:45:11 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id b18sm800132lfp.36.2020.07.29.12.45.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 12:45:10 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b11so13698721lfe.10
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 12:45:10 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr8641583lfa.192.1596051910327;
 Wed, 29 Jul 2020 12:45:10 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 12:44:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
Message-ID: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
Subject: Avoiding 'master' nomenclature
To:     Junio Hamano C <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that commit 489947cee5 ("fmt-merge-msg: stop treating
`master` specially") has the exact opposite effect of what the
intention must have been.

It may remove "master" from git, but what it does is then make it much
more visible everywhere else.

In fact, it doesn't even remove "master" from git itself. It just adds
more of it into the test suite etc.

So that commit is doubly stupid. If the intent was to try to avoid
"master" as a word, it failed on every single possible level.

The code that it removed was the code that actively _avoided_ using
"master" naming, for chrissake.

                   Linus
