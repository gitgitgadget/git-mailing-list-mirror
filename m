Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F2C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE98206F9
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOGMZBz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCUKXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:23:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39899 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCUKXl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 06:23:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so4658726pfn.6
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MkKvUryRwJsIr9udMpvZ0dWUljEWrRLDkGrY8jyp3E=;
        b=jOGMZBz6AlBccnxxhTAKk2ORKRg8XeUgZvmphpwuqZLiasE4JNJzdsJsqXxREGOoUb
         KKjHn2GzIUXMcCSPcPLRC2Sk2+ogFqf1nk0HGeQvluvu/pV72bbtUHRYyhu+2VkVHVIT
         FgZORh5M3UPMO0ymrSCF3QPWIUb+Vmef1VcmtnEnbMaYgYoiSLJQZ4NP+0jLUVbaSN3G
         npDKl/Wi4y6XguYKFt+k62Lc8Q6VJ23QJcGEXes5HJettiEdWx/pxzOsIArAk6bVlBa3
         YMJMvhNrBznn3OJvS5ZiVR8CTGIt0LCnZWZJ/nH2N4fxs//hMRc578egaEkbTS6T+T/5
         bZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MkKvUryRwJsIr9udMpvZ0dWUljEWrRLDkGrY8jyp3E=;
        b=bxsQ/ecZW4amFx4JdKUYJovWG0EtNe84lfxzmu93AIYVSKI5ViqHG4pd2a6PMqaJR8
         6TYjL7OoeUhUjZ3UfQ8ajB7Krap/n3NqSUy6gyVzH++niEOKgirTNdaF50s8IF2tUOXO
         8CEIlFRud2Uvch1ufopuEjjC4O4qcgnQO7TPnIZFQNs3DAwX5PfCFfTatZs0yRa2uPCf
         OiB+/oh6nDuqcou+suUv+aOgfyHdsWXEIZF0z8jqvQ+vnWK/vSDw28fNs802dvcB32vn
         cQWtGb3++CMyhWHC6zBS7FJDKk9prqek5w5eiyCFSq1Hz1QWV/sIBk967JLFbOjIwh2E
         ZWgQ==
X-Gm-Message-State: ANhLgQ3f29Wo8+dVNZiZAGz8UWeBs3JWhZSnZCty6qg+wcYbK2rdUrsh
        KDUh34TppcCU4aNCFQtela4=
X-Google-Smtp-Source: ADFU+vtD+mm6G1ezYzERZItplXv2RCPlcO9kl5cYlszYPgb6Gsn0jY1DFWBmmWspX7tyAFG/TNhuOA==
X-Received: by 2002:a62:6244:: with SMTP id w65mr14658981pfb.89.1584786219950;
        Sat, 21 Mar 2020 03:23:39 -0700 (PDT)
Received: from localhost.localdomain ([221.222.153.10])
        by smtp.gmail.com with ESMTPSA id 71sm8243135pfv.8.2020.03.21.03.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 03:23:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
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
        <vnwildman@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [GIT PULL] l10n updates for 2.26.0 round 2
Date:   Sat, 21 Mar 2020 18:23:28 +0800
Message-Id: <20200321102328.20755-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc1.33.g4914ba4bcf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi Junio,

This is the pull request for git 2.26.0. During this round, there are 11
l10n teams made their contributions, and Emir SARI contributed Turkish
translations, which is a new l10n language support for Git.

Please pull the following l10n updates for Git 2.26.0.

The following changes since commit b4374e96c84ed9394fed363973eb540da308ed4f:

  Git 2.26-rc1 (2020-03-09 11:21:21 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.26.0-rnd2

for you to fetch changes up to 1ae3a389c7a1cf5078bd07389f05252c534a834d:

  l10n: de.po: Update German translation for Git 2.26.0 (2020-03-20 12:19:22 +0100)

----------------------------------------------------------------
l10n-2.26.0-rnd2

----------------------------------------------------------------
Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.26.0 round 1
      l10n: it.po: update the Italian translation for Git 2.26.0 round 2

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (4835t)
      l10n: bg.po: Updated Bulgarian translation (4839t)

Christopher Diaz Riveros (1):
      l10n: es: 2.26.0 round#2

Emir Sarı (5):
      l10n: tr: Add Turkish translation team info
      l10n: tr: Add Turkish translations
      l10n: tr: Add glossary for Turkish translations
      l10n: tr: v2.26.0 round 2
      l10n: tr: Fix a couple of ambiguities

Fangyi Zhou (1):
      l10n: zh_CN: Revise v2.26.0 translation

Jean-Noël Avila (2):
      l10n: fr v2.26.0 rnd1
      l10n: fr : v2.26.0 rnd 2

Jiang Xin (11):
      Merge branch 'master' of github.com:git-l10n/git-po
      l10n: git.pot: v2.26.0 round 1 (73 new, 38 removed)
      Merge branch of github.com:alshopov/git-po into master
      Merge branch 'fr_2.26.0' of github.com:jnavila/git
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:git/git into git-po-master
      l10n: git.pot: v2.26.0 round 2 (7 new, 2 removed)
      Merge branch of github.com:bitigchi/git-po into master
      Merge branch of github.com:alshopov/git-po into master
      Merge branch of github.com:ChrisADR/git-po into master
      l10n: zh_CN: for git v2.26.0 l10n round 1 and 2

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git 2.26.0

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4835t0f0u)
      l10n: sv.po: Update Swedish translation (4839t0f0u)

Ralf Thielow (1):
      l10n: de.po: add missing space

Trần Ngọc Quân (1):
      l10n: vi(4839t): Updated Vietnamese translation for v2.26.0

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.26.0 round 1 (11 untranslated)
      l10n: zh_TW.po: v2.26.0 round 2 (0 untranslated)

Đoàn Trần Công Danh (1):
      l10n: vi: fix translation + grammar

 po/TEAMS    |     4 +
 po/bg.po    |  5404 +++++++------
 po/ca.po    |   517 +-
 po/de.po    |  5664 +++++++-------
 po/es.po    |  5529 +++++++------
 po/fr.po    |  5490 +++++++------
 po/git.pot  |  5228 +++++++------
 po/it.po    |  5631 +++++++-------
 po/sv.po    |  5559 +++++++------
 po/tr.po    | 24563 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/vi.po    |  5560 +++++++------
 po/zh_CN.po |  5387 +++++++------
 po/zh_TW.po |  5710 +++++++-------
 13 files changed, 53994 insertions(+), 26252 deletions(-)
 create mode 100755 po/tr.po

--
Jiang Xin
