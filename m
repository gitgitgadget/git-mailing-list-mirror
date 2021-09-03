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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDBC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C66610E5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350190AbhICREG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350182AbhICREE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:04:04 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5399C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:03:04 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so7284343otf.6
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcdSY6dL3lcguado7ZMmNd4LNHqk85704pDd7oPojW0=;
        b=N6vd1ONeDMcSxbj/Qr9PwYRpoCr4sIEGNtedQq8WQJQ4fEc81P9Boga9gZzfDndPQ6
         od/MUpt7vvzI3vJvorWonAO6VClKAOOiYBI0vYjCbNoJYgMk2qafXFnb7iG3lB/jaY3G
         vEgIAAMDN4gS3QaGnWe+0zVKDXOSWPp1IZHS3WFFXlbLb71ZHsy0cT/rC1JmNYWKyTZ9
         ZXkElVLZrB+/ydfjzbH5wOe38wg+KhR5+NQKaO+1c72Nt2GG12U0/J2kT7y0WDcxYZYp
         1bW38in7ENQwMoKt/I3LxQqYMasK0o+1azm5o/vPgcSHSRjAbr7poIBknwF1A7nZ6QdP
         qkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcdSY6dL3lcguado7ZMmNd4LNHqk85704pDd7oPojW0=;
        b=b9/8cOYIS0WgsV6tOFLoiFO2sQNr1Hdbez28R7N7IA+32FNPuSiiCmkX9LS3QsItey
         TSXN1qTI2iKOeivC+/40WsxvnNlyCrq0/LTgICjgmjDy0rvrYEnfo6zDyWiVlkDAyXDO
         VFgwPr3c7GFmX/6YOdl2TqKO1sTjFvKpcyfPfje/V1t6INP3aE+Ongaa2LQzbr8vAWY8
         JbQteaGxTzAunXFYakXk8EbH2BJdA+/4NRu07xgTo1SpHZFvL+mKQyseC0dO96SRbfLK
         /MHNYw9HrEE7lIsmJkArNozp4/eH+UKZ33CMG4EtY3bz1wug3VQBlyxZuPTmIqgrao66
         SW4A==
X-Gm-Message-State: AOAM531HLVcifYl3reP2jPXxFbw/hkWLcEGO+rJcSArHjfllSAN6WYvH
        s+1I9ZQ8EYDmEyWdXqO55OyZWPpO5Jk=
X-Google-Smtp-Source: ABdhPJxHIrSgRiC8riB3iWnvDVKqe7CJEF95XgkkvzLs91AN5d1lKWjoeKnkqsCG9hY4X877gF8vyw==
X-Received: by 2002:a9d:740b:: with SMTP id n11mr32658otk.69.1630688584024;
        Fri, 03 Sep 2021 10:03:04 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id bf6sm1124044oib.0.2021.09.03.10.03.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 10:03:03 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 3/3] developer: enable pedantic by default
Date:   Fri,  3 Sep 2021 10:02:32 -0700
Message-Id: <20210903170232.57646-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210903170232.57646-1-carenas@gmail.com>
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the codebase firmly C99 compatible and most compilers supporting
newer versions by default, it could help bring visibility to problems.

Reverse the DEVOPTS=pedantic flag to provide a fallback for people stuck
with gcc < 5 or some other compiler that either doesn't support this flag
or has issues with it, and while at it also enable -Wpedantic which used
to be controversial[1] when Apple compilers and clang had widely divergent
version numbers.

Ideally any compiler found to have issues with these flags will be added
to an exception, and indeed, one was added to safely process windows
headers that would use non standard print identifiers, but it is expected
that more will be needed, so it could be considered a weather balloon.

[1] https://lore.kernel.org/git/20181127100557.53891-1-carenas@gmail.com/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---

 Makefile       | 4 ++--
 config.mak.dev | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4e94073c2a..f7a2b20c77 100644
--- a/Makefile
+++ b/Makefile
@@ -486,9 +486,9 @@ all::
 #        setting this flag the exceptions are removed, and all of
 #        -Wextra is used.
 #
-#    pedantic:
+#    no-pedantic:
 #
-#        Enable -pedantic compilation.
+#        Disable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index 5424db5c22..c080ac0231 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -7,9 +7,11 @@ DEVELOPER_CFLAGS += -Werror
 SPARSE_FLAGS += -Wsparse-error
 endif
 DEVELOPER_CFLAGS += -Wall
-ifneq ($(filter pedantic,$(DEVOPTS)),)
+ifeq ($(filter no-pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
+DEVELOPER_CFLAGS += -Wpedantic
 ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
+DEVELOPER_CFLAGS += -Wno-pedantic-ms-format
 DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
 endif
 endif
-- 
2.33.0.481.g26d3bed244

