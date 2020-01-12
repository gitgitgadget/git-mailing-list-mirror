Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D117C32771
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 12:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5999021744
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 12:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw/IrAmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgALMJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 07:09:41 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41224 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732688AbgALMJl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 07:09:41 -0500
Received: by mail-pf1-f180.google.com with SMTP id w62so3503118pfw.8
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 04:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHu7vx7/89feAXGMSFC6w4Wx1O87eNdzSi1Q1hkefVY=;
        b=fw/IrAmihQ7A592cC4ItvxcbBUXw+lRd9Eb5lVGGD0ttK7blqHkbAWK0Yii5thE2jb
         pFGLbCnlZTzEaAoTppJOMMEc36gC6EhRtIK6YXQyQwLRPoeepySTRqLaGq2TYp+h+DQ2
         8Pkr5k1tB4Np9It17HkypysShCbQSwtaV+5g1oxcd7yDCCehaKGEtviBVK5SCF72moGR
         PMRUxFeQeU9QyjEV7EfiEcDgLotMr+S37fhb0JeIHiQcZSyt/UZvUcs8rZ2bmeiZCzdy
         v8qc1BZqVAzGmBn4NgBeR+QWryXxyzyhHsTpDHQdpKefODWSM3bSVfyS7GyO1oXKjvGv
         +85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHu7vx7/89feAXGMSFC6w4Wx1O87eNdzSi1Q1hkefVY=;
        b=SfXJfhEXqtOPJozldr11jHQrNkQxD4HMKn7GJ026pXS2meYhZaKLzvnvSL+WE4Ytsi
         mmuNf6tC+LGxsmaVrdu9mSDoSM2m/SG0iDc227UtxaG0oqH0ergsIYhcDkt4eoKKA8QP
         OFM8i3SusF1FCRsbDv2pDqSCqJp78zHNqcI9nT+DtaLgcgv7TKpixIFWtpPE160rgB8J
         GaurB9yCCH6lvKm7Ek8fpO8TFS/iPcHT/v9WE6mBP49VqAxrfJLl2LXfd7ITSr39niBM
         s44EHqpdaackwLXQre6BKz2ZQJRVpSseCnxbOeCrGO4qg//6jNNM0w1aG7wucA0f1e8R
         Q/tQ==
X-Gm-Message-State: APjAAAUO1ENAE72kI8pR/Np0qGZjgLbs2F4Y5ek67mmjhjwK4E+j1uJF
        uBgMLRmhAv3fzWGd8mQAWlI=
X-Google-Smtp-Source: APXvYqxtfsLgpnu3I04k6ofWaJVJiGa1ekJE2SEkI62EuUXAyo4rBf+l4T+r2yJnVvb5/r5lvS72Bw==
X-Received: by 2002:a63:4b50:: with SMTP id k16mr15840945pgl.386.1578830980299;
        Sun, 12 Jan 2020 04:09:40 -0800 (PST)
Received: from localhost.localdomain ([221.222.158.57])
        by smtp.gmail.com with ESMTPSA id v9sm10132588pfi.37.2020.01.12.04.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 04:09:39 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.25.0 round 1
Date:   Sun, 12 Jan 2020 20:09:27 +0800
Message-Id: <20200112120927.4067-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.24.1.12.g4651f25838.agit.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi Junio,

This is pull request for git 2.25.0. In this round, ten l10n teams made
theire contributions, and Yi-Jyun Pan contributed Traditional Chinese
translations, which is a new l10n language support for Git.

Please pull the following l10n updates for Git 2.25.0.

The following changes since commit 99c33bed562b41de6ce9bd3fd561303d39645048:

  Git 2.25-rc0 (2019-12-25 11:22:02 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.25.0-rnd1

for you to fetch changes up to ddc12c429b63912032cbabfaac689093de43c2b9:

  l10n: zh_CN: for git v2.25.0 l10n round 1 (2020-01-12 19:22:02 +0800)

----------------------------------------------------------------
l10n-2.25.0-rnd1

----------------------------------------------------------------
Alessandro Menti (1):
      l10n: it.po: update the Italian translation for Git 2.25.0

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (4800t)

Christopher Diaz Riveros (1):
      l10n: es: 2.25.0 round #1

Jean-Noël Avila (1):
      l10n: fr.po v2.25.0 rnd 1

Jiang Xin (6):
      Merge tag 'v2.25.0-rc0' into git-po-master
      l10n: git.pot: v2.25.0 round 1 (119 new, 13 removed)
      Merge branch 'translation_191231' of github.com:l10n-tw/git-po into git-po-master
      Merge branch 'fr_v2.25.0_rnd1' of github.com:jnavila/git into master
      Merge branch 'master' of github.com:Softcatala/git-po into git-po-master
      l10n: zh_CN: for git v2.25.0 l10n round 1

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation v2.25.0 round 1

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (4800t0f0u)

Thomas Braun (1):
      l10n: de.po: Reword generation numbers

Trần Ngọc Quân (1):
      l10n: vi(4800t): Updated Vietnamese translation v2.25.0

Yi-Jyun Pan (1):
      l10n: zh_TW: add translation for v2.24.0

pan93412 (1):
      l10n: zh_TW.po: update translation for v2.25.0 round 1

 po/TEAMS    |     5 +
 po/bg.po    |  5258 +++++++------
 po/ca.po    |  8047 +++++++++++---------
 po/de.po    |  5128 +++++++------
 po/es.po    |  5120 +++++++------
 po/fr.po    |  5085 +++++++------
 po/git.pot  |  5007 ++++++------
 po/it.po    |  5131 +++++++------
 po/sv.po    |  5107 +++++++------
 po/vi.po    |  5112 +++++++------
 po/zh_CN.po |  5094 +++++++------
 po/zh_TW.po | 24000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 53761 insertions(+), 24333 deletions(-)
 create mode 100644 po/zh_TW.po

--
Jiang Xin
