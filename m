Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D5BC38142
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 05:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjASFgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjASFgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 00:36:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC0EBD
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 21:36:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so2813720wma.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 21:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M8xsWqTu2u9ePcWazTcHTaY1g6aichaSk9QKMSYvlzc=;
        b=BklFuUubPIZtQa+LcnQXcCZIRR2g0nMvmU7jbPZQkx3q23a2b4URsrfEPqBesDvocf
         X1ShMcCEUA4OgLBVQJazBd7IElN5it95PAbB6TLf9DUO2RwvxAO1xZyIA3UIaVD9hmNP
         Zr6ah5Vg/fUP7Uhp8Zu/b3QB5w73uOqnk1E4LBWahKCVit6Uiuko028Nfs8OaHtBq1sx
         1vdm65274zXK5z2OjZiV5bI8uFV5plHrqwTlDgbvSxqLX98JUYPZz5MJzT8d0M5Dcsc2
         wLSjJ0XMgD+gDQ6qY0LCtfgt8WSMHiMTDrwyw0CQZSu+S7UJtzjJNfctBNPki4RtNg8Z
         uNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8xsWqTu2u9ePcWazTcHTaY1g6aichaSk9QKMSYvlzc=;
        b=KRkEXh95xUSUjmtpmYskRf7iyq1XTDFhZCFnFrcginesbtV4IXlqlpnbeNPNr28u+A
         +pZVnBBYaoh7dlyWGjLApeXcyUkWq3hjt36ljMOgRFfwHP9BftuwHjSLk7pbnO4aFpH6
         79Pk++mJ9+bpZR2gpfLY2NQwRUaFtgZhbm2Q8g6GE3OEjVltFPYkBzxsvgOapvEHxcqg
         TvbxLZ+alMmQPs9dIEkE9dg9mmpo9WslvwYJXmLUP2nzcKCXIkKujs1hzAnSrWPaBt9R
         fzsDiALQmwJYI+nrefF7sM1ADmw0dUDi7J/F8Fw7RH2ky2hkJpTwN0jZQ4w9rV+00xma
         IrnQ==
X-Gm-Message-State: AFqh2ko9xG01g6TXiDjVsdGBRJKsJqEVs2UjTA5Y+TEipEmhvqdDHaUC
        /nENa97XoAOxNeIzFnr6br8CCK8/trY=
X-Google-Smtp-Source: AMrXdXtOSFZcv/7XHHqTwcb73LjJ1ASaepdAbpCeetoa5/dzIXiuG6FRSoDLslQAAB7wNsX9Ig/s3Q==
X-Received: by 2002:a05:600c:3ac8:b0:3da:f67c:aca6 with SMTP id d8-20020a05600c3ac800b003daf67caca6mr8931714wms.34.1674106588738;
        Wed, 18 Jan 2023 21:36:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05600c3d8c00b003d237d60318sm3803509wmb.2.2023.01.18.21.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:36:28 -0800 (PST)
Message-Id: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 05:36:27 +0000
Subject: [PATCH] rebase: mark --update-refs as requiring the merge backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--update-refs is built in terms of the sequencer, which requires the
merge backend.  It was already marked as incompatible with the apply
backend in the git-rebase manual, but the code didn't check for this
incompatibility and warn the user.  Check and warn now.

While at it, fix a typo in t3422...and fix some misleading wording (all
useful options other than --whitespace=fix have long since been
implemented in the merge backend).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    rebase: mark --update-refs as requiring the merge backend
    
    --update-refs is built in terms of the sequencer, which requires the
    merge backend. It was already marked as incompatible with the apply
    backend in the git-rebase manual, but the code didn't check for this
    incompatibility and warn the user. Check and warn now.
    
    While at it, fix a typo in t3422...and fix some misleading wording (all
    useful options other than --whitespace=fix have long since been
    implemented in the merge backend).
    
    Signed-off-by: Elijah Newren newren@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1466%2Fnewren%2Frebase-update-refs-imply-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1466/newren/rebase-update-refs-imply-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1466

 builtin/rebase.c                       |  3 +++
 t/t3422-rebase-incompatible-options.sh | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..accd62fce48 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1514,6 +1514,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.update_refs)
+		imply_merge(&options, "--update-refs");
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			imply_merge(&options, "--merge");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 6dabb05a2ad..5a00618d265 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -25,11 +25,11 @@ test_expect_success 'setup' '
 '
 
 #
-# Rebase has lots of useful options like --whitepsace=fix, which are
-# actually all built in terms of flags to git-am.  Since neither
-# --merge nor --interactive (nor any options that imply those two) use
-# git-am, using them together will result in flags like --whitespace=fix
-# being ignored.  Make sure rebase warns the user and aborts instead.
+# Rebase has a useful option, --whitespace=fix, which is actually
+# built in terms of flags to git-am.  Since neither --merge nor
+# --interactive (nor any options that imply those two) use git-am,
+# using them together will result in --whitespace=fix being ignored.
+# Make sure rebase warns the user and aborts instead.
 #
 
 test_rebase_am_only () {
@@ -60,6 +60,11 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --exec 'true' A
 	"
 
+	test_expect_success "$opt incompatible with --update-refs" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --update-refs A
+	"
+
 }
 
 test_rebase_am_only --whitespace=fix

base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
-- 
gitgitgadget
