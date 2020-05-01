Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64433C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441EB20643
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrOU6vjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgEAI26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 04:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAI25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 04:28:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F5C035494
        for <git@vger.kernel.org>; Fri,  1 May 2020 01:28:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so7392044qts.9
        for <git@vger.kernel.org>; Fri, 01 May 2020 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJgoyRbQ+0GbLq796pa73wc0vzevTPqPZHbe3hDCPnM=;
        b=NrOU6vjK3uHh1DKoYu9MYo3N7f1eCc0GVFX1k/9mWt1svB1u4xXKzOwqIJiuu4LTqf
         ZYUpZf1G5h4yUdc9TcPd49n06wXsWuClV5tLvROenGAQRBsvzuKjeTbBcF4HQ4Wo4fR1
         uCvqY+Yk6Z5rZeOjselhmsc99556QncmyhHt+LfEF7oxxLWSgw8FluRcryvWItYR86gF
         Ho6Hiwb2ERMrPWd2NahGuXybHeHCVfFEg/WCUCvBZJlh3+2HEcr8ppuqd5dbQqfJvqy8
         ILQCBKuBHo08xEH/qZFBD8hXjpvNJUvUGvAxa8wkAABw2fa1rqADKuYrQrxV598MjX6q
         Pi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IJgoyRbQ+0GbLq796pa73wc0vzevTPqPZHbe3hDCPnM=;
        b=rIOBXMuBH03TI27G05xs67qt/jxGv8kZVOXEkPwm1YDmIG7gdOLBtcLs2yF3EC76cE
         t0zMGv4/e9iJTfOYKBNUPpzE2TGccX5XgUTx6E8Oc9MEkmmjOIshYB/IHL2Lla/IAFMP
         gUg1EEF+QKx52xCdDze3aYlQzGI1wbt9SVRqzc7IDd7auVpFwLghR1W/XS6X6vvJFEx1
         7qaWGY6OdtyMlcISSrqZrRt9oByJ6WNwNkDi6/DrZUMX3BKd6+3F0sYHivQI58/oHA3W
         SIWF5En75EYG3sADGt1r3yUEX5Tynu4XKRrqdjkrPbtHAX6GPO0J3qSbWM5ohfEs0IEY
         nhEQ==
X-Gm-Message-State: AGi0PuahJnfaZsfN0G4UHUMo15lxUHiNolPuwRMfGdLhEBrMEorHWhH+
        H7B16OiH1sx8Qc0WrevzfcZlcU50
X-Google-Smtp-Source: APiQypJRZUT031H4FVXrPyz4bs7erwuzaYY5JwWs4NJWNq7m4vQoH8UVRHjxHvnFWF4nsvnYINsMdA==
X-Received: by 2002:ac8:6ec8:: with SMTP id f8mr2498788qtv.330.1588321735973;
        Fri, 01 May 2020 01:28:55 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 70sm2258138qkh.67.2020.05.01.01.28.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 01:28:55 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Harri=20Meht=C3=A4l=C3=A4?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] restore: default to HEAD when combining --worktree and --staged
Date:   Fri,  1 May 2020 04:27:46 -0400
Message-Id: <20200501082746.23943-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
In-Reply-To: <20200501082746.23943-1-sunshine@sunshineco.com>
References: <20200501082746.23943-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default restore source for --worktree is the index, and the default
source for --staged is HEAD. However, when combining --worktree and
--staged in the same invocation, git-restore requires the source to be
specified explicitly via --source since it would otherwise be ambiguous
("should it restore from the index or from HEAD?"). This requirement
makes it cumbersome to restore a file in both the worktree and the
index.

However, HEAD is also a reasonably intuitive default restore source when
--worktree and --staged are combined. After all, if a user is asking to
throw away all local changes to a file (on disk and in the index)
without specifying a restore source explicitly -- and the user expects
the file to be restored from _somewhere_ -- then it is likely that the
user expects them to be restored from HEAD, which is an intuitive and
logical place to find a recent unadulterated copy of the file.

Therefore, make HEAD the default restore source when --worktree and
--staged are combined.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-restore.txt | 14 +++++++-------
 builtin/checkout.c            |  9 +++------
 t/t2070-restore.sh            | 12 +++++++++---
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 8906499637..5b61812e17 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -22,10 +22,10 @@ The command can also be used to restore the content in the index with
 `--staged`, or restore both the working tree and the index with
 `--staged --worktree`.
 
-By default, the restore sources for working tree and the index are the
-index and `HEAD` respectively. `--source` could be used to specify a
-commit as the restore source; it is required when combining `--staged`
-and `--worktree`.
+By default, the restore source for `--worktree` is the index, and the
+restore source for `--staged` is `HEAD`. When combining `--worktree` and
+`--staged`, the restore source is `HEAD`. `--source` can be used to specify
+a different commit as the restore source.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
@@ -40,10 +40,10 @@ OPTIONS
 	tree. It is common to specify the source tree by naming a
 	commit, branch or tag associated with it.
 +
-If not specified, the default restore source for the working tree is
-the index, and the default restore source for the index is
+If not specified, the default restore source for `--worktree` is
+the index, and the default restore source for `--staged` is
 `HEAD`. When both `--staged` and `--worktree` are specified,
-`--source` must also be specified.
+the default restore source is `HEAD`.
 
 -p::
 --patch::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7a01d00f53..500c3e23ff 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1604,14 +1604,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
-	if (opts->checkout_index > 0 && opts->checkout_worktree > 0 &&
-	    !opts->from_treeish)
-		die(_("--source required when using --worktree and --staged"));
 	/*
-	 * convenient shortcut: "git restore --staged" equals
-	 * "git restore --staged --source HEAD"
+	 * convenient shortcut: "git restore --staged [--worktree]" equals
+	 * "git restore --staged [--worktree] --source HEAD"
 	 */
-	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
+	if (!opts->from_treeish && opts->checkout_index)
 		opts->from_treeish = "HEAD";
 
 	/*
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 19efa21fdb..89e5a142c9 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -69,9 +69,15 @@ test_expect_success 'restore --staged uses HEAD as source' '
 	test_cmp expected actual
 '
 
-test_expect_success 'restore --worktree --staged requires --source' '
-	test_must_fail git restore --worktree --staged first.t 2>err &&
-	test_i18ngrep "source required when using --worktree and --staged" err
+test_expect_success 'restore --worktree --staged uses HEAD as source' '
+	test_when_finished git reset --hard &&
+	git show HEAD:./first.t >expected &&
+	echo dirty >>first.t &&
+	git add first.t &&
+	git restore --worktree --staged first.t &&
+	git show :./first.t >actual &&
+	test_cmp expected actual &&
+	test_cmp expected first.t
 '
 
 test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
-- 
2.26.2.526.g744177e7f7

