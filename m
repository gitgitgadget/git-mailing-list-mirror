Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A741D1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBEUQl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:16:41 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33454 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBEUQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:16:39 -0500
Received: by mail-qk0-f169.google.com with SMTP id c82so6279672qka.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3pfy8Jnihd6vfW16X66WSk82M7lmdXU4buDE6skOzFI=;
        b=pHxrVcrn2HQvg06O9q8igYG7I9fNHAX4uNeXHuQPYSDWBZv5DdrNpytec0chuxX3P9
         MjimkCbidKWW2SX91IjySGcllkQD48FTmBjd7L31L44BhQhYu9t0f2XtUfWXuBPjdjYb
         KNRuCi5nT1dNOQeGUJIviD+ZgoKkYXo7A6yLtdRg18J1GeJnhCU+ElVQtnVxotrF9fXk
         PZ9UB/D565QxRqSSXkbO13v+xCvGG9Zv+N3N6+UFUUo+27wPppa0B6vZk4RiZ9coJmpJ
         iI942elAB4P31YIg76sJgB0uglCk7BR9CCgDAZKec2R3AVXh2W8sm+xN61haWLaeI3NQ
         3fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3pfy8Jnihd6vfW16X66WSk82M7lmdXU4buDE6skOzFI=;
        b=I4HFghv2cJKGqCJQg4cgtrDp6RRNBoTgLmJNoHwUydta5BSK+AsI0XTh9pWGzl3nVT
         xRUoGfDW05BGx67SsHfCIbvIKncZ5yY1NHdHEMOvjg7P0FUvGpzGsaWMgYhmKIhNPU/+
         OnfwQ673mHW37qJ8W4nQuwutKPvk+Z+K/eb/5jjNanxoqEuOomVF81T6kSpw0L8GvebJ
         BCKVx9Pe1rxynPYlo4gEVPMfe7ZlprO8c5PCbB467sqhPDzeaOpt4F9sFSjLIakyf9qC
         CqY0tBchss5oRnd1redmOWSNNAyM2eEkFonDMkLlPmCsGVNxa2sBK7w50sAKa2mXUNtr
         PY7A==
X-Gm-Message-State: APf1xPCjP1DqMJzbJZSUj34lph0NJ3Xyu0jDOZpxrCqhwjAV7+/l/ZeI
        PvDo36Lf9X+/+0bxL8r2fLQNyNbl7W+Z4NoVH8FwlkF8
X-Google-Smtp-Source: AH8x225YzllZAxL2fpJULYOCJ5hWRAaYu35mZ41fKQieR0VKK8YCgzYtI1qwZ6cOS7kLdzsO2wdpBkV8kSyTbDor+7c=
X-Received: by 10.55.66.77 with SMTP id p74mr12272873qka.205.1517861798783;
 Mon, 05 Feb 2018 12:16:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.138.10 with HTTP; Mon, 5 Feb 2018 12:16:38 -0800 (PST)
From:   Ian Norton <inorton@gmail.com>
Date:   Mon, 5 Feb 2018 20:16:38 +0000
Message-ID: <CAGUnuBHY9nQvGiROm4S_JvBWMrzieHC1FE50fJqxaauzZhH7xw@mail.gmail.com>
Subject: Are concurrent git operations on the same repo safe?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm generally used to the idea that if a thing is not marked as
"thread-safe" then it isn't thread safe, but I thought I'd ask anyway
to be sure.

Is it safe for me to do several operations with git concurrently on
the same local repo? Specifically I'm trying to speed up "git
submodule update" by doing several at the same time.  I've noticed
some odd side effects afterwards though when trying to commit changes
to my super project.

Apologies if this is answered elsewhere, my google-foo is weak today.

Many thanks

Ian
