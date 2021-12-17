Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6463AC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhLQA0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhLQA0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DAC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q16so952613wrg.7
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14TeSsPSwK6WnWQ0jefPEVSxtywt7qvtv19j4Dyuw5c=;
        b=K49XfGCYdHiveBtRSmwNSeVN1fqmnagapLxd6bb+JgZMfgeBX6P7gTAibAl2P4QiGe
         p22YRf23hTsoQbiv6PqJcIc+DtZcYiB1wLlM5CjRrISrfYqzd0auWsU3/ach53+ImDmZ
         eMlR0pfwfBTlr35T/mqnBH2q5NqyKMkHz5P0dgwRrMUP0WLlX5mLGjOL7pdo5xBqgLll
         hIENg0ktJ2rGA/3+tqiSpbE4jl9y0VRvUpuRTFCs1b2GfTEt8DImdx0FAqbJQh7pAP/4
         St5TYoy78vGX0o/P0DHp6FBiU1GtKE0yP+4aSEQJ2vrnF5bUzOAa8eqa54Y975PCYilj
         Op/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14TeSsPSwK6WnWQ0jefPEVSxtywt7qvtv19j4Dyuw5c=;
        b=dyHlqPoOgZmV68z5EHaVJodptc717h8nO5doJ/eAvL+C38qj0Ovu6bdJbT9q+bLHig
         FigH2JB0TsGGqZITKqoeme5Yz1bQTk4IUCBASEw1dVzy7/DRyhlezpVLrErOsAGyFgNm
         hAZj1/8Rm4YPfY1nv3lfpoHBf0iA+z4Yu19KyDxa5peBc1CTY48n7NSJ9w97z3hWhI6q
         F53QQhZ00w20Wsy3B+746j0sgFLN7WhqSPJUIwHfa8rPdV7CN7QbiMRjqOJWobODVinQ
         TWrfFlI2pacbX204fTdxtxMh932Q/jKrydxtjGhqeZVfgwjYIB+UXAbDugQXUzJLKeWD
         im4g==
X-Gm-Message-State: AOAM533cFXdfeSZjtXqCCrczaELiZJOnScTPKcQYQhxCRnDl7EpLWe14
        BAtpewJTb1efBVw/pyd/TYDUEeqxYLUPfw==
X-Google-Smtp-Source: ABdhPJxdgF/NRkuZnb2NLDA+WkeGsSUS7i3uaFMO7Xj0GCfQFIZ6Z3dMeUlc96qfBZIYxyYxQAigVw==
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr359739wrt.618.1639700797549;
        Thu, 16 Dec 2021 16:26:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:37 -0800 (PST)
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
Subject: [PATCH 07/11] Makefile: adjust Perl-related comments & whitespace
Date:   Fri, 17 Dec 2021 01:26:23 +0100
Message-Id: <patch-07.11-4eeef8571aa-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
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
index 4bb2da36e4e..d488a723b79 100644
--- a/Makefile
+++ b/Makefile
@@ -2322,21 +2322,19 @@ PERL_DEFINES += $(perllibdir_SQ)
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
@@ -2349,7 +2347,6 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
-PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
 GIT-PERL-DEFINES: FORCE
 	@FLAGS='$(PERL_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-- 
2.34.1.1119.g7a3fc8778ee

