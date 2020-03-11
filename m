Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D7AC10F29
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA357208C4
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 07:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fto3iOma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCKHcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:32:15 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45484 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 03:32:15 -0400
Received: by mail-pg1-f177.google.com with SMTP id m15so688188pgv.12
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjmYI3w1XshYa6gRU0tU2xXHScbfWAYMfZrd7YJc8v4=;
        b=fto3iOmaXlFaM/bi8d6Fa1naMmOzBe2SsGrtkDwJL/Z0VqNGu+a/6tF9UO9fieKhM6
         xLxDhTf820bS797ZCmDjigpVF/apRQXZExeVr1FPJzjT6zl2EcpBRPcpuo1FvXiRMtzF
         2hn45TTjsLQpXW/BPDiNGyz/O4k6+ohILfbTb6uREd2oNG2854/Kqm5MnSlEIrD2C1mb
         0hh67V7h7p4WnuXjKsm+ejQZ13ElN43fem+NRrpJaOlw0oeijgcnWTUDlhBvo03heQNd
         1Zxn65efvuSYzhOv03sxrDGs/67kB4gr2DATMQOpM2S48MVPwecJo7zzpg9/5HJFi8fa
         0p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjmYI3w1XshYa6gRU0tU2xXHScbfWAYMfZrd7YJc8v4=;
        b=tRDBHEHzNi6sN3O3QoE343ZDLJj3Q+N52UDvlUuaosOXvM8IrJrmFiAqcwgidyTXo3
         MWl6mUbBucxRaCpRKm2JYrESzmcBPOflvoVSe3Z+Lz1ilaTrtp6ZwedLamXPozZlGxNt
         aj+GRr5zrMxzpxr/7eAqSGLso2yvaXmC3rB850nGHMmhEZjvEVgTkS3OEhiReTOW3yg2
         FFY2nm7PN5TDhGg3WNi5GkJ2FlILi536JlxC5I09cKo5nT+/arX81ESll9jbQt6dFOJ2
         TYss5pHYuQSwHLPjLY3yGvWTifluyGW6ZrHIDenvhWI8zyMtJkh6RlgAZinDURjM4R69
         uB3w==
X-Gm-Message-State: ANhLgQ2CQRa3jOp0uFwX64jrV+ArJ0Waq+9W7lNasPQubT9WG3NJYcRg
        Re4dN51JJlj4fa0EXyUrVi+rkoCRPTEwxswo
X-Google-Smtp-Source: ADFU+vvMHwmmoS1qs0q5s/YdJyX7W63m9U0wjrEzpUD96frcv1KJoQFxjrEh0kjusZ6LyA//gM4JKw==
X-Received: by 2002:a63:c445:: with SMTP id m5mr1538886pgg.194.1583911934052;
        Wed, 11 Mar 2020 00:32:14 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id j15sm17801993pfn.86.2020.03.11.00.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 00:32:13 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.26.0 round #2
Date:   Wed, 11 Mar 2020 15:32:00 +0800
Message-Id: <20200311073200.21160-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc0.1.g67b07ef6f6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi

Git v2.26.0-rc1 has been released, and it's time to start new round of git l10n.
This time there are 7 updated messages need to be translated since last
update:

    l10n: git.pot: v2.26.0 round 2 (7 new, 2 removed)
    
    Generate po/git.pot from v2.26.0-rc1 for git v2.26.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
