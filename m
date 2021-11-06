Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1944FC433FE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0534F6103B
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhKFVGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbhKFVGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A312DC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u1so19494748wru.13
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTrpzzcbqmdFJEyqpG1brEtsXIKwGF/SUizQhryO6eQ=;
        b=m+NuisKcP4TzjFkaS1z9PT+6wjHhkHX89PXHWbY9qnZura8Q0VWXiAZ2Frp1u1qm8L
         LTfHuNhYDe1MzbZUgXdjatkKvUSeKw50Ajmzwl5RrvR8MYL/f/EhWvr4nXZnDxipp35n
         UaGF9FcHMaBcfJ+oUkz/frjIGxjc8EbAbDLQfzscv1JiwH7pCR+sghC2+80WRIg1ePAm
         IR1nHp7fnWkaq+0j3SDfMXTIFPoZg2vc2EFdW8YlRS2OBFKaSYA3PGAlVE0pJkSpR/Ks
         i6zRm8tf8kHVsVGLbjVIzq82GUH/wyFGHQbA33kFMKKvC1o8ZZNoNmlEisvFvZdXVa2b
         w6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTrpzzcbqmdFJEyqpG1brEtsXIKwGF/SUizQhryO6eQ=;
        b=0KgjeGtN2032LfLuyJAhXqut7DXpIHtSHKA7xoPQJD3dQxY/gDGAygTPQCLXpIXgvU
         Eg9ibe146yRh/AqyLB2YQbH/3nuWJ0vOMipuL2jUWGW2XBhmFmi28qI8p3GCj5FruId2
         5d/97lJEaplZlLxK0UO9xK9gFyLvC+4W/NjjqW9G7EI1MOJgfzNQj2dMlOgRaqkyFO8G
         D71tfoYhKyc8DipWSCp9NaBX2/QGh8ZXQgASSPo9LBz756ughn47EzAAyJne0QkW/4e1
         4jcPi9tObVCMEPl9oScp/5hgna0fB442TM1fSSocrUbVF+yNiIQkoEd6fAkwGNTzo2Jp
         0Pnw==
X-Gm-Message-State: AOAM532pa/I/USog9jdOJ2Hi2hwAxtmIYqiszXwszQ4192vf/oxPSXzm
        fjhXqiOxnXUQgk/f3loQQIL/08dtWvIwqQ==
X-Google-Smtp-Source: ABdhPJzdfhju2kAjvdgGr5b4pN7C7rKiujZX+ChIpMVeYzFSq8wthWoZcOZRu12bPSK1FfZ7jNk74Q==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr13842347wrt.93.1636232601894;
        Sat, 06 Nov 2021 14:03:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/16] Makefile: clean perl/build/ even with NO_PERL=Y
Date:   Sat,  6 Nov 2021 22:03:03 +0100
Message-Id: <patch-02.16-2d8049f792c-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 499c29394ce (Makefile: allow building without
perl, 2009-04-03) where we'd stop cleaning the perl/* directory
because NO_PERL was defined, thus leaving behind litter if the flag at
"clean" time didn't match that of build time.

In 499c29394ce this was done to avoid relying on the perl/Makefile.PL,
but since my 20d2a30f8ff (Makefile: replace perl/Makefile.PL with
simple make rules, 2017-12-10) we can clean things in that directory
unconditionally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9f57c34e954..82eb8ea446b 100644
--- a/Makefile
+++ b/Makefile
@@ -3234,6 +3234,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
+	$(RM) -r perl/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
@@ -3242,7 +3243,6 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
-- 
2.34.0.rc1.741.gab7bfd97031

