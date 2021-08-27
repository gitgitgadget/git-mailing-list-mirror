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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5589BC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E6460FC4
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbhH0HOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhH0HOW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 03:14:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1BCC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:13:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j2so3392617pll.1
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5v3ALVxQTiUPOAvZHqAgySOb/0+ocMUZJphYEUC/K4=;
        b=Xp5Z9gW8vsu/Ssk+7hooa7KzNX93LVK3EzZqRYIdiIxMj45M32ljxVrOtGr7zqBNqP
         D5kMhs1Ii9ufLbb+Gaz/tVL5elQ1OiBUQsBDtxE5c0P2t4ukGdFZE/m4Npv1C9vmA9q6
         ggqk5NXx6pGO3MkP4lOnqJfe5ghLYdBIUqi7SHyHrBxsJiy7GCtiepVFKXKMpOIpJLNA
         1AoGlAEKBIa6MC1wvjnMoOHFsx3ZweMjHgmwzmkV37fES0pNKctHFZHvckBjBkjd80X4
         uHGmnX5/b0Y3btQurahA8MqBhhChuNXPybG5MallZ8PeyeaXW667ikTG4GmNeZbHFn6O
         pzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5v3ALVxQTiUPOAvZHqAgySOb/0+ocMUZJphYEUC/K4=;
        b=twoYQI4zM6AmQQmY7P19gTx1oWYIoeUk6mfCPmimER/FDOJ1vUeAZATwFGPm8v0JEG
         YQTmB4sICmFqeK1Akrj4ifcVhd+DbY3CMcCAb9sy5oiV/3eEZiHE2wY+H0Hy0XnCPDjU
         Hk2JQJ0mvd86AKcyW5fM49o2JQnCssNgqELKqJql4B/PXfMI9IyeKKBG54ORrc90OItN
         8lKous5cU4T7QPxyZbPMbao3E7ddhsLwThxUO++ncFqaSYjce6bpzHnO3fYqSQTv20ZK
         YbUipjQk0qLRY1fJwHsAEFji66WFQbEAsDfkuVUenvy1vrbGASf7cm9FKRmUN2QImQAk
         ZnVQ==
X-Gm-Message-State: AOAM530Dz98d3YC3ModtO0iJXm2cv8vwDkn03f7OdzrLnEasYDX8g3AK
        ofMoPn0JJ9ppTjaYbZ79P534Lys1nuBjDA==
X-Google-Smtp-Source: ABdhPJzClZIqxXHrn5fMFBD9iumVcs4FRR0fb8pw+S+RKyVTrvfWvFvQuKv2GfWWWbvvEaAS6wMzyA==
X-Received: by 2002:a17:90a:1915:: with SMTP id 21mr9987226pjg.24.1630048413154;
        Fri, 27 Aug 2021 00:13:33 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.111])
        by smtp.gmail.com with ESMTPSA id q12sm5195836pfj.153.2021.08.27.00.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:13:32 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3] ci: new github-action for git-l10n code review
Date:   Fri, 27 Aug 2021 15:13:20 +0800
Message-Id: <20210827071320.14183-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CANYiYbESO7bvyuRcypmVKvqAdLk5492q5fUPu5ArdCY5PHzFSQ@mail.gmail.com>
References: <CANYiYbESO7bvyuRcypmVKvqAdLk5492q5fUPu5ArdCY5PHzFSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Repository of git-l10n is a fork from "git/git" on GitHub, and uses
GitHub pull request for code review. A helper program "git-po-helper"
can be used to check typos in ".po" files, validate syntax, and check
commit messages. It would be convenient to integrate this helper program
to CI and add comments in pull request.

The new github-action workflow is added in ".github/workflows/". It will
only be enabled for the following cases:

 * A repository named as "git-po", such as a repository forked from
   "git-l10n/git-po".

 * Push to the branch that contains "l10n" in the name.

 * Pull reqeust from a remote branch which has "l10n" in the name, such
   as: "l10n/fix-fuzzy-translations".

The new l10n workflow listens to two types of github events:

    on: [push, pull_request_target]

The reason we use "pull_request_target" instead of "pull_request" is
that for security reasons, pull requests from forks receive a read-only
GITHUB_TOKEN and workflows cannot write comments back to pull requests.
GitHub provides a "pull_request_target" event to resolve security risks
by checking out the base commit from the target repository, and provide
write permissions for the workflow.

By default, adminstrators can set strict permissions for workflows. The
following code is used to modify the permissions for the GITHUB_TOKEN
and give write permission in order to create comments in pull-requests.

    permissions:
      pull-requests: write

This workflow will scan commits one by one. If a commit does not look
like a l10n commit (no file in "po/" has been changed), the scan process
will stop immediately. For a "push" event, no error will be reported
because it is normal to push non-l10n commits merged from upstream. But
for the "pull_request_target" event, errors will be reported.
For this reason, additional option is provided for "git-po-helper".

    git-po-helper check-commits \
        --github-action-event="${{ github.event_name }}" -- \
        <base>..<head>

The output messages of "git-po-helper" contain color codes not only for
console, but also for logfile. This is because "git-po-helper" uses a
package named "logrus" for logging, and I use an additional option
"ForceColor" to initialize "logrus" to print messages in a user-friendly
format in logfile output. These color codes help produce beautiful
output for logs of workflow, but they must be stripped off when creating
comments for pull requests. E.g.:

    perl -pe 's/\e\[[0-9;]*m//g' git-po-helper.out

"git-po-helper" may generate two kinds of suggestions, errors and
warnings. All the errors and warnings will be reported in the log
the l10n workflow. For a "pull_request_target" event, an additional
comment will be created in the pull request to report the result.
A l10n contributor should try to fix all the errors, and should pay
attention to the warnings.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .github/workflows/l10n.yml | 91 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
new file mode 100644
index 0000000..4129fa3
--- /dev/null
+++ b/.github/workflows/l10n.yml
@@ -0,0 +1,91 @@
+name: git-l10n
+
+on: [push, pull_request_target]
+
+jobs:
+  git-po-helper:
+    if: endsWith(github.repository, '/git-po') || contains(github.head_ref, 'l10n') || contains(github.ref, 'l10n')
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
+          # Setup partial clone.
+          git config remote.origin.promisor true
+          git config remote.origin.partialCloneFilter blob:none
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
+          # Unshallow the repository, and fetch missing commits.
+          # "$base" may be missing due to forced push, and "$head"
+          # may be missing due to the "pull_request_target" event.
+          git fetch --unshallow origin $args
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
+          create_comment=
+          git-po-helper check-commits \
+              --github-action-event="${{ github.event_name }}" -- \
+              ${{ steps.fetch-commits.outputs.base }}..${{ steps.fetch-commits.outputs.head }} \
+              >git-po-helper.out 2>&1 ||
+            exit_code=$?
+          if test $exit_code -ne 0 ||
+            grep -q -e "^level=warning" -e WARNING git-po-helper.out
+          then
+            create_comment=yes
+            # Remove ANSI colors which are proper for console logs but not
+            # proper for PR comment.
+            echo "COMMENT_BODY<<EOF" >>$GITHUB_ENV
+            perl -pe 's/\e\[[0-9;]*m//g; s/\bEOF$//g' git-po-helper.out >>$GITHUB_ENV
+            echo "EOF" >>$GITHUB_ENV
+          fi
+          echo "::set-output name=create_comment::$create_comment"
+          cat git-po-helper.out
+          exit $exit_code
+      - name: Report in comment for pull request
+        uses: mshick/add-pr-comment@v1
+        if: always() && steps.check-commits.outputs.create_comment== 'yes' && github.event_name == 'pull_request_target'
+        continue-on-error: true
+        with:
+          repo-token: ${{ secrets.GITHUB_TOKEN }}
+          repo-token-user-login: 'github-actions[bot]'
+          message: |
+            ${{ steps.check-commits.outcome == 'failure' && 'Errors and warnings' || 'Warnings' }} found by [git-po-helper](https://github.com/git-l10n/git-po-helper#readme) in workflow [#${{ github.run_number }}](${{ env.GITHUB_SERVER_URL }}/${{ github.repository }}/actions/runs/${{ github.run_id }}):
+
+            ```
+            ${{ env.COMMENT_BODY }}
+            ```
-- 
2.33.0

