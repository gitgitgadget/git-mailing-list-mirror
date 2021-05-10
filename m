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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82DBC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A588E611F0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhEJLNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhEJK6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 06:58:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62BCC034603
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f24so23793342ejc.6
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgoikah04bhcAWVfHm5KgAowajJiW395o240CmNPoE0=;
        b=smfPUureXqaz4rALlaLWrViYnoX88+f9uRRV4q84a5R7J1YE2lK8lDmuWPRhniOIdD
         ajYAp2Qlhai9wfUXiQUssAu1Wwck665pKPnNecgPT6ARM9qBpao2tq9IUMgTfrCiiCaO
         RdQ8tgWlAAYZT4RMEGUfu62/w+CGnEiQGHSQ6lcnYD67n6ek/tmPyvg/fjEHtZAa0lNe
         BOx/GNWl8HnWyQKJmJnx9nqm/qbdWg+S5wVL5hrhUmpKg9xfFjp3K7NIQHOKBamG9ymc
         Fwa6Zw03oWOX4yhW2IncoOn8oAOvj2MYZt2DKouC94vUHlaN3OzcH5aGieAi+mOLIoii
         ym+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgoikah04bhcAWVfHm5KgAowajJiW395o240CmNPoE0=;
        b=dgg9d3dkgZ15WdHDi/m3sM8kf3Rf7fLijbL6jnth9MXxhhMCCBsfdw8VGpNhToV66h
         w2l7w9A4WZfWWIZI4bBioOJy8qKRHb4w5zlIO7DtjMNJW/DkaHd1q6IaTl+kwrVILt2n
         AoyqRD3A1iUWldAFiDaSS0WTReOOovvFM/FPPNHxbZiOXE/HxctSM+kcMYMgWiT0mD4T
         o0LjbyIgk1c4yuQaY5/Rr4nJwpzD1g7iH8es6xFT75Q2bCqrBZfcTWvFWtiExBZ8LuA4
         w9Aj/qWXN0hawTlXYEjZRtbCuGm3/iKgrxoPmUSrITHd5jRY7fmvCnd7SZvnuxd6KuEq
         7dBg==
X-Gm-Message-State: AOAM5330XLn3Ejk6Yjhh5q0mJZaVu8NWbdwexdVCVlA5er3BEXDJoBbt
        FJeQanvrgtpFmK02yQ6+gD0vUzQEYn1mzw==
X-Google-Smtp-Source: ABdhPJw3tc/PUINFHSH9vJY2G57Ok48QQ20DUNpcEWAFK7e9rwRK1YMrK/PB/qgs3CBO4aRpkXAb3g==
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr24892099ejc.268.1620643832486;
        Mon, 10 May 2021 03:50:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm9050741ejx.86.2021.05.10.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:50:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] perl: use mock i18n functions under NO_GETTEXT=Y
Date:   Mon, 10 May 2021 12:50:22 +0200
Message-Id: <patch-6.6-7a5e7cf39a5-20210510T104937Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com> <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the logic of the i18n functions I added in 5e9637c6297 (i18n:
add infrastructure for translating Git with gettext, 2011-11-18) to
use pass-through functions when NO_GETTEXT is defined.

This speeds up the compilation time of commands that use this library
when NO_GETTEXT=Y is in effect. Loading it and POSIX.pm is around 20ms
on my machine, whereas it takes 2ms to just instantiate perl itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile         |  3 +++
 perl/Git/I18N.pm | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index aaa972c56aa..0705fc2d3fb 100644
--- a/Makefile
+++ b/Makefile
@@ -1986,6 +1986,7 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+NO_GETTEXT_SQ = $(subst ','\'',$(NO_GETTEXT))
 bindir_SQ = $(subst ','\'',$(bindir))
 bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_SQ = $(subst ','\'',$(mandir))
@@ -2276,6 +2277,7 @@ PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
 PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
+PERL_DEFINES += $(NO_GETTEXT)
 
 # Support Perl runtime prefix. In this mode, a different header is installed
 # into Perl scripts.
@@ -2680,6 +2682,7 @@ endif
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
+	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
 	< $< > $@
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 2037f387c89..895e759c57a 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -16,9 +16,19 @@ BEGIN
 our @EXPORT = qw(__ __n N__);
 our @EXPORT_OK = @EXPORT;
 
+# See Git::LoadCPAN's NO_PERL_CPAN_FALLBACKS_STR for a description of
+# this "'@@' [...] '@@'" pattern.
+use constant NO_GETTEXT_STR => '@@' . 'NO_GETTEXT' . '@@';
+use constant NO_GETTEXT => (
+	q[@@NO_GETTEXT@@] ne ''
+	and
+	q[@@NO_GETTEXT@@] ne NO_GETTEXT_STR
+);
+
 sub __bootstrap_locale_messages {
 	our $TEXTDOMAIN = 'git';
 	our $TEXTDOMAINDIR ||= $ENV{GIT_TEXTDOMAINDIR} || '@@LOCALEDIR@@';
+	die "NO_GETTEXT=" . NO_GETTEXT_STR if NO_GETTEXT;
 
 	require POSIX;
 	POSIX->import(qw(setlocale));
-- 
2.31.1.838.g924d365b763

