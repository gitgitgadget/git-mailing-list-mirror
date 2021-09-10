Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF7C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEAB611BD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhIJLFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhIJLFv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867CDC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so839527wmh.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hEbeovRWl39OfC1lzchLvWv9UNpMHWZQ2dp3jGwPf8=;
        b=RDq3+ne2JUr6ERx4azeyLtC58xNGIIaWBsNq/9F6SnTDz1F1K7C7wzn7Yla0kxRId5
         Ds7xWaRelGZvyFopAbevqTo4qgJQ4Y9oFsULp+5G/cqo4R45XtLiq5UkkPmsp6yEzDL9
         YHJMdksxVwdtkUSroaS1MARi/va2FyuCs6YD9IPmUiCB6DYHKBm4gyppxSAfxjsSX6Eg
         s5/Ldnot9axw1dkkFQO49/bkFktafzHRv25YJY+JTiQ4bQwImanMv1HOB41mbLdJn519
         peltR8DVcgPPvcCXSnRmopTPT8D75pVYe/g86sfFaStWq1VBr5BBB/EAAtmIef6ZdMXc
         HQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hEbeovRWl39OfC1lzchLvWv9UNpMHWZQ2dp3jGwPf8=;
        b=74twVRCWlJU4X6soCvgfxpGaLuKyjyJk3X3EHlJ2SnGSeR1vas4SpfWip4efPBjEQz
         d5N2sHERJqHgjWkCAND2g7m+fxz+i4I1xoSUpkiYI+5iztogJnk2VSiMXRWmpFZCikah
         dAa9PP/FVblS4ZIpKBBJ1DSO+KqmaADMCG1lOz43CHvjr59TTcq2JBJocqOeWM4JBLZV
         KLyQfBA+6txEeXNIcxAKI7WF7vKeSHGQvfFFTo1ePGfGNRe9kHuJDCcAWo+E5v82vvC/
         PLjWQq9H7mbjFLBQW0r3imUIiDJbTaLD1QAj5RokCp4TiACxUFtKhytFcMdZV9ekbO9Q
         tTyA==
X-Gm-Message-State: AOAM532ahHZYjGcAeA4wntFUBSYfx3Y71EFuI6dAfPE8ZbyJROPJtwJG
        0tWJQKgxMk6bEIze1SdhUwF2vOMuxufkpA==
X-Google-Smtp-Source: ABdhPJzeoFtjK9+YMBXZ+g3uaePy9PKFwa8FlIR1mPN8+WBGhtd2ED09QEMheodQ7enAk3Nmbph6+Q==
X-Received: by 2002:a1c:46:: with SMTP id 67mr7641044wma.29.1631271878790;
        Fri, 10 Sep 2021 04:04:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] Makefile: drop support for curl < 7.9.8 (again)
Date:   Fri, 10 Sep 2021 13:04:28 +0200
Message-Id: <patch-v2-3.8-76c2aa6e78d-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1119a15b5c8 (http: drop support for curl < 7.11.1, 2021-07-30)
support for curl versions older than 7.11.1 was removed, and we
currently require at least version 7.19.4, see 644de29e220 (http: drop
support for curl < 7.19.4, 2021-07-30).

In those changes this Makefile-specific check added in
0890098780f (Decide whether to build http-push in the Makefile,
2005-11-18) was missed, now that we're never going to use such an
ancient curl version we don't need to check that we have at least
7.9.8 here. I have no idea what in http-push.c broke on versions older
than that.

This does not impact "NO_CURL" setups, as this is in the "else" branch
after that check.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 429c276058d..378f58b950d 100644
--- a/Makefile
+++ b/Makefile
@@ -1436,15 +1436,8 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "070908"
-		ifndef NO_EXPAT
-			PROGRAM_OBJS += http-push.o
-		else
-			EXCLUDED_PROGRAMS += git-http-push
-		endif
-	else
-		EXCLUDED_PROGRAMS += git-http-push
+	ifndef NO_EXPAT
+		PROGRAM_OBJS += http-push.o
 	endif
 	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "072200"
-- 
2.33.0.873.g125ff7b9940

