Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7544BC433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 05:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E71520723
	for <git@archiver.kernel.org>; Sun, 31 May 2020 05:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh4roV3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgEaFRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 01:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgEaFRk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 01:17:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4587DC05BD43
        for <git@vger.kernel.org>; Sat, 30 May 2020 22:17:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g5so1902451pfm.10
        for <git@vger.kernel.org>; Sat, 30 May 2020 22:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SaS4F0BZeBlffT9XCgUYymEeo0TcLuvwzR5ja5tq5Q=;
        b=Nh4roV3RjqjvNB1d7gg/vn25LxJ6+vGWSl5FJtZFQURZea0PT2GN2U/GpdAWWXsZIW
         kaqxxB2E6L8bEx3tAq23jCulZn/6nGDG1AoxQRJuaWOcQXVgd27KZeijOPXNDQkARtqW
         Oc2/55jucS5DQjwXvrdL7lMtBy3G2HIPWNaz36nKR7XjZxLj/AgQmQvbS+ITuaHMWPlU
         xXXRQkqJsZsGp5e3MWELhUujisb/Ipjr6BUwhfPtFinW6YVlvDJ3T3vUD51DHuCqxV4b
         1NlZK+rpINW+UrWByfgPG0BX5OvKEKGAGynSw8RjZiIeuaHYL0SdtZkLE/pJOE+gjpAM
         G3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SaS4F0BZeBlffT9XCgUYymEeo0TcLuvwzR5ja5tq5Q=;
        b=CEdGJeSAys3TueCRyfh2zs69Qursmhp0elXI1p//qqOYI1pP1lHs587U3bg6qjUEUI
         VA9TUJIBxOiyIIsZVQQiJW6+jpzcSHJLYGJZtt2RXmRboWH03IxsqTiRsEBnlP1OSeRo
         IztUmBDDPznufE36wFzW5U6611XtABV3E/ln2CYfetuQFUSD0PWkw+ZR7oLSxFHsTDdh
         gQifpmNmb44wSEFaX2qr/e72d5a1+lirgdg6tGhYwoHVMBPVcH69QMxjj7CfDhmx8XJS
         WOYfsAiuvf87ZR7pKoMxXkpCGjZgD2GneY6mvfBJNtiZ9tjpXQTpOXur6KKC7xsxRNkb
         +oXQ==
X-Gm-Message-State: AOAM530SLPv6M2schYdvRgp28E+rpXW8TBpaH1IphRnSNbqqlAyoh1NG
        dxNBiTC1y6I1gDx9aGXc1Oo=
X-Google-Smtp-Source: ABdhPJzNXkP5FtdPJzw1vIzHkY/01557NFrR9fe2WqGyKuXkcq5pTXq13O68qX5OQDmEK++rIXlbaw==
X-Received: by 2002:a63:da11:: with SMTP id c17mr14098596pgh.71.1590902259798;
        Sat, 30 May 2020 22:17:39 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u5sm3553549pjv.54.2020.05.30.22.17.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 22:17:39 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>,
        Jan Engelhardt <jengelh@inai.de>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.27.0 round 2
Date:   Sun, 31 May 2020 01:17:26 -0400
Message-Id: <20200531051726.9793-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.27.0.

The following changes since commit 2d5e9f31ac46017895ce6a183467037d29ceb9d3:

  Git 2.27-rc2 (2020-05-26 09:38:13 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.27.0-rnd2

for you to fetch changes up to cb26198ec6b3fa0bc58d210ea0338f4e972f9f50:

  Merge branch 'master' of github.com:ruester/git-po-de (2020-05-30 11:26:53 +0800)

----------------------------------------------------------------
l10n-2.27.0-rnd2

----------------------------------------------------------------
Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.27.0 round 1
      l10n: it.po: update for Git 2.27.0 round #2

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (4868t)
      l10n: bg.po: Updated Bulgarian translation (4875t)

Christopher Diaz Riveros (1):
      l10n: es: 2.27.0 round 1

Emir Sarı (2):
      l10n: tr: v2.27.0 round 1
      l10n: tr: v2.27.0 round 2

Jan Engelhardt (1):
      l10n: de.po: Fix typo in the German translation of octopus

Jean-Noël Avila (2):
      l10n: fr v2.27.0 rnd 1
      l10n: fr.po v2.27.0 rnd 2

Jiang Xin (16):
      l10n: git.pot: v2.27.0 round 1 (72 new, 37 removed)
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'git-2.27-round-1' of github.com:bitigchi/git-po
      Merge branch 'fr_2.27.0_rnd1' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po into git-po-master
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'next' of github.com:ChrisADR/git-po
      Merge branch 'master' of github.com:git-l10n/git-po
      l10n: git.pot: v2.27.0 round 2 (+1)
      l10n: zh_CN: for git v2.27.0 l10n round 1~2
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'master' of github.com:bitigchi/git-po
      Merge branch 'fr_2.27.0rnd2' of github.com:jnavila/git
      Merge branch of github.com:AlessandroMenti/git-po
      Merge branch 'master' of github.com:ruester/git-po-de

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git 2.27.0

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4839t0f0u)
      l10n: sv.po: Update Swedish translation (4875t0f0u)

Trần Ngọc Quân (2):
      l10n: vi(4874t): Updated Vietnamses translation for 2.27.0
      l10n: vi(4875t): Updated Vietnamses translation for 2.27.0rd2

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.27.0 round 1 (0 untranslated)
      l10n: zh_TW.po: v2.27.0 round 2 (0 untranslated)

 po/bg.po    |  7288 ++++++++++++++++++------------------
 po/ca.po    | 11698 +++++++++++++++++++++++++++++++---------------------------
 po/de.po    |  7294 ++++++++++++++++++------------------
 po/es.po    |  7156 ++++++++++++++++++-----------------
 po/fr.po    |  7168 ++++++++++++++++++-----------------
 po/git.pot  |  7037 ++++++++++++++++++-----------------
 po/it.po    |  7320 +++++++++++++++++++-----------------
 po/sv.po    |  7313 +++++++++++++++++++-----------------
 po/tr.po    |  7296 ++++++++++++++++++------------------
 po/vi.po    |  7344 +++++++++++++++++++-----------------
 po/zh_CN.po |  7142 ++++++++++++++++++-----------------
 po/zh_TW.po |  7961 ++++++++++++++++++++-------------------
 12 files changed, 48168 insertions(+), 43849 deletions(-)

--
Jiang Xin
