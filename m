Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BCDC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA466103D
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhIWKcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbhIWKcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30765C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so15779241wrg.5
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voaLg+G4Wd/QKPy+abvsS65WfNiyJIUOeGiqcJJ8CWQ=;
        b=Kw9DctdgbVqQ/14Ci+1Oj2UaZfeeMJt1j3ZZWeCogZ83UDVr+VM/pa7ywL2xeGdazD
         YA4ZcZfRS5g0pTcEXM57aizlgUXipLvyCOQtJ7oolf58WOuX41bo02mz110PJcWoiPBv
         EeXvs7KDI/VXzWj6d5hJFcDEgWBQqmg5HTGpyeSiZ5L+RV+9oZtNZIdcYbcfvGqqpLKe
         5VnOqBf6Npy5b2d6ivNLwWYpj/FTWXIx0brAO96SnJSZZHXBPrE6SP/dxdiBcV7FXUrY
         qzAkgHTJgqoYochXxBNHBlaBuDYrwor82PLnqVRgYvkW0NSI/cJxB8sAPRdVFMZhMQg+
         7drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voaLg+G4Wd/QKPy+abvsS65WfNiyJIUOeGiqcJJ8CWQ=;
        b=a1GTfnNpezkVm5XAuH1g9TQ2iyiVquzd82zbIlpcG3+a71Z5G/DpYryFC+XnsNWfm7
         IPTKBCAXPfBbjV9y3xkWhuy8cwjN+BzLLEY8kX42eQRAVGvzejKNmOesO2o4yF1wc/ru
         EPhrCnwPhkGBHq7DpxCxHJkqgpPB+GbEk0oPY4LJY/dr9lEQvExPpF08dlUVBmT7JDCg
         PP+y7ga2v+U91ZLqwvpt1PmwAymGGu8OHztjoIIaNCG7vkDX8R4VTrubonvqfVSC1P7I
         4bS8hWjfja/gA3eosDbukpckcT73WSGbXQqJqql3ZoVtDIe0XZiVvOZr8THTfuzktAlT
         TWWg==
X-Gm-Message-State: AOAM533Xf299tecu/LUMe/V987Rbw7IKIyHXtsU68XAznjACSwHGG1dj
        TEkmpYIsWTCw22bpYpJBwa5Nsjhio3ptjw==
X-Google-Smtp-Source: ABdhPJxsp1K5uwZwScIqnBeGVp2XSftKTDI6iO78d9JzTUxVSKJuQePpq69kkEWK20sbdqMPZkSkvw==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr4244694wrq.136.1632393072557;
        Thu, 23 Sep 2021 03:31:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
Date:   Thu, 23 Sep 2021 12:29:58 +0200
Message-Id: <patch-3.8-010701fd784-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "cmd.sh > $@+ && mv $@+ $@" pattern used for generating the
config-list.h and command-list.h to just "cmd.sh >$@". This was needed
as a guard to ensure that we don't have an empty file if the script
failed, but since 7b76d6bf221 (Makefile: add and use the
".DELETE_ON_ERROR" flag, 2021-06-29) GNU make ensures that doesn't
happen.

There's still a lot of other places in the Makefile where we
needlessly use this pattern, but I'm just changing these because I'm
about to add a new $(GENERATED_H) target, let's have them all look and
act the same way.

Even with ".DELETE_ON_ERROR" there is still a point to using the "mv
$@+ $@" pattern in some cases, e.g. to ensure that you have a working
binary during recompilation (see [1] for the start of a long
discussion about that), but that doesn't apply here. Nothing external
uses $(GENERATED_H) directly, it's only ever used in the context of
the Makefile's own dependency (re-)generation.

1. https://lore.kernel.org/git/8735t93h0u.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index eb5780264a4..c529f283dcc 100644
--- a/Makefile
+++ b/Makefile
@@ -2238,15 +2238,14 @@ $(BUILT_INS): git$X
 config-list.h: generate-configlist.sh
 
 config-list.h: Documentation/*config.txt Documentation/config/*.txt
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
-		>$@+ && mv $@+ $@
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh >$@
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
-		command-list.txt >$@+ && mv $@+ $@
+		command-list.txt >$@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-- 
2.33.0.1229.g0a86d28df49

