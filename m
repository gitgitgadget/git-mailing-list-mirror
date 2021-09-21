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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98582C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820B661166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhIUW4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhIUW4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:56:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E558C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u18so1243060wrg.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClVH6jyIz4znZ8C2R+oY3i7esDwi5lA9JXl+OebTy1g=;
        b=RmE8B5naRqVSCFgGYzCQ/ytgmt6qtRp+FpPkjpco53RX0qz1hOF4++iUiwpAPMlJdu
         d16kMcjegUrU1bYOZRZwHAiHnVgorvAs8gyeq3b9h9xJo/72cYG9jiNcjXeW0hOezf2j
         pqbYoPLc7dNPsQqd1tussbh4S0xoXqrTvxFlONZk2heIa7yLlcxQiWN4uQTv/zr8Ws6T
         7ZxsP/5Wa+3JmYN9WTknbslryRaVGvS6aNByclwcTH7racXxqeQNr/1rfQ/VomgvRYsM
         xChAnuzwu96s8yk0oBSXQm6avB15evaKO9G+FwlXAe8Zbnoi+6NLHXL8CFaFE0A1VL+L
         RNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClVH6jyIz4znZ8C2R+oY3i7esDwi5lA9JXl+OebTy1g=;
        b=vMR7eD8ueN4KbbWvkkspJdCEDhknKpZUd1are6/jizdFMhuGwdX4IrKOEA2OyI82+y
         4Xbm4bWT6wLWF38r7jutYNxwDguL44Pq6fzhHaDm6VZ7mRq7OiilCxGEBZwsZz/yeiAE
         kyZIU8ywl82TPf15dy5vpTP2drfxeS0cHl1ZW1Yj8dGZAV4oBQtRfSWsM20vP2pDT4U2
         k8L527ZRROON1HXEVDJa/ZU+DqWNYLltoCkeZAFlKcG5vaCG2jGVU9ki03ahLwFe2mD6
         DRe3cRwJtvxCWPFH8Qci26owF2RwTf4sP5BRnivgJ0RH0hwvuDONGod7R9LC6oHwQWGV
         imxg==
X-Gm-Message-State: AOAM530b/Uz46MKwdLtBdaOTAtmtRVqWMJth+xczgGU8iDtJVtIcs8jm
        pjbmbrwLfb5WizDxn4e31bvoeCjjnoBa5g==
X-Google-Smtp-Source: ABdhPJxsYL9RXqriktebXCMTCPRJgRdWINvCx6k73smXaGGziShNojzyoejntxDnUbgeUsgG6hRonw==
X-Received: by 2002:a5d:58c9:: with SMTP id o9mr38647246wrf.279.1632264918840;
        Tue, 21 Sep 2021 15:55:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s3sm399474wra.72.2021.09.21.15.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:55:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] Makefile: make the "sparse" target non-.PHONY
Date:   Wed, 22 Sep 2021 00:55:13 +0200
Message-Id: <patch-1.3-e03fde1b642-20210921T224944Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "sparse" target and its *.sp dependencies to be
non-.PHONY. It's now viable to run it as part of a normal compilation
target, as we'll only re-generate these checks if the source *.c file
has changed.

On my box with -j8 it was fast before, or around 5 seconds, now it
only takes that long the first time, and the common case is <100ms, or
however long it takes GNU make to stat the *.sp file and see that all
the corresponding *.c files are older.

See 0bcd9ae85d7 (sparse: Fix errors due to missing target-specific
variables, 2011-04-21) for the modern implementation of the sparse
target being changed here.

It is critical that we use -Wsparse-error here, otherwise the error
would only show up once, but we'd successfully create the empty *.sp
file, and running a second time wouldn't show the error. I'm therefore
not putting it into SPARSE_FLAGS or SP_EXTRA_FLAGS, it's not optional,
the Makefile logic won't behave properly without it.

Appending to $@ without a move is OK here because we're using the
.DELETE_ON_ERROR Makefile feature. See 7b76d6bf221 (Makefile: add and
use the ".DELETE_ON_ERROR" flag, 2021-06-29). GNU make ensures that on
error this file will be removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore | 1 +
 Makefile   | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 311841f9bed..b02250a50c4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -224,6 +224,7 @@
 *.lib
 *.res
 *.sln
+*.sp
 *.suo
 *.ncb
 *.vcproj
diff --git a/Makefile b/Makefile
index a9f9b689f0c..5b09f67aab0 100644
--- a/Makefile
+++ b/Makefile
@@ -2896,11 +2896,13 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
-$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
+$(SP_OBJ): %.sp: %.c GIT-CFLAGS
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
+		-Wsparse-error \
+		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
+	>$@
 
-.PHONY: sparse $(SP_OBJ)
+.PHONY: sparse
 sparse: $(SP_OBJ)
 
 EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
-- 
2.33.0.1098.gf02a64c1a2d

