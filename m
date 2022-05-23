Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C232C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiEWPWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbiEWPVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171FE286EA
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i1so13404145plg.7
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h47ZfOUfxnb+1w4qOBNyDD/o8P04NCAJTNzSV1fpZlw=;
        b=jRDDf+LSpMTNfiH4T7rJ7vCkf6UCTpsjMnOXW+ykrqoaJpEbj/JOA4ZiGcwFOo/1vp
         uNJWnAdv1Vd0F/tmLm3DNWjL5jKXcpCXchqrrlQenjIcU8segKniYrT6pId9KRCOo1BP
         4eFmfUijYColSzSarOeicSWNc5d9ib8i1ODfNQEOxSbluLiOaCWS1Kj8PeSjyURQTpQU
         h2pN3UDYh9V5zXYfEsH3lCfCEareo8I2ICnIR5JUFozHiQUs4z3JxxAzmUFZiOjeDfJS
         Pq7DzJAdPY8L5DTVYF0PYyqGrbZ58PZADZfujqi0luVhqt9jwA+f07eg1m8jo7cfrrhG
         OwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h47ZfOUfxnb+1w4qOBNyDD/o8P04NCAJTNzSV1fpZlw=;
        b=QebquJmfCEivMMqrmawgDwy50aWGdtdh+LXgv6zqzAF0Ow1jOyMBPceJT+6a3iLh3y
         Dj77vNmTnNzSZOFsxcKRe3+c2M3sTjg4skGEFrDH2XgxfK8DfeTyZ/ZjMiKnrTHZzWt8
         OTDvlfCPnpkpCJFqZ39q4K/Kbi4Pgs866HnUQKQ03gPod078focKyucATAPxoCB/3He4
         T0okpFp0581HaUa0czO7cMM8WV6pa3MMPo57kwEZPmTewXauU/pBGbHjo3DjxbRKJ22N
         GIoSMzfGdzKlgNVxRy5OuPdO+MDUO3aa/ftbXUZJUKVJbRl3lL6ot5ggXsnkThTxMwOM
         6zyg==
X-Gm-Message-State: AOAM531pxWtmZ9d+PbYpwzc/chS6cS1nsfLL4kln1HDwFmNI7aTpx5nj
        YK+1ibaEmN3vmYA5BjjKO0A=
X-Google-Smtp-Source: ABdhPJykS0f2zHopBNPxsNEHqBWwp0oWrDIV3R9Q4Qj0186m8MP2+fRsGemjZ2EQwNBH5Czz1F68rA==
X-Received: by 2002:a17:903:124a:b0:154:c860:6d52 with SMTP id u10-20020a170903124a00b00154c8606d52mr23601245plh.159.1653319297560;
        Mon, 23 May 2022 08:21:37 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:37 -0700 (PDT)
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
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 1/9] Makefile: sort "po/git.pot" by file location
Date:   Mon, 23 May 2022 23:21:20 +0800
Message-Id: <20220523152128.26380-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523012531.4505-1-worldhello.net@gmail.com>
References: <20220523012531.4505-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We will feed xgettext with more C source files and in different order
in subsequent commit. To generate a stable "po/git.pot" regardless of
the number and order of input source files, we pass the option
"--sort-by-file" to xgettext program.

With this update, the newly generated "po/git.pot" will have the same
entries while in a different order.

With the help of a custom diff driver as shown below,

    git config --global diff.gettext-fmt.textconv \
        "msgcat --no-location --sort-by-file"

and appending a new entry "*.pot diff=gettext-fmt" to git attributes,
we can see that there are no substantial changes in "po/git.pot".

We won't checkin the newly generated "po/git.pot", because we will
remove it from tree in a later commit.

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
2.36.0.1.g15c4090757

