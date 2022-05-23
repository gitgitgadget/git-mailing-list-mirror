Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA00C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351676AbiEWBZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349587AbiEWBZl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7E38782
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x12so12382115pgj.7
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoFSxQU0lgUFQRzHSqn4Jx/qMtxlc0j2Qw+xrcMw1hE=;
        b=kDgVl8xiHEHQ0oW8crAoqmYVKlSJun9IMMA0BD+VwXkcOoJUB579mYaGjiOQpDFSJH
         cGRcj2SN4eKGmqOgjEWOEbAclbKgiXBMFG+wLsu4EUtm4/uQwnqTSARmLHKCOME8FOSC
         YNANlW4LMLzRZs02aVRv9Xo5ufHZHGeUbhJnm6+311CurR8jSgDlpl8tpRhobNg5n4SV
         kGycThuRrAq9fyUSwz4HcaBHco1n2tJw8iZl90aLcJNBBchzA9fi3BmL6y7cDxMvMR8W
         VjHbUapvpgKwfmDClHnmRD8VbyhUrOa/GXpXlclrtpCXawB9bCL6pXiY5Ynzq19BrYa2
         mbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoFSxQU0lgUFQRzHSqn4Jx/qMtxlc0j2Qw+xrcMw1hE=;
        b=gHtM4b+E65prXVIKCR1wXk6YgXawdYVk1CBjSK2fEERXev7fPfGEK7R6CazNjZoYed
         aLEvO1XudBqHHBQMifBsGs+X06P9YddDoALntRBxJw2r/mRgahxYSDc1bN75dxcpB4mx
         uBWKc6r6Q981X305jmZriVFXMPUX5nj6oipaRhMkzLtOjFo+Z4BGmGtWYFoNSw7iG/dw
         x4mNd900CZAyeOnyYPvvBNh3FUHUtCqFbKdV5p9WwnaJFyFi72kNKnFkJzkdoD7hNXgr
         d1MqxutdBssthkxST4Dr/Cb6DVQ4uPgtoxbWJfR7PiLF22ZDQ71XZkPXgAVe/cUUjNY1
         qLRg==
X-Gm-Message-State: AOAM5322arpwWy0GOE+JjXzBLTei7K/hj0KNU06W7L22l5ypaJJfZMVf
        7jkENqyjsL3VsEe8+TkRVH4=
X-Google-Smtp-Source: ABdhPJwaAvM5ey2q00U2rZtUd2MhhG28FYFQE7LeGrNFApipcHhjFLg3bRpLDnQt2EqJhhKLUB/ycA==
X-Received: by 2002:a05:6a00:170c:b0:510:865f:bf34 with SMTP id h12-20020a056a00170c00b00510865fbf34mr21595323pfc.60.1653269140177;
        Sun, 22 May 2022 18:25:40 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:39 -0700 (PDT)
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
Subject: [PATCH v3 2/9] Makefile: generate "po/git.pot" from stable LOCALIZED_C
Date:   Mon, 23 May 2022 09:25:24 +0800
Message-Id: <20220523012531.4505-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220519081548.3380-1-worldhello.net@gmail.com>
References: <20220519081548.3380-1-worldhello.net@gmail.com>
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
"$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C". We also add
"$(SCALAR_SOURCES)" files, which are part of C_OBJ but not included in
"$(FOUND_C_SOURCES)" because they are in the "contrib/" directory.

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

