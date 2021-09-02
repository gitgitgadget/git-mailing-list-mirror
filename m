Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B5BC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 08:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DAB61051
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 08:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244653AbhIBI4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhIBI4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 04:56:12 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B0C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 01:55:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 4so698287qvp.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcpJ1fw/o+Qnk8x4AD4OCHA4XuheDyzse/9Ay5sOTYg=;
        b=pxwRb4U5INijkANlhRsstmb3/lH38wj8vzT0OqrVmW/XcTuhtjo0GmpYUdeb18h+Uk
         KQqrvMJfRYym3I5Jq3MgTjtphLWyfKrgm2y9EiRPEuR4f6c1pXMGnK/TYi0/izJyDF18
         Va/ac8woRLE09sWk9MexPtlfiiIUMF0S8Ub5Tu0uTiMNQ8wP+OFgjWbt6ypXJGgsMLyH
         bhBF81L1Sspe48p4qM5+8FDXInU4RM7EbW/YfJ092TKB2WcuAeOl77hVKz9/9NJlYI5k
         0biCNiBYSY931nN50jNGek6l/G0FGCpAvuwdyzlXNArVfcysPWnuPbrNr8x1L15CFMTe
         0Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcpJ1fw/o+Qnk8x4AD4OCHA4XuheDyzse/9Ay5sOTYg=;
        b=lXHWRt3XdS1+zLrCxgDDoO+1FOnSNvgN53gaE3h29Uk34+glGLRZpA5X0E2r9IJzSJ
         QNuQOoODJ0OgO8W4UTfuu1l93xBOz30Cjo3GXsZT/VIv5vWp9sKJgoQTHHNnAfQOOgm6
         5X6ksHMnrzZcW93qki61Cb6mtxKKj8xswNDW6TVRdkV/mQ19pb8+NSTobjYOAseZsVdk
         ID7HS1SNcg84OErCezGaXEwF4Dwm84ghb1zrfOlpCsP1geEAgDT/M0B6IRlSnLoS7715
         GQyJvhodnxorlgzH+nMV1kw3ZjkZ7LMCJGOqcvDYyYOoEDWY8fs3BnR+T9TmyBQ21Dj3
         yuIA==
X-Gm-Message-State: AOAM532HfVF1SGovtHFG0sxL+QyPoYrDJ/QVrt1iIZ8XJqErXLnr2dnx
        RqM9P+WpYo4UvDWEDJh16SAibjazthU=
X-Google-Smtp-Source: ABdhPJycxD2z53aU1FiBfJJ3czZmoElH55AeetQYNk4SYRr6hx1fbAalKeLbO8tnWkpR3ADQzX1znQ==
X-Received: by 2002:a05:6214:332:: with SMTP id j18mr1809963qvu.12.1630572913695;
        Thu, 02 Sep 2021 01:55:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id d6sm927452qkn.119.2021.09.02.01.55.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 01:55:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] makefile: teach git about NO_MSGFMT (as supported in GUI and gitk)
Date:   Thu,  2 Sep 2021 01:54:38 -0700
Message-Id: <20210902085438.54121-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NO_MSGFMT can be used to indicate there is no msgfmt available, so
make git recognize that and avoid failing to build while trying to
generate i18n files.

while at it, refactor the change introduced in 4348824059
(artifacts-tar: respect NO_GETTEXT, 2021-07-04) with something as
functional but shorter.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 9573190f1d..9f09a75801 100644
--- a/Makefile
+++ b/Makefile
@@ -86,6 +86,8 @@ all::
 # Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
 # need -lintl when linking.
 #
+# Define NO_MSGFMT if you don't have msgfmt
+#
 # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
 # doesn't support GNU extensions like --check and --statistics
 #
@@ -2691,10 +2693,8 @@ po/git.pot: $(GENERATED_H) FORCE
 .PHONY: pot
 pot: po/git.pot
 
-ifdef NO_GETTEXT
-POFILES :=
-MOFILES :=
-else
+ifndef NO_MSGFMT
+ifndef NO_GETTEXT
 POFILES := $(wildcard po/*.po)
 MOFILES := $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(POFILES))
 
@@ -2703,6 +2703,7 @@ endif
 
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+endif
 
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
-- 
2.33.0.481.g26d3bed244

