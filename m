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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9836C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901A3613FE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhFITa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhFITaz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:30:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBD5C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 12:29:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso25021227otl.13
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHUHK/+rUCSTcHlOqlRpTvL/q7u/Iltm42HOujgH5Jw=;
        b=DZimDWBqhmXk/jdUbvC861qHsWNrHE1O0aPVzjReUr/btysP23FuojE7JtGiLUnPCx
         vax3iA5GAxA8bxRsSi6oIqj+wO7jZ1ldhwo2Ks4NxEzacnfP3Cs7UYxFHDhAmgY0s66H
         AtdNXcM6p1c37LcCbYggMnOiHe8zZG69THFZf8bE5kC8J4dLpGqfx1yxWHhoAMzwys2E
         tDoPKO0vc79CrNNycguFX6v4FOG0U3avGZihgqo9967u3diG9IiHHzZQR82hLEBR6owf
         0FahExYVkn6LlYfxpqbbWFtZzBFPloEKDz7wc7NE310Y/c0QXvkbZWdy9VdyjBjnykDQ
         DrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHUHK/+rUCSTcHlOqlRpTvL/q7u/Iltm42HOujgH5Jw=;
        b=mNQ2BEvvGGQxb9RTyInTstJP0NlqZlLi6qaiFT7ZdZFJePn5hnCsu+ibYSjo8HTxPu
         7QDCkLtOnMEiZEPED5nbUnqFgzGtUlTXZAFvGFZni0O/LzK3yb1lMvw+L14pIIctHUkG
         LOdgvzW8PTpyR/Fvr1dLhS//X+0iQa47CT0jLF9TWs1mesdgSUefWpVnjkM598nNcoyP
         yVj/yBL3CbYtiCi1E1yJY3fXpS3Nr6ALPNxDjouIiqWBWhfso0hEiVETbYzRGDEk4rld
         LuhV2cBn/waTQc+jNbM5e19nZf5/QqmEwsJVu2P54qT4Gzzp4l6ssMRnATkMLhFo3D9r
         rlTg==
X-Gm-Message-State: AOAM532M8yvAvMjDP0bsDcbD1WA8Gy76R+zE4iEnYa/DIaNzavCX47de
        NbQmgza5ipveGydPDKaeyqrkcxTJJczHuA==
X-Google-Smtp-Source: ABdhPJy1Fy7QEbQTVRrVgP37BXdKRBOOS8oz8mZHsJvOZ0pvoRE5GrUwkCj0WBYUoXKCFPWpZRMozg==
X-Received: by 2002:a9d:4d8d:: with SMTP id u13mr786142otk.367.1623266939269;
        Wed, 09 Jun 2021 12:28:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h8sm137385oie.41.2021.06.09.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:28:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/7] notes: fix merge.conflictstyle handling
Date:   Wed,  9 Jun 2021 14:28:38 -0500
Message-Id: <20210609192842.696646-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
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
index 74bba39ca8..a333cc68ec 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -23,6 +23,7 @@
 #include "notes-merge.h"
 #include "notes-utils.h"
 #include "worktree.h"
+#include "xdiff-interface.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
@@ -1000,7 +1001,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_xmerge_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index 978f4e3e70..44f79ac91b 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -62,4 +62,31 @@ test_expect_success 'merge-tree' '
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
+		! grep -E "\|+" .git/NOTES_MERGE_WORKTREE/* &&
+
+		git notes merge --abort &&
+		test_must_fail git -c merge.conflictstyle=diff3 notes merge r &&
+		grep -E "\|+" .git/NOTES_MERGE_WORKTREE/* &&
+
+		git notes merge --abort &&
+		test_must_fail git -c merge.conflictstyle=merge notes merge r &&
+		! grep -E "\|+" .git/NOTES_MERGE_WORKTREE/*
+	)
+'
+
 test_done
-- 
2.32.0.2.g41be0a4e50

