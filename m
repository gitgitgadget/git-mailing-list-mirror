Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDE6C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22C3206DC
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 16:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DejVbT6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgFKQQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgFKQQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 12:16:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C5C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 09:16:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so2860529pfi.13
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hygnNEMMb6SAVuOwG5optMgcW23WEFOR7vVsjinyryI=;
        b=DejVbT6eV66WXlbIHgf1kFNE/V7UP03xRPHIs9NdNJiyy5718brHQw9T5tymKgvpSw
         oZd50QB3uq1403uSVda3C+9g5ox9HPMu9urkgu+xMY72DtvBZRwxiTHc9JRczhKvu3RP
         cG1n5o7m1BlK3LHiybL13ZDJJZuTUvftH7MlpyEad4nFvhmCkeVyfa+4xIKJFhyktGVq
         YEzHvqF/ESFRSYjHNFD050rhduIUSUD80WOj4vrlHgfC3we1vm3Mp+5MNkDfaEgEk2vx
         V5rk9B1uNZ9Hiw4mJbCdmYd4oJIX0egL7enFtgoQ5Eclr3k0IK49y28IJG6jiPZHnIbU
         kfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hygnNEMMb6SAVuOwG5optMgcW23WEFOR7vVsjinyryI=;
        b=LHZvvYZrgNi3AMoln22xqV0Mzrzaz9PJ93NIsq/VgileNPWirIC6Xso3x6zL8Amui+
         CM94k6cFHua8qXJFNno/D+ogQy9IYr5VDitJRFFz62Ad5sUUUSDEFLMP6v8KcJngQjTw
         qRe0513g0TlffJRCBZizYi6fOYJcsHWBgtShS09eEAfzJxai29+5Ar+e720anrNkVmDj
         NehzU9IZDMhEqBPZNgyrxxLzy/s4hC7Zw/FihPxoLDsk5PI0ZeHt0Wf7jPCrIqxSGRlO
         4la0ix0TtJ0nLJJfMgFCR5+y3RLWGgQb2ZW+HJmizjRWeVVyZ6w8483xCECRT+3GzJ+q
         pqRw==
X-Gm-Message-State: AOAM530/sawXroluxH5CJLtPn8rjzNKAyXlckL7wD5fTB5UeL1aGbI1b
        PYs8fQmpk7kgtgoHOgbDV0EwXhnT
X-Google-Smtp-Source: ABdhPJy/xRJLqZjo6Sprj5npbgliNjTM+n4hIFSfjBE58RxUitHQx9tJRVFQWSnctJmjRbTsHIrstA==
X-Received: by 2002:a65:5688:: with SMTP id v8mr2623686pgs.48.1591892206274;
        Thu, 11 Jun 2020 09:16:46 -0700 (PDT)
Received: from localhost.localdomain ([49.206.15.108])
        by smtp.gmail.com with ESMTPSA id z14sm3669520pfj.64.2020.06.11.09.16.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 09:16:45 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
Date:   Thu, 11 Jun 2020 21:46:40 +0530
Message-Id: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `diff-files' command and related commands which call `cmd_diff_files()',
consider the "intent-to-add" files as a part of the index when comparing the
work-tree against it. This was previously addressed in [1] and [2] by turning
the option `--ita-invisible-in-index' (introduced in [3]) on by default.

For `diff-files' (and `add -p' as a consequence) to show the i-t-a files as
as new, `ita_invisible_in_index' will be enabled by default here as well.

[1] 0231ae71d3 (diff: turn --ita-invisible-in-index on by default, 2018-05-26)
[2] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist in
                index", 2016-10-24)
[3] b42b451919 (diff: add --ita-[in]visible-in-index, 2016-10-24)

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---

Hello! This is my first patch in this project.
This issue was mentioned in #leftoverbits on GitHub: [1], and this
patch implements the change proposed in [2].

[1] https://github.com/gitgitgadget/git/issues/647
[2] https://lore.kernel.org/git/20200527230357.GB546534@coredump.intra.peff.net


 builtin/diff-files.c  |  7 +++++++
 t/t2203-add-intent.sh | 25 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 86ae474fbf..1e352dd8f7 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -28,6 +28,13 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
+
+	/*
+	 * Consider "intent-to-add" files as new by default, unless
+	 * explicitly specified in the command line or anywhere else.
+	 */
+	rev.diffopt.ita_invisible_in_index = 1;
+
 	precompose_argv(argc, argv);
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 5bbe8dcce4..742f27a935 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -232,7 +232,7 @@ test_expect_success 'double rename detection in status' '
 	)
 '
 
-test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
+test_expect_success 'diff/diff-cached shows ita as new/not-new files' '
 	git reset --hard &&
 	echo new >new-ita &&
 	git add -N new-ita &&
@@ -243,6 +243,29 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 	test_must_be_empty actual2
 '
 
+test_expect_success 'diff-files shows i-t-a files as new files' '
+	git reset --hard &&
+	touch empty &&
+	content="foo" &&
+	echo $content >not-empty &&
+	git add -N empty not-empty &&
+	git diff-files -p >actual &&
+	hash_e=$(git hash-object empty) &&
+	hash_n=$(git hash-object not-empty) &&
+	cat >expect <<-EOF &&
+	diff --git a/empty b/empty
+	new file mode 100644
+	index 0000000..$(git rev-parse --short $hash_e)
+	diff --git a/not-empty b/not-empty
+	new file mode 100644
+	index 0000000..$(git rev-parse --short $hash_n)
+	--- /dev/null
+	+++ b/not-empty
+	@@ -0,0 +1 @@
+	+$content
+	EOF
+	test_cmp expect actual
+'
 
 test_expect_success '"diff HEAD" includes ita as new files' '
 	git reset --hard &&
-- 
2.27.0

