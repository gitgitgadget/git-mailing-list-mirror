Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE720C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F6864E6B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBJQM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhBJQMW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:12:22 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF7C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 08:11:41 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so3206756wrw.6
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 08:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uQ/c+P2F5OQVNoItdCzD2VrpBZwFIcukFcpOfnPxIp8=;
        b=q139zSX8O95aACWnx70DOtxc8U9oQObIso2cAp7E4Dh6nRvbnWQtHJj/KmAbdNlM0X
         7+Jz2zBkXISb2FilwBsLUacd/+mrk91QQKf0VCeWJAmDRQPhVmJXLz2meDjucDM9/5DN
         J33xen6wWBoeYyOJu9fuF4Grc5MHmF4LlDCL3GLr5gpJpdxYP85skYQ61SITsGz/JJHO
         zOs2gE7xZhV1PKR41tLxGwLBz5O9MfQNbP4/oi0a7HDubJ9K3mRFO63xxopYJI3Kzkcy
         6DN4Aa48VbtuiGB1Yk2EYAsZ/URfRrdRKDhEwCAJVuHtXgIIyUD+hOOXDUAi12JRrea0
         6ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uQ/c+P2F5OQVNoItdCzD2VrpBZwFIcukFcpOfnPxIp8=;
        b=sPIMwyqExU5Evc/is19l92CsXrxbE+TK2iQqXLY57sQnCi8K4YyNAOBtwt5tyhCv/J
         O4HMVCKcJ6j6IAvuZqNAxwD1ErkceWMevwG1X1bRl2rEuSHxfcC41c0AwlvmKV7bZWMs
         I+SBEtHIptBlyT+9ZzRVzworrfgxG0EZMhX1+QJ+n1zXp0Pahq2C+W9cvTwBaxwB7cI8
         hkopuuyRdgejKZfSHRJWgk+IzuIgebbmFOVkMBHMC1eADifpT/8g71C7DQJzk3ZlFnQq
         5Y8Mm71UBnmvYcGOMwvS0o92c4spaSF7ovoywP79TjO4g7pedSBikzoP57sgGY+tif1W
         gI4Q==
X-Gm-Message-State: AOAM532m8NfirdbIuoI0fJMxtf43lL/qDDDDw5Qk71vadpv67zKC0o8x
        QtCDPY2QT672J+d0p9WPlZuNV6QGnoc=
X-Google-Smtp-Source: ABdhPJylgVcPMYvc6TvBah0oPiIC28WEwbj9lohcn2s7Bwt/vd8p1ZyRSaRuGnlOWilnAnSppaI1RA==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr4505594wri.77.1612973500714;
        Wed, 10 Feb 2021 08:11:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm3537609wrw.96.2021.02.10.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:11:39 -0800 (PST)
Message-Id: <pull.873.git.1612973499110.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 16:11:38 +0000
Subject: [PATCH] reflog expire --stale-fix: be generous about missing objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Whenever a user runs `git reflog expire --stale-fix`, the most likely
reason is that their repository is at least _somewhat_ corrupt. Which
means that it is more than just possible that some objects are missing.

If that is the case, that can currently let the command abort through
the phase where it tries to mark all reachable objects.

Instead of adding insult to injury, let's be gentle and continue as best
as we can in such a scenario, simply by ignoring the missing objects and
moving on.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Make git reflog expire --stale-fix a lot more useful
    
    Yesterday, I tried to run a quick test to find out whether master's
    version of git repack prevents .bitmap files from being deleted by still
    having them mmap()ed. Since I do not have a build of master lying around
    just like that, I checked it out, built the thing, and then ran
    
    ./bin-wrappers/git -c alias.c='!(cd /path/to/directory && ./test-whether-bitmaps-are-mmaped-during-repack.sh) c
    
    
    Do NOT try this at home! The problem with this invocation is that the
    alias will still have GIT_DIR set, therefore the git init in that script
    will not create a new Git directory, and the git repack -ad in that
    script will remove all kinds of precious objects from the Git checkout.
    Even though I interrupted the run as quickly as I realized that things
    were going wrong, my repository was corrupted in a major way, and it
    took me many hours to get back to a healthy state.
    
    It made matters worse that git reflog expire --stale-fix was less
    helpful than it could have been, and this patch is the result of my
    directed emotional energy.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-873%2Fdscho%2Freflog-expire-with-missing-objects-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-873/dscho/reflog-expire-with-missing-objects-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/873

 builtin/reflog.c  |  3 +++
 t/t1410-reflog.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index ca1d8079f320..09541d1c8048 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -602,6 +602,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 */
 	if (cb.cmd.stalefix) {
 		repo_init_revisions(the_repository, &cb.cmd.revs, prefix);
+		cb.cmd.revs.do_not_die_on_missing_tree = 1;
+		cb.cmd.revs.ignore_missing = 1;
+		cb.cmd.revs.ignore_missing_links = 1;
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf(_("Marking reachable objects..."));
 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ecccaa063453..27b9080251a9 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -158,6 +158,32 @@ test_expect_success 'reflog expire' '
 	check_fsck "dangling commit $K"
 '
 
+test_expect_success '--stale-fix handles missing objects generously' '
+	git -c core.logAllRefUpdates=false fast-import --date-format=now <<-EOS &&
+	commit refs/heads/stale-fix
+	mark :1
+	committer Author <a@uth.or> now
+	data <<EOF
+	start stale fix
+	EOF
+	M 100644 inline file
+	data <<EOF
+	contents
+	EOF
+	commit refs/heads/stale-fix
+	committer Author <a@uth.or> now
+	data <<EOF
+	stale fix branch tip
+	EOF
+	from :1
+	EOS
+
+	parent_oid=$(git rev-parse stale-fix^) &&
+	test_when_finished "recover $parent_oid" &&
+	corrupt $parent_oid &&
+	git reflog expire --stale-fix
+'
+
 test_expect_success 'prune and fsck' '
 
 	git prune &&

base-commit: 1d4f2316c5b767ccbf20cc3d55c98d1f92e6e1ce
-- 
gitgitgadget
