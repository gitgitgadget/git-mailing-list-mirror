Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5129AC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiEZOv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347842AbiEZOuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABE3CFE14
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so4614443pja.4
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0ko1avpeqZg2FSS7TM0qMxohfSNsn/oRPauO+vpuqI=;
        b=covzC9mo6+6N3KU+HCoYII2QBPDrE/FMXfoVh9A7nx3oPq3x0yB3FIy/l49UX+kRIq
         E2ly6LgclSxSiU+UrsYaQO2Bb3clIEGJ18Hwjy5/FsK2Zxvsul4OaF65DGWvGBcWeO82
         ZiXw5HWgkXga0Dp9zzoZYnAbkuwIJQDxgLR3kxJnwElwUCtdZ2+KVQpaoNeISWUIeX65
         GJkqyReaDs6I0pLmtwRtNQU4gudf1Wr15We3lxOf3OSZj+kqWTLrOv9dgWJ4IJEb9vee
         QZoe3f2Viazu9MD/pfl/biyhgvJpskyI2xa1wLd4ywj5uTZSKc5m2pW7hxv2mQh5ovJv
         nJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0ko1avpeqZg2FSS7TM0qMxohfSNsn/oRPauO+vpuqI=;
        b=kkv6A6A3oZzPY9GhM1iQkMXkmFJkbwJl85TrIHFIlywOcM9Cwv3aL31eKrw0r6Qav7
         e9qgw/mrJLSh5BJSKsDjq6SlcfDqLXTg2i5K5XpuArtpdwZNGBYzOxQmQ+AUAgSbff83
         PgpgWOcn0tkO/XArH1wMjOaeGOAgMCG2bgCmF/cuiMXuy91bdnZFuNiGe5VZ/M5gzrnA
         Nptvd4baSjd86rIHuNFy2KhCrZAib6BERGBsZuALxGx8rJ5NRI9sFtO5iubNR4Uqac9o
         v/UtQFmeCXtdfoqY03oBj7hGJMzt0TYj0VGYvZ2sqyer+k2UL2PHMTuknYa/n8OJ6rod
         TZQA==
X-Gm-Message-State: AOAM532u7YFErYeC7Tcyxee8VtGZCRDU7kmc0l2b5WTft0/K/z2zUrPL
        JfVGT1ZldNFtBSgykGnxvkI=
X-Google-Smtp-Source: ABdhPJyzYgY1jfsqLHHKoqODom6GGjiHxc6KfYG2FhYI+2uw2qr8gsgzEWBNtBeLxLJWHVmzoypJeg==
X-Received: by 2002:a17:903:2302:b0:163:806b:b4a0 with SMTP id d2-20020a170903230200b00163806bb4a0mr2100478plh.160.1653576645164;
        Thu, 26 May 2022 07:50:45 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:44 -0700 (PDT)
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
Subject: [PATCH v5 05/10] Makefile: remove duplicate and unwanted files in FOUND_SOURCE_FILES
Date:   Thu, 26 May 2022 22:50:30 +0800
Message-Id: <20220526145035.18958-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We get source files saved in "$(FOUND_SOURCE_FILES)" by running the
command "git ls-files" or the command "find". We tried to have the
both commands return the same list of files, but apparently the "find"
command will return more files, such as the generated headers. We can
filter out these generated headers to get closer results.

In addition to this, "$(FOUND_SOURCE_FILES)" may contain duplicate
files. E.g. "git-ls-files" may have duplicate entries for the same file
in different staging areas if there are unresolved conflicts in the
working tree. For this case, we can reduce duplicate entries by passing
the option "--deduplicate" to git-ls-files.

Junio reported that when running "make" in a working tree with
unresolved conflicts, "make" may report warnings like below:

    Makefile:xxxx: target '.build/pot/po/FOO.c.po' given more than once
                   in the same rule

The duplicate targets are introduced by the following pattern rule we
added in the preceding commit for incremental build of "po/git.pot".

    $(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %

Although we have resolved this issue by sorting to create a unique
$(LOCALIZED_C), other targets may benefit from this. Such as: tags,
cscope.out, etc.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 72a3ddaed4..0cc397d214 100644
--- a/Makefile
+++ b/Makefile
@@ -845,7 +845,7 @@ generated-hdrs: $(GENERATED_H)
 ## Exhaustive lists of our source files, either dynamically generated,
 ## or hardcoded.
 SOURCES_CMD = ( \
-	git ls-files \
+	git ls-files --deduplicate \
 		'*.[hcS]' \
 		'*.sh' \
 		':!*[tp][0-9][0-9][0-9][0-9]*' \
@@ -862,7 +862,7 @@ SOURCES_CMD = ( \
 		-o \( -name '*.sh' -type f -print \) \
 		| sed -e 's|^\./||' \
 	)
-FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
+FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
 
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
-- 
2.36.0.1.g15c4090757

