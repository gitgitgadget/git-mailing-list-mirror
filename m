Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E79C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347847AbiEZOus (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345274AbiEZOum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5645622D
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q4so1608805plr.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyDPm+LruJahN9f4i52bnVksky7Gx4Gs4izyiWyqMQk=;
        b=Qx6gYXQP7dxgfnr3gxSjBXOk5moAw3+NSVjZt0GsSUVgiLFlgbLIm4IzvCe1OpDGsr
         yj+sVDz8zarxdC3FoNxp2XiooljLH5WncpO/z9iZojDF4REo1Itb0kINKReSWikPfV30
         aDlYxMaFnaJxVSZ58r11JHEbwG8pTJgLKnQkXZ0hukTuY0D0ODl3Q8M5sL3d0ZG7LJta
         dKDlEXP5qG5PCRpr6CB76hVcQTRyFYAzryow41WQU7Fk1ja5ZZ0fFc8wXrf5zGldxvFt
         gRDjnQqaJiw/GiG0dYjp7UJHHQAZJMmbUAC18BAfenvCG994v8E2b0x0u6v9SwlPUyG/
         uJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyDPm+LruJahN9f4i52bnVksky7Gx4Gs4izyiWyqMQk=;
        b=dSkj6HA2DDBoZib2jAGdbPw6w3O9rfqxrEazFfbvmgF3Knkzl8CtDPfbQj8eQm/Nz/
         kiKw82+s/dKaMcqRg1B/2WK/2bGj3TZw6Pa+iSbMuOu7wbeLzPqFupA2KBya8tG/qoRx
         +9AWMPYukmIc38avvH0hhvGXf/BsPedw7KWOrpJc/ZuDVNBwxsOvxY534h9fbQcD8Lbn
         CYwSWaV/YRXXJF01klhVK0kq0fvPhyjVTSdZO5VQHFzFpxmsJMMDyao5xUDGOLoi7F8n
         Cw7sUL3FKc+UW5ddp7aOXyTMA0oa1N+WzdzgMlOh+5vhA4YjDVLsDD7SN7Ux4Ag/XN0n
         N4+g==
X-Gm-Message-State: AOAM530REyr9XZKpmTkGSyW8cGW4IiFGukJty4gK3VK0NwQWI1BGGee8
        Eitrb1fipmmSBRiP7ivjynE=
X-Google-Smtp-Source: ABdhPJwJcvqYqyTJd5eqxb90drZtas38U79G620rj+JGSM4bILJvYdlOdM+VqxLSikdN/WXragAfsA==
X-Received: by 2002:a17:902:ecca:b0:161:cad8:6ff4 with SMTP id a10-20020a170902ecca00b00161cad86ff4mr37817606plh.111.1653576641382;
        Thu, 26 May 2022 07:50:41 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:41 -0700 (PDT)
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
Subject: [PATCH v5 02/10] Makefile: generate "po/git.pot" from stable LOCALIZED_C
Date:   Thu, 26 May 2022 22:50:27 +0800
Message-Id: <20220526145035.18958-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
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
index 7ca95cdb82..f2f9c9bc81 100644
--- a/Makefile
+++ b/Makefile
@@ -2713,7 +2713,8 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
-LOCALIZED_C = $(sort $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H))
+LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
+	        $(GENERATED_H))
 LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
 LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
 
-- 
2.36.0.1.g15c4090757

