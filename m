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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19451C433E1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB38C61A56
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCZKhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCZKg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:36:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01BC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d191so2724465wmd.2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKQvaVxlesFeJuqw5+qZe6Z2hbGnxprCPxH5xQZ2cn8=;
        b=Edvd/rYOy6vVVtWCpoxHvGMyj9HloHT7Xdrjw0+Am1/Njy6vRO0XwOrd09XUDtBCgr
         9F0vSPpbe3I4haMbh+2qPvJBjy9r5KzOk9aAIsIQeBpuH3hcPMp23cwzKOgzZSIVb51P
         x6dwBYJuj2OXEnGUrE4ovCm0HEFLzxNarhy2DGO4Wi+3WWqZ4Vs0q/Ykh8+hpNJ4Ucun
         1JtTa/WudfTTER8YT0aIZb0h2Py1ObYYM6hC3aDkJ7i99a4Jkk4hKx8WbSrnUfV3cd6c
         UGUhM4t+NgiFYujx24OytaEoRahxqb50AfZdhiTYmALNNkya/zz5ZI+j/+CRi1LbGi4G
         dhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKQvaVxlesFeJuqw5+qZe6Z2hbGnxprCPxH5xQZ2cn8=;
        b=gtOBo5s6gY7pseSdFd9Cw3cDerOlIJ7Y4fL8rFfmvny471ebUfmS1U7PDKDdbhVOqG
         0MEQig7zlldixpdTb6h/LYarCBGXGRddklsrU0sFdWqCuE2OuC6iQh8Tz6VBqAcCigLC
         gYUtOb76VsFQuipIOSLnE224BJnK+W2THv3TRMoPfFhL7ipwa11HdnbwxT9ohapM5VzS
         sb30gt8lDECncIwQlSW1+4e/4Oob5ukeAAh5Tuud1812szhar7QJS0L7faVg48T7/Gxk
         wwJTSgc753PE1spkqEHrjcSNqzNb1pOytMHOc/2Q6B1b5rCgGEMU1cBmzPsfIy7X/nVN
         au+g==
X-Gm-Message-State: AOAM53252BVxhyeMvaStY2pxYZ90/xFBESA34X3HRf34s1nara5S8z1P
        U1A+8qVvSmsjnXmGoXcfGYCAqBztWkyIBw==
X-Google-Smtp-Source: ABdhPJyhHkwFG4CJigkl3QTKp4Nwde27QKUN8eyp/636WnMKMmrHnIDPsKd4vnYKhKW/efTatO8JeQ==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr12524675wml.55.1616755016211;
        Fri, 26 Mar 2021 03:36:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1752563wmr.10.2021.03.26.03.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:36:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] Documentation/Makefile: make $(wildcard <doc deps>) a var
Date:   Fri, 26 Mar 2021 11:36:47 +0100
Message-Id: <patch-2.6-fdc55a86cf4-20210326T103454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.419.gfc6e4cae13
In-Reply-To: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the wildcard we'll scan for "include" directives into a
single INCLUDE_TARGETS_TXT variable for readability, consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0ba7564be93..7313956d73f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,6 +3,7 @@ MAN1_TXT =
 MAN5_TXT =
 MAN7_TXT =
 HOWTO_TXT =
+INCLUDE_TARGETS_TXT =
 TECH_DOCS =
 ARTICLES =
 SP_ARTICLES =
@@ -45,6 +46,9 @@ MAN7_TXT += gitworkflows.txt
 
 HOWTO_TXT += $(wildcard howto/*.txt)
 
+INCLUDE_TARGETS_TXT += $(wildcard *.txt)
+INCLUDE_TARGETS_TXT += $(wildcard config/*.txt)
+
 ifdef MAN_FILTER
 MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
 else
@@ -287,7 +291,7 @@ docdep_prereqs = \
 	mergetools-list.made $(mergetools_txt) \
 	cmd-list.made $(cmds_txt)
 
-doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt) build-docdep.perl
+doc.dep : $(docdep_prereqs) $(INCLUDE_TARGETS_TXT) build-docdep.perl
 	$(QUIET_GEN)$(RM) $@+ $@ && \
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
-- 
2.31.0.419.gfc6e4cae13

