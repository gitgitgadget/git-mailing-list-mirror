Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDCC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497FF61040
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhKPMFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhKPMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CEC06121D
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2183175wme.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+3T1NYWnCm3oc8E6iQ2ln3ogGtXMv1bYmNy/z1NChQ=;
        b=TnNESP+xtt2NEKgmtzF5OiTmu2g/Qviv4J4nNE5s3cbya9DiExW6m3AMV88mlR+2OL
         FSWmfG3PErSSLPVwTs6x1gD+fDb355ZQmM358A0sJyjNNIzLVjMz/EjxpyKS1gH15+lf
         v7K/Xmy+rEUru2faWmt8gn+bcEQg3m7DEkb/DYTkXyNkxRKDp72HdVIYLKHtJKS3Qyiw
         FsCO3PNo6YH+gN23pTvhjAQ9qnCTZj6DHuw9O898pVbSwDZAS8b3NpQMDLFycWfq+9Gd
         U5Qwv4fBXy8u/D6KKCTTghsyYjO+2mfjZNuip0XtTh6hJTd9Z1blSrQSvXzafqfUS+S6
         KFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+3T1NYWnCm3oc8E6iQ2ln3ogGtXMv1bYmNy/z1NChQ=;
        b=BUk87kK13MJSjW0l6lpYPVvgZtPQEjHGFuQi7nTOFhoY0qC1nIB9c8aYWcTwCQeWA+
         c6C2JuIgWc5KygehiK/+bogU34UarKlwm8Vd+z1kIe9+wUa+2/HcRdgQtR8BXxfLgXoD
         uDVPTyah5CO1RDBUsrmLmZ08mYPJSFhrlixpI5vM5Aus5+AnlNNHiTZ/fHtcnYDrTIl2
         Ap3g5J4diK/dr9NBA2vZ2xDonecFaMtPnPxOCloAcMlcGG7iK1boQXnTO/m1x92Kzvnw
         CCXqfyRIdP8yRqXG2I2d01HNQ31u00dpvVe29fyJmREJJvEtObzC5m2ZvrcXVrUPHGcx
         klQA==
X-Gm-Message-State: AOAM530QOxv7dk4OF99GJzzVEA2Xo+MJTeJ33tzWBXkL/srI3TiYA6l/
        L8MEYP0MMR/nC17s6iciBzslji56x72yQQ==
X-Google-Smtp-Source: ABdhPJwXMvXz4InA0iDVl7pobRpk7aMfacUCSoyI/IS1lUeL1dYaoEtJUZ6/ogXgjftVRb4J+5YVCA==
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr6997062wmq.175.1637064037483;
        Tue, 16 Nov 2021 04:00:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/23] Makefile: use "=" not ":=" for po/* and perl/*
Date:   Tue, 16 Nov 2021 13:00:03 +0100
Message-Id: <patch-v3-03.23-510499d18ba-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these variable definitions from being simply-expanded to be
recursively expanded instead. I.e. they'll be lazily expanded when
used.

I added these in 5e9637c6297 (i18n: add infrastructure for translating
Git with gettext, 2011-11-18) and 20d2a30f8ff (Makefile: replace
perl/Makefile.PL with simple make rules, 2017-12-10), the reason for
using ":=" over "=" was that I didn't know the difference in 2011 (I
think I copied some POC code), and in 2017 I used the 2011 commit for
reference.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 06405825a24..6b77702e102 100644
--- a/Makefile
+++ b/Makefile
@@ -2672,11 +2672,11 @@ po/git.pot: $(GENERATED_H) FORCE
 pot: po/git.pot
 
 ifdef NO_GETTEXT
-POFILES :=
-MOFILES :=
+POFILES =
+MOFILES =
 else
-POFILES := $(wildcard po/*.po)
-MOFILES := $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(POFILES))
+POFILES = $(wildcard po/*.po)
+MOFILES = $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(POFILES))
 
 all:: $(MOFILES)
 endif
@@ -2685,10 +2685,10 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
 
 ifndef NO_PERL
-LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
-LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
-LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
-LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
+LIB_PERL = $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
+LIB_PERL_GEN = $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
+LIB_CPAN = $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
+LIB_CPAN_GEN = $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
-- 
2.34.0.795.g1e9501ab396

