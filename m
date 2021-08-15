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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78185C4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 23:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50ED961261
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 23:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhHOXMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 19:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhHOXMh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 19:12:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D5C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 16:12:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so18740557plr.12
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bo5oCLx8nH7D4dcDUpjkVhtQdIKXvEl0u1WKu9NjumU=;
        b=rLGWy2ZIrCz5ZXNJgxalg2SvnzAQbDNM77kh2U8eBbWSpvqo0Ozx7sjLF7ZlUO+COI
         AkvwkL/WAxUin7eRsT2VHI5od9HftuwKyRUof0ejejfICHa8VqI1m/UttgztMuEcZywx
         hwhc0s8wdRl3Cw90SAxNKbyGWqKStYyMeGCo6cx8zMdWhCoDW++hNNV+sYhPqUtYvFvS
         zgIjORBafnqWrfQ1qIKxlH7RW7VxxQzIWgIocyG9p92MRt0/8yO3oJVc/3YhlQ9tbisF
         JieWPmhQjpQ5gO6obJYshacDxtcD6zv8oA/poOyfv5n9a4my3p27hJuGLEhLxAW9RW3r
         XCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bo5oCLx8nH7D4dcDUpjkVhtQdIKXvEl0u1WKu9NjumU=;
        b=fxf3W50IeJKyqeGCHGBFn015/1UO67Za9m72gTvPJR4+vz6wtwxYL8HjSbwyEm8jLH
         o6uR2h1IGk9Ak+h08/8POJ1j0lDBjOcmbtyBHzUAghq5xI85KP4+gvrrljOxpfiWg8zY
         N4r6UteqGF9bRMKDJjOq5SZZVLuChOg4aMGcK3xGNikK7Didea65P7Nw84ZKaxq83JlL
         OheeXKBcjCbOhC7SpaRhgrM9P1Okeq0RwEwDMqYn5frhRFeow6VQUzWGm9Eto9w/KJ+R
         TVObt+AzI41sv39XKQIbHtj330ftKD+zqx12VOI7jX80w++0SqEIsw+tFcHehpJFSoQW
         +cYA==
X-Gm-Message-State: AOAM532uxJSWM/qcGiXHq14c11UlL77hcZq9GbVIfm7sP2xI2T9mqivw
        u0pKReY51zgwXDIUhBDz5rM=
X-Google-Smtp-Source: ABdhPJzgqkJfmz03ccWdwz4qcqLJcKUDnIvxZPqWx8fxg0J5SCJGT73rOuiy9+NMfdMZcrVVovg0Rg==
X-Received: by 2002:a17:902:8f90:b029:12d:1b48:efd8 with SMTP id z16-20020a1709028f90b029012d1b48efd8mr10933813plo.23.1629069126499;
        Sun, 15 Aug 2021 16:12:06 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id h24sm9108480pfn.180.2021.08.15.16.12.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 16:12:06 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
        =?UTF-8?q?=E4=BE=9D=E4=BA=91?= <lilydjwg@gmail.com>
Subject: [GIT PULL] l10n updates for 2.33.0 round 2
Date:   Mon, 16 Aug 2021 07:12:01 +0800
Message-Id: <20210815231201.18129-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Junio,

Please pull the following l10n updates for Git 2.33.0.

The following changes since commit 5d213e46bb7b880238ff5ea3914e940a50ae9369:

  Git 2.33-rc2 (2021-08-11 12:36:18 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.33.0-rnd2

for you to fetch changes up to efedbb11de27a22cf9d4c75255057716f0b1b8ce:

  l10n: sv.po: Update Swedish translation (5230t0f0u) (2021-08-16 06:54:20 +0800)

----------------------------------------------------------------
l10n-2.33.0-rnd2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5227t)

Bagas Sanjaya (4):
      l10n: id.po: fix mismatched variable names
      l10n: id: po-id for 2.33.0 (round 1)
      l10n: id: mismatch variable name fixes
      l10n: id: po-id for 2.33.0 round 2

Christopher Diaz Riveros (1):
      l10n: es: 2.33.0 round 2

Daniel Santos (12):
      l10n: pt_PT: add Portuguese translations part 4
      l10n: pt_PT: add Portuguese translations part 5
      l10n: pt_PT: translation tables
      l10n: pt_PT: remove trailing comments
      l10n: pt_PT: update git-po-helper
      l10n: pt_PT: translated git v2.33.0
      l10n: pt_PT: update translation tables
      l10n: pt_PT: cleaning duplicate translations
      l10n: pt_PT: cleaning flags mismatch
      l10n: pt_PT: update translation table
      l10n: pt_PT: git-po-helper update
      l10n: pt_PT: v2.33.0 round 2

Emir Sarı (2):
      l10n: tr: v2.33.0 round 1
      l10n: tr: v2.33 (round 2)

Fangyi Zhou (1):
      l10n: zh_CN: Revision for git v2.32.0 l10n round 1

Jean-Noël Avila (4):
      l10n: fr: fix typo
      l10n: fr.po v2.33 rnd 1
      l10n: fr.po fix typos in commands and variables
      l10n: fr.po v2.33 rnd 2

Jiang Xin (25):
      l10n: fixed tripple-letter typos
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'master' of github.com:git/git
      l10n: git.pot: v2.33.0 round 1 (38 new, 15 removed)
      Merge branch 'fr_v2.33_rnd1' of github.com:jnavila/git
      Merge branch 'tr-loc-v2.33' of github.com:bitigchi/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'daniel' of github.com:git-l10n-pt-PT/git-po
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'fr_fix_typos' of github.com:jnavila/git
      Merge branch 'l10n-2.33' of github.com:ralfth/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:git/git
      l10n: git.pot: v2.33.0 round 2 (11 new, 8 removed)
      Merge branch 'master' of github.com:vnwildman/git
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'master' of github.com:vnwildman/git
      Merge branch 'loc/zh_TW/210814' of github.com:l10n-tw/git-po
      Merge branch 'pt-PT' of github.com:git-l10n-pt-PT/git-po
      Merge branch 'l10n-2.33-rnd2' of github.com:ralfth/git
      l10n: README: refactor to use GFM syntax
      l10n: zh_CN: for git v2.33.0 l10n round 2
      Merge branch 'next' of github.com:ChrisADR/git-po
      l10n: TEAMS: change Simplified Chinese team leader

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Peter Krefting (3):
      l10n: fixed typos of mismatched constant strings
      l10n: sv.po: Update Swedish translation (5227t0f0u)
      l10n: sv.po: Update Swedish translation (5230t0f0u)

Ralf Thielow (3):
      l10n: update German translation for Git v2.33.0
      l10n: de.po: fix typos
      l10n: update German translation for Git v2.33.0 (rnd2)

Trần Ngọc Quân (3):
      l10n: vi.po(5227t): Updated Vietnamese translation for v2.32.0
      l10n: vi.po(5227t): Fixed typo after run git-po-helper
      l10n: vi.po(5230t): Updated translation for v2.32.0 round 2

Yi-Jyun Pan (2):
      l10n: zh_TW.po: update for v2.33.0 rnd 2
      l10n: zh_TW.po: remove the obsolete glossary

依云 (1):
      l10n: zh_CN: review for git v2.32.0 l10n round 1

 po/README.md |   395 +-
 po/TEAMS     |     6 +-
 po/bg.po     |  4028 ++++++++--------
 po/ca.po     |   926 ++--
 po/de.po     |  4576 +++++++++---------
 po/es.po     |  7824 ++++++++++++++----------------
 po/fr.po     |  7873 ++++++++++++++++++-------------
 po/git.pot   |  4453 ++++++++---------
 po/id.po     |  5232 ++++++++++----------
 po/it.po     |     6 +-
 po/ko.po     |     8 +-
 po/pt_PT.po  | 14692 +++++++++++++++++++++++++++++----------------------------
 po/sv.po     |  4592 +++++++++---------
 po/tr.po     |  4602 +++++++++---------
 po/vi.po     |  4576 +++++++++---------
 po/zh_CN.po  |  4587 +++++++++---------
 po/zh_TW.po  |  5105 ++++++++++----------
 17 files changed, 37679 insertions(+), 35802 deletions(-)

--
Jiang Xin
