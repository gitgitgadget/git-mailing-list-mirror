Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC14211B3
	for <e@80x24.org>; Sat, 15 Dec 2018 00:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeLOAAS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:00:18 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48368 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbeLOAAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:00:17 -0500
Received: by mail-pf1-f201.google.com with SMTP id t2so5695281pfj.15
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=giZsMHf0NVPWJB3VzkMWpUCMdUOA4dq377/B7d5AAEc=;
        b=Nm8D0rWgw7vsaf/3O3nJE8flENj/pltSkKidC4RCEIOe2w2vzIKv0k0a/6ghExmC0G
         SQ2jbaCietsm5c1ngUz61jazYF8ZactvBp+p2SU4+5J2F3LqJnS6y4xRLi/fHeNyy/FZ
         kNIxUvqIzSNcJXbaX5fiAgpJSI32MDdn66iL5DU3g+F20onS6jpSoR5GBaax1a1n/4rh
         yTIO637YCZBwLfRWdk3Lc9j7nrBFlXF+kHIJoaBzBThdxT1GM03mBeZ4/4VrASJ/3S0Y
         cX8nLLXKwYH0BAzCYIZ+67RdpSorgOea8O6iwjvxpxm3KqboUpiKiYc+mujPVZwDpXp5
         bZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=giZsMHf0NVPWJB3VzkMWpUCMdUOA4dq377/B7d5AAEc=;
        b=bpQycWkFDZw2o4ys1HP7b9xta9wHpqxoG/LOiT50k5GThSeIVk63u+gA1t9TJehzRf
         sCZBJnQvT5QzZEaYdvw5yCKnwexknCCfubOIpoY+ot6+L37gx7EkMVvqAomqmF8MZ5gn
         wrD4D0PxxL59oq0U+yrc84FcDCx8WgThwHvxz4LA9DetO7/IYxAYtFfKGO+tQIcwVQhb
         rAXpT3M2eFZR6rFInXjhRvL1dgLD94ohGkgvCRDHRTz0Y5l8hKd7eiryJ32bDK7cu+O3
         GF3unul1XnGtxuxa5KKWVK4RQRZkEZozWwJufMWrrsEbx6TR7nuhFXz8rFOXA4FuMqp9
         FZDg==
X-Gm-Message-State: AA+aEWZ64UZJph/7Bo3gqNIZ/vwQ3qOeuYYO+lAosZbxXxHfIhFnBvhG
        pAGA78kOLv4RHSgnYPvSsyH5iameusCr
X-Google-Smtp-Source: AFSGD/Ukv0RcQP3xvW4HXQhLvpXpgXND2ApcR2OLbF88jKoNk/lVKEh0DhHnyxv7af6PaXCgmBRXQ9cKBRsB
X-Received: by 2002:a17:902:443:: with SMTP id 61mr2196516ple.31.1544832017295;
 Fri, 14 Dec 2018 16:00:17 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:59:45 -0800
In-Reply-To: <20181214235945.41191-1-sbeller@google.com>
Message-Id: <20181214235945.41191-5-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com> <20181214235945.41191-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 4/4] submodule deinit: unset core.worktree
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is deinit'd, the working tree is gone, so the setting of
core.worktree is bogus. Unset it. As we covered the only other case in
which a submodule loses its working tree in the earlier step
(i.e. switching branches of top-level project to move to a commit that did
not have the submodule), this makes the code always maintain
core.worktree correctly unset when there is no working tree
for a submodule.

This re-introduces 984cd77ddb (submodule deinit: unset core.worktree,
2018-06-18), which was reverted as part of f178c13fda (Revert "Merge
branch 'sb/submodule-core-worktree'", 2018-09-07)

The whole series was reverted as the offending commit e98317508c
(submodule: ensure core.worktree is set after update, 2018-06-18)
was relied on by other commits such as 984cd77ddb.

Keep the offending commit reverted, but its functionality came back via
4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17), such
that we can reintroduce 984cd77ddb now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 ++
 t/lib-submodule-update.sh   | 2 +-
 t/t7400-submodule-basic.sh  | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 31ac30cf2f..672b74db89 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1131,6 +1131,8 @@ static void deinit_submodule(const char *path, const char *prefix,
 		if (!(flags & OPT_QUIET))
 			printf(format, displaypath);
 
+		submodule_unset_core_worktree(sub);
+
 		strbuf_release(&sb_rm);
 	}
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 51d4555549..5b56b23166 100755
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
index 76a7cb0af7..aba2d4d6ee 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -984,6 +984,11 @@ test_expect_success 'submodule deinit should remove the whole submodule section
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
2.20.0.405.gbc1bbc6f85-goog

