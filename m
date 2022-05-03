Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA180C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiECN1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiECN1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE7B36E02
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v11so5213691pff.6
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXw7gyc3T9msHC621RbhjmAnZiaHQhfwHZIa3YrN8t8=;
        b=nilCOYMYOtK3Ys/iPt5HyNnO2amKaxono/SgeAOwVbFaq5B9Ij8QNVutBJMf4iPo5T
         YQ+ZD8ppGGftUL3rKM7gIKwinxy1oNU0QYQjAD3RXkKehpVVqVUcyMMNfgBeHaDySFat
         1T/MzrBcnIKApE/kGukpmEqpCMrerJZm4wjjGN/Ey68yy6GsoKM4E7PkXPCBkPV34Mf6
         WCFMDfx3/4rLpKj0inZm1UXzNN1BE2lU8ATFkvFwrRP8iidha9YZKFEkMvLaPD/ZjTMA
         mcdyBybLUwThv0LedXYAoSsMKD/TohFHGy7N7jRG0D+pU2S2Lm+UF2LzBQsDmdbC2fnU
         ldBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXw7gyc3T9msHC621RbhjmAnZiaHQhfwHZIa3YrN8t8=;
        b=77nBZls0QikBN04L+0iN/eNQ3hiD0ulzBY7xlkp8pjqEw2aMLGNBTOhoHwe6zS9id7
         F7HG9I85Dyp7UKz0IXG44NFjlRWy/5rN5nwmvMhu/jkvI1oBSGl51LmaN0y+KqZxmYXp
         Ba2AKXQvYs4Bp8GF6qKOwmL1epwSvpq+0/3nAHEbYuq02Xl+G/sN70nWXP38+wYypRDT
         TXQXjGJFdml07D0D37Q7kjfuDi3g8gY27gVxejbU8MmNg688NYCQwsQjADcevyNs9Tj6
         KyUm2RjxBn7XjZPsELTcJ3oz/fCOW22LZETCpW+3TnMY6pO41MI4ZqmFr0Ak+5q1Hbv6
         QbrA==
X-Gm-Message-State: AOAM531GgeHBJiiVcyZb3EIyKxxP9isHSRDqD5SNiD/lrST+j9I0Xmh3
        ABUVevDIDMUiJ/mBTQVHzXk=
X-Google-Smtp-Source: ABdhPJwh0vEXYk7OYn442I/Iji5ofMjctu6ml+6e9qVBaEvFmE+9I0PWDU1vVsYqV3ddq79p7DfKfw==
X-Received: by 2002:a63:6c0a:0:b0:3ab:8716:3d04 with SMTP id h10-20020a636c0a000000b003ab87163d04mr13509647pgc.507.1651584250228;
        Tue, 03 May 2022 06:24:10 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:09 -0700 (PDT)
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
Subject: [PATCH 2/9] Makefile: generate "po/git.pot" from stable LOCALIZED_C
Date:   Tue,  3 May 2022 21:23:47 +0800
Message-Id: <20220503132354.9567-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When running "make pot" on different platform, we may get a different
message template file "po/git.pot". This is because the "LOCALIZED_C"
variable may have different C source files on different platforms or
different compiler conditions.

We can make a stable "LOCALIZED_C" variable by applying patch snippets
as follows:

     ifdef NO_LIBGEN_H
         COMPAT_CFLAGS += -DNO_LIBGEN_H
         COMPAT_OBJS += compat/basename.o
    +else
    +    LOCALIZED_C += compat/basename.c
     endif

But it is much simpler to use variables "$(FOUND_C_SOURCES)" and
"$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C".

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
index 83e968e2a4..60ca42c268 100644
--- a/Makefile
+++ b/Makefile
@@ -2714,7 +2714,8 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
-LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
+LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
+	      $(FOUND_H_SOURCES) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
-- 
2.35.1.577.g74cc1aa55f

