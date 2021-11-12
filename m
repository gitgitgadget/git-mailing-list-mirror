Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90223C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E3E60F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhKLVwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbhKLVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3174CC061767
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id az33-20020a05600c602100b00333472fef04so10221237wmb.5
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpfKh7sOV/xR4EqC3wG2RvtI/n/tff68yXnkhYtpdtc=;
        b=CBTvIZEV5PrRgcpEG3p4Cfs9mvxhgSCQRPZi0AuWaN1NcfobxwAR/T913103hwRZbA
         urPa8MS+12Rwc9TkhJ6nd9V5Oy+IvWGPoWGXw+3yVtKYuArrffBRx3ulUA2gsQxxZZ+2
         48bZa3JPJuoI/Cwu536z/lrWcWkoi0DalHaMJhmTw0NaMixZM8cXOnA5rY/sOSjRCxOE
         BA8q7VgbIQN09O7+U6gPRbBv9QRrJ7TvYvlNV25BrnkDNOrbg6UuW+3/EJpTg9evqfBq
         4X2u3uuE3z8zHOoHZVfZ6Pp+A/BkUDjxX2zDAW8+X8gzR16qsC3bXFpK5IWK3tAUsYZr
         Jk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpfKh7sOV/xR4EqC3wG2RvtI/n/tff68yXnkhYtpdtc=;
        b=rHhxMosbsvBZPnvkOsgFyMSwvMPHG9XhttxAyMhPBQEgbutZiJJPJ9a/LP3N5LJHKE
         PvHLza2p7sjKuqXcde/HE12OCjQqAclYZIQ0ldXv1WDFU5OWScG6mfWLfIFwhQxSOhtU
         KFWDrenpAiVabTszXgYCv5Vdw5TU/Av6s2+FaeJi28XcDFa9mfmRpXeE9OZLCwQZdWR2
         TbakvSRL7eqHfrewwCy9bx1Jc5DFNMFfuQu23miAJXoqVnVOn4BANIedQBOBNqa55WkY
         lgelqaSfCM7SsQNOQNRDx1yLiEoTV0qtZQSxCvuHlJ1/3FNQQRGHBdUTnZTEAr1GQtDu
         PL7A==
X-Gm-Message-State: AOAM5331h5eE9pf0YxhxS4qnIRbFrDbM21xMtYVLt+XlXRqqpcMnHfoK
        7tgUU/zCmFcjMh3PgLb3QvWFgMD53AzJ1g==
X-Google-Smtp-Source: ABdhPJyaTbIOkw4iHovAvJHbf+CiONAfCA8yzYUIGzECYzFGVGBBaVhOYt+wgbEz3pIn3fUyCb/JXQ==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr38911294wmb.155.1636753748846;
        Fri, 12 Nov 2021 13:49:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/18] Makefile: use "=" not ":=" for po/* and perl/*
Date:   Fri, 12 Nov 2021 22:48:47 +0100
Message-Id: <patch-v2-03.18-472e1eb74bd-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

