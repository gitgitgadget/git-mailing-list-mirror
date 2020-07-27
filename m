Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE017C433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6C92078E
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU029PIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgG0Sue (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgG0Sue (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 14:50:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE56C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 11:50:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so18151600eje.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AN6WF9Crve7gd9pE2ZDGTaXKt87BjtN6tcZJbVyvWBY=;
        b=fU029PIoCjFfDQ3XIRnNLSPVG0CroK81NY/dW12iPrupTa3hGIS5O4xHhJi9/77KxG
         dBM9w4JiWTm9mF5Vnp1GxV2IWa7O/DQrAlwM3mAmNFXf9JXHIiMKghbZ76LPACbcz5oO
         vVeUhRt9j2fVfjK6ZCULMZuw4MucjFejGiKHW5migKY1YOe6aBo0q/+kn9EG3XY4RkO7
         nrxa3e1lBxxJcY8WNPMy/duwRC28mwGdXDdTfWN5jT3TS+G2Gem8RhFXiCmaQr3nH+jx
         K0sHNHN2e9FJuhGvXK33qAOfeG1fl/Z0bUKHxtihK2myUyW1ILStxRdDYaRBUD/LwwOl
         uf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AN6WF9Crve7gd9pE2ZDGTaXKt87BjtN6tcZJbVyvWBY=;
        b=iqMg8RvD+ivzKwvqU3ovhpqOfyu3ld/WDj6z07wbNjU+C3cTc2A4bwUy3ZU7KxxHik
         h6dUrlP5RAYJg0VP2ifIPGSYyffMbR9qL7TwEcPxmagRg+J12YJulO5wzTMJ47bdtGcW
         7CDIYibLS6e0IimOwPX3adKAJWrdrqNCQZD2UCTvOoNMKWC2ttX2MCNRZnyQ6ewYjHHy
         uRX4AKykrl/j0lBVXiS60s0zW147oRBNJKU+9HxRIeIrnEv1gZOa4E3q9oRLBECgrtpJ
         WA6UUZHQFGKd4TUFvObo3j3P3pr/ZPSdYAYGY0R1/ZlJtWcK9X/yC9RxSgrXXS9sZtTF
         cU4g==
X-Gm-Message-State: AOAM5317FvSysmTHqW2wzDzEdG3bC2wWfGqeF2BUZF9ZizYMpou+MjmU
        gSII+A6Ovc2cwWSU0Tt7FHUvXvnfvRGan//LCgIk4kIQTcY=
X-Google-Smtp-Source: ABdhPJy7zujmtqlX2vEAQQiQm3H8ZHl142RVL2n8yzbbHL1CNoOrVw7u8l/HnnGjDuoUJ+Cjlig4o5JvPgyATVC35JA=
X-Received: by 2002:a17:906:6146:: with SMTP id p6mr15756184ejl.211.1595875832259;
 Mon, 27 Jul 2020 11:50:32 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 27 Jul 2020 20:50:21 +0200
Message-ID: <CAP8UFD0X33kreC2Vf-LUQbzm0hcKMyCwjwRqboT4BU5cejE2rw@mail.gmail.com>
Subject: Draft of Git Rev News edition 65
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Garima Singh <garimasigit@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
        Taylor Blau <me@ttaylorr.com>,
        Brooke Kuhlmann <brooke@alchemists.io>,
        Liz Landau <lizzie.landau@gmail.com>,
        Carmen Andoh <candoh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-65.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/441

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
July 29th in the evening (European time).

Thanks,
Christian.
