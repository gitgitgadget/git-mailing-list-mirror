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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C040C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11231613AC
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 14:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFEO7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFEO73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 10:59:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF04C061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 07:57:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u126so5630841pfu.13
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VR6f1v7bSXrA6nVH5Ss4LfnA5La5Xv3aGS/hHFuXz1Y=;
        b=pRBjtWLGNarwHyItwlct2ZFhffS/xcTr8Ax2ka2AUppUXK6C+bULrLpidNmSNdPOec
         +SZoXstIDJEK1twUYZjV3vplSl8j59EmKh9ZU4fluHXewWKUOai5Qc/4djdrvLLnBlgo
         484RhZKcTzZLE1/RPY8c2CUZuL+RhckoJij4jwphuOkdQv0hyDtBDdcEnUHLfSkCv/L2
         dAnUuUIExjJ4ommMZagWbNvjbDXwczJDo/cNUWjTtv4phXuPRfCTXGe3p0CoE4sZ2aJj
         nrmkGEREX9j4wp3CTE4y4HZB9RCAblIKFxkc9vMRROp490Tc+7kixmOceG++24vGT6xp
         H6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VR6f1v7bSXrA6nVH5Ss4LfnA5La5Xv3aGS/hHFuXz1Y=;
        b=bD4bgq9qNnzEf81248xA/CEQ2rtr/973OJvklNU++cO+39kyF5kEKAMzzE8d9Ybnyf
         D36Dgn39T/jxGlpycS+yvs5n56GhtJ8y3W800tFMhx/zKdyJ/hpGLf0Shkglc3FF0dj/
         nhNDK9z7iaePNNcJtCfyGf/8qMSOhcbRy01wPqWDhK3O5GDZC5GJQbDywavMavd+iSde
         esIGff33mqclfvUGxK8uqHR+PO2UEa/QC7n2Xn+euF5gbbFls4TlBNORMt/aw/cX5WD8
         vJOlCCV23Cr1GVf33hs71D0BkXjKLVXN4MLcTNqJe7KGErhc2WW+CpMDoiFHBiQZeB3f
         s/Mw==
X-Gm-Message-State: AOAM531wsr9dUAg80kW7tGZKkOFfGcdblnBqmSHDE0NK6ZG/8XOX0tD1
        s4NYP5ckLL8kAgvGOAwVF8E=
X-Google-Smtp-Source: ABdhPJwTTYPq5ZwLxQSKZUc2KEoLfRxhhiGQ2GSgLbuVP5DYaFJ/djD6L/0dviJs/R+kD8f4RvOVPQ==
X-Received: by 2002:a62:aa01:0:b029:2ea:743:6693 with SMTP id e1-20020a62aa010000b02902ea07436693mr9668451pff.68.1622905044366;
        Sat, 05 Jun 2021 07:57:24 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id o133sm4333918pfd.49.2021.06.05.07.57.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 07:57:23 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Alexey Roslyakov <alexey.roslyakov@gmail.com>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
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
        <vnwildman@gmail.com>,
        Vincent Tam <VincentTam@users.noreply.github.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        rlespinasse <romain.lespinasse@gmail.com>
Subject: [GIT PULL] l10n updates for 2.32.0 round 1
Date:   Sat,  5 Jun 2021 22:57:17 +0800
Message-Id: <20210605145717.13646-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Junio,

Please pull the following l10n updates for Git 2.32.0.

The following changes since commit bf949ade81106fbda068c1fdb2c6fd1cb1babe7e:

  Git 2.32-rc0 (2021-05-16 21:05:24 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.32.0-rnd1

for you to fetch changes up to 33b62fba4d61d604b30942fb4ec22b6e2782726b:

  l10n: zh_CN: for git v2.32.0 l10n round 1 (2021-06-05 22:45:18 +0800)

----------------------------------------------------------------
l10n-2.32.0-rnd1

----------------------------------------------------------------
Alex Henrie (1):
      l10n: Update Catalan translation

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5204t)

Alexey Roslyakov (1):
      l10n: ru.po: fix typo in Russian translation

Bagas Sanjaya (5):
      l10n: id: po-id for 2.32.0 (round 1)
      l10n: README: document git-po-helper
      l10n: README: document "core translation"
      l10n: README: document l10n conventions
      l10n: README: note on fuzzy translations

Daniel Santos (2):
      l10n: pt_PT: add Portuguese translations part 2
      l10n: pt_PT: add Portuguese translations part 3

Emir Sarı (1):
      l10n: tr: v2.32.0-r1

Jean-Noël Avila (1):
      l10n: fr: v2.32.0 round 1

Jiang Xin (9):
      l10n: git.pot: v2.32.0 round 1 (126 new, 26 removed)
      l10n: fix typos in po/TEAMS
      Merge branch 'fr_next' of github.com:jnavila/git
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'l10n/zh_TW/21-05-20' of github.com:l10n-tw/git-po
      l10n: README: add file extention ".md"
      Merge branch 'pt-PT' of github.com:git-l10n-pt-PT/git-po
      Merge branch 'fix_typo' of github.com:e-yes/git
      l10n: zh_CN: for git v2.32.0 l10n round 1

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git v2.32.0

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5204t0f0u)

Trần Ngọc Quân (1):
      l10n: vi.po(5204t): Updated Vietnamese translation for v2.32.0

Vincent Tam (1):
      l10n: fr.po fixed inconsistencies

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.32.0 round 1 (11 untranslated)
      l10n: zh_TW.po: localized

rlespinasse (1):
      l10n: fr: fixed inconsistencies

 po/{README => README.md} |   113 +
 po/TEAMS                 |     4 +-
 po/bg.po                 |  7100 ++++++++++++------------
 po/ca.po                 | 13056 ++++++++++++++++++++++++---------------------
 po/de.po                 |  6956 +++++++++++++-----------
 po/fr.po                 | 10104 ++++++++++++++++-------------------
 po/git.pot               |  6731 ++++++++++++-----------
 po/id.po                 |  9809 +++++++++++++++++++---------------
 po/pt_PT.po              |  1237 +++--
 po/ru.po                 |     2 +-
 po/sv.po                 |  6882 +++++++++++++-----------
 po/tr.po                 |  6819 ++++++++++++-----------
 po/vi.po                 |  6893 +++++++++++++-----------
 po/zh_CN.po              |  6862 +++++++++++++-----------
 po/zh_TW.po              |  7104 ++++++++++++------------
 15 files changed, 47249 insertions(+), 42423 deletions(-)
 rename po/{README => README.md} (72%)

--
Jiang Xin
