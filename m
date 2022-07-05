Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA30CCA47B
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 14:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiGEOCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGEOBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA821805
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:47:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so17671680wrc.2
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtSB1zdS60cK5ZOvqMunjOcXQYoTKQzXENfK7w7qx7s=;
        b=bCQ1LawQnr/+qzGwfvU9+oWGxWxXporFPwi5w0cvrr6sOM5ofKzwEPOSsrLpZ+pZVc
         2OtoOIP36TP9X3Iak9kNBLrlxBR7Cm+5kSJHzh3aSjVw1NkstVOUFvfxWMjo9JuNVGMf
         KznX5x6soJPvieTCt+oMj9+rnXkRWCuICjacp19pfn/nM66m6BmevH8PWHV6hQx7nZFQ
         fFTiH4Gw2ltL2i63GYYlkCF19qK3+hCbbf30+vrjtqEnwsHdig0INQz4VpCYFPnVy1N7
         jjtmcSuqMf3GmvREtSpuqsBIDOIsCj6rLajiUmcFV5eZCUYnVThc5/tlXGoyCQy1Sck5
         QBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtSB1zdS60cK5ZOvqMunjOcXQYoTKQzXENfK7w7qx7s=;
        b=fdWBqszdA8jKWrE1LY3CoNonc/Y7U/iaw9M4CQlv/XZxgSpHQ+TfFgn0ZrU6kdiEF1
         vivE+IuzDzofb7DS+eX/Z+ATyf2JK677BtjJwV2+qIed3BiuBanOyqwKaDiFBKA40DGA
         Eoo+VWgziHIfNmTXz+Z6aYUQfV+Xh0kwSDy7xrqFnloAW9TQSLdwqtjP+xrISKGI12RV
         zBWrKrQCo2MJg1S5OqoFSr80LUKK5xRwJQzR0YWIxZgsPY1wImMUmq+2YZe7y+86TYQv
         wrPWmH6tJKzUxSBS76PKcgHtBoDJytUTHgs0XeemiQFmkDMh58b2luL6YYgPmRYHuWYU
         8WEA==
X-Gm-Message-State: AJIora/Kb5RFjLVUsIe9tZiRQWXJ5DGss/+LS0fbjqHIye/BbXd1D+vu
        2xfWi13ZCNYKwqtiEHSUzNgWYni3SCFGNg==
X-Google-Smtp-Source: AGRyM1voyW9BK46QV3MV7m4akR9C3itSFlyUS7YYZGg4KLoYtK/moTuseFr2LCaa1LFMjh7NYItUOQ==
X-Received: by 2002:a05:6000:2c6:b0:21b:ad25:9c1b with SMTP id o6-20020a05600002c600b0021bad259c1bmr33495750wry.391.1657028829355;
        Tue, 05 Jul 2022 06:47:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm40786942wro.54.2022.07.05.06.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:47:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/6] Makefile & .gitignore: ignore & clean "git.res", not "*.res"
Date:   Tue,  5 Jul 2022 15:46:56 +0200
Message-Id: <patch-v4-2.6-d7e85d4c4a6-20220705T134033Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g50625c3f077
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the overly broad .gitignore and "make clean" rule added in
ce39c2e04ce (Provide a Windows version resource for the git
executables., 2012-05-24).

For now this is merely a correctness fix, but needed because a
subsequent commit will want to check in *.res files elsewhere in the
tree, which we shouldn't have to "git add -f".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore | 2 +-
 Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index a4522157641..42fd7253b44 100644
--- a/.gitignore
+++ b/.gitignore
@@ -185,6 +185,7 @@
 /git-worktree
 /git-write-tree
 /git-core-*/?*
+/git.res
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
@@ -225,7 +226,6 @@
 *.hcc
 *.obj
 *.lib
-*.res
 *.sln
 *.sp
 *.suo
diff --git a/Makefile b/Makefile
index c1d02f04499..1ccf13595de 100644
--- a/Makefile
+++ b/Makefile
@@ -3409,7 +3409,7 @@ cocciclean:
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
 	$(RM) po/git.pot po/git-core.pot
-	$(RM) *.res
+	$(RM) git.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
-- 
2.37.0.913.g50625c3f077

