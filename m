Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30350C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09405610C9
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhEQIhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 04:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhEQIho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 04:37:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F210C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 01:36:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t4so2725180plc.6
        for <git@vger.kernel.org>; Mon, 17 May 2021 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4v0cjpDcY6MdzH6NEFREYpqhcpBanDq1AF87PxyW/w=;
        b=Qn6hBn21iYOOFeUpP6ZwOYEz1F45q4noCylqsWVisAtZS/VUvCaAo5R5P5iZa8m5no
         rfMUuU/oaUpurh/0XbQH3XORL+aw3f/zOhOJ2C0/rKwezvIcC1ip4uYgTtF8TdCZ1eer
         GXgsIP3KhzahgfZ8m2Q3ORFdvkLfGa+d+Zotyz9H8/+rQ3dAF4/ukvXgPBn03j6ndvkv
         Oc7TNSVX6O9rwuPsJergsV5Qjo3828TvExS04gJGBDqa9XyX1C0Lxy4jeay5DFhQBfMn
         wUbBVGOBTEj3Ch+akuWedUQNre0PVodbjQX1cePguAWoC60kEi7IT5pgY+rOfWQbaoA2
         R0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4v0cjpDcY6MdzH6NEFREYpqhcpBanDq1AF87PxyW/w=;
        b=XuMg2/H7KMER34plOqAfg9MPaPRS5KgA8iznJqtX9qSey8qQvCizD2hwV2W4Y1cc5S
         cxrDaoLtkVcsYwjL4jrGqbcRn7LTM9PXdW/+k3ow0MUz/B1T2Iit/Y7pDyZ+gVgmaixV
         nULy8fQWYF9NAk05WzBm9c4/vhLZ3HWTy6xK4B073ILbVwrO1IGQXooZefie4IdmLTiG
         tvsQ4a4lI9n4SNfFxs+QS7h0gzY1fkMPJDIbG9zGKuTWNe/790WayD9BY38BSGx3mr9q
         t0GVnnQazAxAloLLHC07LXqNplrflr8LAOrD+oJ70cz2WLqD+CbTXRMHKef1lHUfL4kQ
         BrUw==
X-Gm-Message-State: AOAM532hNftlHjroSio7xdIBpndcmxI8EfKaNmMFo/LXF1+/M4s9+9qB
        ebzEGiLjYy2xUVW1JuFmLyed8RLXMls=
X-Google-Smtp-Source: ABdhPJwXRfH7nQmdM9X3ZwAubjRDOPnpF9mCHJvgLr8PuBhaAC3wEpv7Qm1iQJhI9hOlR7xDeFKEGw==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr61041043pjl.128.1621240588027;
        Mon, 17 May 2021 01:36:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.144])
        by smtp.gmail.com with ESMTPSA id x21sm4806863pfr.124.2021.05.17.01.36.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 01:36:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.32.0 round #1
Date:   Mon, 17 May 2021 16:36:20 +0800
Message-Id: <20210517083620.51170-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi,

Git v2.32.0-rc1 has been released, and it's time to start new round of
git l10n.  This time there are 126 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on this
commit:

    l10n: git.pot: v2.32.0 round 1 (126 new, 26 removed)
    
    Generate po/git.pot from v2.32.0-rc0 for git v2.32.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

There is a helper program hosted on https://github.com/git-l10n/git-po-helper
for git l10n coordinators and git l10n contributors to check the conventions
of git l10n contributions.


--
Jiang Xin
