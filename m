Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F3C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 08:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiESIQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiESIQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 04:16:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522A38BD3
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m12so4139600plb.4
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLG6kv5qLo596EOmbNFTRWAKv8TMUXS1CKfnWnS4Vnw=;
        b=b8tNnmNW6n8+voX4i/P+ra/zRKm3NV5jDLJSziIB0SCB4GVR2FGjCVtM+tLa3Z8D3G
         R8WGA4B6DhcuJ3alFoM2JLQp/nswLmMPP8fFSRCN4MNfplyUdPmvT6464MYtdzUW5qaY
         p17JTUhSX/+0lmv8/J/WLktdbhyX6qZkCkL+esu43s8Un6TGb3pqeZtpB4cPGA8nMgwH
         vpNwHz6We0/oCI5waN758XOI3atTK4admbJVnXgXJu6xGuTao0r36TaosJnZOqoEDX57
         VFXVbqhQtFfJUv6Mp9U/iodWx6plfn1D54Ht/3F4Z1DDlAwDMfwTNr+0EGV/dMqRdVPm
         1fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLG6kv5qLo596EOmbNFTRWAKv8TMUXS1CKfnWnS4Vnw=;
        b=haxfWHLrl13NLC3WMn8wBssy1PpriFj3/XnI7tSflTP87SvbCOkKCtjnseIHTSNivn
         ugb1tPW9QwYBeV/P3dUioCk3sGKOItMGzwun0/f65ByYDW+OyA94e8sMPLyef5JHsm1M
         1eA1tB+qLakkH8u9RvL0RwM3U+dssr/0Lj+MW+6m/jspAaBBO4rESsECdTTD9QNaDGGP
         PKqakON+SPInestj+6LSsf+o8o4gAL/vVVALsnlhuIsdqHwk6n8nWQsy/t1YCt1y2nEu
         3F6AQFOnAFlRZ+xFr35JRxIntwd/zo5XLX3Kjp9pPb2u6mn39UyYOgamynZQG4qvk0As
         MCUw==
X-Gm-Message-State: AOAM531SxwarpX4vgrFcH3x20Bxs/GL2RrB1stnKIQWD2yBhZcvVl2w1
        X4qF0WcJTyAOlIRh1lY/9kM=
X-Google-Smtp-Source: ABdhPJwHZIZKwt0WEfQM3+M9FMKWC3N7F8rrN8MyEqWmyIFAPWcQ+FH1a6Os9dW32+vwxpMvTIbzvA==
X-Received: by 2002:a17:902:d88a:b0:156:1609:1e62 with SMTP id b10-20020a170902d88a00b0015616091e62mr3627907plz.143.1652948171422;
        Thu, 19 May 2022 01:16:11 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u127-20020a627985000000b0050dc76281d3sm3576687pfc.173.2022.05.19.01.16.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 01:16:10 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
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
Subject: [PATCH v2 1/9] Makefile: sort "po/git.pot" by file location
Date:   Thu, 19 May 2022 16:15:40 +0800
Message-Id: <20220519081548.3380-2-worldhello.net@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.36.0.1.g15c4090757

