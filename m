Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C751C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7736140A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhKPMGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbhKPMEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFE9C061227
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso1743358wml.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4Bcy5NxgsNvhTA1DszLMvlWZrOobM8cSJBXupNUz/4=;
        b=SNuDX5B0jTrkmLPiJa/hprQQPVewK2E19h/6IEdbspnmNQSAzvJ6xsH/GoLLxnFtVl
         5vMjaU+X2uNxPx5m2v65fegfqZoNj3CPHv3o+juIaleWlozAK2scAlpyVNf1pSzqlScb
         ufIlEhV5N3igo8Z7/vrxWEUFqshsWlNjJtq7Xo361eBk2IFCZuA3zBkFZwavY4ybQYho
         rzgIsXuSqBVXhbl6/vpqL2TDOeOIoDd//vLLPY4PdBNW7EQ7aII5d7d1Vi9aKEX0+bzH
         WM61d9ArgITOorAg2UZMJOZRvwCRu/toKHIDlFx0Cnw6naHgSIPf1+nYp9l/fSkpgCQu
         j1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4Bcy5NxgsNvhTA1DszLMvlWZrOobM8cSJBXupNUz/4=;
        b=wE3R+fnt70hoG3suCEWscMHsMROJRJbIKZsNVWbrwgy3lYr6xmcPLl8l0E2fUbinRe
         g4SQYTLxMRUeKxWGjHqlzn33GLw5up6FIHqyfGXkGooFbAhcwXXw/czXtU+kh5taw2w5
         meU3Y8N4QtPMR9zgZY3JltCsICTF3gQ/aqwscKoaQTYNIwdROZQjCZJBn45zN0DDJW41
         JCVpd6QzOV9lsWVVr9WsDCsi6zg/k10j2+kwb9HQ0zisGNrT5t4HhnFrkBlZFBIcNKhh
         X5veaVb1yJh/lZZ+s3NpUNmcSwZHXL9dMJPjXk7YDZslX0j+kRaB6suzCKG39iD+FIWo
         Kbvg==
X-Gm-Message-State: AOAM533XXi91pU+U3jdVqy+W8UYKEjJFIbyrDwqUJQWVO38I0G7XRcOL
        OqusT1LkBmj7jkT3jEYM2wn0iU3/8tuFDw==
X-Google-Smtp-Source: ABdhPJwL+kUA3Y/nSEk68kzNCrGePuIiHengGXUTpVuwRuLDAyVHcIpnbnuMY/h85Kx0SLty0eS+og==
X-Received: by 2002:a1c:447:: with SMTP id 68mr68957049wme.69.1637064041070;
        Tue, 16 Nov 2021 04:00:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:40 -0800 (PST)
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
Subject: [PATCH v3 08/23] Makefile: adjust Perl-related comments & whitespace
Date:   Tue, 16 Nov 2021 13:00:08 +0100
Message-Id: <patch-v3-08.23-0c0a3de390e-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

