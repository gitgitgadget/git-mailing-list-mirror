Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EF5C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEEA6113E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhIIJLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhIIJLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:11:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A0C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:09:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y17so1201314pfl.13
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5cX/fkXKpj867xz9YhYXSPUgsdDNT66vFLYCgfd18c=;
        b=gHatgn/lbgzAaqZRMXvva0o/jzSiEALv6vZmPiqM+j+2Tg1H6yNjGjEeHsqzOb57vX
         R5SyfGHnfV05tenMeEwtOvSo5zQrOa3WgiDKHAD/DCtOws4artS/ftvVcq04+vVNPa/2
         zrbaCLFweNJ6gQ0pVWscN4p6rjsEUiZTmgh4+2NLLK5n4l41y4QENNVzQSxlfNxEAyUt
         jBE/aLyA+RwMhDClLtmywUKl4H2IwHrhQcs9CKJE8kyp3dDc0ZOl+9GyBehqryu7+Vgh
         15ZX4DmWbvvHCV9vNX7JxguJm3VUrbhc6YIH8SXAhZi6E+RmmErTMhMXTphbyIe0dBqd
         xO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5cX/fkXKpj867xz9YhYXSPUgsdDNT66vFLYCgfd18c=;
        b=aV3hxLgW2iJ/LDoKc/fuja+gxP4AluwgS0WW1v8VNhSxRgEW7IRhcyqK1UTy9LGMep
         cYtGsdnQ22/JSCnuYNx/lNaM+G9q/sxg9ZqliNqc0r4ItgPSEPC3/v0a4mvhzcO65+NZ
         CBIWSeExwa5HTeaPmBRz/I5AdsR/0C0RmzOC4pdJy9cjsD3/su8iRKe2Vbnj+7h7Cjlz
         XyRsmXIFQp6oVHInzDlw5jX+Cm7KGYuB8BWjyLn3IHIo9VMsL6isRcAd4EtoedqFcwuJ
         JDvmoNiAI+fCd88hQPFKv9lg1AdoCRcDb4AhDf0u6thhb4aIvGxvQUJOlCgV5wTGvnva
         ubIg==
X-Gm-Message-State: AOAM532AoNwsZ/Z7Llbn8/nBquibStIpsk3Yvy+uAWszJ34ltz6MqOac
        oZL2U4VXsf3zC4sBV9m05ilzNBvQAoo=
X-Google-Smtp-Source: ABdhPJxSWDpw19IpodrdGhKS61YMMh56/qaH+wvXTnODj9h7dZ4FSlwU+f+bapFYMAP/m+PWnYeTTA==
X-Received: by 2002:a62:158a:0:b0:40d:7fae:d109 with SMTP id 132-20020a62158a000000b0040d7faed109mr2220245pfv.34.1631178598822;
        Thu, 09 Sep 2021 02:09:58 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.108])
        by smtp.gmail.com with ESMTPSA id g3sm1620908pgj.66.2021.09.09.02.09.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Sep 2021 02:09:58 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 1/1] ci: new github-action for git-l10n code review
Date:   Thu,  9 Sep 2021 17:09:27 +0800
Message-Id: <20210909090927.66336-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902023139.89251-1-worldhello.net@gmail.com>
References: <20210902023139.89251-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The repository of git-l10n is a fork of "git/git" on GitHub, and uses
GitHub pull request for code review. A helper program "git-po-helper"
can be used to check typos in ".po" files, validate syntax, and check
commit messages. It would be convenient to integrate this helper program
to CI and add comments in pull request.

The new github-action workflow will be enabled for l10n related
operations, such as:

 * Operations on a repository named as "git-po", such as a repository
   forked from "git-l10n/git-po".

 * Push to a branch that contains "l10n" in the name.

 * Pull request from a remote branch which has "l10n" in the name, such
   as: "l10n/fix-fuzzy-translations".

The new l10n workflow listens to two types of github events:

    on: [push, pull_request_target]

The reason we use "pull_request_target" instead of "pull_request" is
that pull requests from forks receive a read-only GITHUB_TOKEN and
workflows cannot write comments back to pull requests for security
reasons. GitHub provides a "pull_request_target" event to resolve
security risks by checking out the base commit from the target
repository, and provide write permissions for the workflow.

By default, administrators can set strict permissions for workflows. The
following code is used to modify the permissions for the GITHUB_TOKEN
and grant write permission in order to create comments in pull-requests.

    permissions:
      pull-requests: write

This workflow will scan commits one by one. If a commit does not look
like a l10n commit (no file in "po/" has been changed), the scan process
will stop immediately. For a "push" event, no error will be reported
because it is normal to push non-l10n commits merged from upstream. But
for the "pull_request_target" event, errors will be reported. For this
reason, additional option is provided for "git-po-helper".

    git-po-helper check-commits \
        --github-action-event="${{ github.event_name }}" -- \
        <base>..<head>

The output messages of "git-po-helper" contain color codes not only for
console, but also for logfile. This is because "git-po-helper" uses a
package named "logrus" for logging, and I use an additional option
"ForceColor" to initialize "logrus" to print messages in a user-friendly
format in logfile output. These color codes help produce beautiful
output for the log of workflow, but they must be stripped off when
creating comments for pull requests. E.g.:

    perl -pe 's/\e\[[0-9;]*m//g' git-po-helper.out

"git-po-helper" may generate two kinds of suggestions, errors and
warnings. All the errors and warnings will be reported in the log of the
l10n workflow. However, warnings in the log of the workflow for a
successfully running "git-po-helper" can easily be ignored by users.
For the "pull_request_target" event, this issue is resolved by creating
an additional comment in the pull request. A l10n contributor should try
to fix all the errors, and should pay attention to the warnings.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .github/workflows/l10n.yml | 105 +++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
new file mode 100644
index 0000000..27f72f0
--- /dev/null
+++ b/.github/workflows/l10n.yml
@@ -0,0 +1,105 @@
+name: git-l10n
+
+on: [push, pull_request_target]
+
+jobs:
+  git-po-helper:
+    if: >-
+      endsWith(github.repository, '/git-po') ||
+      contains(github.head_ref, 'l10n') ||
+      contains(github.ref, 'l10n')
+    runs-on: ubuntu-latest
+    permissions:
+      pull-requests: write
+    steps:
+      - name: Setup base and head objects
+        id: setup-tips
+        run: |
+          if test "${{ github.event_name }}" = "pull_request_target"
+          then
+            base=${{ github.event.pull_request.base.sha }}
+            head=${{ github.event.pull_request.head.sha }}
+          else
+            base=${{ github.event.before }}
+            head=${{ github.event.after }}
+          fi
+          echo "::set-output name=base::$base"
+          echo "::set-output name=head::$head"
+      - name: Run partial clone
+        run: |
+          git -c init.defaultBranch=master init --bare .
+          git remote add \
+            --mirror=fetch \
+            origin \
+            https://github.com/${{ github.repository }}
+          # Fetch tips that may be unreachable from github.ref:
+          # - For a forced push, "$base" may be unreachable.
+          # - For a "pull_request_target" event, "$head" may be unreachable.
+          args=
+          for commit in \
+            ${{ steps.setup-tips.outputs.base }} \
+            ${{ steps.setup-tips.outputs.head }}
+          do
+            case $commit in
+            *[^0]*)
+              args="$args $commit"
+              ;;
+            *)
+              # Should not fetch ZERO-OID.
+              ;;
+            esac
+          done
+          git -c protocol.version=2 fetch \
+            --progress \
+            --no-tags \
+            --no-write-fetch-head \
+            --filter=blob:none \
+            origin \
+            ${{ github.ref }} \
+            $args
+      - uses: actions/setup-go@v2
+        with:
+          go-version: '>=1.16'
+      - name: Install git-po-helper
+        run: go install github.com/git-l10n/git-po-helper@main
+      - name: Install other dependencies
+        run: |
+          sudo apt-get update -q &&
+          sudo apt-get install -q -y gettext
+      - name: Run git-po-helper
+        id: check-commits
+        run: |
+          exit_code=0
+          git-po-helper check-commits \
+            --github-action-event="${{ github.event_name }}" -- \
+            ${{ steps.setup-tips.outputs.base }}..${{ steps.setup-tips.outputs.head }} \
+            >git-po-helper.out 2>&1 || exit_code=$?
+          if test $exit_code -ne 0 || grep -q WARNING git-po-helper.out
+          then
+            # Remove ANSI colors which are proper for console logs but not
+            # proper for PR comment.
+            echo "COMMENT_BODY<<EOF" >>$GITHUB_ENV
+            perl -pe 's/\e\[[0-9;]*m//g; s/\bEOF$//g' git-po-helper.out >>$GITHUB_ENV
+            echo "EOF" >>$GITHUB_ENV
+          fi
+          cat git-po-helper.out
+          exit $exit_code
+      - name: Create comment in pull request for report
+        uses: mshick/add-pr-comment@v1
+        if: >-
+          always() &&
+          github.event_name == 'pull_request_target' &&
+          env.COMMENT_BODY != ''
+        with:
+          repo-token: ${{ secrets.GITHUB_TOKEN }}
+          repo-token-user-login: 'github-actions[bot]'
+          message: >
+            ${{ steps.check-commits.outcome == 'failure' && 'Errors and warnings' || 'Warnings' }}
+            found by [git-po-helper](https://github.com/git-l10n/git-po-helper#readme) in workflow
+            [#${{ github.run_number }}](${{ env.GITHUB_SERVER_URL }}/${{ github.repository }}/actions/runs/${{ github.run_id }}):
+
+            ```
+
+            ${{ env.COMMENT_BODY }}
+
+            ```
-- 
2.33.0

