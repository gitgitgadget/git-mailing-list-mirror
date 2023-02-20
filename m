Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA86C61DA4
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 03:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBTDdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 22:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBTDdC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 22:33:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E435BDD1
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 19:33:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o17-20020a17090ab89100b002349a303ca5so1806669pjr.4
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 19:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALLiCpjr7mz458J3wWleOaC6br8s4W7Uooo/wcb8gxM=;
        b=fYaeboGzby9nnEYYSC2a2uvn4YP33WNp5PWtj0eE8rR9a/mE4RjtMgXxIYw2adbxiP
         TMFqZjfmFJKuWk7q1G/lD6Z0N6+os2pe7r9cChqLE9bgYFy4r+1Dp2W7hjQqDpp/iynG
         lB0HNnOEC4vQ9Kif/Y0N75gbFZZpaEY5YrjzAHKQwmZ1BZEQu+MvaAkfTZ1Q2ObBBbog
         ONeDEiwgRvjCNQ9n1e9GBoMLPjWQtMpb20jAJWNl8pwncnnN22DCu6DfGYE6ZqiMR7Fc
         3AN9/Z6eIIzkdf0YJWJZPOKoJLktybhC99fJf/5bXu5Uy+RA3RSYSuX48p9WXkRQNLVA
         AnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALLiCpjr7mz458J3wWleOaC6br8s4W7Uooo/wcb8gxM=;
        b=iTrFh/afhFFb+Mo2D4gjLCp1g1E7ZRfd/V4oWbiqZbdP2REDJJ3Vg6e75OairPP78A
         AhNZGmv6B5B+N09t+pjrODP43XhN1lO6ypBIx+B6/hx87JFbBQlfnWrIGZNe+aMo0Sax
         /iGZbJUb/BhupZvyGw7m8kq/dKlvYmNQSTZKk+fVYHvfltvDHI79PZh+Mt6oxlKHY2tD
         sqMB2Cph7VAD/sLasLHbSU17gErRJMcXe7emxN8hkrtJo1WWdoIXD83kd4YqRbbOvFAa
         Q0BDJUnZklyJ4TUBpUR7zhCRlKOxK7KZOQy1Dj+BoE3qtyHrjVM4c4obOHunhDlaR3Up
         YsOg==
X-Gm-Message-State: AO0yUKVAdvVrlkcgDBtbc00HMcYGot7oig5E3Ojn+Y/lSFkZySk5pQc/
        JJWB74i5JJtFQM3si7Z6yRSgleghKuE=
X-Google-Smtp-Source: AK7set/hLeb1yFe8fgr6YKhsbx5CPXWb1lyHY+cBC6czoLoC0yD8A5f1rjc6zk3R+0VedPLGo8cMOg==
X-Received: by 2002:a17:903:2291:b0:196:7906:b4e with SMTP id b17-20020a170903229100b0019679060b4emr1899011plh.19.1676863980536;
        Sun, 19 Feb 2023 19:33:00 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b0019462aa090bsm2160747plc.284.2023.02.19.19.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 19:32:59 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 1/2] rebase: add a --rebase-merges=drop option
Date:   Sun, 19 Feb 2023 20:32:23 -0700
Message-Id: <20230220033224.10400-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Name the new option "drop" intead of "no" or "false" to avoid confusion
in the future if --rebase-merges grows the ability to truly "rebase"
merge commits by reusing the conflict resolution information from the
original merge commit, and we want to add an option to ignore the
conflict resolution information.

This option can be used to countermand a previous --rebase-merges
option.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt |  2 +-
 builtin/rebase.c             |  2 +-
 t/t3430-rebase-merges.sh     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..92e90f96aa 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -528,7 +528,7 @@ have the long commit hash prepended to the format.
 See also INCOMPATIBLE OPTIONS below.
 
 -r::
---rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
+--rebase-merges[=(rebase-cousins|no-rebase-cousins|drop)]::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..96c0474379 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1436,7 +1436,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.exec.nr)
 		imply_merge(&options, "--exec");
 
-	if (rebase_merges) {
+	if (rebase_merges && strcmp("drop", rebase_merges)) {
 		if (!*rebase_merges)
 			; /* default mode; do nothing */
 		else if (!strcmp("rebase-cousins", rebase_merges))
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..861c8405f2 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,36 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success 'do not rebase merges unless asked' '
+	git checkout -b rebase-merges-default E &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase --rebase-merges C &&
+	test_cmp_rev HEAD $before &&
+	test_tick &&
+	git rebase C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
+test_expect_success 'do not rebase merges when asked to drop them' '
+	git checkout -b rebase-merges-drop E &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase --rebase-merges C &&
+	test_cmp_rev HEAD $before &&
+	test_tick &&
+	git rebase --rebase-merges=drop C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
 test_expect_success 'do not rebase cousins unless asked for' '
 	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
-- 
2.39.2

