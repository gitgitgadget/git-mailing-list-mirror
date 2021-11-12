Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E79C4332F
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25B960F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhKLVwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbhKLVwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE1C06121D
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c4so17847408wrd.9
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHlOEGzV6voy+J/uffjktW6Cuw60nw+9x1xLPztGOK4=;
        b=B26PmDt6xfmzhZXJ3F/t4f39GshyPfZCWbhUiAhZDZnG3+L7zRPghRvqWYrfAbuu4I
         szGfrK8WwLUtM7tTb72daDVj5cV0l3g464gunFCegtp2g69V9UATDjUf7Drcqy/OxsUM
         ZmomjP2UYWBFd8uc6uZak1/guoO6IooNlOrX02PU5KgJSQxwBUIK17SL5sIxVBND++sD
         lmBEcaGBYIWg3BDCLJXQ2Qc6YYcGIceiEYasLZ7HB6FCh8EZhcIIkkBO1BFn2v4whhNw
         E+MF5ek1pyqGeqJCxho6fd6ZQf/ZKBS5nb+lB1e0+rFrFrLgQxSHRKhGmuYGDMJkWUuU
         +RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHlOEGzV6voy+J/uffjktW6Cuw60nw+9x1xLPztGOK4=;
        b=VYzQXT6zLb2AQfH0QrZgexJhWAYOLhX6YFu5s0quf1d8wO0WDvXDxNm2o88iSUcCIn
         5H2HeVMhibKbr4qmJLuq4Xu78a+lfOCSZmDMWVulOX4zI7GR35gllEQx3w26NKGw7LCi
         rq2z9dLjL8zdg7vIV9V3vl83K7hMFwRaXEtS0+k772/Scw5GxSUXUu0VwItth6raBOBV
         m9BTa6/TFg7QsDZ56vFYQeu9ea2CBpJYhANmyxK/+PVncg8xKtFSPzanr6FPLpdw5DRx
         VHtaOFCNvsOjuqqHVxdNaQ5angQuFginFyKnLTm/ao/PQrNeQTxTwqnnrBP1pxoxZHBa
         fWIg==
X-Gm-Message-State: AOAM533gJbZKHtxQHMW/gvD1abIviShjVvfc+XGrl5hRHBlcnvHdkHnX
        7VHudNKeKiqpohHQzR8Ddn2DY4Cmw2dQiA==
X-Google-Smtp-Source: ABdhPJxL2ALWh6zNt8zvSaWUejoZzidBY8wq2sGIUCtV4ynU89zsws9SO9ePAiTOnehrFR7c/tIsPQ==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr22226233wrq.171.1636753754022;
        Fri, 12 Nov 2021 13:49:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/18] Makefile: adjust Perl-related comments & whitespace
Date:   Fri, 12 Nov 2021 22:48:52 +0100
Message-Id: <patch-v2-08.18-a9502a23989-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

