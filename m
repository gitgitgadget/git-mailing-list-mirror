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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC1FC48BDF
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A487461369
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhFVOXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVOXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 10:23:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C5C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1663447wmc.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKZsPSsndtv0jSomcSYBRePIyQQCNBSpFDpWRlbH/as=;
        b=Hg5k20muA413JmnSvpirZPJSmJkUv1JCW+fW2uc2GJ1Eu2blchQS2fx7xlmXkh531h
         10It4JinKkvLdu/DYLg0WW8D/JpIk67FD3ePru5+bRgVUG9cTtlySIOtDS2CX9NX5nzZ
         za1jtcvT+Nndjid3yDt0MnsULPBMjKb8mCZR5dJSFI5Gs7pUqeYGERz36CZa6xJS8rzF
         BtgJ4grnYeTA5pV87Cc/NxnRB3UjRWnPK0Pt2q3cdNBQOsPL+54C3bxqfUAg8FW7P4Yp
         4o+2G19uLL47WKHEDz19KJTee4cZukNOVL0UtGlHEGrTPBvtsSq4lVSYGys4CxBJst9k
         mUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKZsPSsndtv0jSomcSYBRePIyQQCNBSpFDpWRlbH/as=;
        b=bmX04hKzTyJpfVGaq+hS4QP2eGO//Clc1YRYHmeHx2D0GT74KQaA1Xj9Kuby4KMabb
         cRcF74IcXD5HxVPtjh/XHQxCh5uAKClBUMxi1S4vxQ1rmeHzb7PzjN8FvO0xuK4VzWyP
         45xku7AnPcyqSonCfMJ9q6adtQtExJ9e4aOtLYzkI2rvwFLsFgxeRva2Lyk5Gp3LBNGQ
         nmajCtzjkjI1xOQFSfGJ3uyElBBADdCoR8NAqBJkp15DJlVzo4tEeWj9uoa6pxSPEe+t
         HW471b4CeLy6QZApCaXzOIEvlt6oz+y2tWze+SlWdk36VEkBUVxygiboRuuODLczEwdB
         QdsA==
X-Gm-Message-State: AOAM530J7db4wgxJgWubEua/FsnYGx61n682UBdfO6hODHpvOZJLvy4q
        /b0da7Pn8qEaNf32ORC1emAzUyvDosAscw==
X-Google-Smtp-Source: ABdhPJxvjl5t4FgnbEOLw1FKg7zEbvqrZrW8ug4Y3psft7EkfbDnnOaKsLXswdSZdtv66jwCd2y4Sg==
X-Received: by 2002:a1c:984c:: with SMTP id a73mr4655194wme.17.1624371689931;
        Tue, 22 Jun 2021 07:21:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm22617395wre.84.2021.06.22.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:21:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] Makefile: move ".PHONY: cscope" near its target
Date:   Tue, 22 Jun 2021 16:21:25 +0200
Message-Id: <patch-1.3-383a90c8ace-20210622T141844Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the ".PHONY: cscope" rule to live alongside the "cscope" target
itself, not to be all the way near the bottom where we define the
"FORCE" rule.

That line was last modified in 2f76919517e (MinGW: avoid collisions
between "tags" and "TAGS", 2010-09-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8f..4dd9711a653 100644
--- a/Makefile
+++ b/Makefile
@@ -2737,6 +2737,7 @@ tags: FORCE
 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
+.PHONY: cscope
 cscope:
 	$(RM) cscope*
 	$(FIND_SOURCE_FILES) | xargs cscope -b
@@ -3245,7 +3246,7 @@ endif
 
 .PHONY: all install profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE cscope
+.PHONY: FORCE
 
 ### Check documentation
 #
-- 
2.32.0.599.g3967b4fa4ac

