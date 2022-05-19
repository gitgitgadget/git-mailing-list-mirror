Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E7C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiESIQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiESIQO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 04:16:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BE038BD3
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q18so4120769pln.12
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aIg53QMLlUsbnIEoNkI3J4Eabwlmj6nGI5Bok5v/xYk=;
        b=N7uD7HuKSgKHCtx/2IqREgEB5FC74vxrc8PWpRyp3EOws3AqAwh/b8Qi8RkmUxhAM7
         0n6wh45QLDe7yN3Ex1UmS1n9O9R4GYL+Uug3VBsinhZTaPyuzBO1EkgQKIz6XDSZ9GNV
         eYF7b0dcoLph0uK1Ne/0TpL1vN61pm0wOy/pQ4/1XYQaxRD7jCSLh5ixDMAxo72XCE+K
         /2QhOrtDa/Yf0MKpc4sLjhwnP7cG0pHfvxXefrPJZ06S3y3sX84w81V8DyRbb6nOjh/4
         gWvPNYKVql077kqCXb7n/vSwFiP2Aq4DBKN8Do+r5o9JZpiW+9MNPLQ0+KX8s/ibKFrC
         LjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIg53QMLlUsbnIEoNkI3J4Eabwlmj6nGI5Bok5v/xYk=;
        b=z/1DzSdfPvMs253cV/MJhkkEPTOpD2Yv8EdNlrQl8W+rUEAQbHkLOxNeyZ7FRLmt5z
         7+/I+Qy4ZVywPmSJlt0AED/lKNeGxM8T9yLkFeis8soNdOSEh2JCZ3njeV86+WhxvcD5
         DGVyLZBhZ/jaY3VfPu3oj9c3oQ5Wqp/mvA5CVoocG/k0HXeN0AEDfSNvL+9YN1CLD3nH
         S0JzY93G2/H4nwqIve225tkuPJhFgmHbYlU2XY1OvWeijZLISKK6qZMT4jM+MKKAoG22
         bC3FG4yns85tNOlM5rJ9vdLpa516kL7HFBfVGV8Sb4T/hJoM+rEtTlJtgjEi3KJLpJ0W
         khXg==
X-Gm-Message-State: AOAM531nd1oJ7H5CtGwwBMQLiv4f1Fz3ELQ+BJGa8CdwG6NmxKBlGHhP
        RaaGGoJLzE7LeDkSlmRGat0=
X-Google-Smtp-Source: ABdhPJwtIRiqcAneGY77B7HxNs/3u2sfKtumpz99bv5gOWMmO4h7m4uLBLVd35nhBCBre9Eqw8Cc/Q==
X-Received: by 2002:a17:902:ce02:b0:153:bd65:5c0e with SMTP id k2-20020a170902ce0200b00153bd655c0emr3454594plg.160.1652948172922;
        Thu, 19 May 2022 01:16:12 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u127-20020a627985000000b0050dc76281d3sm3576687pfc.173.2022.05.19.01.16.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 01:16:12 -0700 (PDT)
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
Subject: [PATCH v2 2/9] Makefile: generate "po/git.pot" from stable LOCALIZED_C
Date:   Thu, 19 May 2022 16:15:41 +0800
Message-Id: <20220519081548.3380-3-worldhello.net@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.36.0.1.g15c4090757

