Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22096C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DDE2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG8pDC8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHYHxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgHYHxm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 03:53:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E198C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:53:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id oz20so10327247ejb.5
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=81SU5cuVDSGlBqqfIbndkS2oAzlM/VMvW/A9Ul9h1YQ=;
        b=LG8pDC8aTw/fb9cJKUGiUh/7sZSCjKL2ubWGxSl5LhW5cFvB6UgbxlLP9gJ1FiiYg6
         pLsdGA6SpJlaXJZZxbC6i/uStJRqygxE5VyhEtyEGdjMc6UL0cj0mWbD4VL/jy++QWS8
         4wHxbZydoHiIAgC/2GdiYz2PK6V7AoajCC8EGVCF4DcZs1HGz8vyMjc1MROqnCyTbNT1
         vtDLh0s8OyVPHw7a2M81L4xkRdQ1U3HEX6pvr5QSb9RtLCtbv8MoXbaFeu33/47Zt/3r
         00U2cL9/M0Lh4ZtalUhF6dpfP4x7Xh7PBWTG9X7nzmXg+g9PrUsh69ilVkzUcZw3UuC5
         sNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=81SU5cuVDSGlBqqfIbndkS2oAzlM/VMvW/A9Ul9h1YQ=;
        b=YdJNqAIIqAhhQUj/z1u5pY5oSHQ0tCakywfqShVTGtdGvY0fZD6XN6wNblLNb0M/zZ
         MCXrM03AO63omFXgWXyWV19ORYI7FDw/xwcNcAnT9vLt/tw+qgk8KHqlncPyqUn5JcuV
         IOdw0LyVyZVWSslrX3jtmBqQ9iFi/Rg2FHBQIwpy7V+iepbnTae7xZm43HQFQ6jy3m+v
         qatBvw9KsCsVXN/OongUJgFhzErv3xSZrI8Sk3DxWZSc9AnYuYjXugEysaQtaI7uD0Ws
         7AhaxoheqABOf6p3BDpOVvjXIvi6nNPzhvQT9Y/g24KgCJoctpgbrTTNXdxXRRSgpM8y
         pKQQ==
X-Gm-Message-State: AOAM532ATaD3LgnAbD/V5Ln+JKWbCibZ69POOfIFpvuHzLfapTbifwJo
        9hZWl+vMmdwSha8lB/l6pmBuoy3uuK5Xi7ZGFeOO0YpbJhZ2qg==
X-Google-Smtp-Source: ABdhPJyBF7ojC0KqVaLr0rAqK5KloS/41sG+uPzxgoSNnR0miyGTKgsvXI6WlvIvLmaeS8eRZ5S2/VP8NkF5YJWwk9E=
X-Received: by 2002:a17:906:6146:: with SMTP id p6mr9539569ejl.211.1598342019829;
 Tue, 25 Aug 2020 00:53:39 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Aug 2020 09:53:25 +0200
Message-ID: <CAP8UFD3f9=yzWVgqqCiO4BTOA-QfyzbgRbei6wLkv6-Gc3eVCA@mail.gmail.com>
Subject: Draft of Git Rev News edition 66
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-66.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/453

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
August 27th.

Thanks,
Christian.
