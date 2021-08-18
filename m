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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A3C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7622A610A6
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhHRVgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhHRVgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 17:36:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9221C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 14:36:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lo4so8026024ejb.7
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbxgvQZ8s3OeVElupkCephnykyG0997ezByfytER2fE=;
        b=MceGSooJlQ1U3fA8KD6DAExysBDAO/rLC+P1dzxBxenNVO+/zkOC6p2/6fJnvxkP2q
         rv3hFEC2leiRAXMxah3S7nWuep3N7KfTqFoQyg6Kgx/k2Op+Bcs8zr3/rYxV/cg58oe9
         LpTyTHDYfAjICNWfqXKQEmiox6xDxWP1w7922zRWhbvOejSpvSvP8febdqFYesk57Hcm
         CL350CBd01SfxnltKsJJ4zvGq4GqARLm/fQ0iQ9RsHj48AvrBYGSAXHf8h6l91WkHlwT
         7PXaif+vF3QKgO9UH0bEP1p6qZ6Ooy8ijGbtDg290sbunsybhDm6nNTG25ccawWEsgYG
         vtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbxgvQZ8s3OeVElupkCephnykyG0997ezByfytER2fE=;
        b=tJIdeK4HMZwR9gWPgQcrXwTgC2u7zgMMo1iDNfjjszBp1dMnTOJNvAF0di8ovobZRe
         SrfcWUeWLOiuefow8P8WSIfP8HBXgNIGlOpGlYDqX1VHUmKek+c+KsWg0n15hhGZIY2n
         Hb08/3rLvgWYziPcAoVHNaTVt7PA8IC+iIyHJKB12vlIvz16jY2IxNbeUWBQx6SdMIlg
         tpwlCm1w2o1bJ5j2HCOcOxIZHMayzr6a5tWGHS3N6byN1DVXTkog6WUPl0hWvLTdDvlx
         SMp9I2YilF/LfiVspHmqC7hq7qVnR+HRVJiC51uyboweJ2yJZAkZB+wGrNuYnGUqkmAu
         DKlw==
X-Gm-Message-State: AOAM531VQBDkpKNtfpM+1hMTtcx7EpU6one1SRfXYChrE14Z6WtakVQS
        E0PR3aiSiDMenicd6wzU1mytMJRwgQE=
X-Google-Smtp-Source: ABdhPJzNmAMKpOEmT6FfTdq4csc4Gi7XRUUN7B9SK9Cb1CDSYDvdh712XaU0U54p4nfKRdO26a9CEg==
X-Received: by 2002:a17:906:a195:: with SMTP id s21mr11813120ejy.181.1629322576554;
        Wed, 18 Aug 2021 14:36:16 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id m6sm678054edq.22.2021.08.18.14.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:36:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] Makefile: remove archives before manipulating them with 'ar'
Date:   Wed, 18 Aug 2021 23:36:11 +0200
Message-Id: <20210818213611.3658076-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
In-Reply-To: <patch-1.1-2557117855-20210629T084356Z-avarab@gmail.com>
References: <patch-1.1-2557117855-20210629T084356Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rules creating the $(LIB_FILE) and $(XDIFF_LIB) archives used to
be:

  $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^

until commit 7b76d6bf22 (Makefile: add and use the ".DELETE_ON_ERROR"
flag, 2021-06-29) removed the '$(RM) $@' part, claiming that "we can
rely on the "c" (create) being present in ARFLAGS", and (I presume)
assuming that it means that the named archive is created from scratch.

Unfortunately, that's not what the 'c' flag does, it merely "Suppress
the diagnostic message that is written to standard error by default
when the archive is created" [1].  Consequently, all object files that
are already present in an existing archive and are not replaced will
remain there.  This leads to linker errors in back-to-back builds of
different revisions without a 'make clean' between them if source
files going into these archives are renamed in between:

  # The last commit renaming files that go into 'libgit.a':
  # bc62692757 (hash-lookup: rename from sha1-lookup, 2020-12-31)
  #  sha1-lookup.c => hash-lookup.c | 14 +++++++-------
  #  sha1-lookup.h => hash-lookup.h | 12 ++++++------
  $ git checkout bc62692757^
  HEAD is now at 7a7d992d0d sha1-lookup: rename `sha1_pos()` as `hash_pos()`
  $ make
  [...]
  $ git checkout 7b76d6bf22
  HEAD is now at 7b76d6bf22 Makefile: add and use the ".DELETE_ON_ERROR" flag
  $ make
  [...]
      AR libgit.a
      LINK git
  /usr/bin/ld: libgit.a(hash-lookup.o): in function `bsearch_hash':
  /home/szeder/src/git/hash-lookup.c:105: multiple definition of `bsearch_hash'; libgit.a(sha1-lookup.o):/home/szeder/src/git/sha1-lookup.c:105: first defined here
  collect2: error: ld returned 1 exit status
  make: *** [Makefile:2213: git] Error 1

Restore the original make rules to first remove $(LIB_FILE) and
$(XDIFF_LIB) and then create them from scratch to avoid these build
errors.

[1] Quoting POSIX at:
    https://pubs.opengroup.org/onlinepubs/9699919799/utilities/ar.html

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 157293b555..20a0fe6e88 100644
--- a/Makefile
+++ b/Makefile
@@ -2594,10 +2594,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
-- 
2.33.0.453.gc5e41af357

