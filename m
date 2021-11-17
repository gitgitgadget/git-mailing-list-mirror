Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B1C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E90661C32
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhKQKXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbhKQKX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DA3C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n29so3565732wra.11
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsXeXYStWobVGpsANde1O0jZf70fvS8R5zlqcXXAs3g=;
        b=GFzlOzFRyI9HH5+wcSvudlXLcjhgWjTkki99jLU/M72PEhzm+L9bnFN/aUC77SnULG
         FVfr+4iQaxbbZn6m9l4iDVcmaYJP/4ukWltafGaPK7+Jxf9fJpVQdP7YLpMZFT5MP+L3
         J98GQ4gk3g/Whcm7Npp17nJwzY7XhDqpCyftuxrjpbHKFgb0guEFJfWoio1ruYtBpmH6
         pB13SkcFJQVnNwfOM21HQDLsO3qtVhYvhgFOJ3kfjdP/V6GgJcIO0ihvFLpJpCSA84LB
         APz1FuD37tu4govQaMgTKMKQNVrCmVMSBq7n1DFseGRYmz51yCcQ+vviW463k7Q0TRge
         28Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsXeXYStWobVGpsANde1O0jZf70fvS8R5zlqcXXAs3g=;
        b=YFpSk6JYWmcPA68aK835yMYoDp78GrPQfKJhtME4qjiFOXFJhoulMhBZY3th6d/yDs
         4TnJO+0i+9pcgtAujh2ouOs+M/19DuNas0nLOdRNa3awOkb/1i5K2RKoDrN3P+JlQm4t
         VRJtHIzwhyNTAJb3jKf0UwL/VHBbKE4WHtwuC2GV7b4LFROKi3qTHTaWfZBwzuZDRWdS
         PVTvH3j5Bpnx8EjlMx/gXtQM93ZUAJthdM68gfczA1p1zQla9RV7EoOQ7FVsFPXrkg8S
         /rolR4+vssD1bLRadaadaXqOYIGfBFN/Ho+VjbfjXp3cB7k6SzJCLenmOhidXhRvHubt
         aDHQ==
X-Gm-Message-State: AOAM531vQZuvuFXoR8QrBpfc9F8qZnaPAQeXgEFzAswXJfNVYRdpxQAp
        dOdGIj95P5hFu7A250SiQN5eHyKcsvfcuQ==
X-Google-Smtp-Source: ABdhPJyIOZbEydTvApnjoXR3rU4IRRuq4xlEQKqpatoSjahqH9sS6Fev9REqGjLjL3vk3X/ms6fvAg==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr18844305wri.69.1637144427706;
        Wed, 17 Nov 2021 02:20:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/23] Makefile: use "=" not ":=" for po/* and perl/*
Date:   Wed, 17 Nov 2021 11:20:02 +0100
Message-Id: <patch-v4-03.23-29b000eb0f1-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
2.34.0.796.g2c87ed6146a

