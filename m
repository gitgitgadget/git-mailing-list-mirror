Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90878C4727C
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 07:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE7523A1E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 07:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luddb+Bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgIVH2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgIVH2H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 03:28:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B799C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 00:28:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w5so15845954wrp.8
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 00:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ZiJsJjxbLXTlmvveLHp8v8mI7RXCLopT3H4KQd7KPWM=;
        b=luddb+BpZQ75pvmVAZHYSe5wVLAu9gx8N2B7SGF5ow4AZkdZS4ixDE+mOnXfSukSZg
         adb+003CXeUwG8OsugM3VHsop+z3JDgZRdWaF1H219Qber+lVfG/BD7mNcVi22BvN8Gg
         5KkbySkm5y865y9OgRKb6zIrO9SQgreF+I143C1earpyc4LVXBTaMmLZBRuchC8aTOi1
         027ihEU2WeX7pQAB3rtAy1omHAtSX5Vyuki0ESzZ9HeAow+AEFFCYMHbdUci5ceJMk/X
         HidVGQMPk4vBq8Cj82R1pcV1l8UR0iI2EKFE+5hxPkWFt8m9/zUdrBzrUhdoTg4m0EX0
         jhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZiJsJjxbLXTlmvveLHp8v8mI7RXCLopT3H4KQd7KPWM=;
        b=r4vROhtgC0Xv+m5V2Xu5Lb/zUUD98XUjqMpzMEbARfNMg6B45hEGy6tzTddOq8qMrQ
         XrkICxgf9/kTR4nBAyKUVWMiqzScTEWDOeNzoAMvm43XjmxcjWMdl/1JbA3IZtf8SOaH
         TFoMjXTfsN9ZwW4rawBJwQ6lRJ8x0xDOUuPJFuF1CHdtIIg+GovwiazH4Ep4gWsSB408
         Q0fdh5e4BBrfwg++fyYkRPt+WiABAGXjtemAn138pFn76CJnMIxqCZDWh4Rqnn0IaZ5a
         Reu0/WKG23KV+B/8i1ExqOOZTQYGK40JtPEYhfV9qiuL2dJH5E1lPExiVNHhxKRluhQH
         zHPw==
X-Gm-Message-State: AOAM5338QKk41HPaHPve/ljBglA2RrI40/m3XpYJCCmOVaK88/TS8tSb
        7w/jww3IMIs6tT82w34VGeay1XhytgI=
X-Google-Smtp-Source: ABdhPJzDkgs/7Ls3q5L7x75PnRdwqKBSRpP+BhU+9KC5HPpNwUiGRPxUIW76IcgkACjJFMsTzoKSvg==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr3950104wru.103.1600759685794;
        Tue, 22 Sep 2020 00:28:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm3649064wma.29.2020.09.22.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 00:28:05 -0700 (PDT)
Message-Id: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Sep 2020 07:28:04 +0000
Subject: [PATCH] ci: github action - add check for whitespace errors
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>,
        "Chris. Webster" <chris@webstech.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Chris. Webster" <chris@webstech.net>

Not all developers are aware of `git diff --check` to warn
about whitespace issues.  Running a check when a pull request is
opened or updated can save time for reviewers and the submitter.

A GitHub workflow will run when a pull request is created or the
contents are updated to check the patch series.  A pull request
provides the necessary information (number of commits) to only
check the patch series.

To ensure the developer is aware of any issues, a comment will be
added to the pull request with the check errors.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
    ci: GitHub Action - add check for whitespace errors
    
    Not all developers are aware of git diff --check to warn about
    whitespace issues. Running a check when a pull request is opened or
    updated can save time for reviewers and the submitter.
    
    A GitHub workflow will run when a pull request is created or the
    contents are updated to check the patch series. A pull request provides
    the necessary information (number of commits) to only check the patch
    series.
    
    To ensure the developer is aware of any issues, a comment will be added
    to the pull request with the check errors.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-709%2Fwebstech%2Fcw%2Fdiffcheck-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-709/webstech/cw/diffcheck-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/709

 .github/workflows/check-whitespace.yml | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 .github/workflows/check-whitespace.yml

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
new file mode 100644
index 0000000000..9d070b9cdf
--- /dev/null
+++ b/.github/workflows/check-whitespace.yml
@@ -0,0 +1,69 @@
+name: check-whitespace
+
+# Get the repo with the commits(+1) in the series.
+# Process `git log --check` output to extract just the check errors.
+# Add a comment to the pull request with the check errors.
+
+on:
+  pull_request:
+    types: [opened, synchronize]
+
+jobs:
+  check-whitespace:
+    runs-on: ubuntu-latest
+    steps:
+    - name: Set commit count
+      shell: bash
+      run: echo "::set-env name=COMMIT_DEPTH::$((1+$COMMITS))"
+      env:
+        COMMITS: ${{ github.event.pull_request.commits }}
+
+    - uses: actions/checkout@v2
+      with:
+        fetch-depth: ${{ env.COMMIT_DEPTH }}
+
+    - name: git log --check
+      id: check_out
+      run: |
+        log=
+        commit=
+        while read dash etc
+        do
+          case "${dash}" in
+          "---")
+            commit="${etc}"
+            ;;
+          "")
+            ;;
+          *)
+            if test -n "${commit}"
+            then
+              log="${log}\n${commit}"
+              echo ""
+              echo "--- ${commit}"
+            fi
+            commit=
+            log="${log}\n${dash} ${etc}"
+            echo "${dash} ${etc}"
+            ;;
+          esac
+        done <<< $(git log --check --pretty=format:"---% h% s" -${{github.event.pull_request.commits}})
+
+        if test -n "${log}"
+        then
+          echo "::set-output name=checkout::"${log}""
+          exit 2
+        fi
+
+    - name: Add Check Output as Comment
+      uses: actions/github-script@v3
+      id: add-comment
+      with:
+        script: |
+            github.issues.createComment({
+              issue_number: context.issue.number,
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              body: "Whitespace errors found in workflow ${{ github.workflow }}:\n\n${{ steps.check_out.outputs.checkout }}"
+            })
+      if: ${{ failure() }}

base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
-- 
gitgitgadget
