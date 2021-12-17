Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E84AC4332F
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhLQA0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLQA0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E90C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so968435wrc.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmAsePczrBgJMRHXNMKFfzSAis9Rcea40juGAJMAli0=;
        b=jd3H+qvt+JgjizTuhc5iVx5BDFlDzHoO+d2xMfGddCEuh63Dlv6kgG+xxx6PzXZAL7
         hRlM9qhJOwV5NmYAym+ASyocOcMvEsfZXaIoI/cLv6ibQwgilCvqrAv/t+PMjaehpSIX
         ncgmDDLkXmbncj2ejYs/Ewea9r9xz2mAb0mL7g6/Sh+gSWzBX2EJOoB+Uj94b/cCkU+l
         XbDvRVnt+xljfiPvKwgaVPBFC1vJdWFclucr+WmdOnh597qP1r09cPi7r2chUzg7nI0n
         4odYCS19jJbreRSc9HIMjfimBqvVCevSKkUv/W5DfZBw/tWaJ5N3seIc8NCQM4FyFAIW
         0Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmAsePczrBgJMRHXNMKFfzSAis9Rcea40juGAJMAli0=;
        b=TqvJ2vzjGv9RoTuG2ZPf8yW9sQ/oQBhEieP0jlw+AAzo7LKoh7OVYiMUxVdu0mK3N0
         bqs2sTf2ZeTX99+BDylCd99OhGMJyM3kYbC33Gf8EF4+PipKu8h+FxTSKfSAlLQEm8GD
         9ykgy32U/3e1Yy2sDP9NfV4jCKRrU2yebBSpBloXx3xTb3PtnD416Ocnhnd29m+hZ7re
         DIlR666jkPaX0gFlG4NmVnDADKRtU4Le5hXYy4yWZpAWcq5e2zUYjKLAj6l2FvBLAReE
         RrrhPGzfr9c1JKZKuPRCJGePUARK0MrlBFvTob2Fsq9ICez53IrTjeiTGgyvkDMhw60k
         qMgg==
X-Gm-Message-State: AOAM532DSYpKWyMuYTvEAHDCuiVflG/W96hCWok54iLLcnxlx/nwgwmB
        NwiW60LdUvQvkD136Ndt9pJi+/SHfat6Rg==
X-Google-Smtp-Source: ABdhPJxFkPLCxwfdYR95WNsLsxUN1OABlM2v1aQNd5abZYulT0/HAZcM6rfYRBTqq5ZiQLo/Dlaqgg==
X-Received: by 2002:adf:9d4b:: with SMTP id o11mr363978wre.11.1639700792987;
        Thu, 16 Dec 2021 16:26:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:32 -0800 (PST)
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
Subject: [PATCH 02/11] Makefile: don't set up "perl/build" rules under NO_PERL=Y
Date:   Fri, 17 Dec 2021 01:26:18 +0100
Message-Id: <patch-02.11-37eeccc5646-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not define LIB_{PERL,CPAN}{,_GEN} if NO_PERL is defined. This
changes no functionality, but makes it clear which of these rules are
needed under NO_PERL=Y. See 20d2a30f8ff (Makefile: replace
perl/Makefile.PL with simple make rules, 2017-12-10) for the initial
implementation.

We do for better or worse rely on "install-doc" calling
"install-man-perl" regardless of whether NO_PERL=Y is defined or not,
i.e. we'll always end up with that manual page, even if we don't have
any of the Perl code installed. Let's add a comment about that
adjacent to the rules that build perl/build.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index b21ffe25c2a..d4c31a2718f 100644
--- a/Makefile
+++ b/Makefile
@@ -2731,19 +2731,12 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
 
+ifndef NO_PERL
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
 LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
 LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
-ifndef NO_PERL
-all:: $(LIB_PERL_GEN)
-ifndef NO_PERL_CPAN_FALLBACKS
-all:: $(LIB_CPAN_GEN)
-endif
-NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
-endif
-
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
@@ -2751,6 +2744,14 @@ perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
 	< $< > $@
 
+all:: $(LIB_PERL_GEN)
+ifndef NO_PERL_CPAN_FALLBACKS
+all:: $(LIB_CPAN_GEN)
+endif
+NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
+endif
+
+# install-man depends on Git.3pm even with NO_PERL=Y
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	pod2man $< $@
-- 
2.34.1.1119.g7a3fc8778ee

