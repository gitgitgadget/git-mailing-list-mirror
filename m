Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E471C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018AA61BF8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhKQKX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhKQKX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB6C061746
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so3636012wrb.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4j11wb869VxLpE5VDq64Jfl0O4y9O1lNegrbfopaWbo=;
        b=IytQpIWfMOV7QIUN5pbet16deDVsWNt23VK7NdLPHL8WmKNRCSJ9BHV+Zm62vaQyxb
         9hkre4t+edEC/EEKcyrgLRenTey/NXOC0tiECCa9Ea3hB3KQ35sowmy3xs0BDfbMNXh2
         DOzinadt+DioXBQlgUFpIJAiuAkyOXhTg3F5NiTs2OdUh4Kc/cb84QZkEemERmIJyAW6
         z4N7okgYT7TBH3tb0sysx/Jy5Hfbe7Je0V1iayag4tGqCNSfJ3Cp1D9ZEANOR08LmaDM
         pFBYFSjRx8gCHzChT10BvcJSHZOvsoiIoHPvCi5wIswZhSgROpsMAt0d3GExKlfC0PrB
         mYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4j11wb869VxLpE5VDq64Jfl0O4y9O1lNegrbfopaWbo=;
        b=Ewwe9dQBj/bVDvYbtb18V9ZRxSEvzXFa0nl/dJJCTAZJgJW5e5gAT2ihIeaz6qFJsH
         QTkmCSsKzJJ1NnfWYXQmw2LjNsqbFqadJyHjTS7KySPb9wf8iE35IGmFT9kCjS3/NoS/
         mW40AJ2pSpxOV7OiFg3SVYZjQWoa8xRiiiQGYYnxxuIfN8Ksfw0kMZUaIzjVlYzrqjHf
         nfCMNu/Y7BQ0fQ09wiokdRlqz1FtnJSR1/IX9FGXPGywllvxI+2o1ehliFN+rQv6HhEy
         WgvjQT0itIMptI8bU8RNDbeh2V/KgjJ74CZHgH3AKg9swzLh+HZxhFewWussap/SgXJ+
         8wvw==
X-Gm-Message-State: AOAM530XJTVAKAxz6XkFgXqVoYEedPcEAoEPs5GAYiPDW1hErJmWKkoC
        Z3jwS8367rNMN7ZeDkO8bXxx0gJdxLGe9Q==
X-Google-Smtp-Source: ABdhPJzb/OwPWOmL8U+PqnZvO2tYIB9/UPvkagb2HfcqnXXv6d1yoPCEuGV95Lr5LRLO8ZzO2mZK9g==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr19099909wrz.286.1637144426877;
        Wed, 17 Nov 2021 02:20:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:26 -0800 (PST)
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
Subject: [PATCH v4 02/23] Makefile: don't set up "perl/build" rules under NO_PERL=Y
Date:   Wed, 17 Nov 2021 11:20:01 +0100
Message-Id: <patch-v4-02.23-b7c36c9fea0-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
2.34.0.796.g2c87ed6146a

