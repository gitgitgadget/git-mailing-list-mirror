Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED658C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 11:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1149610A6
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 11:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbhHZLjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbhHZLjj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 07:39:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B38C0613CF
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 04:38:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m26so2541914pff.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cr6lroyXKW/STe/COYa/HwfoyoYCKxub6N2zgbSLfJo=;
        b=PGUKMvA26kAkkCJePAjYqknftoBdQNPcdRVsSGA26YJTMreSa1wKSyqCMkjz/07QiU
         8iP1tOG1k9hVWj+ej1h7UiYSLffuWrAHynRpoONGvv5mr7OYcJo6vjkbtcFWGxve9oEL
         I45oOeIzfOnk5vOt+aVsi99D2OJeuZfNLmEm3jttEIhHtMfZ0QzlnQZKZiXS15ANN994
         ezlt+esB+hVOJOFfkJIdi5lYd/g1jGNAYsNQRiinWUPt9tuz0StVvW2QLzYWvLOB9Ats
         YzzyzK+5KrbgCG4rCiqIySn9PdTyiMDuh0g6et6T+H8dbQfjk7RGd1jdwXdEBmhbkZNF
         5Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cr6lroyXKW/STe/COYa/HwfoyoYCKxub6N2zgbSLfJo=;
        b=gKxr4aXt4KI/I+Oms3sOe3u+BXjwrCsWrQsInxyGb2eSE4dEnyhoPFJ4RopMqLBYQw
         S7i4LIGWpEyLUdul1PopRA5kxKjNXUfAgQdlT+Wz70EjNbti1aoszy+q0wSunRc42/Tt
         smAgVw5qbKK8pBiXPiQA/lmfnbLdgIfOryFTRttHIQuPfG8TDLXLmtS1CU8gkiz5MBG+
         NLA8wlHBQg9ZR8k2H1eGfXCpvscafPZN/eNb/yXbLm3qQd+tXVERotVwm0buKsSri6PE
         3Lx/ThBUp12zw+0jy/+Q3HrOGiMymSdWR1WV5D7YCeGh9T6VwY9Q93AVo5WZj4c4cPDC
         HbAg==
X-Gm-Message-State: AOAM531uP2KDx2vzNmeFtz22Nt5vqxgj0DawyhoCmxLqnl0CgBtEqu72
        yA5nBoHfOItToMT088U5i+kK1TY6R290tA==
X-Google-Smtp-Source: ABdhPJxwYqtUBT/5wozghvaoxKC2mLCSfzBkTRWHWPaK4uDIXM/h+gmUnI4I8OPd+TiRBEjLqBIPLQ==
X-Received: by 2002:a63:d057:: with SMTP id s23mr2953977pgi.431.1629977931948;
        Thu, 26 Aug 2021 04:38:51 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id gm5sm2414717pjb.32.2021.08.26.04.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 04:38:51 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, felipe.contreras@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] make: delete strip target
Date:   Thu, 26 Aug 2021 18:38:24 +0700
Message-Id: <20210826113824.50078-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826113824.50078-1-bagasdotme@gmail.com>
References: <20210826113824.50078-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The target isn't needed anymore since stripping is done in install-strip
target (in previous patch).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index b8a3a64422..027b052a0c 100644
--- a/Makefile
+++ b/Makefile
@@ -2170,8 +2170,6 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
-strip: $(PROGRAMS) git$X
-	$(STRIP) $(STRIP_OPTS) $^
 
 ### Flags affecting all rules
 
-- 
2.25.1

