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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DC4C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E85964E66
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhCNQUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhCNQU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 12:20:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A591C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 09:20:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w8so7515893pjf.4
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWPSbUYf5JDs9O3s0+jX+zppQ0V8n08P7uPxAGwApJk=;
        b=BecWSDdDlrwlfUDApL+16j4kH+1D5/9j/yhKO54UsVWTAUgxa0Da1YDBeYaQbGOkZu
         NOHn1xDKV3qa9UxnINaq96v8TD3qz8Rgw7ERhwDCxjTmFc3dg4kVL6h+JORGvxDg9WIQ
         RRbDQwrMuYBixsSUQj4fLNm0QX3BdPRjMVw90fn1q1IvZgtWuOSeJg8S5g9DZk9x3cdG
         MCrf5sHeKJ3o0jsotZ19WOA9qrgMK9S2q8XiUMdiZwq2m4xARwNofGFYvGBsiVlOPHhN
         RjIXYDaSTB/wtAxobRE3nWRCfdc55GeSnxI0SPTDw/EXs+ZHA81sZSI98o0cbZW6p+fB
         KsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWPSbUYf5JDs9O3s0+jX+zppQ0V8n08P7uPxAGwApJk=;
        b=E1ggy2UZyH6RBohicDWMwZqPS3mJw0ttx/bJwT859hfBU0zP32TKyV2RFaz0emxjHb
         piPc1tIIawexVZVsK4vTMR9pH87tKt1vO0Mdh++eqwvxhkAVF+1xF1VGBUMkx0TCVhul
         n3ptvudzZAJoXdL+V09zSsGUUiMeB0/nkxOgj2rSIxx1+9U5n4PJcJ/DHouWqliYb18q
         xKuYxRJwfRseVgy4/iJp4YYP74IUPLZpLSXMKTKgo3+QvRCYDufboquqriRl9srFE28R
         u52yTw8/82yQn63DlHG+No1lXAyr1ELm0poDrG5QKhW2IvrYjyw5vCPSFCVhxIjPrbgf
         GXFQ==
X-Gm-Message-State: AOAM531ZHDL6sVXwX3vxv9TrGJcW4e8h+Wt99GrUJBH4QZ/2hn9gi8n0
        ahxA0qUgYH0k3sl2q0G1irE=
X-Google-Smtp-Source: ABdhPJwKw3QBdkoWU8Gr14/cr2sLtzgrHc07LA/rLDBsD1z/b0NfDR2InEhlAQS10m+ai84W4j0PAQ==
X-Received: by 2002:a17:902:e2d4:b029:e4:be01:1d9a with SMTP id l20-20020a170902e2d4b02900e4be011d9amr7607468plc.43.1615738825630;
        Sun, 14 Mar 2021 09:20:25 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id v23sm10830051pfn.71.2021.03.14.09.20.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 09:20:24 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.31.0 round 2
Date:   Sun, 14 Mar 2021 12:20:21 -0400
Message-Id: <20210314162021.28282-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.31.0.

The following changes since commit f01623b2c9d14207e497b21ebc6b3ec4afaf4b46:

  Git 2.31-rc1 (2021-03-02 22:41:13 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.31.0-rnd2

for you to fetch changes up to 473eb54151ef8756fd2cfa1ef37d8b941a081049:

  l10n: zh_CN: for git v2.31.0 l10n round 1 and 2 (2021-03-15 00:05:25 +0800)

----------------------------------------------------------------
l10n for Git 2.31.0 round 2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5104t)

Arusekk (1):
      l10n: pl.po: Update translation

Bagas Sanjaya (2):
      l10n: start Indonesian translation
      l10n: Add translation team info

Christopher Diaz Riveros (1):
      l10n: es: 2.31.0 round 2

Daniel Santos (1):
      l10n: pt_PT: add Portuguese translations part 1

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Emir Sarı (2):
      l10n: tr: v2.31.0-rc0
      l10n: tr: v2.31.0-rc1

Jean-Noël Avila (2):
      l10n: fr: v2.31.0 rnd 1
      l10n: fr: v2.31 rnd 2

Jiang Xin (14):
      l10n: git.pot: v2.31.0 round 1 (155 new, 89 removed)
      Merge branch 'pl' of github.com:Arusekk/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:git/git
      l10n: git.pot: v2.31.0 round 2 (9 new, 8 removed)
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'fr_next' of github.com:jnavila/git
      Merge branch 'pt-PT' of github.com:git-l10n-pt-PT/git-po
      Merge branch 'russian-l10n' of github.com:DJm00n/git-po-ru
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n/zh_TW/210301' of github.com:l10n-tw/git-po
      Merge branch 'master' of github.com:vnwildman/git
      l10n: zh_CN: for git v2.31.0 l10n round 1 and 2

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git v2.31.0

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (5103t0f0u)
      l10n: sv.po: Update Swedish translation (5104t0f0u)

Trần Ngọc Quân (1):
      l10n: vi.po(5104t): for git v2.31.0 l10n round 2

Yi-Jyun Pan (1):
      l10n: zh_TW.po: v2.31.0 round 2 (15 untranslated)

 po/TEAMS    |     4 +
 po/bg.po    |  9522 ++++++++++++-----------
 po/ca.po    |    25 +-
 po/de.po    |  9837 ++++++++++++------------
 po/es.po    | 12294 +++++++++++++++--------------
 po/fr.po    |  9407 ++++++++++++-----------
 po/git.pot  |  7693 ++++++++++---------
 po/id.po    | 24358 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/pl.po    |  8218 ++++++++++----------
 po/pt_PT.po |  6128 ++++++++-------
 po/ru.po    | 13832 +++++++++++++++++++--------------
 po/sv.po    |  9613 ++++++++++++-----------
 po/tr.po    |  9383 +++++++++++-----------
 po/vi.po    |  9621 ++++++++++++-----------
 po/zh_CN.po |  9094 +++++++++++-----------
 po/zh_TW.po |  9571 ++++++++++++-----------
 16 files changed, 90300 insertions(+), 58300 deletions(-)
 create mode 100644 po/id.po

--
Jiang Xin
