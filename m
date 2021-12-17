Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C04C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhLQA0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLQA0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4BC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c4so933588wrd.9
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ql3TtL5TZqGq4T4/ynaf1dyBXi4n/xbD4efcilH4oUQ=;
        b=bXqHWJPq+OgB82K6kBnAOgB1Y6IWLGxCubn7fZlasDyMbRcswsMk1juaO4ixS3zXTv
         XA91LrF0dboPJ1GxUsl0Zl14M3kuxTEL4c5vkgnp8/4odFWlOcxFY5/Lo+TwNoeOTMpj
         5R6379HhmXg2d85QXrtJSIp2kcgOORWsQ5PDocj9k1EPQ6ucNaspE5J9U6wmBKtkWVsB
         /aVb68toj7RL3UFMz6WuC2BWpSQDWluDiQ4QEofsYtjhGk0fXHv9BCcmCf6qpp/cvCiF
         J/Vi0kjYs6bq23RDS9uJqRpvxrqmlXr5fI+aO1BNqWKJO3XHoMGiOOJQDVWOB5oO0XtJ
         2+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ql3TtL5TZqGq4T4/ynaf1dyBXi4n/xbD4efcilH4oUQ=;
        b=p6P+Y5Vx2DPuPJkH6qhj+E/BygxZQOd8yMReB+Be/ME3oVbwdGEbrLGFT+EjHc+mym
         P1Os+NVKGKEEBWOdwvd6HJT/jWz3IF051VSDoHLcRzJ5AEXh8i3J/6wioDwVn5Uv6cMO
         9M5ednYOkYtQK56YUf7QPovKsPlRtSrc76o5pAANGEElKe+cKhA+W74p2pBdq8fCH70o
         6zSdRZMocwgzeWhQm2nfmNIQI9qITPOIieCgWFm8RcSPHGK0ExCjws4aj4F2BW3byAyM
         CqjMJepXEyNFHm1SMK85lKiSdiqZZ8RMgM7DhXWaQ14PZIfB+wtP8MgnMRB2/wCdgvLA
         2QJQ==
X-Gm-Message-State: AOAM532NLKxfanN3JqFP0KEYJWtu3tVXQj37dr7+DYYZSXfX/ZBp+QRt
        NXceNUV/jqchGccYSDxZYNs0L1odXwETFA==
X-Google-Smtp-Source: ABdhPJwDc/2WtXJOXH6XPNrQ6rq2n7zyHoYE43LrsseGqndrUKaA9Gkc6jj1wx7NObghz7jWhI6uWA==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr364745wrw.218.1639700793860;
        Thu, 16 Dec 2021 16:26:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/11] Makefile: use "=" not ":=" for po/* and perl/*
Date:   Fri, 17 Dec 2021 01:26:19 +0100
Message-Id: <patch-03.11-572a82c71a1-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
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

This doesn't make much if any of a practical difference, doing this is
cheap either way, but as simply-expanded variables in our Makefile
generally indicate special behavior (e.g. making a copy now, and
modifying the RHS later) let's change these to show that nothing odd
is going on here).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index d4c31a2718f..cad9795ec0a 100644
--- a/Makefile
+++ b/Makefile
@@ -2719,11 +2719,11 @@ po/git.pot: $(GENERATED_H) FORCE
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
@@ -2732,10 +2732,10 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
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
2.34.1.1119.g7a3fc8778ee

