Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF8C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5497060F0F
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhKLVwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhKLVwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810AEC061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d5so17906677wrc.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qBn5kDhD0ODSgKUUX9sh0GSDKRDREY35Cc3hjTgsck=;
        b=Id0FGB6oXjXecegEEEbj87yjfx1GQ53N58nF0SH0tGQ/Wip2OdVVNrX5YJczIOpWIw
         otFzcbEvtw6VtVbPrZFsVJi0CPUf+mGCBMPDtj9fcZhVlNov6CW3e1bQhGKHdCZi3AQ+
         UZFLYcEa14t4mCuFWYnG8P7cLJ5D4nJStlkrMtO1Jf2HAFQ0MDUzT8rsjcTlfA4Q7cj7
         rGNWLDY/skHAIbz9euTgP6Xf8tI22XLyFf0oby1SwGD1uxxF/Xu6Hx/XdkHZ4w6+d0Gg
         ++tuuAGhR6DkWMOe3ta2PXIHp2l5ttgsOiNf2vdapHyxeftg5dvtGQ4jP3aOqayOQ9id
         hLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qBn5kDhD0ODSgKUUX9sh0GSDKRDREY35Cc3hjTgsck=;
        b=I5DXhz+kmb7D3kxlfa/6seCA3EiLVUCa7V2SkIX92DJv2d1MS/xItaZsLfmeT6MXrh
         Q2i749Ne08VDgsw8T1WDVMbIQhzg/1N1lKeFo048MCv5qu44d3RBHnxOdG42teWfW6bJ
         7mWSBnhaWtLHHogSTfAcyu+t1C9ej88HusFh5MyzK4jMuzOx0HZR1bcRpPm6FnIxIY9Q
         9EfJROpwBRKOQ0gkOHUldVx/CUqv+GP7LiW4uD6rIx7K87K++cjV42zUaI3tkFh1jNgU
         xwWSYsUYoEf1wJQQCbkx2AszssBjSBt02gYg9VqHcu+dQOEEBTRmDq/AqkeZvfoCZWwc
         3apQ==
X-Gm-Message-State: AOAM533iXqe8EfvADuzAZI11Z6VXNZ8wGSXonZxyAYxFnq3aTx4zQXPU
        oKSwCvP/X4G180T7JYYQMnT0pYEOeWgb4w==
X-Google-Smtp-Source: ABdhPJw2msgtXSyZIME4SO3mjysAF8G6wD7DZZ3ol+3Py2QBeTttGTQaa9iRCzwcs/Clj+PPwXQ4Fg==
X-Received: by 2002:adf:f209:: with SMTP id p9mr22048626wro.191.1636753747862;
        Fri, 12 Nov 2021 13:49:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/18] Makefile: don't set up "perl/build" rules under NO_PERL=Y
Date:   Fri, 12 Nov 2021 22:48:46 +0100
Message-Id: <patch-v2-02.18-138f60ba37b-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

