Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9585EC433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7065A2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS5LOeh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGZQb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGZQb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 12:31:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03280C0619D2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 09:31:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m22so8058324pgv.9
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri5ILW6looPQPw7kIlf2LTeY9Ld2ttbOC2RflUkr2nI=;
        b=vS5LOeh2hf2RoULZQmlO+cQ0ZQ8QJiVcnQJ0KLJQe7F0jy4MHX/x5zZUUnWBGg26/l
         c/CLX3xhagkoHbow2cciUhjVgNMcWYiQ9TDsWSl17sPnLFRVvRQydtKhpz2/cF8LUgkS
         HDmGND3Ce3J1z0XnjSYkAafT4mNyykNZaYLNo5l9Ssa6eqH7apel+6rdrxLWJwmjKBt6
         8QVZCNiy+33X9v0tHvP4BqeKWMGH24ismxRf1Vwi1o2DJo5x3ibPe1peV31YWZCwCz7a
         jbDgmuDslcX7fttj0tQpJrsY6Gw5aP9lpf+Ab3W80M0Gyv6g4vNM0wK643k8naffAve9
         FZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ri5ILW6looPQPw7kIlf2LTeY9Ld2ttbOC2RflUkr2nI=;
        b=ije9f/YX+hyDil5Wx8MXuDGbLPVW36lfAHbhXV7XD34LX7sRaYoSScg96IXDI6X0+r
         eVIOxe9ah7CXg39sYaCnsmB1IsjsCxXEGh1p7a5ax+XGRRApoyzkuo4lcr3wLYQuUVBs
         KdNEizXU7ZO/8sgpdc4r/L1NKcsPx3lPbRV+0KVK7+KldMyzUfsXyFNGAYIAeES1MuWV
         iHnNZgx1oq98oODXiCv9vngm3sbab+qU7NjByiRSiyW/z5FhvKmeFEQ1c0mXJ06Jq/vO
         R8uPATexhUwwv2joAlTAdSr3vNhios04hd91Zw/xRL9b5YIPLtOTqHmoeeeooI72JE9H
         qnuA==
X-Gm-Message-State: AOAM530K07DgLtbA9rKsvSv1gqBVrTWtsuqCWy3avsadfvOO/0q+LBPp
        dUrQF4TDZxw6xTHydX/UaGA=
X-Google-Smtp-Source: ABdhPJzsjXF/nxrfI3TZ0GMo+zqOxoIxIzmQL9S/xmH1gKlXfNdrp3h30Ywz87uXUkvx0/YLx87XoQ==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr17044854pgv.213.1595781086491;
        Sun, 26 Jul 2020 09:31:26 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 199sm12586950pgc.79.2020.07.26.09.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2020 09:31:25 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [GIT PULL] l10n updates for 2.28.0 round 1
Date:   Sun, 26 Jul 2020 12:31:19 -0400
Message-Id: <20200726163119.21834-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.28.0.

The following changes since commit bd42bbe1a46c0fe486fc33e82969275e27e4dc19:

  Git 2.28-rc0 (2020-07-09 14:00:45 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.28.0-rnd1

for you to fetch changes up to 05b3a3d73048c4284361cc75242d22d9c8a20a9f:

  Merge branch 'master' of github.com:Softcatala/git-po (2020-07-27 00:05:41 +0800)

----------------------------------------------------------------
l10n-2.28.0-rnd1

----------------------------------------------------------------
Alessandro Menti (1):
      l10n: it.po: update the Italian translation for Git 2.28.0 round 1

Christopher Diaz Riveros (1):
      l10n: es: 2.28.0 round 1

Emir Sarı (1):
      l10n: tr: v2.28.0 round 1

Jean-Noël Avila (1):
      l10n: fr v2.28.0 round 1

Jiang Xin (6):
      l10n: git.pot: v2.28.0 round 1 (70 new, 14 removed)
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'fr_v2.28.0_rnd1' of github.com:jnavila/git
      Merge branch 'l10n/zh_TW/200716' of github.com:l10n-tw/git-po
      l10n: zh_CN: for git v2.28.0 l10n round 1
      Merge branch 'master' of github.com:Softcatala/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git v2.28.0

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (4931t0f0u)

Ralf Thielow (1):
      l10n: de.po: fix grammar

Trần Ngọc Quân (1):
      l10n: vi.po(4931t): Updated translation for v2.28.0

Yi-Jyun Pan (1):
      l10n: zh_TW.po: v2.28.0 round 1 (0 untranslated)

Đoàn Trần Công Danh (1):
      l10n: vi.po: correct "ident line" translation

 po/ca.po    |  854 +++++++++----------
 po/de.po    | 2586 ++++++++++++++++++++++++++++++-------------------------
 po/es.po    | 2728 +++++++++++++++++++++++++++++++++--------------------------
 po/fr.po    | 2552 ++++++++++++++++++++++++++++++-------------------------
 po/git.pot  | 2452 +++++++++++++++++++++++++++++------------------------
 po/it.po    | 2536 ++++++++++++++++++++++++++++++------------------------
 po/sv.po    | 2526 ++++++++++++++++++++++++++++++------------------------
 po/tr.po    | 2505 ++++++++++++++++++++++++++++++------------------------
 po/vi.po    | 2548 ++++++++++++++++++++++++++++++-------------------------
 po/zh_CN.po | 2490 +++++++++++++++++++++++++++++------------------------
 po/zh_TW.po | 2540 +++++++++++++++++++++++++++++++------------------------
 11 files changed, 14504 insertions(+), 11813 deletions(-)

--
Jiang Xin
