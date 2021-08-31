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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A86C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 01:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EB460F46
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 01:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbhHaBeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 21:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhHaBeP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 21:34:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58283C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 18:33:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q68so15165001pga.9
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 18:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYz2wCJfCNcxSPtmTLzrRCcD8qh2bFeiobbZ/A3tUvU=;
        b=iOOQYg6RWJSb1CJrtG+y+IlfoWD45/CuOVdpKXf3ubFQySr9ehxcZqDncUzoinPzab
         BNmm1luUoVu4DrriCkkJQnc3p3P1Zi6BTqdfQNThJAMbwzvcq+msXW4MhZYOmdzhwLsd
         CmtoQMqkRkaH0nZ+Sdnnsafuc6rXX0+J+n3GpIU1mtipXU+Ubseo/JZ83WjAjQTvLEuN
         ncGI2u4BF+BepFmEM6gek5ukxvPbkWu3nexuQRsCv6gsM1uhAKqqYDmtViinK/f2SYlh
         Vwrg2GmbX1j0X7zPpzBFDxJQmsOFhpfpVHbOmdT2mdXpCkO423XD/jVNSpk7F4Fn8RcW
         ht8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYz2wCJfCNcxSPtmTLzrRCcD8qh2bFeiobbZ/A3tUvU=;
        b=FeOAWwKTzHrCqAfgUSvWMQaX/UaYLwg/qgJWUHRPW2Cz0iztAWGkE9BEjCsYBIKbG2
         NLVyKUnVKTTxRDjLNIquQpbDlYB2qSFUnRgRhaHZH/iN6LUk4G9ZfbzBdR+IlpsQ9ZRc
         SUbe3l7FoGJivu7z/bijxLdnFzXUSa/ZVFur+ppmhTXGGqOgpW7CcWUmwCYpliCDAz3L
         NwCMLSBAdysR+6k9W5BN/hVPI4YjsF4D3SqZCplxb/Z/21/OtvgRzC7avqSLEnNWhr2y
         bBOBXmcLbnG6VKNl+L3vdPYSBUYGIeTCAFMU+csivS2PV4vzZ6dtcM/ZhmKwAxHIKA8Q
         foow==
X-Gm-Message-State: AOAM533ICCIp233Ih/bw+jTHvzpIipDeUMVGmFjwR6cqn9t59LY9ODFy
        bUFFRC+U2YNeiydoa41NZbKqV0Qqaa7/Pg==
X-Google-Smtp-Source: ABdhPJyZganizLiFzvckcCbusD3fYQf7ILdXnnlu9GA43UZEgDVXu5hDF0eniD12AnB7AMo0zmnEqw==
X-Received: by 2002:a63:79c7:: with SMTP id u190mr23719209pgc.355.1630373600440;
        Mon, 30 Aug 2021 18:33:20 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id a11sm17998015pgj.75.2021.08.30.18.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 18:33:18 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND v2] make: add install-stripped target
Date:   Tue, 31 Aug 2021 08:32:36 +0700
Message-Id: <20210831013235.388682-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the target that install Git with stripped executables.

install and install-stripped share the almost-same recipe, with the
difference only on extra arguments to $(INSTALL). In order for this to
work properly, installing all programs ($(ALL_PROGRAMS) and
$(install_bindir_programs)) must be splitted into separate portions for
compiled programs and scripts. For the former, add $(INSTALL_OPTS) and
for the latter, don't add anything.

$(INSTALL_OPTS) contains stripping options that are passed from
install-stripped.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Changes from v1:
 - Share recipes between install-stripped and install targets (suggested
   by Junio)
 - Don't delete 'strip' target. There may exist scripts that depend on
   that target. Once this patch is integrated, deprecation notice can
   be displayed when running the target, but it is done in separate
   patch.

 Makefile | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index d1feab008f..28d1e9bfae 100644
--- a/Makefile
+++ b/Makefile
@@ -3004,7 +3004,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
 endif
 mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
-install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
+install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
+install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
 
 .PHONY: profile-install profile-fast-install
 profile-install: profile
@@ -3013,12 +3014,21 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
-install: all
+INSTALL_OPTS =
+
+.PHONY: install-stripped
+
+install-stripped: INSTALL_OPTS = -s --strip-program=$(STRIP)
+
+install-stripped install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_OPTS) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(INSTALL_OPTS) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
+
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
 	# have already been rolled up into the exe's pdb file.

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
2.25.1

