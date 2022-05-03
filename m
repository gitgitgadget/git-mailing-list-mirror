Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C73C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiECN1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiECN1k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2573377C7
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a191so1425627pge.2
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4rmeG7xC05SBG4+TLUVFdD8yVUD37TGwPracvTN1GM=;
        b=jeJ94VMcJ5lL9R1PnmchgNEtjQRVGjw00cy24ISdI7WNP82i1cC+1TUBbU4kHhkLt1
         y2o0yaYmwizJtCLa1hXPLoYK6Fpwyfw0PkuX7mESiF3j4y3TRe50FnM/AZs6Ks1240jG
         Ut82GEx5eMqLLbTRO/EJDnc8GVWc6JR7qDOwayRAU+Q0uPVW1GTCq7mzvR3sGyJjivwT
         jEgxdbtSY5Kk3NZwe1EIXTmgzJKQ6uyUbhNONNvQLHCU3/8tRVSirhFULXufWXyWmVOW
         Vx0hVNXFDdnMUlCOQrFx6/DbaHeZQzneAFvcRKpJsVVODDpYp3U1Iu+VaC7YrJzkZCKc
         2ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4rmeG7xC05SBG4+TLUVFdD8yVUD37TGwPracvTN1GM=;
        b=SVkzMeHLB/2sYDLa0ri7ZTWrfhbwRmsY3lXOBL2+sviFnlGAxYaLOtpdwsIWLbLuDV
         ABcKtKeWmWnZrHiEXnMkCWVi5jXOOV323DArw8Io0pUYeuUuRhB2//SD0l/WC3hUh7wN
         tJXQ+i5ppyaIAjVUFZUBmZehzM53g9RuB3zGK7s7ZPCxDzCOrV8oTiGnGAcd9D8CoTyL
         Sh0hqqvZpXWTiWuA+K/1TOh17Yfk/m12xPd2hpYcunDc6HXDVYuOVyoFXjBN6/EuPdrC
         F7AjZcfOG1Bomz0f2eaN6qPysc24Ro/bPVLJ5DS0aevATh7EcVEuBHkcNWPrT30cLXlr
         ZkqQ==
X-Gm-Message-State: AOAM530LYk4uikmmYxbrBXIrTBVYXDxs71Hg4jPg8UTqoWsFI2fMdlEy
        fitbefwc8vgR+kzsUXlklFU=
X-Google-Smtp-Source: ABdhPJyG37W27+cPlgfdFsBzoA5LKnq/vrdDdim+TDHvd/O0BFS2V1UIqDjn6j2ygmkGK9uBr4mbnQ==
X-Received: by 2002:a63:f749:0:b0:3aa:361c:8827 with SMTP id f9-20020a63f749000000b003aa361c8827mr13752555pgk.361.1651584248308;
        Tue, 03 May 2022 06:24:08 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:07 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
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
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH 1/9] Makefile: sort "po/git.pot" by file location
Date:   Tue,  3 May 2022 21:23:46 +0800
Message-Id: <20220503132354.9567-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Before feeding xgettext with more C souce files which may be ignored
by various compiler conditions, add new option "--sort-by-file" to
xgettext program to create stable message template file "po/git.pot".

With this update, the newly generated "po/git.pot" will has the same
entries while in a different order. We won't checkin the newly generated
"po/git.pot", because we will remove it from tree in a later commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index f8bccfab5e..83e968e2a4 100644
--- a/Makefile
+++ b/Makefile
@@ -2706,6 +2706,7 @@ XGETTEXT_FLAGS = \
 	--force-po \
 	--add-comments=TRANSLATORS: \
 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
+	--sort-by-file \
 	--from-code=UTF-8
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
-- 
2.35.1.577.g74cc1aa55f

