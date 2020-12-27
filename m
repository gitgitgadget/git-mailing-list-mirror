Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F383C433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F8020867
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 14:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL0Ons (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 09:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL0Onr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 09:43:47 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72315C061794
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 06:43:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q4so4429954plr.7
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 06:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ji5Xs0EFCnCOBUeWYBCVPdRY1d6Onw2aIlqMR9kAE2o=;
        b=MARZVJj6mEH880pF5ZFw7dUe2LG7Z6hxiQEdFdkWVq3sKW3MWfkxvAhaMEcoLrJUB4
         t1L7xUoaD7PegaoXXaB1jh893hwyAP80sqeKFw3bkFZVPV1wh+93me1IzpYAjNjpWDRJ
         N+X65Efi268W0wxmw2xtLm6yUZAISnxoj9SKjL6EkUrcT4GdcSJgUpDc/Krx0dfigZh3
         tV+0tsaOYq3r9V+UzQwoS61bMIm2OK1ZKdKzcRvehlx9uHHX3cF/vLqj4Yn7HCapKETG
         +R2V7YqvDW54p41YQMEN1Jcev2tw4Wy2qQ8HhbYK1fs7Nr8B5xIASVmISOpoikMNfMyx
         KxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ji5Xs0EFCnCOBUeWYBCVPdRY1d6Onw2aIlqMR9kAE2o=;
        b=aIBLhbZzDwO2lVeJ6HtACPWoooPErZ4H6s6Mk50cs6eEtl8oxV+ZLdgX5JvILILIZG
         T1eq27RUe//TqQydxxqx3IQXYniYMehsJMAXtD/zuHa6lN88Suy8mVbpvlqguEsvhh2f
         1JQWpuesmAoX9k4oJaMhh4oTrpDRvkTIQMz4W2nTiMFh8+jaycmCY80zWz3eTXOtKk5G
         z4GDo20FZ0seEn3n+5l4n3svJKYu+oxfnBiblTa3EeoTR8ql5ThLxefpOdEpiS8gzo/u
         v2vfL55gyr8IW50OJdedKK7+clXnZ+mjKQHOL333jqyeHnyMhVPrmnmllahDEXCOrLTB
         6/kg==
X-Gm-Message-State: AOAM5330TTrDfBr+gekUhA2ZraJf8SI+ht5MsDzxuC73ivh/YZGfyLZA
        wYAdbJ+VHdxRP7KqSqnbMUM=
X-Google-Smtp-Source: ABdhPJxo7c+cTaDuF+NCIpRxkZBQTP24VeokvQid7RgIdUxceOW3DWK4iFf1S3mTYdTx/0XTqvs19Q==
X-Received: by 2002:a17:902:830a:b029:da:df3b:459a with SMTP id bd10-20020a170902830ab02900dadf3b459amr20910402plb.75.1609080186942;
        Sun, 27 Dec 2020 06:43:06 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x127sm32243092pfb.74.2020.12.27.06.43.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Dec 2020 06:43:06 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>,
        Baptiste Fontaine <b@ptistefontaine.fr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>
Subject: [GIT PULL] l10n updates for 2.30.0 round 2
Date:   Sun, 27 Dec 2020 09:42:57 -0500
Message-Id: <20201227144257.26283-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.30.0.

The following changes since commit 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707:

  Git 2.30-rc1 (2020-12-18 15:15:18 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.30.0-rnd2

for you to fetch changes up to d13389bf27f1618525ab4c29c53aca1334fdfa74:

  l10n: zh_CN: for git v2.30.0 l10n round 1 and 2 (2020-12-27 19:23:27 +0800)

----------------------------------------------------------------
l10n for Git 2.30.0 round 2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5037t)

Arusekk (1):
      l10n: pl.po: add translation and set team leader

Baptiste Fontaine (1):
      l10n: fr.po Fix a typo

Emir Sarı (2):
      l10n: tr: v2.30.0-r1
      l10n: tr: v2.30.0-r2

Jean-Noël Avila (3):
      l10n: fr fix misleading message
      l10n: fr.po: v2.30.0 rnd 1
      l10n: fr.po v2.30.0 rnd 2

Jiang Xin (9):
      l10n: git.pot: v2.30.0 round 1 (70 new, 45 removed)
      Merge branch '2.30-rc1' of github.com:bitigchi/git-po
      Merge branch 'fr_next' of github.com:jnavila/git into git-po-master
      Merge remote-tracking branch 'github/master' into git-po-master
      l10n: git.pot: v2.30.0 round 2 (1 new, 2 removed)
      Merge branch 'fr_2.30_rnd2' of github.com:jnavila/git
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'l10n/zh_TW/201223' of github.com:l10n-tw/git-po
      l10n: zh_CN: for git v2.30.0 l10n round 1 and 2

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git 2.30.0

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (5038t0f0u)
      l10n: sv.po: Update Swedish translation (5037t0f0u)

Trần Ngọc Quân (1):
      l10n: vi.po(5037t): v2.30.0 rnd 2

Yi-Jyun Pan (1):
      l10n: zh_TW.po: v2.30.0 round 2 (1 untranslated)

m4sk1n (1):
      l10n: pl.po: started Polish translation

 po/TEAMS    |     4 +
 po/bg.po    |  5080 ++++++------
 po/ca.po    |  7145 ++++++++--------
 po/de.po    |  5329 ++++++------
 po/fr.po    |  5156 ++++++------
 po/git.pot  |  4969 +++++------
 po/pl.po    | 25969 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/sv.po    |  5198 ++++++------
 po/tr.po    |  5246 ++++++------
 po/vi.po    |  5404 ++++++------
 po/zh_CN.po |  5063 ++++++------
 po/zh_TW.po |  5346 ++++++------
 12 files changed, 53358 insertions(+), 26551 deletions(-)
 create mode 100644 po/pl.po

--
Jiang Xin
