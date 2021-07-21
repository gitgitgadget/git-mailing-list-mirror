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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13385C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67EB6108B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGUWmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhGUWmk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:42:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2177BC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t5so3852489wrw.12
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMg6bFmwh0KpGfP8NshiU4zHAM8oV0709HaA31wq56E=;
        b=V+HOC+ChiDlb/r2rn89TUkW/PlHYiY32IUF5mCqLW1USNYxwx+ekboYFgOFL6l/NeN
         wTDJMCqIJUmGdc3YkMud32CJKd7aq9BYJKFlZOmf5UXZFYKt/pth8SDqoVjqWdHo90L7
         aQORP0GnL9/XzupgCQPP0BC8EHSWXs4fw1uKIOiBKD8bRgdRBQy5k/+y3BA052Fq8ixG
         O6cwKPworeIx/DajMNdVWr9lb4Jk61w6XOkGM6FWXUB0g+kvvIW2W84nvMjOso16IyLt
         rTnNpowahoaFOxoSEwpfo53B/bWKX42Yfhczf3Ezp8Mxaoc/ICFMOXNU90fQTOnWPCnl
         viDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMg6bFmwh0KpGfP8NshiU4zHAM8oV0709HaA31wq56E=;
        b=poD7hos+gUIOj5hHKpg6PzlX1ibvrUeLPOiti9iBZvMG47Fz2hXrj2+9/8wMDxm/35
         5CN+e7KvVgUp3hjeilr39tyWx+ckJSHvqTr8lMFr2x5OYMTp9nqN4SW7uuLMjvA0bBZT
         wm+X3ycYerw0mUr9UVik6WHtbrDQ40p3bXQmWCUP8Kg9rQItgmQPhhL20tY8FvjQsZxA
         rHFExb/7j9N7agluUAUsosvPw5ecI+W+YpXjDTbd/Yai2gxLoe9+CX9yyp5c/OYVW1jD
         2kQZj5tXsRjLe3HoYEDpaIDi55HJtMTIWZlSVaOfSMzoDoTVNQGD65A/8XmKjwWFriWv
         pLBw==
X-Gm-Message-State: AOAM533xzKqWX+Muo+TRJL6dKJJGAb6NS1Sxv2hGZxp0oySEh5djOD4G
        ZYOUThqL9h0VXTiVyXC8bspa57YaIPKlaw==
X-Google-Smtp-Source: ABdhPJwfqj+YuuJ/CTm0lFpOVEVDlRTARgWbta3VxosRa+MDkCFtLsGWrohhrWblP2yaKXLN/+HgZQ==
X-Received: by 2002:a5d:5606:: with SMTP id l6mr44861112wrv.190.1626909794533;
        Wed, 21 Jul 2021 16:23:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v11sm27690260wrs.4.2021.07.21.16.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:23:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] Makefile: the "cscope" target always creates a "cscope.out"
Date:   Thu, 22 Jul 2021 01:23:05 +0200
Message-Id: <patch-4.5-f8d151f1f6a-20210721T231900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com> <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the "cscope" target was changed to be a phony
alias for the "cscope.out" target.

The cscope target was added in a2a9150bf06 (makefile: Add a cscope
target, 2007-10-06), and has always referred to cscope* instead of to
cscope.out.

As far as I can tell this ambiguity was never needed. The
"-fcscope.out" (note, no whitespace) argument is enabled by default,
but let's provide it explicitly for good measure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore | 2 +-
 Makefile   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index 18895d94ffa..730ff23b923 100644
--- a/Makefile
+++ b/Makefile
@@ -2752,8 +2752,8 @@ tags: $(FOUND_SOURCE_FILES)
 	mv tags+ tags
 
 cscope.out: $(FOUND_SOURCE_FILES)
-	$(QUIET_GEN)$(RM) cscope* && \
-	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
+	$(QUIET_GEN)$(RM) cscope.out && \
+	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
 
 .PHONY: cscope
 cscope: cscope.out
@@ -3230,7 +3230,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope.out
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
2.32.0.955.ge7c5360f7e7

