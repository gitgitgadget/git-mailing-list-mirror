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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C70C48BE5
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC22161369
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhFVOXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFVOXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 10:23:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34457C061756
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so1887313wme.3
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fue2WtfXsyGV2IUFnwpUG3baMPEWktuB05WWVgppe60=;
        b=QXZH9Ct+3ZFP94ROPsDjvI4jAfyIthLg0Cq+nu/DQUYgSe5bg15AU6h4mSp19E2C4P
         gE4zQH2YlxgezkmC9zg0u6yspXx1NiFP8JxkW58yWk5e/P0BCH5MgmWMTnObD/0TvuPy
         ZEdJMokzvJJ7kER8p5idb8LxS6sjxbaJXFSF6yQGnEHdTa0ZQQpmJjbQ2qOAqRj19+PT
         /5a/K7N7mVxzP0C/1yddI//+nfwcqzlZWxLcVx6mh20dn4sF2BwcIeHtjI2G5ZRMxBxp
         DtHqaSgBXc5KH3OUoM2vqaukX8AZRIvbLqbWiH0DUTihJs0Zr/RMQDeLshn7IH2tUQ7f
         I7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fue2WtfXsyGV2IUFnwpUG3baMPEWktuB05WWVgppe60=;
        b=J1KsoqLU+1sG9sGfQ8ibFj8gRQ9UuiD9MxPxJYOgj+PMLmKGd0FxBCaQNKvP5i1gUU
         0FxfQAhuvozePydb6Ai1v0bdjqSUhfVKWmbAA8WDBB1RGaxzHKtVTSiqqMVgq8/PX3i5
         IzCW/rYpMJKQ9Tc6iMB/ejGd2Dot6RaY6wqSdVcLMkuimDnntFn5GQesEYuCTa5pN9te
         H99Q5qVxHtr4M+zO1BABriHBqjnCcT/y8lGGJPpEPiJsuDxSwz+qvibQ6zGRnSFknp/q
         IPZG7+SNsmesrsDUUC1KQ8A2Wxuv6WCG9GLnRMJHqmXRMplUEYw8tGg7llB7RSyhwCxz
         t1bw==
X-Gm-Message-State: AOAM530TL70+ENQlFC96EKF8D8b8XcIMbKmImdSnInSbFxmbdTvnEkkO
        DdmLFJO2bxxkyJlL8aF1EqYGkAgg/iTfRw==
X-Google-Smtp-Source: ABdhPJyVcQw9f/wAiZhoUBNE4iqIF+ds6hjFSW3i6zoL5TeBOdvdFNlE4DtKhuDT6bsbYmx8XBVGMA==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr4745831wme.130.1624371690623;
        Tue, 22 Jun 2021 07:21:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm22617395wre.84.2021.06.22.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:21:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] Makefile: fix "cscope" target to refer to cscope.out
Date:   Tue, 22 Jun 2021 16:21:26 +0200
Message-Id: <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cscope target added in a2a9150bf06 (makefile: Add a cscope target,
2007-10-06) has for some reason been referring to cscope* instead of
cscope.out. Let's generate the cscope.out file directly so we don't
need to speculate.

The "-fcscope.out" (note, no whitespace) argument is enabled by
default on my system's cscope 15.9, but let's provide it explicitly
for good measure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore | 2 +-
 Makefile   | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 311841f9bed..d74029c1ca7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -217,7 +217,7 @@
 /.vscode/
 /tags
 /TAGS
-/cscope*
+/cscope.out
 /compile_commands.json
 *.hcc
 *.obj
diff --git a/Makefile b/Makefile
index 4dd9711a653..25d2a3e5ddc 100644
--- a/Makefile
+++ b/Makefile
@@ -2737,10 +2737,11 @@ tags: FORCE
 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
+cscope.out:
+	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
+
 .PHONY: cscope
-cscope:
-	$(RM) cscope*
-	$(FIND_SOURCE_FILES) | xargs cscope -b
+cscope: cscope.out
 
 ### Detect prefix changes
 TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
@@ -3211,7 +3212,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope.out
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
2.32.0.599.g3967b4fa4ac

