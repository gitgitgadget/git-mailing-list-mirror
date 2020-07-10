Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B4C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD53207BC
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQBGsxB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgGJHrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJHrC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 03:47:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A279EC08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 00:47:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cm21so2258879pjb.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnEkKr5KhQMa9Qgvc2ZNCbjyv2c2snQ5Kj+qCRFHkvE=;
        b=sQBGsxB8KKa2qf5jTh9m5PF8hmySOXh//bcD/5O8QF0wK+6L5zLJL2A4kdcb3M++FE
         4YuUQBWFd/QQl9rlZYK67AgRkzH74jGXeOHBliUWZtVAAAspmccclekUuMKBkU3iwegG
         bx5O2LSrB5MExjl7lpEgoVcDNliyzktCwSS1RtKuNsE8Pq/+/FsXJA4cXel9E2XzQgEv
         iC6S1PBBdQzof+bGpT+okY3nJikQUhLFbxmr9IZKva8REJQBpwlwwWfEaOH99VAgzeDH
         h3/Kveuixer2i7bWpVbse7nt7Ep/cDEWd9sPIhGT6Our+D8HFEWB0fWHlQNoLyzyJBJX
         Hiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnEkKr5KhQMa9Qgvc2ZNCbjyv2c2snQ5Kj+qCRFHkvE=;
        b=aW37Y+3OmlN+qNcANYpU2nrFk4ChoJHkFoPVtG5b2Mc2tPbcYGtWeNApKbOOwGCrvQ
         RFHngfFtnbxpACxp+M4+RGre3p8gCp7E2DEWbo/ipppcb4xLTmqCxU0QH12wnNEROqNR
         1lxBuBJOL9hesaeH9nNt7KHPMg6KJCz+s1NnZi0tWElSAeq01hPgydjmtsLgJDoqgWyw
         +o8lkMakkQvWgeZDpO8NghbTivbMO48fezp4HEvBUEdI3Tu1pvbVBzg9xn3/pgOT1b+S
         q5+wMWDpjGs4gUXuJJqnxRrFLNqYsgQMCCTaViggxNBKAXGFc/gg/UeYvI79nqlR3TUU
         3DbQ==
X-Gm-Message-State: AOAM532qY1XfBQZBHgpNKTeQ6vt9Rv22auPfHzMfl+6JhjmtuzLdatYT
        NseeEsqizEAOXncQYVUmoIeILvq5
X-Google-Smtp-Source: ABdhPJwVJhej7Xul0ngT9ukAvF/2uUMbkqjwhtZFnqvgp9Y0QJIH2qh1w/p7WDQpqGUjepL3NlRaGQ==
X-Received: by 2002:a17:902:e903:: with SMTP id k3mr42396722pld.148.1594367221486;
        Fri, 10 Jul 2020 00:47:01 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id k189sm5244779pfd.175.2020.07.10.00.46.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 00:47:00 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Alexander Shopov <ash@kambanaria.org>,
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
Cc:     Git List <git@vger.kernel.org>
Subject: [L10N] Kickoff for Git 2.28.0 round #1
Date:   Fri, 10 Jul 2020 03:46:39 -0400
Message-Id: <20200710074639.16322-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.28.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are 70 updated messages need to be translated since last update:

    l10n: git.pot: v2.28.0 round 1 (70 new, 14 removed)
    
    Generate po/git.pot from v2.28.0-rc0 for git v2.28.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
