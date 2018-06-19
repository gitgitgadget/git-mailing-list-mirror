Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9041F403
	for <e@80x24.org>; Tue, 19 Jun 2018 00:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937078AbeFSAG2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 20:06:28 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:42851 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937064AbeFSAGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 20:06:24 -0400
Received: by mail-qt0-f201.google.com with SMTP id f8-v6so15378144qth.9
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kvJHgXAkQZ6DZ//WVK3ELqVYpDgQsMzhpaEy1bif2CE=;
        b=BwYiBQICuBVBQeLfB4/CnQGkSxMGWAt05dsZ7tD/z+6hD4qqYwk1zYwq8z6xUEfnlM
         buVMejc0jqkgnVIN6lH8Jlz/40paNANwRHv373QnlHvQ9jSVLztygaQTQnJu5W7xSJkG
         4FKQS+GjkUrusuDtf30ZBXv8h+t0GkTUpq7gMVT40OsqBkfpEGpEPwcan6Y8CRf+EiWb
         6YmUmV8zrKXKEpMwXWKPgdBlsMfmvCXTaAin8w7uKAlMwrw+IGCOeB1zDOfDbRixrw8/
         HHgGOH9I7pkHLWadXJ+apyN9vwqf4UYWccgZ0qGE8igHj68XFWgtjTiBTUwmjg7vcELY
         D9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kvJHgXAkQZ6DZ//WVK3ELqVYpDgQsMzhpaEy1bif2CE=;
        b=bKnPwv6qAn8RW0vDzFn1DdrqkYUJ3Ew2s/PKDlMMDo0b/UOnkvXmY58vXs81S3ELQ7
         jarKRJzIZPiVLGKGugDuWhNNSc+8+sQpXbuWTkHsfA85om2KfzcL3TxSs65y1t8eJQUR
         w1GoeriurM13vkp+XkM4ZcrdivT/dRFIb0n9KTHaK24HOLAAdTt3HeSMufIfzNtUdwqL
         2rwVKH3d5eN95y0p6PH0c8v/AdDdQest9VmSCCnnbI3T1BsXuXfzsv4j5f6tR4KFTRNA
         K4Nxgdy/Ca4XNNbwK4ELo69ysX4KzMvkj+lTFFvPv0JXateNhd5jcZGCXTuVVehQD8RS
         85pA==
X-Gm-Message-State: APt69E2em9U/PT4UQGIzpyEYaeLPRKrRme1Ex/ZNyx+PPA+l6ZNncOw6
        vmJF7vXfKFpiC9xQLrk/i37/w5+ukXRT
X-Google-Smtp-Source: ADUXVKLsVCEzyabjqVKt9fCqSL+rDW22L3fcJXsqT0VA6CQfgXmuPtTsCl3dd7RF0TfxOuv9QdyPufheOdBl
MIME-Version: 1.0
X-Received: by 2002:ac8:524e:: with SMTP id y14-v6mr8153418qtn.56.1529366784002;
 Mon, 18 Jun 2018 17:06:24 -0700 (PDT)
Date:   Mon, 18 Jun 2018 17:06:08 -0700
In-Reply-To: <20180619000608.147422-1-sbeller@google.com>
Message-Id: <20180619000608.147422-4-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com> <20180619000608.147422-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH 3/3] submodule deinit: unset core.worktree
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is deinit'd, the working tree is gone, so the setting of
core.worktree is bogus. Unset it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 ++
 t/lib-submodule-update.sh   | 2 +-
 t/t7400-submodule-basic.sh  | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dffc55ed8ee..19480902681 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -980,6 +980,8 @@ static void deinit_submodule(const char *path, const char *prefix,
 		if (!(flags & OPT_QUIET))
 			printf(format, displaypath);
 
+		submodule_unset_core_worktree(sub);
+
 		strbuf_release(&sb_rm);
 	}
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 12cd4e9233e..aa5ac03325a 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -235,7 +235,7 @@ reset_work_tree_to_interested () {
 	then
 		mkdir -p submodule_update/.git/modules/sub1/modules &&
 		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
-		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1/modules/sub2 config --unset core.worktree
+		# core.worktree is unset for sub2 as it is not checked out
 	fi &&
 	# indicate we are interested in the submodule:
 	git -C submodule_update config submodule.sub1.url "bogus" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 812db137b8d..48fd14fae6e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -993,6 +993,11 @@ test_expect_success 'submodule deinit should remove the whole submodule section
 	rmdir init
 '
 
+test_expect_success 'submodule deinit should unset core.worktree' '
+	test_path_is_file .git/modules/example/config &&
+	test_must_fail git config -f .git/modules/example/config core.worktree
+'
+
 test_expect_success 'submodule deinit from subdirectory' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
-- 
2.18.0.rc1.244.gcf134e6275-goog

