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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F3C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A69E6190A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC2QeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhC2Qb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:31:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF88C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:31:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b9so13471412wrt.8
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJJJnW3236iXJ0q65RjPclqblo37dyZ/mlcnzsAct/w=;
        b=hwJhK3NDkZwWVtfm6wqgQHkdKR/ZoKrOuRB72AM0svS0ffXfnBZzcwPZ2e8TWV1PAx
         Ze9Yf+/XoTlUjeYAYJgGzWXmPVZGeqpwUiJggZYbmx9rKT1aTZgr4MBTzEabSLoOHVaC
         dng+aG/VNyDTp5hHr4gEDNFFqHs8azVCi9YojYjK4/pbKfIPz4qzVM/1rmdu8BHgN4I6
         pC0ZEaL3Ti7hfIasAf92S/3EddKZF+ad4iq7VUvZirEZzG7GSe3lzD9LFZQH5va2Os0y
         B2/UgWNkqU7h0abCoW6R1Whrjih7Lb+QwkjPyp3G3La1NJIxFnrGmH7O1992Mid9nHdk
         29KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJJJnW3236iXJ0q65RjPclqblo37dyZ/mlcnzsAct/w=;
        b=SniiK8sFHnEFYjhGg7pPbzOdGSgpumYgEh+nQXa1bronhzB+FD3pP2nUM36+pb3350
         6Jpb/vcPy2oQyzsJN812oWY4ZwbntRbWjahTSibPwJy5SalsmGKOkcnFzYGoeGD4TOWN
         rzRx+t+3s1kIHubhDR/SdeSET27B3caiaTuVlOvtKCLy5H76nTZylQlv4Bq4UAq1OIp2
         S2zprtbhZK7zOB2xoBlLyLi5RjIxJNP+HwPVtXi+eEuzNeOfmDLGuNHRiCQY2p9mn5Ar
         XOmB8ndGNs0+BOGfSve8/3rN9yPH4vS7xMLdwSqxzc/OLvzoJDjyUSYS4v8Yll7OtPRr
         RcuQ==
X-Gm-Message-State: AOAM530GvqhKjHIrxyX3htDJwAmlC5L1CH8dCqDK15YRlbHHzP2v8c0H
        DFDznSS+LfTqvq2N6H0atiDpql6YXurB4w==
X-Google-Smtp-Source: ABdhPJwyDbG8AKlyeZW/YFGBjdZ6XVzeRJydedxdwU9MDIkmFcd0C9KkkdSan8haUr/mEN9FvjPECQ==
X-Received: by 2002:a5d:468e:: with SMTP id u14mr29931470wrq.359.1617035517684;
        Mon, 29 Mar 2021 09:31:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm25410464wmg.41.2021.03.29.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:31:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] Makefile: begin refactoring out "ln || ln -s || cp" pattern
Date:   Mon, 29 Mar 2021 18:31:40 +0200
Message-Id: <patch-2.7-5f59121dd0f-20210329T162327Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com> <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Begin refactoring out the "ln || ln -s || cp" pattern in the Makefile
into a script. For now this is trivial, but in subsequent commits
it'll simplify things a lot.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile    | 8 ++------
 ln-or-cp.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)
 create mode 100755 ln-or-cp.sh

diff --git a/Makefile b/Makefile
index 1e59d90a8d2..cfc87d7734d 100644
--- a/Makefile
+++ b/Makefile
@@ -2199,9 +2199,7 @@ version.sp version.s version.o: EXTRA_CPPFLAGS = \
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
-	ln $< $@ 2>/dev/null || \
-	ln -s $< $@ 2>/dev/null || \
-	cp $< $@
+	./ln-or-cp.sh $< $@
 
 config-list.h: generate-configlist.sh
 
@@ -2552,9 +2550,7 @@ git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
-	ln $< $@ 2>/dev/null || \
-	ln -s $< $@ 2>/dev/null || \
-	cp $< $@
+	./ln-or-cp.sh $< $@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) \
diff --git a/ln-or-cp.sh b/ln-or-cp.sh
new file mode 100755
index 00000000000..de79cd85a81
--- /dev/null
+++ b/ln-or-cp.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+target="$1"
+link="$2"
+
+ln "$target" "$link" 2>/dev/null ||
+ln -s "$target" "$link" 2>/dev/null ||
+cp "$target" "$link"
-- 
2.31.1.461.gd47399f6574

