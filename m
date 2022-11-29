Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C753C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 14:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiK2OJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiK2OJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 09:09:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393EA22B06
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vv4so34088727ejc.2
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q37YzqBkTLrE60NsBW6jIhh4Jau5xx2CLdYrci8Bbs=;
        b=A1Jmls0XB8H4jxldZrK9as38EgQJQ7dl2+YTeQgji1KRE2Cp7Ibo963qTz96NPuOGw
         Z+W8alOLzZBoVo9ml7GjWBoT7FvxBY2tCItA6YzUXO+5wIl93R9X8ocRiGuwqWxCyZ+G
         ThilddKI2AWWsluZIZIS6MJ7ynylac36O30Oprl3YVTaw9u4RISymQ+5CKz06g6xwNO0
         AgOLiejaJO9X0j77DhzUyHo+KSv/6PKxcXGLhfgMkw5JFlIMGDEY/zeYeMrHwBkeEhhy
         TDpbbYaQsyR1PyDexcbCqCYQ4/bF+NwVha14eaDj5WWoBcylY0/RBJKrT8I7inugMfcN
         2dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q37YzqBkTLrE60NsBW6jIhh4Jau5xx2CLdYrci8Bbs=;
        b=NxFcZiO+bIQ4AsQ5wD8Ot//M7Se/mww/5R8zC3Eh4BLX58cO6stt0QVOAnYzN+4i7O
         AJNJmEjgEbz5hx/p8CuXz8z14ehDO1s3qJzAgIKdx/VEZb0t7G3a7RHwd4cqDweT29Gq
         cUgXhhknlCzvrSWu+kvefnAvEj5aKcikL+cUmEUyJSLmHZ4MHU9Zd8jjUtZOiE8I/mQG
         82bU//Y52IippT1T03Xd08nWwhuDp8F+i4sci4A5pHhDUFnMGGO/2XjXrTM6pBgRwE4Y
         u5fCmFUEiTy9ozeKQkpW6p1+FWA97yYecPWgf//pbU2Ypj62pTxUkGJgiKiKQ/G6a/Pp
         3NYw==
X-Gm-Message-State: ANoB5pl1zljd6OYaGXnx6OnScGT8yWVQOFSSPzVfh8gFSWbKf/fpl+Fj
        zj4ABuDZqjb5hvNqIaDunwi3X/U6eYvg/A==
X-Google-Smtp-Source: AA0mqf55xj9JSrjLdrfAE0TYEmD84hqHekmEWQnzECBhtgvG8R3489nXu4EF9dqtkd3ajq7HzdagmQ==
X-Received: by 2002:a17:906:c042:b0:781:541:8f1d with SMTP id bm2-20020a170906c04200b0078105418f1dmr49038443ejb.117.1669730960390;
        Tue, 29 Nov 2022 06:09:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id be14-20020a0564021a2e00b00463597d2c25sm6307907edb.74.2022.11.29.06.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:09:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Smith <psmith@gnu.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] Documentation/Makefile: de-duplicate *.[157] dependency list
Date:   Tue, 29 Nov 2022 15:09:14 +0100
Message-Id: <patch-v2-1.4-42b4f241c97-20221129T140159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.993.g0c499e58e3b
In-Reply-To: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
References: <20221127224251.2508200-1-psmith@gnu.org> <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "DOC_MAN[157]" variables combined into a new "DOC_MANN" to
declare that e.g. "git-am.1" depends on "manpage-base-url.xsl"
etc. This change helps to make a subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5e1a7f655c2..d239f6751f0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -129,9 +129,13 @@ ARTICLES_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 HTML_FILTER ?= $(ARTICLES_HTML) $(OBSOLETE_HTML)
 DOC_HTML = $(MAN_HTML) $(filter $(HTML_FILTER),$(ARTICLES_HTML) $(OBSOLETE_HTML))
 
+DOC_MANN =
 DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER),$(MAN1_TXT)))
+DOC_MANN += $(DOC_MAN1)
 DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER),$(MAN5_TXT)))
+DOC_MANN += $(DOC_MAN5)
 DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER),$(MAN7_TXT)))
+DOC_MANN += $(DOC_MAN7)
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
@@ -351,7 +355,8 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
+$(DOC_MANN): manpage-base-url.xsl $(wildcard manpage*.xsl)
+%.1 %.5 %.7 : %.xml
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
-- 
2.39.0.rc0.993.g0c499e58e3b

