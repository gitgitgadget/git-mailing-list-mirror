Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6EAC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2687611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhJUUAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhJUUAW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8C3C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so1242338wrg.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkgBhVa/QV+2LehHk5YhU2YXM/roo0Wv2l/J6Q9XTbA=;
        b=eSPgZVmxq27TnlFy9aN5kIiHyYKDstM7b+U0ve/QqIUbtTeJC6YGpVjz4xxH4HJipX
         Zqkdx4bLXXM51QcEdmxEytcKqMeM2mMGQL+rIgPPPTH8kGfe2tySs0z300Gj/w1aQ/xK
         +IcmKJfbML6k9/qBlVKJRCmapE2LXxnN5ib3MoVjurAXV7qP3EQ1tIs6knCrNicFRFA5
         p1nxGNvq+lwoog0rLQMGUP/W5hzfmFkLQSQRtNvyc6zJv9qf2SaMU4uWYlSLZ/+85RSQ
         5F4qvIUUk5lGOLiNH9o31/blAw/y3U2O44xhNRdDJ1/9+7eN+IkFw43X7gqn3htEqeJg
         Kyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkgBhVa/QV+2LehHk5YhU2YXM/roo0Wv2l/J6Q9XTbA=;
        b=soESSQPYNAiF7CibLzALbZuAlKAl0HyEt9gqaoBFIbq8ZMVONbf71rLFQ/e8zeT7RS
         gPb+eExhRskQf3fjmnLDuiYrO0sVz1CszLSpJksDc37PHhRgQVPyUATYoDIQylVTz6Ba
         Ot09CKIM7WlyNUTrvnazjT9Ry6Pz3o0CWwe2ANn1XJusdNsjMjl9AzyN9dZ8280JbMN9
         bkLlY0THrhCWmcRWux9qzU79/pPqbwaN8LG8rpgIWeKTFiAuuFKfqEbKj1CsgiLAyLCC
         ZQbfAgfUeA8ghfZpOZEqBMZe2O4nbXe3cBRGlhPDAaRviYVFeYy+7GLmqXE89a7JXChX
         4cOA==
X-Gm-Message-State: AOAM530/to/n65oCTPYofem5NgGoIJc7OcO8EqAjQ/1YKKJfvZR4fNZH
        p/fcPaz0kIlp2zKsK6QDHIeo/jPQtutK0w==
X-Google-Smtp-Source: ABdhPJw3Yr884Whuzh4bpsujV2JebpevNYj2iQUzrgFY1DqxJt6T8E4B3X/BMcEm3JThdA/OAA0/EQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr9949236wrc.231.1634846284595;
        Thu, 21 Oct 2021 12:58:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40sm388765wms.10.2021.10.21.12.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] Makefile: remove $(NO_CURL) from $(SCRIPT_DEFINES)
Date:   Thu, 21 Oct 2021 21:57:57 +0200
Message-Id: <patch-3.6-04c45e191a9-20211021T195538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop including $(NO_CURL) in $(SCRIPT_DEFINES). The "@NO_CURL@"
replacement added in 6c5c62f3401 (Print an error if cloning a http
repo and NO_CURL is set, 2006-02-15) has not been referenced by
anything in-tree since 49eb8d39c78 (Remove contrib/examples/*,
2018-03-25).

That commit removed the reference from contrib/examples/*, but this
@@NO_CURL@@ hasn't been used since git-pull.sh was the primary entry
point for "git pull".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fdce392929b..50eba522f4e 100644
--- a/Makefile
+++ b/Makefile
@@ -2253,7 +2253,7 @@ hook-list.h: generate-hooklist.sh Documentation/githooks.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh >$@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
-	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
+	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
 	$(perllibdir_SQ)
 GIT-SCRIPT-DEFINES: FORCE
@@ -2268,7 +2268,6 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
-    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
-- 
2.33.1.1494.g88b39a443e1

