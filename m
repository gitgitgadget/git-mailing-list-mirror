Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266BC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 08:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F30B20738
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 08:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F421AATk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgFWI3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbgFWI3I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 04:29:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A90C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 01:29:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so6342660eje.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oVH33qcYS7yIidDQCRvr/14cOfSb7tEm4DoOGZUeKNQ=;
        b=F421AATk8tOw0gfEcFMjOWhAJ1vL88odrA6QY6K3I3NfSkbxD2qSncbMsr/OTPIQkW
         3H8n1hbLtqSuRdqUgNEfD5qLjlHtjAiaS7J4dYWyhmdDsrGjLcwiMG4gvwNgkNuwpo/l
         pplZVkm9LYRBjDbCJlubKeicZW0o+fDrdGMjO+ZDQJmCj8HxjcIeD2I5m4dEtmyzbHKk
         WRtt8B8na0+E2DwhTcWr3GByOQcXJHlu7x7LbDW9ehUDjPoPidCH/W5Xw1GBt8v2RFvt
         z+PJ6upRLlhDDz1jsfrnj9BKDPu/U2qVHkp/x1CRVMuXE/9FMDJ1/04wt5nJC68H294U
         lmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oVH33qcYS7yIidDQCRvr/14cOfSb7tEm4DoOGZUeKNQ=;
        b=O18WscRPUHQ5CrSh46HZwdoCMm2gF8czhl5I7i+DqoDkGryu/U3x0kbZZ7xU0nFhNu
         M5g3N+GNBdR5I3itKXT4VKHteCFxzVfEcwtugxAqMlbp2hzfXT1yf3nYwUXfRn6TFR6u
         LLufsrTcJ2atMlMoNEW8YzKYapCij0Rc/Yclp6lez8iRYzXGc/xaWmQccbbDI6PMtXC9
         qVaDeV9saXfvKYjvLdUeXBDA/4ox06BBXktAJMntbjxenqfUA25+97yy1FaQq9xZ3Di5
         kPFb0BChR5CY8wF4DHtlrx/PXnU0kZNwarZPIukLKL8S2kdGzsHmg2IMbCmaALRqyikv
         rAJA==
X-Gm-Message-State: AOAM533TJX0vGI7rHpaDBXcTcv1Zul3jDaspfcmxz9Sy/TZl6qmk97U7
        mL3ueohD5gEM40I78bzsVphojzzlAeIBrrQjX8jRlVWmJuQ=
X-Google-Smtp-Source: ABdhPJxik02uVKTO0VtwnyjApeul5rojBn5xooKRYB7EB/FW8KJD739rSbVbfv02PwBjVAW7N4E3T1zHxZj/aFJcclQ=
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr19621264ejf.197.1592900946550;
 Tue, 23 Jun 2020 01:29:06 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Jun 2020 10:28:55 +0200
Message-ID: <CAP8UFD2kyzpemdV2Npx9pff8zyr-M+vhAf_j2Yuxnr76q5gWUg@mail.gmail.com>
Subject: Draft of Git Rev News edition 64
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Xin Li <delphij@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-64.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/433

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
June 25th.

Thanks,
Christian.
