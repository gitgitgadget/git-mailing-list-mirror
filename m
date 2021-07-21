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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6019C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A151B61249
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhGUWmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhGUWmm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:42:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC5CC061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d12so3831112wre.13
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyJK/Ak+cPx4/DM9mhewAqJMfKfZUJQOzuzofgyXbkI=;
        b=DbklSK4yFcPI0L0+2H8v+y7kJorbWGPDt5Y9AMdOp8AWQPlswv8x4EdKsgiYdM6/7L
         SOvfGpBM/M43Mk5nnPJZRa8V12PJCunD5vjjDKN/pJ2GypktX98b0DLRm5IwqekgzAdz
         4R3wvbQhB1XpKZBEUnpsOGIEwZldvYZv7CnbKW6Dws3vf0sbPEeZTYtbi1+9J3oVxIpx
         hni381SC9br6GR7U7kCAxntCI7RmhAIILo7bIVKO38myDE4j4W9QC+MWRXztiQZraAtF
         k5B/Sr4Q/lhQeg2m62UAYAtQ9ACjcYdbkRzA0RnmwFIK/2YqT0UtgKC7h3I9vLp4Hjar
         KLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyJK/Ak+cPx4/DM9mhewAqJMfKfZUJQOzuzofgyXbkI=;
        b=FAdhAyqK6DM6TnkZGTb9wtTtJ7fxRXZ4RYo0exCDrHH8uPDnNEZvpBsAzI4Ml7N7j5
         kYtNCN4/Gp8+JIcUdYBgY/c8HlMr7LgLVk2ilsHwBqv5kuQBaYyl11BE3WlNEa+KC7us
         wVD/l83cp9UVhOTsGCuwdWtiWEk1Dyk9r3ggKZl1Mpak3ZnG4tz/C2QntVMeGcdeeO/n
         1A2GDDnHDb+eVoUmQZmo7cjb6YLIsbEjgsRPWep4QW+PSNZcsR69a6gbmS7iWmQi2f4G
         kzVCZi4P39M8UfizlbH++6ESpNXejCOwX7mr53CEvIbkKTnqOTypp/JrP0XGblKA/Y5S
         nZXw==
X-Gm-Message-State: AOAM531nmFHyhI/xAmmjMnqa2bD2bSn9RR5SfQSDQ7A2Jl9PJNRfyFdf
        7GRccrpzgCbpMoPQJViyggOABASJZxA+QQ==
X-Google-Smtp-Source: ABdhPJwhalCZNHBjGcgLmMTm9sglc9Nglk5fB3yYl59nUazNlGbX0Q97NslXaUs7J9vA2RkcH/ffhQ==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr20626483wrw.266.1626909795631;
        Wed, 21 Jul 2021 16:23:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v11sm27690260wrs.4.2021.07.21.16.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:23:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] Makefile: normalize clobbering & xargs for tags targets
Date:   Thu, 22 Jul 2021 01:23:06 +0200
Message-Id: <patch-5.5-f3ff76d0e98-20210721T231900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com> <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "tags", "TAGS" and "cscope.out" targets rely on piping into
xargs with an "echo <list> | xargs" pattern, we need to make sure
we're in an append mode.

Unlike my recent change to make use of ".DELETE_ON_ERROR" in
7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
2021-06-29), we really do need the "rm $@+" at the beginning (note,
not "rm $@").

This is because the xargs command may decide to invoke the program
multiple times. We need to make sure we've got a union of its results
at the end.

For "ctags" and "etags" we used the "-a" flag for this, for cscope
that behavior is the default. Its "-u" flag disables its equivalent of
an implicit "-a" flag.

Let's also consistently use the $@ and $@+ names instead of needlessly
hardcoding or referring to more verbose names in the "tags" and "TAGS"
rules.

These targets could perhaps be improved in the future by factoring
this "echo <list> | xargs" pattern so that we make intermediate tags
files for each source file, and then assemble them into one "tags"
file at the end.

The etags manual page suggests that doing that (or perhaps just
--update) might be counter-productive, in any case, the tag building
is fast enough for me, so I'm leaving that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 730ff23b923..295ac359cea 100644
--- a/Makefile
+++ b/Makefile
@@ -2742,18 +2742,19 @@ FIND_SOURCE_FILES = ( \
 FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
 
 $(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
-	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
-	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
+	$(QUIET_GEN)$(RM) $@+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o $@+ && \
+	mv $@+ $@
 
 tags: $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) tags+ && \
-	echo $(FOUND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
-	mv tags+ tags
+	$(QUIET_GEN)$(RM) $@+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs ctags -a -o $@+ && \
+	mv $@+ $@
 
 cscope.out: $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) cscope.out && \
-	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
+	$(QUIET_GEN)$(RM) $@+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@+ -b && \
+	mv $@+ $@
 
 .PHONY: cscope
 cscope: cscope.out
-- 
2.32.0.955.ge7c5360f7e7

