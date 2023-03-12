Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619D6C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 12:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCLMoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLMoi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 08:44:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7030B3E
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 05:44:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so9162367pjp.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678625076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uduRcl2eaBx154sgTZUvAxUUW6O+KW6p2awbq36F8ZU=;
        b=eivicKzqfs03Ez5LKIxbUpTjql/h4joA4HJHpG+0dtB/SJN8Z6Bw6I44J3dRugEj8m
         rphvFRJoIxF98nLhnneVWi1R2onxLnxzvy6bQYQbwZDhDU4Ttl8Z4LPZFPHPDw9hghNY
         QPOldzpgS7SZO0dFYxj8VwAzmNJ+EFDXluxJQIUCyNceaR11Do78vddcnqfXFp8Y9iAf
         HD+Nz8kBE3Gl4waI5ybWvoxU3Kzc6f6BSJyBtLdXpAGtYBPDuToqc0CEytC4HJEzDnqN
         ppSlQJQxrnjHXttC55HgMVtvH/o/8J/5ohjWxUsfAsOajYB2URGh7XGL1N0VHYxHCCEM
         cpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678625076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uduRcl2eaBx154sgTZUvAxUUW6O+KW6p2awbq36F8ZU=;
        b=FS/kHsUlBvolKJTaF0eXSV1dZGyfTHbe3IpNFPWfU5Swm3xF4DoqqOFsqcPF1L8mIW
         pBPPJiHmT9Tr20uyMVE4Kdy5Rqga0QVs4yZnTAkq7p/tlgWRQ7FiUN8tw8g8Q7vTOJth
         PaGX+6srCjg2o5+MNJRQxjjOwt1T4QdK7klDkPS0kwWF9D8yr1DBxr1jLAQn7/5+vFcQ
         kxeA8KXuRNtlWoDF2Ng1ksk1x8fAYQcScKVuBXHyOPxFTk1HzGCT5jpGHQXfDCY/HlN+
         TFC7Uw1hGzlj1P+WuLqGnezfdVB3PXWo+GghhMi1EiW8M/z4kxCaHuKhNGNRKo7PP/yG
         g/kg==
X-Gm-Message-State: AO0yUKW18yXE/wtNzceHpW8CMqz3FqT+XugXHJ6tXeq+1TUedfMxvfrq
        liG666wUzOFmtlYY/zuMYqhEVCA0P9WTGQ==
X-Google-Smtp-Source: AK7set/WD3sN1YQ3rSLJgBjVXmyNFOMpHajT+FvJBWXxvDUZ3BzUJZz485m6QfE9fxwoqjYOnTDCog==
X-Received: by 2002:a17:903:32cf:b0:19d:1d32:fbe with SMTP id i15-20020a17090332cf00b0019d1d320fbemr36936526plr.20.1678625076249;
        Sun, 12 Mar 2023 05:44:36 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902b48400b0019460ac7c6asm2756431plr.283.2023.03.12.05.44.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Mar 2023 05:44:31 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [GIT PULL] l10n updates for 2.40.0 round 1
Date:   Sun, 12 Mar 2023 20:44:19 +0800
Message-Id: <20230312124419.31093-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.40.0.

The following changes since commit 725f57037d81e24eacfda6e59a19c60c0b4c8062:

  Git 2.40-rc2 (2023-03-06 21:53:11 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.40.0-rnd1

for you to fetch changes up to 3dbb0ff340d53cc567036b50ba1d393abfc1ffee:

  Merge branch 'fz/po-zh_CN' of github.com:fangyi-zhou/git-po (2023-03-10 22:50:14 +0800)

----------------------------------------------------------------
l10n-2.40.0-rnd1

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5490t)

Bagas Sanjaya (1):
      l10n: po-id for 2.40 (round 1)

Emir SARI (1):
      l10n: tr: Update Turkish translations for v.2.40.0

Fangyi Zhou (1):
      l10n: zh_CN v2.40.0 round 1

Jean-Noël Avila (3):
      l10n: fr: fix some typos
      l10n: fr: v2.40.0 rnd 1
      l10n: fr: v2.40.0 rnd 2

Jiang Xin (8):
      Merge branch 'turkish' of github.com:bitigchi/git-po
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'fr_2.40.0_rnd1' of github.com:jnavila/git
      Merge branch 'catalan' of github.com:Softcatala/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n-de-2.40' of github.com:ralfth/git
      Merge branch 'fz/po-zh_CN' of github.com:fangyi-zhou/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5490t0f0u)

Ralf Thielow (1):
      l10n: update German translation

 po/bg.po    |  806 +++++++++++++++------------------------
 po/ca.po    | 1138 ++++++++++++++++++++++++++++++++-----------------------
 po/de.po    | 1167 ++++++++++++++++++++++++++++++++------------------------
 po/fr.po    | 1006 +++++++++++++++---------------------------------
 po/id.po    | 1220 +++++++++++++++++++++++------------------------------------
 po/sv.po    |  765 ++++++++++++++-----------------------
 po/tr.po    |  771 +++++++++++++++----------------------
 po/zh_CN.po | 1118 +++++++++++++++++++++++-------------------------------
 8 files changed, 3499 insertions(+), 4492 deletions(-)

--
Jiang Xin
