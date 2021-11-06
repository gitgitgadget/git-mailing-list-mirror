Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D8C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1FE60F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhKFVGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhKFVGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B6C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d3so19497210wrh.8
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IP0gmKCUT+hz821e5QaWgKFLqjAhFdPxL9uFRDSjQk=;
        b=aez6gfXZhRt8/Gcs8gFKZGUud96S8YwQMXS3ulDZLa9fgJiKP+njyYaJIHBXZJ6Twu
         WpRIl8jcOW/3QpQcpjVqlWDnBRjLqEkCcrNtJs+7oI2H05f5Ph9Cpjsk0zQqp9yc11JB
         MWDAMv+Be4ghv8+y7pFr8OLcFoETssgFdtJ8AWqJ7ffg7nHEJaesTxtzbrQWKgJNgYmV
         58GTzviHpzrO+1gunxsNCe4zVnpvamZeSHKmZXseUPq1mnweqbPeAcB8/3rJHKlPGlge
         pM1rUZofo6BjkR7aXghaAwFtlork/4wD8tMw7KUZxWo9fR3XQl9mMIz9nWwh37KhLaQd
         aPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IP0gmKCUT+hz821e5QaWgKFLqjAhFdPxL9uFRDSjQk=;
        b=n0HnV+S8ev0Vzrris3EBwL+p/9RzptOLmROa/xk0NRhOtAmUmw0mFA7T8TogQzlIjA
         s8aqfZpTI3hq/pwcIECvLc0jK1Uwsa5R+Je6L78OtbPmQB0fHJUERzJ/zVR+3FJ1rN5f
         iePAAm5UmW7DIfHziCNe35Ug3Z7dSjt5K9hYzp4b9WPIR+EmouSDZdUU/LpiqMd7UBT5
         IBzeMPxoRh+VvvnmnidzTBZjfhLbHZeU0JyQrw08lmFPAP8eaL+IOQ73zErNl1r7w34j
         v2iek2YkO9AmAboD7LBI1X/25Ira8dr8KqGXzd96h9qi2vO7EZelrpe+x8opVdfvgn8w
         HuQA==
X-Gm-Message-State: AOAM53001NKcWG16tqJ3353Sx+a49olBTTDKcLBegAvDvvv2nZLzagYb
        ChAkNOCT/SsBlg7WxlY3HG+6ARyFqUJSKg==
X-Google-Smtp-Source: ABdhPJybHyvkinkdVYSNpLsdWQ3EHjYoQSbJSbAM/EYu7U121x2anfQQ3XHxoij/T+Dk7mkLsU+4mw==
X-Received: by 2002:a05:6000:1868:: with SMTP id d8mr48581286wri.285.1636232604314;
        Sat, 06 Nov 2021 14:03:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/16] Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
Date:   Sat,  6 Nov 2021 22:03:06 +0100
Message-Id: <patch-05.16-d8e14cb723d-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix several small issues with the dependency graph of the generated
"GIT-PERL-DEFINES" and "GIT-PERL-HEADER" files:

1. Folllow-up my 4070c9e09fc (Makefile: don't re-define PERL_DEFINES,
   2021-05-05) and move the rest of the assignments to PERL_DEFINES to
   one place, and change it from depending on "localedir_relative_SQ"
   instead of "localedir".

   The former is what we'll actually use, and while it's unlikely to
   matter in practice (we'd just skip re-building these under
   RUNTIME_PREFIX if the relative path was the same) it makes it
   clearer what's going on here by bringing us to a 1=1 mapping of
   these variables and what's subsequently used in the
   "GIT-PERL-DEFINES", "GIT-PERL-HEADER" and "perl/build/lib/%.pm"
   rules below.

2. We don't need the substitution of " " for ":" added in
   07d90eadb50 (Makefile: add Perl runtime prefix support, 2018-04-10),
   let's drop it. This doesn't matter for the correctness of these files,
   but makes it clear  that (unlike GIT-BUILD-OPTIONS) they are not

3. Don't have "GIT-PERL-HEADER" depend on the "Makefile". That was a
   lazy way to over-declare the dependencies added in
   f6a0ad4be71 (Makefile: generate Perl header from template file,
   2018-04-10), now that our dependency graph is correct we can be
   confident in dropping it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index fd4fe6c1045..181dc52f152 100644
--- a/Makefile
+++ b/Makefile
@@ -2293,6 +2293,9 @@ $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
 ifndef NO_PERL
 PERL_DEFINES =
+PERL_DEFINES += $(gitexecdir_relative_SQ)
+PERL_DEFINES += $(perllibdir_relative_SQ)
+PERL_DEFINES += $(localedir_relative_SQ)
 PERL_DEFINES += $(PERL_PATH_SQ)
 PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
 PERL_DEFINES += $(perllibdir_SQ)
@@ -2311,8 +2314,6 @@ else
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 endif
 
-PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
-
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN) \
 	sed -e '1{' \
@@ -2325,7 +2326,6 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
-PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
 GIT-PERL-DEFINES: FORCE
 	@FLAGS='$(PERL_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
@@ -2333,7 +2333,7 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
-GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
+GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES
 	$(QUIET_GEN) \
 	INSTLIBDIR='$(perllibdir_SQ)' && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
-- 
2.34.0.rc1.741.gab7bfd97031

