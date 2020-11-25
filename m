Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC7C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAFA206B5
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbP2+CcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbgKYR2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgKYR2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 12:28:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834CFC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:28:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m16so3413621edr.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Cmfm6lC9nzxDsp3+Trj90ASshiuvTuTRpymjWJoKPSg=;
        b=CbP2+CcC6nWaLfbPTABJMchMAqOXGyIyPJlvI/SxDleTUwwZZOw1wt/UwTEMzC9lmT
         Nde4Raspz2DdrizEdyS1L68/SNOjFyEvRsVu5zZh+IPcwf3C94Q+Of6zzdvl1ljsJL9X
         KaXZcL4zfEnNouvVedir6usOXjg5+F+oIihBGVssqO7vaXGTVU3aM9DlXrMgvvsrEXfq
         jIl9SGNvv+5K7AXkWOJcSjUJtvpXqN6gKEAwHzO5fT12LWLSV4YGkbpiS8HECPyuaR7s
         qtXTIgWQOliNhjJMWo7Kqk3vdwNxKFJjJMZSn0wlrnJNTpwlHILttIytvefIHyQKnuHR
         Dabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Cmfm6lC9nzxDsp3+Trj90ASshiuvTuTRpymjWJoKPSg=;
        b=WS/I/eUDImn6HToZ/Petu56jHSSLSnxH0MOQDzUrxGiRCJX8WS4mUE0009szKUScyh
         5zm/kNJmRV1ISsKL3JB5poMh1Yc7G1EJaRaGq8G9P0719k/E/a8w8/giOIH44pK0U0sS
         sDI/s012wp80LW0gNcY47rWyU4cYjiJJy75uiX4GJJu/FKzu9viAOLhvFJRgbJL7/uy3
         KyxoUq828JJd3X2J9QTm1/GyXlcaNyUMpJXhHZmIye5Ny8VkjMGiE2mxneCRzfbpHKK6
         ncxNA3NhlPUxSDB7DX2BbuiwWa7uKiG4fg3Z9KWiA0Nx62Ba0SYVe8IS4QH2I+poQxW3
         tDmA==
X-Gm-Message-State: AOAM530lFj+0QqWPoxxOZHnCDfr4hEfZpG4SNeeI2/sKZouwTvtiumV0
        Y4uU7h70YiguJ/n7ITnycIV8UIHIp+8gAs5YfR2CG4+B46XZLw==
X-Google-Smtp-Source: ABdhPJyGa9iRv+eqUqfDWJii5gXj/1nSINP1/zkMsbn0TK0slipcrLWHU/yoFGy9C4CJZuBOiX49xJr/aDXXk8u8kI4=
X-Received: by 2002:aa7:cb52:: with SMTP id w18mr4537309edt.362.1606325326992;
 Wed, 25 Nov 2020 09:28:46 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 Nov 2020 18:28:35 +0100
Message-ID: <CAP8UFD10RsOi8_gdg-ZbcrN2HHaPyia096svnjmCu_U70LU_8g@mail.gmail.com>
Subject: Draft of Git Rev News edition 69
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Victor Engmark <victor@engmark.name>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Tarun Batra <tarun.batra00@gmail.com>,
        Semyon Kirnosenko <semyon.kirnosenko@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-69.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/463

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Friday
November 27th.

Thanks,
Christian.
