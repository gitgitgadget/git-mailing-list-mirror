Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF1C433E0
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA7A61A4D
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCZKhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCZKg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:36:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA219C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so5174115wrd.1
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xC1ps3QktHIK+dagAzacxjnFTwdo9ZRRWQKP0HcTE0=;
        b=DR79+NtpaOg8qB00psxb1oddKMUDH+5s9jMlzGmPiFP0rmzAW2G79EtdHaV5U5HjyT
         9WiiyOOMbNHawdXgXQhZfpK2E7Sit2PBc17k04VxxVRx3ao4YDRmV+3eXQMmgtK4hl/V
         lthIYLdn3PzefAYWeU+OBF7kIhHdyVDsB7C12EwIJ5gGDpsMFGkci5cnnXtnyAB0qlmC
         ipaJr4r/NIKynk5Jp+p2UQhv40umlDUo1tXEfGgzLixJ506zQe7PM/PBPBNE5nmHctxM
         RhnNtfSQiWEjaN5b1ymQDYXARJkpPM/cYyue3zhp1IqKb5I4TwnhtmOAST6yGX+IlcfJ
         /YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xC1ps3QktHIK+dagAzacxjnFTwdo9ZRRWQKP0HcTE0=;
        b=Y/M4xhwPdlThcCqAlIDhTFGc9Hydie0C/8quutp5VBPLeIPmPSx4u5VxkMXVt+SB8r
         YvQ4eXtt26QC1JhupTwLtU+rQUGnndzr47pe6IOqLWId/AzYSrXUOWdqLvo3u//8Y+fN
         Tc/5NdXei6lQKoIL6mArnHkProRWD2Y3kZnq9GhMlnvQf7ODB13nTLJCp0Tc89b5hIvV
         pQfmbImmiFOHBC72+SaKq1/cJ8aev2qVnzNO7tBRv8C0/KSgVsKg/qvFQz8TLVzHSIG4
         0ykObtjt5AC53P6+WlOSW9zjdTKlefOUnl+zGQqH+HbgW9/8I1w+Mpp26+Psd7xP6Msz
         tMRQ==
X-Gm-Message-State: AOAM530g6B5WdAJT5wR27oUqMdE10HgjHrRxvFoOu19omf8GRrm38PVK
        zfzo/hciVXNiv9uyccVy4oNJb5OefWyniw==
X-Google-Smtp-Source: ABdhPJxC2AhKjJcwdl38hpMuxLBI3tjhgqPuDEiNlKk4/VFudfGdcv9pWOYCV5myNrjyUibr838YVw==
X-Received: by 2002:a5d:6b84:: with SMTP id n4mr12613622wrx.258.1616755015352;
        Fri, 26 Mar 2021 03:36:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1752563wmr.10.2021.03.26.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:36:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] Documentation/Makefile: make $(wildcard howto/*.txt) a var
Date:   Fri, 26 Mar 2021 11:36:46 +0100
Message-Id: <patch-1.6-a5ec5fe4bdb-20210326T103454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.419.gfc6e4cae13
In-Reply-To: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor occurrences of $(wildcard howto/*.txt) into a single
HOWTO_TXT variable for readability and consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 81d1bf7a049..0ba7564be93 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,6 +2,7 @@
 MAN1_TXT =
 MAN5_TXT =
 MAN7_TXT =
+HOWTO_TXT =
 TECH_DOCS =
 ARTICLES =
 SP_ARTICLES =
@@ -42,6 +43,8 @@ MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
 
+HOWTO_TXT += $(wildcard howto/*.txt)
+
 ifdef MAN_FILTER
 MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
 else
@@ -427,9 +430,9 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
 	mv $@+ $@
 
-howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
+howto-index.txt: howto-index.sh $(HOWTO_TXT)
 	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
+	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
@@ -438,7 +441,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt GIT-ASCIIDOCFLAGS
+$(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	sed -e '1,/^$$/d' $< | \
 	$(TXT_TO_HTML) - >$@+ && \
-- 
2.31.0.419.gfc6e4cae13

