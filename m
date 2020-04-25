Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530FC55185
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 06:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0AA2071E
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 06:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm4mfWhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgDYGPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYGPg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 02:15:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB2C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 23:15:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so5888223pfn.11
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/hKXA2RMMgGzzGIMZ4ugwTdKzxmOfXWjZLTFmXeaZc=;
        b=Sm4mfWhL8VTjVO/4kh8tx4c1EpEspYq0S5+qGEe3hBEL36sBVJ9tbd0BKB4VZYUMuo
         5UhXUjClEg2o8/IY2bwCfTBr87lWi6T7jT69rZQFtLXzzbGvEYTPlTRoJrmPs8qPcr21
         Ldcs6W4lmD3MHCXgAVqG5TQGoTTycaMoLAjOXO+CTqJqIe5TY0SfE6kCY/1kD0gak7dG
         MCDb7Lw41rwnfyepxG1/6ya4oH2MCdKVetdcnn61AtfTt+ctZesKx1a18WeXPVQsac9j
         2LUIeTIOfVPYAtWACoseG52skMMTnGjIQbDKXMtd4YLq228gdfXYVLd7nhDJq6jqvh3A
         IiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/hKXA2RMMgGzzGIMZ4ugwTdKzxmOfXWjZLTFmXeaZc=;
        b=dT0ski2ajud1LxsCBN64292IVG2PVE0im2ExBHBt7IkAJ68y1qstD57Ul6bgQybf1W
         LLDTE1khFGCShSyJoJ6HIv2t3aPCYK2awHs3s2HMflDpv/TiUAOo2pVK1NpzISuQnOOf
         Y0aq9MDsiVUo7fhWOxmq3XHDfv3BHE2PCMxzHkRJjjevQijGlH9RroQ2eyt+Y+v5ljQX
         4oxEC7PukDwVtZAf/pwPZXEDaNzDX2CJkSuV+sVQ+TFMZuNoz4Wx0+gZ+WdF78q+VM54
         ajWS8I8LLaQcgFvAfPCVMbLVABu2a/e2XGr3O3RfhYkmJwWJOcEP4tx5OFTi0/3M7CaP
         cnig==
X-Gm-Message-State: AGi0PuZOoLn4My5MxmSj7nFjYeJ86TKUQvkAzDGwDjUK4PIpGPstMQlH
        CYNbbhfee7lVgAQ+KB5NkKBFYAsR
X-Google-Smtp-Source: APiQypLtPfDljAAH/8yR7rqlfnmIaMXpsGPJEOYfcYg5m5BXqkbo6MaSkQkN5/LeT73TNbfClfnSww==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr11424834pgo.301.1587795334340;
        Fri, 24 Apr 2020 23:15:34 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y184sm7363250pfg.127.2020.04.24.23.15.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 23:15:33 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] macos: do not assume brew and gettext are always available/wanted
Date:   Fri, 24 Apr 2020 23:15:31 -0700
Message-Id: <20200425061531.12845-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

since 27a7067308 (macos: do let the build find the gettext
headers/libraries/msgfmt, 2020-04-23) a build with `make NO_GETTEXT=1`
will throw warnings like :

    LINK git
ld: warning: directory not found for option '-L/usr/local/opt/gettext/lib'

localize the change together with all the other package specific tweaks
and make sure it only applies when both gettext was needed and brew was
the provider.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile         | 9 +++++++++
 config.mak.uname | 7 ++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9804a0758b..031a231ad6 100644
--- a/Makefile
+++ b/Makefile
@@ -1303,6 +1303,15 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	ifndef NO_GETTEXT
+		ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
+			BASIC_CFLAGS += -I/usr/local/opt/gettext/include
+			BASIC_LDFLAGS += -L/usr/local/opt/gettext/lib
+			ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
+				MSGFMT = /usr/local/opt/gettext/bin/msgfmt
+			endif
+		endif
+	endif
 	ifndef NO_APPLE_COMMON_CRYPTO
 		NO_OPENSSL = YesPlease
 		APPLE_COMMON_CRYPTO = YesPlease
diff --git a/config.mak.uname b/config.mak.uname
index 540d124d2e..0ab8e00938 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -133,11 +133,8 @@ ifeq ($(uname_S),Darwin)
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
-	BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
-	BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
-	ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
-		MSGFMT = /usr/local/opt/gettext/bin/msgfmt
-	endif
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease

base-commit: 27a706730868835ec02a21a9ac4c4fcb3e05d330
-- 
2.26.2.569.g1d74ac4d14

