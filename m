Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CCAC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AAC61BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhKQKXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbhKQKXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC049C061202
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:33 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1661473wme.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKM5NSWEUZZ/ClhecGRt6FM08CAhCaAUBaNRamL1AMA=;
        b=MR9t5HVWTzaG3P+ldmTgrtikbbO4adxGHotvv3VBfFIN5G5L+A9pnESzt+z8yVw2gW
         vHevn9vSSj2MrNuyX/SC8KzzgzDfMbs7+9hlhTOoczhANwMMeP+8p4XKuZEX9Ln3ZoIC
         Dk8Zc//On7bBuhHp+9oQ/OQk0FLIoVvNLnxZMYM+GOpiCj4P+R4n2YXjBFpNDY9REWvj
         O9wbKGHM68DfiYBfTQFDk1EToPti8MFfwMeZTXwUflVfX3j242v/R9Rwqvg6JYITdUp4
         BxAMZPFmwdsoogM/JFI0S6AzZ0sF+4XHiyCrNZ9wytaAXgxofwLwxtuVd8rbe58BYwMj
         v8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKM5NSWEUZZ/ClhecGRt6FM08CAhCaAUBaNRamL1AMA=;
        b=U48QDEgm6XXfI6Gzn8ZS4CDsR+2FkPujwkzKQFI/wt1ue6HXUxIe5s/4a7wSBnszdO
         pWX/NsQa0wMK9KQCHrORQD/NaXxG4iHkeWOLRG0vPQK5IL3HLCD53yomct1V7NcEGXa6
         F7rCE95DkNaMNhJNNr7v+u/uUh3U9YTJWxpATsZeMt85jdkbFXu/bPv5OJNV+3RKn+lc
         4Gx8htaVroD4JzOhRy2qkuKmX4oi3nPH94vFeQFDHsSLdJbXeab1ruos6TM2/xC3GlKl
         yg5Q44SEL1s+GCCRVX7ZtSojvaVuM681KbdOU9HOZDOhBU3tY0TR4OiAWcMopVv6SEcH
         y8mw==
X-Gm-Message-State: AOAM532SLHI6UBOVqGkhG4JrjqgqV3GPvDbc+oLPmnVg13a9nOTMZ7RX
        zGimXlCEDH82Dbpf9olOHeMduPw33f4tvA==
X-Google-Smtp-Source: ABdhPJzAEKCi//RiNCgXd/kEPtC/ePG7/RaSzPM8T/9AEunvjBi1efcnOH1C5FpzrXBVDQBtf+/CTg==
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr76833546wmd.184.1637144432278;
        Wed, 17 Nov 2021 02:20:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:31 -0800 (PST)
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
Subject: [PATCH v4 08/23] Makefile: adjust Perl-related comments & whitespace
Date:   Wed, 17 Nov 2021 11:20:07 +0100
Message-Id: <patch-v4-08.23-1e25b532ca2-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Folllow-up my 4070c9e09fc (Makefile: don't re-define PERL_DEFINES,
2021-05-05) and move the rest of the assignments to PERL_DEFINES to
one place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 288f4834db8..ab78f8dd42e 100644
--- a/Makefile
+++ b/Makefile
@@ -2312,21 +2312,19 @@ PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
 PERL_DEFINES += $(NO_GETTEXT)
+PERL_DEFINES += $(gitexecdir)
+PERL_DEFINES += $(perllibdir)
+PERL_DEFINES += $(localedir)
+PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
 
-# Support Perl runtime prefix. In this mode, a different header is installed
-# into Perl scripts.
 ifdef RUNTIME_PREFIX
-
 PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
 
-# Don't export a fixed $(localedir) path; it will be resolved by the Perl header
-# at runtime.
+# The RUNTIME_PREFIX header defines $Git::I18N::TEXTDOMAINDIR, so
+# $(perl_localedir_SQ) won't be needed
 perl_localedir_SQ =
-
 endif
 
-PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
-
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN) \
 	sed -e '1{' \
@@ -2339,7 +2337,6 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
-PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
 GIT-PERL-DEFINES: FORCE
 	@FLAGS='$(PERL_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-- 
2.34.0.796.g2c87ed6146a

