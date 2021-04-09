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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410D4C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6CC6108B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhDIPDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhDIPDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38F4C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:02:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s7so5832150wru.6
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3sM3yuWaPoAgy4hqSZitSOX2CYBalPMB1zLgbcZc5I=;
        b=vT4BVkHAUCiZBpOu01aNCEEQfHxEHYy4i7jzgSPDGmXgVjAPAlT6rBsm/QrpeSlhJo
         5/7ERf4DpLviuHSTPUx0Q/obC9ugKVz5B5D7xrhEn23ltyoDBFmyivOj1q12vOXxinP5
         jYALvfqZ118zWBMY2zUV/PRFkt96oN8VoXEA5AHZBQJDg8NGxNbjfZTLlurXgK16KczL
         SlUCIC46S3SyMWHvgd7hQVHEzUiqZ/qyKd7QCmncNtO38oxcNOoy1k7i2Z5wzEQvmTgC
         uJAraglJr9gco0DM3iID9CbhUAFXcK4lDSkUOl8K+k/ZvXBVCnfki3N9AouFOS8tCkwq
         OgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3sM3yuWaPoAgy4hqSZitSOX2CYBalPMB1zLgbcZc5I=;
        b=DgDz0lucdI5PBpL4PaY18sWt+UQUuGM3Lf7EWf1ndUpGEZMfDlSvv2ZO6Mwatihc6a
         CVGq6ztnSw35IqzBsz1+xI9ItHiqlCaM3BEfx3u+gSEu/Z214isDRdr9VtiFeb8zXOhS
         b2ffcKI5G1K9w/dv02sK54YRSK1tB1lSUjUCfz7wpI9Q9yaEbqaIh7Q+gIRWmmZakHVh
         gGic7E/2Pm1s73UgF2Zgsm5iiY74ZXM6bQ4TJckvsXlIgSvOMQexx3ND9XH55scM5R+p
         AeMFQJFDZWhsHKHIoXG3FlWT+Epw4F4XUytkaaL1i1Mc5JGFpnYzsKnhjyL+j+5mbRd/
         TEfA==
X-Gm-Message-State: AOAM532sk86qQMjD2wZx9WBhkNRicW3OLTEYajSfmhB6kx1mEFDIOqAF
        N7K6/yDG2Wc+ALQqiXKEzCnC6aA8HDEDUA==
X-Google-Smtp-Source: ABdhPJwlbmVtnejF4Gg3S0ySKswG3R9uJGi7rq08HpNrUS6mLmglTKkb6ZixG6qNfid/9qj5uY+r/w==
X-Received: by 2002:a05:6000:1371:: with SMTP id q17mr9822065wrz.326.1617980576147;
        Fri, 09 Apr 2021 08:02:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:02:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] Documentation/Makefile: make $(wildcard howto/*.txt) a var
Date:   Fri,  9 Apr 2021 17:02:44 +0200
Message-Id: <patch-1.7-8efebc7a03-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
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
index 874a01d7a8..f0597777b9 100644
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
@@ -428,9 +431,9 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
 	mv $@+ $@
 
-howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
+howto-index.txt: howto-index.sh $(HOWTO_TXT)
 	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
+	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@+ && \
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
@@ -439,7 +442,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt GIT-ASCIIDOCFLAGS
+$(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	sed -e '1,/^$$/d' $< | \
 	$(TXT_TO_HTML) - >$@+ && \
-- 
2.31.1.622.g1b8cc22e65

