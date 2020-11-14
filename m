Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B4FC63699
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D2F22267
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV24JFhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKNAet (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgKNAet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 19:34:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EEC0617A6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k2so12158487wrx.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gWDz9/SWZ7N7h4GNphEYMJIZWtymw4ByXjkmREoQWWo=;
        b=gV24JFhCE8xRJihBdBiJst9DvGtWod1UFh9xrOswBco3SuEB/mX2S6vuAwVhb64kli
         GOIHqPOss6d0X5j7fk11WopX0rHJR4LWOBfrjMXOoJUnEHEzsFsTljvv9Z6EaBJNuyls
         j04lbWshhVFABDWPJEnfNcWap9r63wN+vgsEXWoMAl0RdWDYbQmfhe2020hgtZbWKLwC
         +SFrxWpVwS26/r2s4cNe/kdxxfeQtLB853Bvns3GrczlqcJFPMSF6+pWMwC8iumkRbJE
         BG7f9ajbdgYLqWvzhGuDtlc3TvmVcRaNbY98eyziSexiHvdjJ0zOeFepwrVqf2yU9E8c
         qtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gWDz9/SWZ7N7h4GNphEYMJIZWtymw4ByXjkmREoQWWo=;
        b=fIGyjO4NjZL7iEwkK1LNOGJ8m+s/r8ev2Heg4beVYG+8RDp6Jptbtybks5eBZuu3Qs
         dYDv5+VLBRo3Z+4xEOHtUaJ+9cYIMxa43d7MzVkKh1RPgaEVq7BKxPGFVXIgsRkHbj5g
         gWPUxX6mUWGGtt3Ga4V9x6wSZ9W54obAtSUu7QYdFD1nU7wT7OYkMMYMwUEkBqZl7heT
         +rDcQ7mjHc3cz5rgHBAh/OPMCe+CC/oU/P0LZ0D8dAcyN0nVnaf761NjWmycyYVni3Sr
         KPgwIOeffk1r4FPjDuFzGfH/2z1F/hgNL0HI38kzfszb8QxaVp8tCFJ61w2CpbkimEDj
         hV5w==
X-Gm-Message-State: AOAM533KlunyLM9V2CTUdwmpcJFN8SWi9hxe84KQIApJkoE7uCvsAJ+q
        vH+DE7Rk5559Idi6kXB/tbM7ZYJ7jko=
X-Google-Smtp-Source: ABdhPJwLCC/OIzbh8fBZradce00tJf6voAbfiShyGOE92u7FbGrovJwLOY+Reo3wXiKADSXSr9sX7w==
X-Received: by 2002:a5d:4e07:: with SMTP id p7mr6540479wrt.63.1605314087808;
        Fri, 13 Nov 2020 16:34:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 89sm13046586wrp.58.2020.11.13.16.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:34:47 -0800 (PST)
Message-Id: <85c5766556e53f780b9a3ac677a0c758c51baae2.1605314085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.789.git.1605314085.gitgitgadget@gmail.com>
References: <pull.789.git.1605314085.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Nov 2020 00:34:43 +0000
Subject: [PATCH 2/4] t5572: add notes on a peculiar test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brice Goglin <bgoglin@free.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Test 5572.63 ("branch has no merge base with remote-tracking
counterpart") was introduced in 4d36f88be7 (submodule: do not pass null
OID to setup_revisions, 2018-05-24), as a regression test for the bug
this commit was fixing (preventing a 'fatal: bad object' error when the
current branch and the remote-tracking branch we are pulling have no
merge-base).

However, the commit message for 4d36f88be7 does not describe in which
real-life situation this bug was encountered. The brief discussion on the
mailing list [1] does not either.

The regression test is not really representative of a real-life
scenario: both the local repository and its upstream have only a single
commit, and the "no merge-base" scenario is simulated by recreating this
root commit in the local repository using 'git commit-tree' before
calling 'git pull --rebase --recurse-submodules'. The rebase succeeds
and results in the local branch being reset to the same root commit as
the upstream branch.

The fix in 4d36f88be7 modifies 'submodule.c::submodule_touches_in_range'
so that if 'excl_oid' is null, which is the case when the 'git merge-base
--fork-point' invocation in 'builtin/pull.c::get_rebase_fork_point'
errors (no fork-point), then instead of 'incl_oid --not excl_oid' being
passed to setup_revisions, only 'incl_oid' is passed, and
'submodule_touches_in_range' examines 'incl_oid' and all its ancestors
to verify that they do not touch the submodule.

In test 5572.63, the recreated lone root commit in the local repository is
thus the only commit being examined by 'submodule_touches_in_range', and
this commit *adds* the submodule. However, 'submodule_touches_in_range'
*succeeds* because 'combine-diff.c::diff_tree_combined' (see the
backtrace below) returns early since this commit is the root commit
and has no parents.

  #0  diff_tree_combined at combine-diff.c:1494
  #1  0x0000000100150cbe in diff_tree_combined_merge at combine-diff.c:1649
  #2  0x00000001002c7147 in collect_changed_submodules at submodule.c:869
  #3  0x00000001002c7d6f in submodule_touches_in_range at submodule.c:1268
  #4  0x00000001000ad58b in cmd_pull at builtin/pull.c:1040

In light of all this, add a note in t5572 documenting this peculiar
test.

[1] https://lore.kernel.org/git/20180524204729.19896-1-jonathantanmy@google.com/t/#u

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t5572-pull-submodule.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 1d75e3b12b..7f658dba6d 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -136,6 +136,21 @@ test_expect_success 'pull rebase recursing fails with conflicts' '
 	test_i18ngrep "locally recorded submodule modifications" err
 '
 
+# NOTE:
+#
+# This test is particular because there is only a single commit in the upstream superproject
+# 'parent' (which adds the submodule 'a-submodule'). The clone of the superproject
+# ('child') hard-resets its branch to a new root commit with the same tree as the one
+# from the upstream superproject, so that its branch has no merge-base with its
+# remote-tracking counterpart, and then calls 'git pull --recurse-submodules --rebase'.
+# The result is that the local branch is reset to the remote-tracking branch (as it was
+# originally before the hard-reset).
+
+# The only commit in the range generated by 'submodule.c::submodule_touches_in_range' and
+# passed to 'submodule.c::collect_changed_submodules' is the new (regenerated) initial commit,
+# which adds the submodule.
+# However, 'submodule_touches_in_range' does not error (even though this commit adds the submodule)
+# because 'combine-diff.c::diff_tree_combined' returns early, as the initial commit has no parents.
 test_expect_success 'branch has no merge base with remote-tracking counterpart' '
 	rm -rf parent child &&
 
-- 
gitgitgadget

