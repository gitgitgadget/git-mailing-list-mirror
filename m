Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15402C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0CB60F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhKFVGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhKFVGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0471C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t30so19490231wra.10
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOKbk+Fwdn2H/NR/X8rknCL+mpmc623CWMMV/0KheV0=;
        b=Ac9FzRVJwnpphUCSCg1ZBxc39/R6kT8fUCv1jONXKqgxexp4s6fGOG09YDcgRXvIJG
         a0cysaiuEvZ1jPV5Nqrc3JNA2FPVsXDsCmQJ6f19J9WYJbSr4gIwVs8JZ6jWgKCOlW18
         iv0a6LCg5CvCdkEAstU3zu+EUQSERO8Z3qNPKfe/PzrHAunGncnDpmAUmrGeXHrNBel9
         GzQjimHA0WahLxZx+I/YAqGcNcmbMO3CpKNph7AaOj946zRPuGQGln124glFYY04tLpO
         8IAHrYBU1nLy9JLD9uuMHVj8La4ljjFEYbJYMdtJmMp2M4GdeFIvGVKdHYoKsjabTyBw
         1GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOKbk+Fwdn2H/NR/X8rknCL+mpmc623CWMMV/0KheV0=;
        b=la1wPF57lh9ghoThIoYHv7mx9VJmNVqWddExw2Mry8xAGeD0oipSQYWzi55D4qaUmM
         sa+vWkjnoO+R9bLcDjrJ6UGsQWgyBHd1anl4ujF0QQDB+lSo/MqEG40dBGRcL0TDndoZ
         nkc29UI61dF2nX/APX5aoGmFEHlM8zD1tOb+pBloAJIHLjSeLcrsGkx8jSn3sJ+aMbwR
         jjgthK+bTJ5ZABWUZ/tUUqqChq0ljIqC1PWY5j2l9aSm07vznmb534T+8Yq3EJvari8t
         N40B4bXWIiEzFhS53RWha66uk0xHeRbZLd1z66yZP7B8IU8T4QQlz4DGkCL3GuOOWWTq
         RpOw==
X-Gm-Message-State: AOAM532sMaA+m2hjzqRxmr+ffVJWp4zDTVS7dwBh+903gVG4J4cFPynn
        HOVZk7gBJa5zdRAafNA9bl6qBR2TovlnAQ==
X-Google-Smtp-Source: ABdhPJyc2EZVmcc4wHJosFQ1BEIJ2NaOZkJACyBuRmNT4r6tkCj33YfyvKnctkN/NaezdQ6Wld9LAQ==
X-Received: by 2002:adf:a143:: with SMTP id r3mr85707289wrr.8.1636232601115;
        Sat, 06 Nov 2021 14:03:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/16] Makefile: don't set up "perl/build" rules under NO_PERL=Y
Date:   Sat,  6 Nov 2021 22:03:02 +0100
Message-Id: <patch-01.16-56acc94dfe7-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
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
index d56c0e4aadc..9f57c34e954 100644
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
2.34.0.rc1.741.gab7bfd97031

