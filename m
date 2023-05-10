Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B66C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 21:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjEJVhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjEJVhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 17:37:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583D3A85
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6aaf52ff35bso4468517a34.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683754664; x=1686346664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYyJGzjoRZ/uu0tJQ7EXjIEHDeIgQCWUxmFSOXU9W2E=;
        b=ZrNsuSfsRIRUcAUVxXjpFClsJl/gDup/VOba8sivts7EyvTV85r3kpgYS/U/PG4hmA
         USND5EcR9fsiYJuT5Vw6FHVwssowclBhymk53Q1lmULhJMCR3HwrLqfzKGxwWg/iDzmw
         sGwtBGgclMF6aUdtLveeIh6BZBSoyFqx94hudqiLvpjDuG/YOTRAwy518mDfaNsle9QO
         1gtBOM/PlhuHtH5UMyYVFUY/vd93Xx3kGNiK91zEZgjNkjpF0ipHlrXOh2SsZBS8Jg1w
         gNKsTt+Iu2GZelFN7kvRH7u2L+Tr9ItbB6esVc5TFmkzZjzLRIjSNahA5hYCgfzYRlKm
         k3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754664; x=1686346664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYyJGzjoRZ/uu0tJQ7EXjIEHDeIgQCWUxmFSOXU9W2E=;
        b=XVU3kCPIRiaoOfKG+Tfm9MAGtDuL/XHil66jVz9uZG4ngrVnH2tU/wu+ZhAFmOBizM
         RMi4yA995x8MzUd77N2cVFdrfj7ezuqBUTraTtxjnfCgvZDl9nz/KOBX/DnLBLYA8H4i
         Ig/TtLOltWQ3dtGQKnQiwpzaSFJRAHD/9PIllDwd4SadxGPfZmNr4DTNEeFquhyJrI6W
         QgbmGpuxbI7Tc4R+ma2DFcQvgCzGBShRcaeZxo9z+cu4hshCGrsQ8/b+USi1NXE1NUXT
         lYrCin+hK3cIxiqsTRQ7SbPL+OLs9NaOTqdc7IRMZ9jW7c2vEBbWNHe7I+EadAq8SWGP
         BGPA==
X-Gm-Message-State: AC+VfDzwVXWDmbve6EpclXk5aIfYZhvWseCTd17Y0uGCoZMUunkd1ZRC
        FaJU4aCvRAK5t4h5dju+B/CkFpTjuic=
X-Google-Smtp-Source: ACHHUZ48qzgIdruHiH+IgHJk4/LDITxVP1HdUxQP0CSIef/D8g6gJRyt/6uAR8wos2y70cTH4tQCUw==
X-Received: by 2002:a9d:6d98:0:b0:6ab:1d86:e4a5 with SMTP id x24-20020a9d6d98000000b006ab1d86e4a5mr3562552otp.25.1683754664516;
        Wed, 10 May 2023 14:37:44 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dj8-20020a0568303a8800b006ab2af64f34sm1286093otb.13.2023.05.10.14.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:37:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/4] notes: fix merge.conflictstyle handling
Date:   Wed, 10 May 2023 15:37:37 -0600
Message-Id: <20230510213738.505241-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230510213738.505241-1-felipe.contreras@gmail.com>
References: <20230510213738.505241-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently it's completely ignored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/notes.c                    |  3 ++-
 t/t6440-config-conflict-markers.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d5788352b6..9a9044b50b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -28,6 +28,7 @@
 #include "notes-utils.h"
 #include "worktree.h"
 #include "write-or-die.h"
+#include "xdiff-interface.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
@@ -1020,7 +1021,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_xmerge_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 	if (!fn) {
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index cb2ee3ad0a..c51512ced6 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -55,4 +55,31 @@ test_expect_success 'merge-tree' '
 	)
 '
 
+test_expect_success 'notes' '
+	test_create_repo notes &&
+	(
+		test_commit initial &&
+
+		git -c core.notesRef=refs/notes/b notes add -m b initial &&
+
+		git update-ref refs/notes/r refs/notes/b &&
+		git -c core.notesRef=refs/notes/r notes add -f -m r initial &&
+
+		git update-ref refs/notes/l refs/notes/b &&
+		git config core.notesRef refs/notes/l &&
+		git notes add -f -m l initial &&
+
+		test_must_fail git notes merge r &&
+		! grep "^|||||||" .git/NOTES_MERGE_WORKTREE/* &&
+
+		git notes merge --abort &&
+		test_must_fail git -c merge.conflictstyle=diff3 notes merge r &&
+		grep "^|||||||" .git/NOTES_MERGE_WORKTREE/* &&
+
+		git notes merge --abort &&
+		test_must_fail git -c merge.conflictstyle=merge notes merge r &&
+		! grep "^|||||||" .git/NOTES_MERGE_WORKTREE/*
+	)
+'
+
 test_done
-- 
2.40.0+fc1

