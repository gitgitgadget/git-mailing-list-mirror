Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79158C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349555AbiEWBZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiEWBZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A038782
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h13so6077727pfq.5
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwJRpqFyGUl5kw71uc25NoZp+zgxndYNfkHDeQZIHuA=;
        b=IGuUjC8xIPqNkJfg0x5hKAyAYwsdHSsMWEY6ld7SMnf2Jv0Y8G6RJDw1XzgRGji1zy
         Pt2xhXTdcYas07ZrHt9PlvTfiH3WQTiyOGoHEcUOrduxSwuPm9sYcTNFwRiWVMj2dKM8
         Zu/ByobqboqN4YgOsLrqyTmw982eATdQlQizoS3GaA1GjuEBt9x20n4PgdXWQHGPFVmo
         W0d2MVex1zIYqH9v2MhIa/anegJDgZ1kwmW5bsGMWxZG3vPFOcIVeMrUpYjL4gU74GPE
         KDQVW2b7dBXa5qlcPZX9Xgujx1WvB4o8tyjPz5PU3ZemezbMsZ8GayqIi7US8hEJB3OQ
         jW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwJRpqFyGUl5kw71uc25NoZp+zgxndYNfkHDeQZIHuA=;
        b=hblp05e4nNSuhqr4PQBQGmNqrV27yRRF74v1XTMMIk0Zd8ILl0rhzuq7mzRy0Mmb40
         PF+V0CqD/evuarotnXqnUhShx94y4NgkDP2rli24OEVOBVzpOj1n8RtDff/dV5o4PVr7
         XB27F74PONpjAyWsYFoRK62JcE5u6uero51+4YvHPy/jffonZ+d/wDApHGk21DVZuD4f
         RmgYmFQ6yLeLT0TfqTOPcF3pZXzKMU7gnIIeljUtQJaO+tPEdjBs5N7d0mWFdRPZ5pK3
         zA9BulCtve6bUeLHWK6uOXYpX23Nk3cj24k+7nKsnBCZsm1hNPffy+URGlxYoSNCjoTl
         ZKkg==
X-Gm-Message-State: AOAM531UYn9F5ES4XwykjcHVUxKeVQyBvJhK6TXAy2A1ALS3Bb+YloQv
        868DDOwnigmFx+e8cXoCbyQ=
X-Google-Smtp-Source: ABdhPJzgp2pHqBhxxl+uE4ExTQtgUe8sGk5q2RJkKbui0LyiIgvpUrCFJhd4xNYc8Rv+Yu0Cj9bg9Q==
X-Received: by 2002:a62:15ca:0:b0:518:132c:22a6 with SMTP id 193-20020a6215ca000000b00518132c22a6mr21534833pfv.28.1653269138887;
        Sun, 22 May 2022 18:25:38 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:38 -0700 (PDT)
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
Subject: [PATCH v3 1/9] Makefile: sort "po/git.pot" by file location
Date:   Mon, 23 May 2022 09:25:23 +0800
Message-Id: <20220523012531.4505-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220519081548.3380-1-worldhello.net@gmail.com>
References: <20220519081548.3380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We will feed xgettext with more C souce files and in different order in
subsequent commit. To generate a stable "po/git.pot" regardless of the
number and order of input source files, we add a new option
"--sort-by-file" to xgettext program.

With this update, the newly generated "po/git.pot" will has the same
entries while in a different order.

With the help of a custom diff driver as shown below,

    git config --global diff.gettext-fmt.textconv \
        "msgcat --no-location --sort-by-file"

and appending a new entry "*.po diff=gettext-fmt" to git attributes,
we can see that there are no substantial changes in "po/git.pot".

We won't checkin the newly generated "po/git.pot", because we will
remove it from tree in a later commit.

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

