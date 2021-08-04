Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3085BC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068C860F6F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 01:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhHDBJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 21:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhHDBJh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 21:09:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86176C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 18:09:25 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so241495otq.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDMvgqUAZQNGsdEP/Pa/YV84zNPgxe3+a4/7DPK1rdc=;
        b=Ax1FZVUPx8JtPbtDQJ4o888DmWmFmvfNGWzX0OLm7myZ2tknCOWfSXuM5ye/wd4ug7
         p/M2ibiSw/YtDrxvTnaFabspskB80XF7V7Gh8MnfJtXk5biozlaEwEbLr/1IB2KOaZsT
         kvIAMp8ATqDhVqDuIaVKFBeNr+gmGcU82QUFwORP9AG74XXCYvaYFem7kgK20NZ+j5XA
         CCpSecuHwoKBOplqUS049iruBrFDBG84oh7UOBShN+rGGZ4Jnj35U8fFZ7BOEyQhye5S
         wdTyzIINn1nfgwzF/rYfmSwGkXrsKWf1WPOx1vU18jMfr3+twfxeclxkeu5FGDTLMSHX
         N97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDMvgqUAZQNGsdEP/Pa/YV84zNPgxe3+a4/7DPK1rdc=;
        b=P4IjVRMlKRzIdJFTC8P0pOxRkVrKGaLku3p0CDQvpZVD278uN2DRMM/sACDU7HfbA6
         jApBC3YK5xaSRG4+Q2ujrNAXID6b3/ZEHMQ+VWfrJBPQJzCD7q0msOIDyDjU28vv1DiR
         1LkYe+ZEQvEH4hNs0pxEHKtTeT5Y5jw+ug3fYERhB5Zv7TakzOO55XOEhBQIHQ8jwg+v
         ZXH20g248PeMQAlPfav7j+fHg9StFjpirXLuYcCXADB7hYEVhzRaD/Gy2UzYUwC59jkJ
         0DpJ8ct8XUXCHc2fieXFCoy+ca1qUVsJL1SPAqUy1sb1S1aoFNansY2gTLo4VGbhFE9Y
         7BoA==
X-Gm-Message-State: AOAM531KrCAkPDdzCctURfCliFrwSi2FpLnBZKfbG1gN1maUgqedpJMP
        hzwRK4azkFJ4RdowIDTn4619ULXkp1M=
X-Google-Smtp-Source: ABdhPJzp/4XxgZ6r5vUQ3YW3F2ZR1+GqXkiYLKjm2eXSUutJKjHPMPYP0hKOWTvBhNpfPMr2jXNbdw==
X-Received: by 2002:a05:6830:3145:: with SMTP id c5mr17248499ots.245.1628039364679;
        Tue, 03 Aug 2021 18:09:24 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c21sm179721oiw.16.2021.08.03.18.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 18:09:24 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org, paulus@samba.org
Cc:     pietzsch@mycroft.speedport.ip, sunshine@sunshineco.com,
        tair.sabirgaliev@bee.kz, lists@haller-berlin.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] gitk: macOS improvements
Date:   Tue,  3 Aug 2021 18:08:57 -0700
Message-Id: <20210804010900.33133-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.433.g9a510e7e11
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following patches improve the user experience for gitk in macOS
by avoiding to abort if the terminal where it is running hasn't been
authorized for Automation as reported a few[1,2] times already.

It has been tested in macOS 11.5.1 using both the system tk (8.5) and
the latest (8.6.11) from brew, the third[3] patch is needed for using
8.6 and has been included with the gitk version from brew as well.

Carlo Marcelo Arenas Belón (2):
  gitk: skip calling osascript to set frontmost for tk >= 8.6
  gitk: avoid fatal error if `exec osascript` fails

Tobias Pietzsch (1):
  gitk: check main window visibility before waiting for it to show

 gitk | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

[1] https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshineco.com/
[2] https://lore.kernel.org/git/20201025175149.11853-1-dev+git@drbeat.li/
[3] https://lore.kernel.org/git/pull.944.git.git.1610234771966.gitgitgadget@gmail.com/
-- 
2.33.0.rc0.433.g9a510e7e11
