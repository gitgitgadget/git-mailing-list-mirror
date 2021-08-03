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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7A8C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 10:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B6760F8F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 10:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhHCKPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhHCKPv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 06:15:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB2BC0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 03:15:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d1so23133166pll.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2RriIeD2tYTVo8/K3i0Fz+WC5Fatv+stM1llrQLjIU=;
        b=JuHUKiwj9GFKaIgx/78T3ZQlyQ09A2lQVc55tYYdAqZdf7SMOwPhmZPLaWuXYAqX6I
         bu4zQgJN/8fKSJVD40j6DaWgUP9ni+rcSqEkP4CcY1hNQ/Ga589VvDa3wRD113YAOwzW
         8v6DjKf9FY72FE1VaUaOgvfdxe1q+YmQZE7FdMIA7V14CAhGtei/QEFpxmcn0jI4uLzC
         FhzsHfIp1jjpkj7zSVLeSrDRrWKmLooRDp/ku9H91JHb6IRBN8kH/hM66iIej1R0CiBU
         ULN6rDQQYYYDfC+vi43pKAw1t1CwmfIEH25RG8W9DpJV/kveyLYkZ6k71hOgO+VaTSS6
         LLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2RriIeD2tYTVo8/K3i0Fz+WC5Fatv+stM1llrQLjIU=;
        b=cEVsrc2BmjiZSZ0SYNBOrCC8YIyh0a1e82jnPlyecQ6EzT8ns71D+QIeVHpjrpaZpS
         szUlpUWylVrw82W+dmuIpAfEwuqD1oen4SRen61A/sGjprMk1a/TBTiilIc5sURdlzlc
         m2oFs6n9prljL0p6aBFNqsxCs9TyzyDEMrDq9Ot6XV4eBVyySK4B6cLNmOp5ZhcI7j9q
         Ki3VJ4svtiXuQna1PJ0OE80Ayg6iA+FOBQ4GzYy5N33meVxQNRv1XKbGO8yp/H0UX8yM
         RxjHm03SwHV9aacFRKGMOCdpdl1yJ1EwswfDIXao/gWO5yDYjeiLMQYIzUKnaxrqS44J
         w+CQ==
X-Gm-Message-State: AOAM531C6P7hCCRy710LVry6bOl/KXAa87iyf1UXbPNLpdTIbxkcIV1h
        x4YrRGKPrykuKmT9POYwSduYNInfNlCDIA==
X-Google-Smtp-Source: ABdhPJzbrcwzJz3mQv5mn2pxhjry7H1qXBWQBTUKFrlFwatVj66t8t49FY2jTmSnBuvkxk5drbIljg==
X-Received: by 2002:a17:90a:af88:: with SMTP id w8mr5015332pjq.104.1627985739153;
        Tue, 03 Aug 2021 03:15:39 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id s7sm14617673pfk.12.2021.08.03.03.15.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 03:15:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
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
Subject: [L10N] Kickoff for Git 2.33.0 round #1
Date:   Tue,  3 Aug 2021 18:15:26 +0800
Message-Id: <20210803101526.27150-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.33.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 38 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on this
commit:

    l10n: git.pot: v2.33.0 round 1 (38 new, 15 removed)
    
    Generate po/git.pot from v2.33.0-rc0 for git v2.33.0 l10n round 1.
    
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
