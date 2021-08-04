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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E2C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371086104F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhHDWzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhHDWzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:55:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8BDC061799
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:54:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m12so3924100wru.12
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2x/ZjLflp6HNp75sXkUj9vz4JZF72p6+NeE5fq5cLQ=;
        b=JSX+I5qd+QGVUxIm6A0F47c3FrcMDu+ECougI038PkezSnpWyt+2uU3MmPyM9mkfOv
         TcdOgidfD4+yGEBE1alROOi4I2nyVmp5D07wUQ7Z2CZAU+ZGM8gkTVJJrh8VDRPtRTUu
         BqqQavwtiRbHQVXSeszC0N6vEzmNqwwOP+3vthnUiqR9XJL+cfoE2d/J7lzjfh7YXE+B
         4W3W1qfzXpvOuQVoNXOOYhgPEovZpQIDh6jJTfm8GDylqPpz5iGrbg2/r3ZvE+/+4EkJ
         9mWu73KJas5fNW8Ld3BGjOxGpZkQGBbAGfsoO1kWoyuMIkLKK23Ku1M0Upg8GNBPc+NM
         obJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2x/ZjLflp6HNp75sXkUj9vz4JZF72p6+NeE5fq5cLQ=;
        b=PGOoQ6Vithh1BMLu/fClWnz2PAVi4NxhhgDDJgl58klmveyWByDVGcEyDZ3TgfrDyi
         /8FzldgZqvVEVBuAAeHCxIB2Tj+bSNxOmMmQ9B14jQimCPdLka1/DziaaZFNcvwh/2Ov
         zYMmfHcYUcyxCF6PmEy4ex4257s7ZIsn8cf02buNqQoyJko10xKsDSoCO+JDNcwGosYg
         clbPWsDhejCh7iD5ZDobsy9lGnhe5Jeb2SWkuIWWzYJAnAVVEBLqESsvXkA4w4iwM9d7
         yDlx2ZlLjVM5HQNxdO0G97j0/EFfs9jtTxj44s1RHQDh+BE7po8cRtZ1yeK9qXjaN/3k
         uxVg==
X-Gm-Message-State: AOAM533r7usJjR21HX1IeKF/3BM3kXda72SNhXwZWtfmXSrrtq+m5cou
        GILp6gKCI+P++Hec9aSeyus0B14N734KPQ==
X-Google-Smtp-Source: ABdhPJyQzRznCdP4R9ZdTJnTaLNCjkEnB7pGeujZUNl9uebeCd0SsLv1f1ORtUbOvkFmWv1vsuKGEw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr1647433wrr.105.1628117687310;
        Wed, 04 Aug 2021 15:54:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u11sm3968190wrt.89.2021.08.04.15.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:54:46 -0700 (PDT)
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
Subject: [PATCH v4 5/5] Makefile: normalize clobbering & xargs for tags targets
Date:   Thu,  5 Aug 2021 00:54:40 +0200
Message-Id: <patch-v4-5.5-1eaf3416329-20210804T225222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
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
index 2a176ba5742..1ad7a685d10 100644
--- a/Makefile
+++ b/Makefile
@@ -2749,18 +2749,19 @@ FIND_SOURCE_FILES = ( \
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
-	$(QUIET_GEN)$(RM) $@ && \
-	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
+	$(QUIET_GEN)$(RM) $@+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@+ -b && \
+	mv $@+ $@
 
 .PHONY: cscope
 cscope: cscope.out
-- 
2.33.0.rc0.597.gc569a812f0a

