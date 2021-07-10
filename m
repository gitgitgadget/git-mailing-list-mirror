Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A60EC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 04:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2628061361
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 04:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGJFCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 01:02:05 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:56818 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhGJFCF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Jul 2021 01:02:05 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Jul 2021 01:02:05 EDT
Received: from myt6-d81e73bdf7a6.qloud-c.yandex.net (myt6-d81e73bdf7a6.qloud-c.yandex.net [IPv6:2a02:6b8:c12:422d:0:640:d81e:73bd])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 7EC614A1840;
        Sat, 10 Jul 2021 07:52:41 +0300 (MSK)
Received: from mail.yandex.ru (mail.yandex.ru [93.181.207.110])
        by myt6-d81e73bdf7a6.qloud-c.yandex.net (mxback/Yandex) with HTTP id WqF1Pa0I78c1-qfImGvbD;
        Sat, 10 Jul 2021 07:52:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1625892761;
        bh=VWNd1K8d3bhPkxgLacOvosS87mhMTm7m2r330cvvZvo=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=MGFBxIORT2NIipUJAT9tc/CI4PNteZXpulOl/1l3mMp0rVWZRHoDka1ciMbGVB3v6
         WsWKCe5MmRAsy/JNqFT7OwRdvChl0vowxhhpAe9SimpbSWny3EYCoG6wZRDNU7aRFg
         L0YyWJzAQBTcGhU9AdDsO/qDqA5Y+X7Sos0b6JlQ=
Authentication-Results: myt6-d81e73bdf7a6.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-ab88f6e23eb0.qloud-c.yandex.net with HTTP;
        Sat, 10 Jul 2021 07:52:40 +0300
From:   grizlyk <grizlyk1@yandex.ru>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
In-Reply-To: <87a6o459bh.fsf@evledraar.gmail.com>
References: <3957861622848346@myt5-a5512e99e394.qloud-c.yandex.net> <87a6o459bh.fsf@evledraar.gmail.com>
Subject: Re: Pro Git book: concerning data lost due to ".gitignore"
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 10 Jul 2021 07:52:40 +0300
Message-Id: <4458411625892760@myt6-ab88f6e23eb0.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi

> On Sat, Jun 05 2021
> It's way too common of a pattern to e.g. have a *.o file made from a
> corresponding *.[ch] file(s) in the same directory.

The patterns were common for old times (before VCSes was involved). To deal with temporary files (like .o), generic OS tools like "make remove_compiled" can help to clean directory before stage. To keep derivative persistent files (like the same .o) separated directory can be used.

> git already does a good job of supporting it. 

Sure, the light message: "There are ignored files (%u<number of files>) not placed into repo.\n\t(use git status --ignored to view)"; will improve the activity. Otherwise some files somethimes will not be placed into repo unexpectedly for user. 

> You'd e.g. compile all your 
> assets outside of the repo via your build system, and just not have
> anything in .gitignore.

Do you suggest to copy desired src files into separated repo directory (the repo directory placed under VCS control) by generic OS tools (i.e. by cp command) and stage the separated directory? 

If yes; for the first it is copies of all src files; for the second we could lost some src files due to the possible wrong copy patterns (the same reasons as by wrong .gitignore patterns). 
So, to explicitly create output files into separated directory and to implicitly include all files in src directory into repo is only reliable way to keep commits without data lost (the way will sometimes include extra output files into repo). 

to explicitly create output files into separated directory is responsibility of translators and makefiles. 

Best regards,
Maksim.
