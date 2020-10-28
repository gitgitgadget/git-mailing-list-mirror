Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABBCC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C678220735
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFx7DGhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbgJ1W4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389664AbgJ1W4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:56:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF068C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:56:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d25so984626ljc.11
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xEOU9dauF+GcbkdhJf1UaRCxpOTRxUHTnvLX5XbIcW4=;
        b=iFx7DGhTadjEmL86QpkqCdgKX+ler8EjoR4a5yEKRYKJlB0dzwZ0wZ4fIHVXiVdNoi
         UERFkEJHBMlcJvY8ooSeyTrqxk48Cdo/r4Ew5MQV4aIaxPjuD0I5h7bOth3viUWP7eNv
         B8kn/Fzmefmj0IGU35Kieu8CxvueGprXvjppsL/jY0jvDb6i8yPIqmFOuUBCxNHYJpGz
         ZOdzRlt6yRqgVOk0HO9ooF/ouTCjw7u7G5PWsfUvgIu7uiG1qkd2a94sy7AoyTKdapsi
         sONx95+0rUA8fRV5DbO9VqVQGl//QziX16M9c8aw2xFl5Pn11BzxmJW/XcTXXMBwA0wI
         L+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xEOU9dauF+GcbkdhJf1UaRCxpOTRxUHTnvLX5XbIcW4=;
        b=XtRDr+GwNvRQSibLlXVlDGK5/2v0GMaUyGbruhuTt/c5RYyBVdkclnDmjJRfnLasoR
         z7n9gT+eth53Eqz509NCdGWfbw80Aps920eRn1nhucHLkiTepzalM9KmklpSYSPbSI5D
         3XgjHoQJKkQJrwsRd4ZOEvyqkk5XtppTg5/RyyoVQeBy7oQIfAHFXbxYEwV/uDDf8R7b
         edzCl4PIuGKYo6R68fxd/jt16XFChiulPetCMa6Yc2CwBsXB8Wc2wkNzwuMAtO8jVvxm
         KQDYOVs3isPyVzba3Ioqy//A84MGqiYWR5UuibmxLPL94VOK66hD3UCd/lZ3wUElkZBu
         OkSQ==
X-Gm-Message-State: AOAM533EamY/9dQr0GtFfLqwe3kuPgsBhKbBYTcY6L6FHPq/BDaWU3JK
        N3uGXHgv79ATN+rBkwlD9sda910WotGrD93Cci+whkwzndOFxQ==
X-Google-Smtp-Source: ABdhPJzauvY/+Ohs5TYbQqQOLeuQEfSRryMPmeRt+Bm2ewfkwPp4mTSinK56z1x/dlEvS0Coi+MRMJY4ONs3h6wP7nI=
X-Received: by 2002:a17:906:68c4:: with SMTP id y4mr6750952ejr.197.1603877603954;
 Wed, 28 Oct 2020 02:33:23 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Oct 2020 10:33:12 +0100
Message-ID: <CAP8UFD1nCqoxe9pnSo1Q5290x2W8H4YpzQj6DFBzEmNcZan25Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 68
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-68.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/460

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Friday
October 30th.

Thanks,
Christian.
