Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48992C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2819B6054F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhIHFRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhIHFQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 01:16:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419BC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 22:15:52 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 17so1336068pgp.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BZkJi39hAhkcL9/EsGMdpjmstFnyJurrszdmhqp22w=;
        b=RhdlxJTktmQU+5EFBpR6655KR4thyEFssgn/qTNP8EKjCaORTKVgV6W5z+cpVHzAai
         wK53a90x02TsxRpWnY4N/7qnMyYZQf+HcsAo+lKPVjK0TfXhE+j2Pv/oKO5JfOgm8DYd
         Mi3AYGEcKiQKm4xRrZ8S+13aVDNF6je/Rn/sKbxGAfNQhR5n98eQU8dWHxeslmjy2w2u
         NVlVcWxCICn215sJ7NyjR+2ANcu5Rd1iR1Vts4S760xmhWKLdbL46O1dPaC5zF+V2pQF
         sMjQUvuxNHzH+lJ4fpnBqr5MbAaxK065s83JmzuXsAu/PufEoJPULFctV5wZuSaEcyzL
         9z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BZkJi39hAhkcL9/EsGMdpjmstFnyJurrszdmhqp22w=;
        b=qFUVqoze1bDyMb82woSW/sX7PMaTWDc/CRcbTZnGv61vv/aehVWH+Cl8fIhh3befgr
         yMD62gwMFhIB6PgA48oAWIC5wybCyT2ZXyeeYv49gPgL8snJR4idT76FBlNsOB6KmuhT
         nnYFAf+swCethNLs1CoGTzFKMyxB94wogDFLXBEo2S2+lGTntxHwX6clnGsztv1S1JZ+
         okSgzfpyJTcF32vcXKX7YLcY2vaEQ6qRbKTkO7khAiLJf6udR2XJD+TcspnPcz8c7Hrw
         ZMW/tgLQ+I/9tt1DhudJ2l2KIUFE4bYC6kw2kamfohIbBpP3XcmIgYK/+C8hbc48WvZl
         3g9w==
X-Gm-Message-State: AOAM531D2aEmkvOgol5rZtE49N12bn5teEG7iAcZmoHL0nnh/0Qzr203
        LlOBP2nlR/8FGg6r4vTAZroAa22J/IG5bA==
X-Google-Smtp-Source: ABdhPJyg943d6CsK3hRh6wULUjq/2hPlyTAtwpcjTWsvF3eXkZ1SSCVlJqYpTEit5exo4l3nuJq6xA==
X-Received: by 2002:a62:7594:0:b0:416:310f:d083 with SMTP id q142-20020a627594000000b00416310fd083mr1880651pfc.33.1631078151465;
        Tue, 07 Sep 2021 22:15:51 -0700 (PDT)
Received: from localhost.localdomain ([74.213.228.209])
        by smtp.gmail.com with ESMTPSA id s200sm745665pfs.89.2021.09.07.22.15.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:15:51 -0700 (PDT)
From:   Colin Curtis <colinpcurtis@gmail.com>
X-Google-Original-From: Colin Curtis <colinpcurtis826@ucla.edu>
To:     git@vger.kernel.org
Cc:     Colin Curtis <colinpcurtis@gmail.com>
Subject: [PATCH 2/2] add liconv link for makefile
Date:   Tue,  7 Sep 2021 22:13:40 -0700
Message-Id: <20210908051340.13332-3-colinpcurtis826@ucla.edu>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
References: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Colin Curtis <colinpcurtis@gmail.com>

---
 Makefile      | 8 ++++++--
 builtin/gud.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 379cd91a97..e1679cca47 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 # The default target of this Makefile is...
 all::
-
+OS := $(shell uname)
 # Define V=1 to have a more verbose compile.
 #
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
@@ -1514,7 +1514,11 @@ ifndef NO_ICONV
 		ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
 			ICONV_LINK += -lintl
 		endif
-		EXTLIBS += $(ICONV_LINK) /usr/local/Cellar/libiconv/1.16/lib/libiconv.dylib # -liconv
+		ifeq ($(OS),Darwin)
+			EXTLIBS += $(ICONV_LINK) /usr/local/Cellar/libiconv/1.16/lib/libiconv.dylib
+		else
+			EXTLIBS += $(ICONV_LINK) -liconv
+		endif
 	endif
 endif
 ifdef ICONV_OMITS_BOM
diff --git a/builtin/gud.c b/builtin/gud.c
index 04808a08f5..9a5a1e71ac 100644
--- a/builtin/gud.c
+++ b/builtin/gud.c
@@ -24,4 +24,4 @@ int cmd_gud(int argc, const char **argv, const char *prefix)
     }
     
     return 0;
-}
\ No newline at end of file
+}
-- 
2.30.1 (Apple Git-130)

