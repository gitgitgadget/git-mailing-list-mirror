Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5688C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJMPkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJMPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6D33848
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so3426830wrp.10
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eAw38ujllYqnB4Hl/yYsEVXfRHQBweaeZ33TaUPjtU=;
        b=GRKdXx5pE7SlfkcQONiDM77FvV4IrVUUg6RC/a1V2c7liZqqWNTLp1SBEXaYn1DSaC
         2o4edb3W+UQTx8MQ2rAyv8mZjtYdIjUbf0kxNknm4PyOu1vohAv54+s3mBDDzBL2wOPQ
         xvQs3sW4kz0cyzfokxz3fVMvzzBY4Fjd2FSJXJjjKL/a5UnxuHQKelVvphe2er7CMCwV
         8smaiiai/ZSnTZjGqo/vduluL+bz9fsDwHu1mwZZVh7UMztWMO7axpGlUhn+3Q2E7H5P
         1bO5hhc+GevdYlZ0Ut75X6mzXTbLwzt+TA89foUZ3MbNYoWmCxXm6dPKdsMX+8MbdDfP
         zh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eAw38ujllYqnB4Hl/yYsEVXfRHQBweaeZ33TaUPjtU=;
        b=JpgI7/7z/1k6SdDIekW9GXUOq3gXjFTdwWbEUtAOhkQVbSinETDbmmWjV8a7wqAbKE
         Y+aFLxNOFBNpwGP/ZamGtxrE5plJF675W2VAnU06DvPtzFKSkETe5UBkikifjBEMpCkC
         wkzLDl8pOnvyQGRd4vmFsW2ExORe3685flqdbnd+stvseZg/AcfgOPRUUjF8iJ4qYU5x
         TPdTTzrutFDbO3iQtZmNjXXbMNsifUGyowhysTEf3gFGixLoez/tzOcQCxrYznw4W7DD
         1GKlgMHxrn0NGhajZn4amZsqKELHqdk25CDuNWa8N52v5+goSYhyePsv0H10tZVGa6us
         p8+A==
X-Gm-Message-State: ACrzQf0YriopgXHICW14fM0htlE2csSbZMbvQ6dkPVWyzFT0ZJ9TzizE
        9RJ5v1chPVuk+e2/qjJchAFVMqMUeZhslA==
X-Google-Smtp-Source: AMsMyM7CHBLRcqhX6BaMz0YvbeWkNGvC6TFoug5ihKYv+er2QIEn3hdeCU9WtPmC6mU8BbSVKOmSEA==
X-Received: by 2002:a5d:64aa:0:b0:230:71e5:c540 with SMTP id m10-20020a5d64aa000000b0023071e5c540mr382720wrp.625.1665675592023;
        Thu, 13 Oct 2022 08:39:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 17/34] doc txt & -h consistency: add or fix optional "--" syntax
Date:   Thu, 13 Oct 2022 17:39:11 +0200
Message-Id: <patch-v5-17.34-a27ce91d9b3-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the "[--]" for those cases where the *.txt and -h were
inconsistent, or where we incorrectly stated in one but not the other
that the "--" was mandatory.

In the case of "rev-list" both sides were wrong, as we we don't
require one or more paths if "--" is used, e.g. this is OK:

	git rev-list HEAD --

That part of this change is not a "doc txt & -h consistency" change,
as we're changing both versions, doing so here makes both sides
consistent.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-rev-list.txt | 2 +-
 builtin/for-each-repo.c        | 2 +-
 builtin/rev-list.c             | 2 +-
 builtin/verify-pack.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 20bb8e82176..51029a22715 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,7 @@ git-rev-list - Lists commit objects in reverse chronological order
 SYNOPSIS
 --------
 [verse]
-'git rev-list' [<options>] <commit>... [[--] <path>...]
+'git rev-list' [<options>] <commit>... [--] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index c6379b783c8..d45d873f579 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 
 static const char * const for_each_repo_usage[] = {
-	N_("git for-each-repo --config=<config> <arguments>"),
+	N_("git for-each-repo --config=<config> [--] <arguments>"),
 	NULL
 };
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ada68a4af5e..3acd93f71e1 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 
 static const char rev_list_usage[] =
-"git rev-list [<options>] <commit>... [-- <path>...]\n"
+"git rev-list [<options>] <commit>... [--] [<path>...]\n"
 "\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index db9ac5c4606..27d6f75fd8a 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -56,7 +56,7 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 }
 
 static const char * const verify_pack_usage[] = {
-	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>.idx..."),
+	N_("git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx..."),
 	NULL
 };
 
-- 
2.38.0.1085.gb7e61c3016c

