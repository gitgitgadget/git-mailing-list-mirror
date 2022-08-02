Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A03C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiHBPq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiHBPqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A997E03
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c22so7413698wmr.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GN2s/F8Sm3KSVqeCD8Pg2q5VbVB1sDorMcenpqOct6k=;
        b=oosb+nEHjz/uMtW06rRdynSCeQdpDxeVAM5BbEDLhMwZYmTJb8z/SC/EitSagU13gf
         6HmLnlYoNUpvS/2QsB/ty/3Cnsx56KQQHXDpN/O1vDuiKS+5QSY/PidYibC70c3lVFXY
         NSPEK0oC27wzkg7ijDrQ9/dER9V0weAESHQWynALUqCH4j+4lz5w6VBhAcuVk/62yKop
         u2HtDQWsNpKtY61QHx1sNJe8nDqUMenRho3yEPpLnWtsJyn5wp+bNwn5fGnhlQtqYbzz
         PhTmn/kDp2YhRh1uamQKTFFsgur1YfJk0IU/mjJC7CeZf9qcNJXmlHOLAOZwbK0Z9W3t
         WxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GN2s/F8Sm3KSVqeCD8Pg2q5VbVB1sDorMcenpqOct6k=;
        b=vQLeWAYhd+9VfjAbrmCaPQUvdFtpIoBjCm45Ae9oiJkFxUSMSKyA4JlZkCbCHfALx2
         cGOG4O1VgnGGXbwmJw0R4vJbXvq24C87Lml7pQIUk0jkA0iJRSohgg9BEzAb6JiBqAM/
         6pLfskUJZL8yAgXPQSi5QnEx4bD+qLbj7n9c6hiv2JaFcRUiZXx8OlV3Ebkm3pnpHaob
         UzVI68EQkYfHGE8SoHKcLPwIP1HhJRCM532KKtM76ekvMZNrW4iA0RaGVRanJata3Sk7
         3Du8iGQ2tjosDXi59vc63sfPy5U4MzK25v20Ynr0qFOQ0W8iX/JcRVu7VwIO5YavZUOp
         yzsA==
X-Gm-Message-State: ACgBeo2uiU30QARdXGr45zgUuaLAepe0TGCycYbnTkt8YiQqsgCSeZJz
        b9UCXQVZsccxcrqUCDn9d8aWic/rl4/2TQ==
X-Google-Smtp-Source: AA6agR6+oXSSN5+Zw0JD9E9erpKadFGjdfmIwFsnJmBSjC0bNVDQ51PV6TUvXmTy45wZ961u8HZEbQ==
X-Received: by 2002:a05:600c:19c9:b0:3a3:469f:c1e7 with SMTP id u9-20020a05600c19c900b003a3469fc1e7mr43884wmq.141.1659455181832;
        Tue, 02 Aug 2022 08:46:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/28] test-tool submodule-config: remove unused "--url" handling
Date:   Tue,  2 Aug 2022 17:45:49 +0200
Message-Id: <patch-v2-05.28-43902201701-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No test has used this "--url" parameter since the test code that made
use of it was removed in 32bc548329d (submodule-config: remove support
for overlaying repository config, 2017-08-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-submodule-config.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index e2692746dfd..22a41c40926 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -15,14 +15,11 @@ int cmd__submodule_config(int argc, const char **argv)
 {
 	const char **arg = argv;
 	int my_argc = argc;
-	int output_url = 0;
 	int lookup_name = 0;
 
 	arg++;
 	my_argc--;
 	while (arg[0] && starts_with(arg[0], "--")) {
-		if (!strcmp(arg[0], "--url"))
-			output_url = 1;
 		if (!strcmp(arg[0], "--name"))
 			lookup_name = 1;
 		arg++;
@@ -57,12 +54,8 @@ int cmd__submodule_config(int argc, const char **argv)
 		if (!submodule)
 			die_usage(argc, argv, "Submodule not found.");
 
-		if (output_url)
-			printf("Submodule url: '%s' for path '%s'\n",
-					submodule->url, submodule->path);
-		else
-			printf("Submodule name: '%s' for path '%s'\n",
-					submodule->name, submodule->path);
+		printf("Submodule name: '%s' for path '%s'\n", submodule->name,
+		       submodule->path);
 
 		arg += 2;
 	}
-- 
2.37.1.1233.ge8b09efaedc

