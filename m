Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44AC43457
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 21:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1078D2076C
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 21:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM+WucDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgJKV1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbgJKV1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 17:27:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DDC0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 14:27:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b8so3645934wrn.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nt+4oFmKua2yAFvBSems8RziG/3R9d3LE4EpTPcWeQE=;
        b=UM+WucDYXTQQfW5/idZiOEjmasQdx89RqwqgyWfiQR8KdyXj8Cp1q++D/YEqUdFprh
         V7eGg3L27FpeDaSx1oT9UjNqwkEKZCvhHQStQpDC1ohdhYjKq3W7ExD1gRGjs9jxK4PO
         A+zKB06AQgcfA25SzI7QGrb5S0Ixwy6EibpOmAxieVkfYEDk+ffgu8UJb7CO4BXDltXH
         0T4dP9fYqd/8E/58BmXQgvBO5UAgrmMFKV7Bdt02eCpgjl30xw7JOIb4njieKurbf4u0
         8wvK8PfCwl7xeILHPqtLZ5rAhJa/fRbfvRUwj9qrlzXX/xMbEuBT7tJ3icUTAoP+qF1R
         2xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nt+4oFmKua2yAFvBSems8RziG/3R9d3LE4EpTPcWeQE=;
        b=lASSqDiQUuLnlwmWRuE0KT123uTOIfQdcJFGJKzHJgiKIb9RymrAVN2tCcMeXY0gR6
         fLZ4tb2lxggbkhWtsEFMPdLBpkC/EPf1zda5LlIobaDTIdLMf9wdRkFtZYTm7yCVucZb
         mTB4/l+UZQyHuYUcTrrySnKV5sVyWtAFCZC8JGXhmMY7lSmUS6kzLRjlfJQ1fTJmnnTC
         /iNN0IRcIiSSCIJSG5PcvxPYvcJZhC1k2L31oPqwwB3KALpP02HWkoLI9Iy4qObLXUZg
         nQl+TjAynKiBy6VFL/2GBh8WvaApYBAqUN0KWVuyVaKvcdAMI+2HrHd3rhDi+++/r+Lm
         25BA==
X-Gm-Message-State: AOAM532bHxxYtzAHb9n1TorOCA4T6Svzi9KOIAM/wigC1Co3UmDrrFSW
        jhof7SF5Zs/zLk65mcVAbfnoeMuDm4w=
X-Google-Smtp-Source: ABdhPJzX4UXJuR/35Eq5b3JXG25spoProyfMcaUkICYORFQfevzrVcktWaQKVgsXHZyhrzEyJx+UZA==
X-Received: by 2002:adf:94e3:: with SMTP id 90mr24579825wrr.380.1602451634126;
        Sun, 11 Oct 2020 14:27:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a127sm25444007wmh.13.2020.10.11.14.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 14:27:13 -0700 (PDT)
Message-Id: <5c889e487d344efd1a0eb0cb5b717375de450c89.1602451631.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.748.git.1602451631.gitgitgadget@gmail.com>
References: <pull.748.git.1602451631.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Oct 2020 21:27:11 +0000
Subject: [PATCH 2/2] ci: make the "skip-if-redundant" check more defensive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 7d78d5fc1a9 (ci: skip GitHub workflow runs for already-tested
commits/trees, 2020-10-08), we added a check that determines whether
there is already a workflow run for the given commit (or at least tree),
and if found, skips the current run.

We just worked around an issue with this check where older runs might
unexpectedly miss the `head_commit` attribute.

Let's be even more defensive by catching all kinds of exceptions,
logging them as warnings, and continue the run without skipping it
(after all, if the check fails, we _want_ to continue with the run).

This commit is best viewed with the diff option `-w` because it
increases the indentation level of the GitHub Action script by two
spaces, surrounding it by a `try ... catch` construct.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 58 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d4298878f5..9dc359bc23 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -41,35 +41,39 @@ jobs:
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
           script: |
-            // Figure out workflow ID, commit and tree
-            const { data: run } = await github.actions.getWorkflowRun({
-              owner: context.repo.owner,
-              repo: context.repo.repo,
-              run_id: context.runId,
-            });
-            const workflow_id = run.workflow_id;
-            const head_sha = run.head_sha;
-            const tree_id = run.head_commit.tree_id;
+            try {
+              // Figure out workflow ID, commit and tree
+              const { data: run } = await github.actions.getWorkflowRun({
+                owner: context.repo.owner,
+                repo: context.repo.repo,
+                run_id: context.runId,
+              });
+              const workflow_id = run.workflow_id;
+              const head_sha = run.head_sha;
+              const tree_id = run.head_commit.tree_id;
 
-            // See whether there is a successful run for that commit or tree
-            const { data: runs } = await github.actions.listWorkflowRuns({
-              owner: context.repo.owner,
-              repo: context.repo.repo,
-              per_page: 500,
-              status: 'success',
-              workflow_id,
-            });
-            for (const run of runs.workflow_runs) {
-              if (head_sha === run.head_sha) {
-                core.warning(`Successful run for the commit ${head_sha}: ${run.html_url}`);
-                core.setOutput('enabled', ' but skip');
-                break;
-              }
-              if (run.head_commit && tree_id === run.head_commit.tree_id) {
-                core.warning(`Successful run for the tree ${tree_id}: ${run.html_url}`);
-                core.setOutput('enabled', ' but skip');
-                break;
+              // See whether there is a successful run for that commit or tree
+              const { data: runs } = await github.actions.listWorkflowRuns({
+                owner: context.repo.owner,
+                repo: context.repo.repo,
+                per_page: 500,
+                status: 'success',
+                workflow_id,
+              });
+              for (const run of runs.workflow_runs) {
+                if (head_sha === run.head_sha) {
+                  core.warning(`Successful run for the commit ${head_sha}: ${run.html_url}`);
+                  core.setOutput('enabled', ' but skip');
+                  break;
+                }
+                if (run.head_commit && tree_id === run.head_commit.tree_id) {
+                  core.warning(`Successful run for the tree ${tree_id}: ${run.html_url}`);
+                  core.setOutput('enabled', ' but skip');
+                  break;
+                }
               }
+            } catch (e) {
+              core.warning(e);
             }
 
   windows-build:
-- 
gitgitgadget
