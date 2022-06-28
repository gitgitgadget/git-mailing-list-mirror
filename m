Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9956EC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbiF1KQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbiF1KQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DCE2FE6C
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v193-20020a1cacca000000b003a051f41541so902923wme.5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsm5GzcU0K00K+c7I8TX09L5t8i9W0aEj1bWo9m1fEk=;
        b=qUnCyCuZb7WQk41bgzJx17MN2f3AaSEN5f7VevPe2L/xlgzHzBWerjngLkeBzlPI+g
         fD6C2ec53l7KwyVPEPz2gPDKDzhc0p68Z2CMYlW4iLmNsg/NC9j5g9Y7zEW7FHN0ZjH5
         E+IT6srn6VusuDMWdHKAHIxGmUmrsZoQCij/4mlPY90s+JtfbhMit6kPDv/IBXQIP0Pd
         hMIpE7fe2NKo8rp8h+7XRQf2E5GUXqX33aH8vJazU/1ySEXN4zepHF1CSIZXI9yY0wge
         O4hVrA9vV7eoc6K7rBSG+r8+KIMEp6Xs4NwGHcPvQ0Ug39F/qmWN1lOiyGVcHfQ1d1vj
         9DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsm5GzcU0K00K+c7I8TX09L5t8i9W0aEj1bWo9m1fEk=;
        b=XWWEabZ4eMQy3jo6KXDmJ56HI5PjEW5c0/YOmxf2oqH8pXccIA9+/ern4pFGyBRtq2
         0wX6trZtRgNoevFb47qIF/WKOcCvGvI+LDjCmS7yNleim7zm/yEm9cC3LOnvFRb8321z
         zzsiebLXx2aej+Yedm1qoQlaXqK6NL9BXuc+njT/aA+stmzAv7/Six++kpC3hLHpG07s
         oDhlzNGDVQAiT6mNaX6RVWGWepKuksKIqY4y4hB8J99J6d3FUEwzg0J1LG08RZcg0S5c
         chJ1nW0TZybzJPB51+93Jxnxcg4wobjQB7ttMM+fe0ZHDF2a6rhAiM+8A9/oJ6bCC9t9
         CE3A==
X-Gm-Message-State: AJIora8Qi+iLhcfdToGjTgODnJTLwcexLdZ7tRViRcgHLeOcA6xQOQTC
        vYVkcHiTQjhs1DDdpzFPTe4jcHxsFfQUdw==
X-Google-Smtp-Source: AGRyM1uIonzNd7/PvPxMBb0Q8TpSn+HH4hpstjnn1coUuvy/5SKLLVpnJBxuSvRe4pWuDE5C1lUpxA==
X-Received: by 2002:a7b:c848:0:b0:3a0:3937:893 with SMTP id c8-20020a7bc848000000b003a039370893mr20451066wml.163.1656411374232;
        Tue, 28 Jun 2022 03:16:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/8] gitweb/Makefile: add a "NO_GITWEB" parameter
Date:   Tue, 28 Jun 2022 12:16:02 +0200
Message-Id: <patch-v3-8.8-0c8f26ee876-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From looking at the {Free,Net,Dragonfly}BSD packages for git[1]
they've been monkeypatching "gitweb" out of the Makefile, let's be
nicer and provide a NO_GITWEB=Y for their use.

For the "all" target this allows for optionally restoring what's been
the status quo before the preceding commit, but now we'll also behave
correctly on the subsequent "make install".

As before our installation of gitweb can be suppressed with
NO_PERL. For backwards compatibility the NO_PERL=Y flag by itself
still doesn't change whether or not we build gitweb, unlike the new
NO_GITWEB=Y flag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile        | 7 +++++++
 gitweb/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index d150be4dc32..92bea603394 100644
--- a/Makefile
+++ b/Makefile
@@ -309,6 +309,11 @@ include shared.mak
 # distributions that want to use their packaged versions of Perl
 # modules, instead of the fallbacks shipped with Git.
 #
+# Define NO_GITWEB if you do not want to build or install
+# 'gitweb'. Note that defining NO_PERL currently has the same effect
+# on not installing gitweb, but not on whether it's built in the
+# gitweb/ directory.
+#
 # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/python
 # but /usr/bin/python2.7 or /usr/bin/python3 on some platforms).
 #
@@ -3155,7 +3160,9 @@ include gitweb/Makefile
 
 .PHONY: gitweb
 gitweb: $(MAK_DIR_GITWEB_ALL)
+ifndef NO_GITWEB
 all:: gitweb
+endif
 
 ### Installation rules
 
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 66fceb9e94f..3b68ab2d672 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -130,9 +130,11 @@ install-gitweb: $(MAK_DIR_GITWEB_ALL)
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_FILES)) \
 		'$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+ifndef NO_GITWEB
 ifndef NO_PERL
 install: install-gitweb
 endif
+endif
 
 ### Cleaning rules
 
-- 
2.37.0.880.gf07d56b18ba

