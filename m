Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A267C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CD660231
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 16:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhHVQOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhHVQOK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 12:14:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9342DC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 09:13:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w8so14295612pgf.5
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26LqyJlJepYbFt89KKo+bc9M1qmBSb/U7Ga3vpmtEWE=;
        b=bP6AQOEmO2dZHURCZdAEXo94aqFhTB/bqlKtxloAzQkl1iKZHMYDEPoT9PonRoeVhi
         mg4aYQ4K5o3KmDU/PN2aTrhIw1nOuP0gEwBQFpjXWWwqfz1c0fK3WMICFSbY2m86/kHm
         wJaQ3brzzTLcrDVRf9NSbBUjV+xbkbcCzUl/o2YtEtrYv9W1ZgeWn8ZXitORi8/Ce7Zx
         QnZG2SnZ/9VwJT5uH7Aj6/GPRJf7LtDo2SeyVnKR3vaqAeHK8sKSmX5lc5vFNalyG0IY
         jkFGU3keYg0E0IMk1ZYfE0KWqzVUtHS61PIMcbHOL5c+wGDcCsqXjFb+B2VXnim12/Gl
         Rf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26LqyJlJepYbFt89KKo+bc9M1qmBSb/U7Ga3vpmtEWE=;
        b=lehnbXGAPBNSRHYAItnx+8hIQBNaFNAzr5hildCeJyR5JWfBYPMHCSJS5ti3DPA6xd
         4b9O7Rga56K9sayJObvBl/hwo+rap/nzzlL+gba3k77Enb2qtyIryYJfXUPsAeF5qve1
         DsFvJfgy22u7KW5suKXM14f5v6YP6DgpSLBt9MsTLbZV+mpgE8Pd6Xu2X3CmVxmpPTVo
         zZ7aUvjAhCmFuaJFE0FTHh+5ymwXLCknuZzvy8M1T8xY6c5Nmw5KEMzH3FiONJgmklG0
         1PFGqnnkJiIMQKLTMX8pvW8FI7+RCVZeJiBpeWoGWaQZqJv+RZxj5f/l9jodGoT6aGZv
         XASA==
X-Gm-Message-State: AOAM533YgTXYcIst+C8Gb43ztNLBaFPwVO3y2Pzarwat2RihnNO2YzCV
        I4J+Ipr3Otu9SEykxYOq5fRrnpa5aWU65Mpo
X-Google-Smtp-Source: ABdhPJwOcJuVq8kH/ifs5MhgPZAs/UVupxTeBbD+mTKi51zWCkW/yFcx05JbthzjDsEO1SPTopd6Lg==
X-Received: by 2002:a63:1358:: with SMTP id 24mr23627229pgt.327.1629648808927;
        Sun, 22 Aug 2021 09:13:28 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n31sm12957480pfv.22.2021.08.22.09.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:13:28 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
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
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 0/1] ci: new github-action for git-l10n code review
Date:   Mon, 23 Aug 2021 00:13:24 +0800
Message-Id: <20210822161325.22038-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Git l10n uses github pull request for code review. A helper program
"git-po-helper" can be used to check typos in ".po" files, validate
syntax, and check commit message. It would be convenient to integrate
this helper program to CI and add comments in pull request.

A repository is created for testing git-l10n CI workflow. L10n
contributors can fork and try.

- https://github.com/jiangxin/github-action-test


Jiang Xin (1):
  ci: new github-action for git-l10n code review

 .github/workflows/l10n.yml | 143 +++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

-- 
2.33.0

