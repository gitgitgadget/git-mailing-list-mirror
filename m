Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA1AC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355625AbiBCV7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355638AbiBCV7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:59:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6034C061401
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:59:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e81-20020a25d354000000b0061b1a807047so516160ybf.14
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k7esGtayVb1Q4S+vH8OP5pOyeSUIhNYdFHRrHUKEmFM=;
        b=bU1zA0S8YZvj3n9Q7+TK7exGbrsPyV3PvtJygW2RFB8kW10lhKwaZiSL+OAV9Wli4W
         F6kVT3LrxQP/jHxGRMoHDpOgso3NV8CJBUirizbZyw19ArL+PhSjLGZOmMY8TYLg8dlJ
         0CE3SuYFQrVZ7RzjCSf4XQyz8A9hyghkAg6bHeA5x/XZ7YSY9cxtdo60wZ2RWZgrsGWs
         pgSanMYDl+Gaca+kW7UCgf8yv/z5pUoxIVtztyho/RwDKbJ4hVVkcMI3b9nVBIzdI84H
         5VNwdikxcIYZVQ2R2jHWm21QHezd9V2zz26nDNoK0E6gjUDa8gIv0AFOsRQ2PbZAT/ib
         a+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k7esGtayVb1Q4S+vH8OP5pOyeSUIhNYdFHRrHUKEmFM=;
        b=YTy/W+kNzvDvNQe08lesI1dQriJDTbzrmjDnoGl9B4cHJV2adD7PV1o1agUL1TYgO8
         e6Kq2PfjLVIKHxGS8HuPOXpJOitpKPEjYMJNdghsxcmyCfxYFhcqcVYR0FwR907HvfQV
         ukgssU3ccTZBJk6klGBvg9N5rvnHAdesEVkQSNnAS+vLO8RFitEHsmAybmmHQ1b6k4md
         um8ZTCgo1+vhwHCGcoUSmOmu2EKEb5gN27KlW4DR0zkA7klut8+osE31kHI2UJ6of2Zo
         iOLyBSzd1cQkwlo8IwBCQP0NdSfh/hvWHHw8Uwx6jbR0Qdgcvkt8AbvGlJfCijLW/tJs
         PPww==
X-Gm-Message-State: AOAM533ZkeNzSAKww42UecBQ7x9SXh0YVfhMT/QTVSRsSxS7wlyWNV8V
        1deYCcWFuyQqzYkAIGRqBpKP4xrqmEcV2XEGmS6I+Ofgh6a7Ai876Hx9Em2qjHTl8cLSpWnh6p+
        RLBapbZymBzGyHivyADCAWMhBfjPF9b3Vt4YjyJBoqXZGQjTfa7z0By9FnJnlomznGJRk4wZaLg
        ==
X-Google-Smtp-Source: ABdhPJyUU1NuicCEtbQNj/TM4aRG9MjzEPitfRe+4Z8tgsG1256zgs7qNTPHLeDoFcYxlAVj8KzuFMiGBfXEGzUpOYA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:662:cd2f:9dc:846b])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ef05:: with SMTP id
 g5mr189739ybd.568.1643925569905; Thu, 03 Feb 2022 13:59:29 -0800 (PST)
Date:   Thu,  3 Feb 2022 13:59:14 -0800
In-Reply-To: <20220203215914.683922-1-emilyshaffer@google.com>
Message-Id: <20220203215914.683922-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 4/4] submodule: record superproject gitdir during 'update'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recorded path to the superproject's gitdir might be added during
'git submodule add', but in some cases - like submodules which were
created before 'git submodule add' learned to record that info - it might
be useful to update the pointer. Let's do it during 'git submodule
update', when we already have a handle to the superproject while calling
operations on the submodules.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/submodule.txt |  4 ++--
 git-submodule.sh                   | 15 +++++++++++++++
 t/t7406-submodule-update.sh        | 27 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index f801f49ea1..ab37800954 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -98,5 +98,5 @@ submodule.superprojectGitDir::
 	reference to determine whether the current repo is a submodule to
 	another repo; if this reference is absent, Git will treat the current
 	repo as though it is not a submodule (this does not make a difference to
-	most Git commands). It is set automatically during submodule creation
-	and 'git submodule absorbgitdir'.
+	most Git commands). It is set automatically during submodule creation,
+	update, and 'git submodule absorbgitdir'.
diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66..7c247bee7f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -449,6 +449,21 @@ cmd_update()
 			;;
 		esac
 
+		# Store a poitner to the superproject's gitdir. This may have
+		# changed, unless it's a fresh clone. Write to worktree if
+		# applicable, and point to superproject's worktree gitdir if
+		# applicable.
+		if test -z "$just_cloned"
+		then
+			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
+			relative_gitdir="$(git rev-parse --path-format=relative \
+							 --prefix "${sm_gitdir}" \
+							 --git-dir)"
+
+			git -C "$sm_path" config --worktree \
+				submodule.superprojectgitdir "$relative_gitdir"
+		fi
+
 		if test -n "$recursive"
 		then
 			(
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..b42a339982 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1061,4 +1061,31 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update adds superproject gitdir to older repos' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitdir &&
+	 git submodule update &&
+	 test-tool path-utils relative_path \
+		"$(git rev-parse --absolute-git-dir)" \
+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'submodule update uses config.worktree if applicable' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitDir &&
+	 git -C submodule config extensions.worktreeConfig true &&
+	 git submodule update &&
+	 test-tool path-utils relative_path \
+		"$(git rev-parse --absolute-git-dir)" \
+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual &&
+
+	 test_file_not_empty "$(git -C submodule rev-parse --absolute-git-dir)/config.worktree"
+	)
+'
+
 test_done
-- 
2.35.0.263.gb82422642f-goog

