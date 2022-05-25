Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B17C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 20:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbiEYU5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiEYU5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 16:57:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49775A0D04
        for <git@vger.kernel.org>; Wed, 25 May 2022 13:56:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f21so30336085ejh.11
        for <git@vger.kernel.org>; Wed, 25 May 2022 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FoqTAz8lHBxmaFw+BrM8snYtQ/v4aTAPC4XzApZrm0Q=;
        b=h3DaWkBOuqKIqVoaJJqrXjXN+1cDVMYf4VrGXww+Zw6myaZY2YGWPejes/TlOay9MU
         b3Ya8LoR0bh4UxoCB9JLNcEEedrE/pQUjJyl537ew53tEqMYTXGpAb1o7uT2sUP5aq7H
         eKLNMAz3r8VCNUayJ4O3QFTen/t8gyvssZ7EGj7mGMAWmeZIjAns7p/yc3+7S9NvD4eD
         KRhZetVWTOtkGqrXaNV/b5v7p6dJzD+Ko7zhOqxtH30G3MpdUcqy3YGlv14pU4b2oqxg
         LFJ+Bt49X/JFvhM7uKoTz1l6hHCA+SrZqq4aJOBN05ycmJ24NtpaOdTj8v8o4l40bWtz
         dClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FoqTAz8lHBxmaFw+BrM8snYtQ/v4aTAPC4XzApZrm0Q=;
        b=WBgQP/aoBI2L9z/9oW+NSUqF6PCRz4rye65N+7IplIEVK9ZY7faEKDUu2qnVFkzr6O
         RZ9dTIqjR+qCZGEJVT3A+mgaTAJu9xW+OwBNqxHMM6kgGDpaHCt4QLFYLSV58v72dMwF
         bpbBdRNtuB9OKypO5vRwxcGi4JKzsiQv3QF/ORapmOP5PETLTGKI61KaUn1KW4FeEHjr
         XIptKhgaeCJ9EExjGE7e9f1rO8ZMNzH45u8e9GVcarEfU4+Eoe9QH9UwYO0yZbbciwGD
         kUy4Rmy44l6B3WRMyVS1cCUeXpMPxJcU+e6zcbmnJ94OIZf549BgL7wVZl+mHXWMOwJf
         G7AA==
X-Gm-Message-State: AOAM531zbYCh6U0R+UEUZu91QyEkk6zg9oe88XmdratzF+NkRaQ5o8DU
        5ObHC55R+oHRSQ6lrGaNEgXWLt4rGJ4=
X-Google-Smtp-Source: ABdhPJx5HqWADdsG9RBDQ8WaH+3qhsD1rJUVdfEJxbleVk9DrjOx2Djlqr420vej5jX/5UkV9Wo0dA==
X-Received: by 2002:a17:907:a0c8:b0:6f7:492e:e74c with SMTP id hw8-20020a170907a0c800b006f7492ee74cmr30169833ejc.670.1653512217746;
        Wed, 25 May 2022 13:56:57 -0700 (PDT)
Received: from buzz.local (84-236-78-147.pool.digikabel.hu. [84.236.78.147])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090651c200b006f3ef214e20sm8534274ejk.134.2022.05.25.13.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 13:56:56 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] Makefile: build 'gitweb' in the default target
Date:   Wed, 25 May 2022 22:56:51 +0200
Message-Id: <20220525205651.825669-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.36.1.427.gb7c35dfc0c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Makefile's default target used to build 'gitweb', though
indirectly: the 'all' target depended on 'git-instaweb', which in turn
depended on 'gitweb'.  Then e25c7cc146 (Makefile: drop dependency
between git-instaweb and gitweb, 2015-05-29) removed the latter
dependency, and for good reasons (quoting its commit message):

  "1. git-instaweb has no build-time dependency on gitweb; it
      is a run-time dependency

   2. gitweb is a directory that we want to recursively make
      in. As a result, its recipe is marked .PHONY, which
      causes "make" to rebuild git-instaweb every time it is
      run."

Since then a simple 'make' doesn't build 'gitweb'.

Luckily, installing 'gitweb' is not broken: although 'make install'
doesn't depend on the 'gitweb' target, it runs 'make -C gitweb
install' unconditionally, which does generate all the necessary files
for 'gitweb' and installs them.  However, if someone runs 'make &&
sudo make install', then those files in the 'gitweb' directory will be
generated and owned by root, which is not nice.

List 'gitweb' as a direct dependency of the default target, so a plain
'make' will build it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index f8bccfab5e..ee74892b33 100644
--- a/Makefile
+++ b/Makefile
@@ -2188,6 +2188,8 @@ ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
+all:: gitweb
+
 all::
 ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
-- 
2.36.1.427.gb7c35dfc0c

