Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B59C4363C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16CD221974
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFQgARv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgJHP3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgJHP3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 11:29:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE5AC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 08:29:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p15so6887764wmi.4
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WbDPi4xUn3dvdGulAdgO88VoTq9chezruhV/7xOiJMY=;
        b=JFQgARv2mqREXfI1fE6mh37HoNaxEKK4ISVVrx5PGOkur+aqrrRu6VIYn4YNywCtpu
         Qb26jwZOifdRWUITqYXu200GVTp8NeCfGG9VDpFLy8N9HFeLsTwznGBUmrFRJDO167l3
         5X8mWkodBzRPMBc6qiIRCf2sLk9GF4rLtyi0hNKsaNSHB7SUiRGb5YFbk5bOthwJDyWG
         LaY9MZ2T92SHzkIzJ+822EGB0BYhYEMoaCkzP072tezp3HIc0ssCTls4cjxy7CIXVhyz
         UXQDhWsoG3xCM9I+kNwdls/0pfmd/Z+gKCW213/DIx7lbhrBu4YbEKYnwEryQeuITsub
         fyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WbDPi4xUn3dvdGulAdgO88VoTq9chezruhV/7xOiJMY=;
        b=XXd4CEkavhvOYuU+STY+0WMM/yEt/IYwrQk+q+GRSLTws0WMpcngHxVzWqrXY5lvHs
         9QKk+yzGN5KqrGMcmGkVNJ2rFqwOsC/dhBwWo3Bf+yCQyYW8rrh6JlOIJoc8u7e2a0gA
         Yvu4TKruD7SOvJtYddm3NJWjf7oHD/a8RjZz+ZsOx13CY1HaehaBrMx2pEncXkeeyWAx
         NKQUBXs2JwIIQTNMa4GitokuwZ3H75MbjE5a/sP5I37TKUkneTF4G5W7Xua8g1QtAaJ1
         0a87ikG9nlg4Klya5wy55CcIVyLnotnd2qatQC8UWmTAlGEk61E3638vk/HTRC6E+o1Z
         cA+g==
X-Gm-Message-State: AOAM533YAYq5nngJ43cNj7hWjZ9XqUGT0Aw0rPHeynEA9f0w0cJngrby
        WcAPmmZJ8P7wUWmn5LyUoCmJHGhQGvw=
X-Google-Smtp-Source: ABdhPJxne+B7J8Vn05SEg9PI1pmTNyFokaN0RaRRxQUCWdOh3fm6cd/3K4BjKzoYanrhkrnHTY6I+A==
X-Received: by 2002:a7b:cb8d:: with SMTP id m13mr629378wmi.59.1602170978510;
        Thu, 08 Oct 2020 08:29:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b25sm5192006wmj.21.2020.10.08.08.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:29:38 -0700 (PDT)
Message-Id: <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
        <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 15:29:34 +0000
Subject: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
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

When pushing a commit that has already passed a CI or PR build
successfully, it makes sense to save some energy and time and skip the
new build.

Let's teach our GitHub workflow to do that.

For good measure, we also compare the tree ID, which is what we actually
test (the commit ID might have changed due to a reworded commit message,
which should not affect the outcome of the run).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5bd321e5e1..7391b46d61 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -9,7 +9,7 @@ jobs:
   ci-config:
     runs-on: ubuntu-latest
     outputs:
-      enabled: ${{ steps.check-ref.outputs.enabled }}
+      enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
     steps:
       - name: try to clone ci-config branch
         continue-on-error: true
@@ -35,6 +35,43 @@ jobs:
             enabled=no
           fi
           echo "::set-output name=enabled::$enabled"
+      - name: skip if the commit or tree was already tested
+        id: skip-if-redundant
+        uses: actions/github-script@v3
+        if: steps.check-ref.outputs.enabled == 'yes'
+        with:
+          github-token: ${{secrets.GITHUB_TOKEN}}
+          script: |
+            // Figure out workflow ID, commit and tree
+            const { data: run } = await github.actions.getWorkflowRun({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              run_id: context.runId,
+            });
+            const workflow_id = run.workflow_id;
+            const head_sha = run.head_sha;
+            const tree_id = run.head_commit.tree_id;
+
+            // See whether there is a successful run for that commit or tree
+            const { data: runs } = await github.actions.listWorkflowRuns({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              per_page: 500,
+              status: 'success',
+              workflow_id,
+            });
+            for (const run of runs.workflow_runs) {
+              if (head_sha === run.head_sha) {
+                core.warning(`Successful run for the commit ${head_sha}: ${run.html_url}`);
+                core.setOutput('enabled', ' but skip');
+                break;
+              }
+              if (tree_id === run.head_commit.tree_id) {
+                core.warning(`Successful run for the tree ${tree_id}: ${run.html_url}`);
+                core.setOutput('enabled', ' but skip');
+                break;
+              }
+            }
 
   windows-build:
     needs: ci-config
-- 
gitgitgadget

