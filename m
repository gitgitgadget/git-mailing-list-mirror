Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE65C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 02:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED9D61058
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 02:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbhIBCcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 22:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhIBCcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 22:32:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EDCC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 19:31:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so437119pjt.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZPwFRMmMKMtbEqvPK4JOEFPxvQ9KOcNgeG7ffs6O4k=;
        b=jEBwSit/2o2Jh++77+ks8SNLlKv5wW753hfZMv0EFDLb5sucIxPhKxf25vGmbFKYrb
         TCFErQrLCWfoNbaMtwI0HRaf2clB9duomrRsTZjeH6gqF9wdDAtZat35MUsl+v3/JLYW
         pU6gzDSDmH7Vr2wUSTXPKsCZBzvComsSPUevHuxUWbhxHou2EzoYyIGU29ijspLKx3Vx
         uM/Yf2l672qobp0uUCrT5kJc4grdCEzeANHUKPqJ9vun/siGTQykHgEjd2dYVZLW7rBC
         PO3no+l871ltfQM4ckmyaIEK7gnyOE+sGrDu6BzBXExqxHZjK+kcvSsPeL87RSHfzpTW
         DJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZPwFRMmMKMtbEqvPK4JOEFPxvQ9KOcNgeG7ffs6O4k=;
        b=E9bNYRA+46X15qipRNlaIhpsb3iltKvYLa9KJ8gV0zPd0E/R0VHrFg4/PH2a6zQHUW
         TGw+prxjeOekDQWwD49vz0ikjNa0j8qFN4U9NEXlS8nEW/Gb+jcEzvTk7H1YmGv66UCt
         GLJ1mrSMLS11WsS+VSXyW51AaSIAsIXsNGDzlqxcr7PrI1mF7kg7HvqmzTGhMAE8ArPu
         iizWB7Fi1t5sMbHeL6IUr7/YArP9KdBkIgNTbWqikIcPIm2RhWi12U1m33UJbN4Xdt40
         d0bFYnurFy0wID09XOf1EDGbEFPUWTpx8gGJOKPO5r8kSR4kggvEW0wl4vcM8XLHlDMo
         djDw==
X-Gm-Message-State: AOAM532H9i5aUgOTCDlGKvPIZGcEooMvbnlkvARBk45FVcq/P+dWrbf+
        li9uAu0SsHGGQ0BBsa6UIYJ/beFB7nc=
X-Google-Smtp-Source: ABdhPJwadRKd6OZf+HZE0EZIUsRiIotINCKkushbYV1UKkf3ah3Pdo6aYzvOjNchJyTZo7kvTn4wEg==
X-Received: by 2002:a17:90a:f2c4:: with SMTP id gt4mr1052619pjb.219.1630549914546;
        Wed, 01 Sep 2021 19:31:54 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.109])
        by smtp.gmail.com with ESMTPSA id 186sm289518pfg.11.2021.09.01.19.31.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 19:31:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 1/1] ci: new github-action for git-l10n code review
Date:   Thu,  2 Sep 2021 10:31:39 +0800
Message-Id: <20210902023139.89251-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CANYiYbESO7bvyuRcypmVKvqAdLk5492q5fUPu5ArdCY5PHzFSQ@mail.gmail.com>
References: <CANYiYbESO7bvyuRcypmVKvqAdLk5492q5fUPu5ArdCY5PHzFSQ@mail.gmail.com>
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
 .github/workflows/l10n.yml | 93 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
new file mode 100644
index 0000000..7e2385d
--- /dev/null
+++ b/.github/workflows/l10n.yml
@@ -0,0 +1,93 @@
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
+      - uses: actions/checkout@v2
+        with:
+          fetch-depth: '1'
+      - name: Fetch missing commits
+        id: fetch-commits
+        run: |
+          if test "${{ github.event_name }}" = "pull_request_target"
+          then
+            base=${{ github.event.pull_request.base.sha }}
+            head=${{ github.event.pull_request.head.sha }}
+          else
+            base=${{ github.event.before }}
+            head=${{ github.event.after }}
+          fi
+          args=
+          for commit in $base $head
+          do
+            case $commit in
+            *[^0]*)
+              args="$args $commit"
+              ;;
+            *)
+              # Ignore ZERO-OID.
+              ;;
+            esac
+          done
+          # Unshallow the repository, and fetch missing commits using partial
+          # clone.  "$base" may be missing due to forced push, and "$head"
+          # may be missing due to the "pull_request_target" event.
+          git fetch --unshallow --filter=blob:none origin $args
+          echo "::set-output name=base::$base"
+          echo "::set-output name=head::$head"
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
+              --github-action-event="${{ github.event_name }}" -- \
+              ${{ steps.fetch-commits.outputs.base }}..${{ steps.fetch-commits.outputs.head }} \
+              >git-po-helper.out 2>&1 ||
+            exit_code=$?
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

