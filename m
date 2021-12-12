Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8402DC433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhLLUOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:43 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:43933 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhLLUOh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:37 -0500
Received: by mail-wm1-f52.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so10344857wmc.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWXEchfQX0/NN0eLovtHyt+oyPVkpufR6b8LLsID7wI=;
        b=RDXgvAipD8llcPaVMZpHAfJQUq2BxEnwdMi7M/PU+Co2HaxTD/Fs+kHpXsCV/eDLbt
         OuIfcQ5rhVACCECFyedRxVHZxSYEHZv/zWlmkxU6QdOcEv9gmiE3SEgLsK/Vl1pNEv3w
         S8UANybtuoOXs3Utdl+iAFlawCCAjWRUFAYwTzDZB2e+KB6WezfivYfDJAQ6rFcnvqsy
         xcriK5dSpuMg0bZWb2d0qSN4N6GDibmSgyDFOixYjkv3KQwKVhBHZhl+Df4pP5HfpyI8
         lE6oy1hIlNv7hyCdAeH0gMUcAF5fr7KDvK7WltS0caZCJyyB0sPk410JJbvP3gn+803V
         p5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWXEchfQX0/NN0eLovtHyt+oyPVkpufR6b8LLsID7wI=;
        b=yM9kNK+BFxj9Br9BA+7CrO8wiWiufo8zlwdXDnYCY7wKLVvCps7LMJ/kY2m8wblaRJ
         QJHwEKmuvJ8gJ9Lahw9zvI0aVD5zFyHx0XE/8P7JOyK5r0iY2ZVJ7dCVTENLPZogjoi6
         AUD0xfmaMBY7MMrCoMiIIiDHqOU97H0p5FJx1fLjNV1gXpSr39DQU2NYHwcmyxA/AcPA
         2YClTq1+V6a9r7axol3d8hFjYDYRBCG0M5iLTcDsXLaxuKzmSYvfd2MwCak/M8P2onFJ
         VsMZ/SQ/j/Ht9KvBpkVgqn7gcG3XcJTjoxEhjF7kXzPz5YcRRKPQbCLtp7vCGHqJmw1D
         jQ4g==
X-Gm-Message-State: AOAM5316PN8zEgAlgLcbBL/e8sLx61qJSuXl6nQS/jdkgvkdcPYQjgdo
        VkY6sOCKviq7rqlJfItS130SButIyYYnSg==
X-Google-Smtp-Source: ABdhPJypXLtrEXBIBAjy+mEGX3BJUenKoxekZomuZOC1fnMScVRWhFzNsRlByFoxiYOYwuECenJVTA==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr32094072wmi.134.1639340015734;
        Sun, 12 Dec 2021 12:13:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Sun, 12 Dec 2021 21:13:13 +0100
Message-Id: <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the test suite has been taught to run without a
template directory, but in doing so we needed to fix code that relied
on the "hooks" and "branches" directories.

The "hooks" code was all specific to our own test suite. The
"branches" directory is intentionally created, but has been "slightly
deprecated" for a while, so it's not created when not using the
default template.

However "info" is different. Trying to omit its creation would lead to
a lot of test suite failures. Many of these we should arguably fix,
the common pattern being to add an exclude to "info/excludes".

But we've also grown a hard dependency on this directory within git
itself. Since 94c0956b609 (sparse-checkout: create builtin with 'list'
subcommand, 2019-11-21) released with v2.25.0 the "git
sparse-checkout" command has wanted to add exclusions to
"info/sparse-checkout". It didn't check or create the leading
directory, so if it's omitted the command will die.

Even if that behavior were fixed we'd be left with older versions of
"git" dying if that was attempted if they used a repository
initialized without a template.

So let's just bite the bullet and make the "info" directory mandatory,
and document it as such. Let's also note that in the documentation
that this doesn't apply to the "hooks" and "branches" directories.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitrepository-layout.txt | 17 ++++++++++++++++-
 builtin/init-db.c                      |  6 ++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 1a2ef4c1505..eb58ab08817 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -160,7 +160,10 @@ branches::
 	and not likely to be found in modern repositories. This
 	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/branches" will be used instead.
-
++
+This directory is created by the default linkgit:git-init[1]
+template. It will not be created when using a custom template that
+doesn't contain it.
 
 hooks::
 	Hooks are customization scripts used by various Git
@@ -171,6 +174,10 @@ hooks::
 	Read linkgit:githooks[5] for more details about
 	each hook. This directory is ignored if $GIT_COMMON_DIR is set
 	and "$GIT_COMMON_DIR/hooks" will be used instead.
++
+This directory is created by the default linkgit:git-init[1]
+template. It will not be created when using a custom template that
+doesn't contain it.
 
 common::
 	When multiple working trees are used, most of files in
@@ -190,6 +197,14 @@ info::
 	Additional information about the repository is recorded
 	in this directory. This directory is ignored if $GIT_COMMON_DIR
 	is set and "$GIT_COMMON_DIR/info" will be used instead.
++
+This directory is created by the default linkgit:git-init[1]
+template.
++
+It will be created even when when using a custom template that doesn't
+contain it. On older versions of git this was not the case, as various
+tools came to rely on its creation (including parts of git itself)
+it's now unconditionally (re-)created on 'git init'.
 
 info/refs::
 	This file helps dumb transports discover what refs are
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 3cf834eddd2..75495c9c8c6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -222,6 +222,12 @@ static int create_default_files(const char *original_git_dir,
 	struct strbuf err = STRBUF_INIT;
 	const char *work_tree = get_git_work_tree();
 
+	/*
+	 * We may not have a info/ if the template explicitly omitted
+	 * it.
+	 */
+	safe_create_dir(git_path("info"), 1);
+
 	/*
 	 * We must make sure command-line options continue to override any
 	 * values we might have just re-read from the config.
-- 
2.34.1.1020.gb1392dd1877

