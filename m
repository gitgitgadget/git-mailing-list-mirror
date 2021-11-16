Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA2FC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F7261040
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhKPMFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhKPMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B738C061210
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso1731832wms.3
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxul1YYNwYQX3tFj/SVCdT0l2SN3rSACHXGzLgadBwE=;
        b=FEAkI6Z+O2w5pB8oLpJou9J/iFlmyW+v4htuGC9VAvEMmyC9w7jZ7L/bMFhrcgBgKy
         khBAnCZC4GIZDjrIp4y4Kw1COrpAfbvh5TUcbnK3UOHl+hAbBujaTRSCrzRPlQ9FZwpX
         sZuXz1tPab536KaN+7GEl3pri4Ca+F6DtGjw8KwNhixiedaQJTkboEBWZhY/StEe+tCR
         a7A4FTQKipphMa5IHOAyqw8r5UBWSgtbswMZy6fLgeHBwHhZxoBre00M93ZfU5j0LmJZ
         A7uITRS0995fGOISCfF06pQsNqTWjLWvFBe8LbPA3L3mRaxdYY0JJHLsIGCmYMeZ9FXE
         OBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxul1YYNwYQX3tFj/SVCdT0l2SN3rSACHXGzLgadBwE=;
        b=XHVC5AaGcxpiQJhG3IKlabZZDcNp9uySP/FGittVOdirKmUZ95Fui5PpqqD2i7/2yz
         PPGuSbbzZMbx8iOJs7EpsX4nsZOqdp0p4rHYsSrOqGIMOykORE8CsuiwSUXCarzQDyo8
         JAFb5DpbDXLDTKyknyON6AFcX1C8PPnnhYifwHmAbhqEwXy5x+UAO/JOKomgq7oHz4ze
         L1OeFSsTSRiCHTAQdQS/0VBgH7k9htNSve0C1rigqwQz/ZvgFL8RpRRmHDni5Y5xEOEH
         aFR//0xWhMJY/J5WZjx+R2tKdts54+fGIT9v7jYxU9NoHzocABtU+0w3wmg5rmTjrjU+
         1SPw==
X-Gm-Message-State: AOAM5303Lqwmj3Hz6IvkVMM0+47vblPRt4CpGCKotlcmUpyyOmDYQfs3
        R5RkaWO4b9312uY3fKSZBar9wFdBOhc76w==
X-Google-Smtp-Source: ABdhPJyzWv7yscW9v6LKma+Fi0FZaM49yoJpVD6zCvsM3bTQUE26Zuw8wZidlgKyEjUmz3bydBkayQ==
X-Received: by 2002:a05:600c:4e4a:: with SMTP id e10mr6861285wmq.176.1637064036720;
        Tue, 16 Nov 2021 04:00:36 -0800 (PST)
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
Subject: [PATCH v3 02/23] Makefile: don't set up "perl/build" rules under NO_PERL=Y
Date:   Tue, 16 Nov 2021 13:00:02 +0100
Message-Id: <patch-v3-02.23-b7c36c9fea0-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
index 11da97de233..06405825a24 100644
--- a/Makefile
+++ b/Makefile
@@ -2684,19 +2684,12 @@ endif
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
@@ -2704,6 +2697,14 @@ perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
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
2.34.0.795.g1e9501ab396

