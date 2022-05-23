Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF70C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiEWPVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiEWPVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E1286F5
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a13so2881852plh.6
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+TON87asLklkMyFlMpIqRa5MMConjy4oXRjWnS41UI=;
        b=e/aqgUnkWk3o3cdrnjoEfsbBZf7qvAHOIs6GR+HXE/s5J992mkhqgRA8/Bko51DXKp
         mXM4hKAQZuZSUL5lB0SpiHVKl6z8NJxIsHqrqVxu/cLMA7PqbF352eTFFkD7TnChMmDa
         T7ulm9VcFGdH/zPHdt8/pyL/NUrd2DIhBtfwOjx5kC0r0sou7AETSau/2SXRlPWXXuFX
         XViBTtmSt8G7nIvnzyUXUeZdyVJY4RYCFHBZbxCHP8kQ6zuAppaz/T8RS0yMYyEvLmwj
         3QcR/OEDTa9ZtYy2iF++M08W0OMsimWkBYxrGFvn+N8xFI2BgAGW1ye95sA+4NClW2f5
         Z3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+TON87asLklkMyFlMpIqRa5MMConjy4oXRjWnS41UI=;
        b=FEuAJmOPVPxBz3JLi6qqRnWVpGJSDJqTqgxm1TKHhO/brdyUUxbRY1wg/YyNzGuBZP
         rSUiNKWlFKX/QH/O0MYhXVfZ4pjUsl/CPXvxj0KnEJTW1VuXuZVHCH5BZO4+cr872C7Y
         d2LhH0wRV670fRyOf/hhNSYeS8f3VZeFn0lUQnPhidmKd1FhEmEtdMGVt33LOXOpgyjq
         u1JjD+jBZXtJS/xKzbXBHqJ06hVdk8mxwffnRbk/ZfGudCAV+sKZ6I6IHr2UvWYAV4dI
         TuwvEbJwgMqK5nUlhkqp+1MwUphULWCyUngmL6aHDevTfTIYwfY1U+tZmvZzoJTaX6DF
         mTvA==
X-Gm-Message-State: AOAM53120xlw5dNNnS8F7s9EI5sejQw6/3WWDfAuomq8kWjxj5i2bxYO
        vDCZtEsuQlz/2Ck1HCeU1+o=
X-Google-Smtp-Source: ABdhPJxTWbZhOk+RaH2exJ1x6uIHmC3/NVaqjLJwL1lJGyW6RJ0X4vlWrolp4unBIrEhh/RKEUs3Jg==
X-Received: by 2002:a17:902:b116:b0:161:4a38:a719 with SMTP id q22-20020a170902b11600b001614a38a719mr23395100plr.90.1653319299132;
        Mon, 23 May 2022 08:21:39 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:38 -0700 (PDT)
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
Subject: [PATCH v4 2/9] Makefile: generate "po/git.pot" from stable LOCALIZED_C
Date:   Mon, 23 May 2022 23:21:21 +0800
Message-Id: <20220523152128.26380-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523012531.4505-1-worldhello.net@gmail.com>
References: <20220523012531.4505-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Different users may generate a different message template file
"po/git.pot". This is because the POT file is generated from
"$(LOCALIZED_C)", which is supposed to list all the sources that we
extract the strings to be translated from. But "$(LOCALIZED_C)"
includes "$(C_OBJ)", which only lists the source files used in the
current build for a specific platform and specific compiler
conditions.

Instead of using "$(C_OBJ)", we use "$(FOUND_C_SOURCES)", which lists
all source files we keep track of (or ship in a tarball extract), to
form a stable "LOCALIZED_C". We also add "$(SCALAR_SOURCES)", which
is part of "$(C_OBJ)" but not included in "$(FOUND_C_SOURCES)".

With this update, the newly generated "po/git.pot" will have 30 new
entries coming from the following C source files:

 * compat/fsmonitor/fsm-listen-win32.c
 * compat/mingw.c
 * compat/regex/regcomp.c
 * compat/simple-ipc/ipc-win32.c

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 83e968e2a4..46914dcd80 100644
--- a/Makefile
+++ b/Makefile
@@ -2714,7 +2714,8 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
-LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
+LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
+	      $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
-- 
2.36.0.1.g15c4090757

