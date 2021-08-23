Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51527C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2895B613AD
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhHWO3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhHWO3R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 10:29:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C98C061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:28:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g14so15521503pfm.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2juwDmjgEYjWJJr/tonKvDKgIotHHAiJ2jNy0O2vhhI=;
        b=LgG203RCCIeKj4q7AMi8J6o7eq2i/VRnDxWr6K8N47vXOk2+/F4MNK4rJ7QuvU9pR7
         Lo/5C2Wgn6RShh29Ywqp80yHnvaH4jc+HmhWM5QYRs5wQWao8t3zGL8zASps1sAVdvKs
         Oxl+YL/TAbTl3AJQPF52jsYRg57Xz9++RD+F+W/i+WldG2DImwsrgIZ8EIfgspuIGTqx
         1l+O5aQiDOuut1YMeiUeWoHYUMGVrJQuErGAdeeqjrdK3I0mmXqOzvBxThhnYVokvQgm
         vrqyM5XuhcygzoicotDzEuV9JTlylB+cxjeaRVw/Ra6DzUGUZ3AE0Bzbdsiv4IGQqfjv
         Vf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2juwDmjgEYjWJJr/tonKvDKgIotHHAiJ2jNy0O2vhhI=;
        b=QcSgW4wGRxyMBsKgTVW7MqIOA5UFYUwayRhZZLHk4jfHPz9nLZl6I4vpNnUqCSWhTA
         Z6akLnzSBC7jS5mEX3ktsVrf8tGoNVVlMqxn14z9abKAb15iUY4YLUr+lDsQEyHMRWBM
         Cm8WU387/eg0Uer0R3geJwJAuQZO9ZXqlfQn8DTvDrPlECS9shUilRbQAup6cYVgBcX/
         skM8gq7X+2QhMHspv9786EFxJbx3MlYtYNCREMy3HgaazE8MTgmil7YEtfAXCUFF7bfI
         750G9ZrXnqg5C+AQCpAsOs0eTUb9DSk0p/FYhk/p+EjkLHDCwK3zTVzeSKstMGNLUxk0
         aLdA==
X-Gm-Message-State: AOAM531WPh0Ac+nq9cqiMgxu+Y09NH4L5qAiVRMSFhFwqpeorcZ+Ig3N
        /lFwwRVfu5qen9mxK2OpyI0=
X-Google-Smtp-Source: ABdhPJzD8f0meaaJDPn+mHe9C7T+rBmYQ3/Zy646QPkE/SUarnIIS+2rfyGKa/8nNSyLATYocCB+Zg==
X-Received: by 2002:aa7:8802:0:b0:3e2:bb03:4560 with SMTP id c2-20020aa78802000000b003e2bb034560mr30825729pfo.62.1629728911233;
        Mon, 23 Aug 2021 07:28:31 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 143sm16125703pfx.1.2021.08.23.07.28.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Aug 2021 07:28:30 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
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
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v2 1/1] ci: new github-action for git-l10n code review
Date:   Mon, 23 Aug 2021 22:28:21 +0800
Message-Id: <20210823142821.26658-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20210822161325.22038-1-worldhello.net@gmail.com>
References: <20210822161325.22038-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Git l10n uses github pull request for code review. A helper program
"git-po-helper" can be used to check typos in ".po" files, validate
syntax, and check commit message. It would be convenient to integrate
this helper program to CI and add comments in pull request.

The new github-action workflow is added in ".github/workflows/l10n.yml",
which is disabled by default. To turn it on for the git-l10n related
repositories, such as "git-l10n/git-po", we can add a new branch named
"ci-config" and create a simple shell script at "ci/config/allow-l10n"
in this branch.

The new l10n workflow listens to two types of github events: "push" and
"pull_request_target". The "pull_request_target" event is just like the
"pull_request" event, but provides write permission to create comments
for pull request.

For a "push" event, it will scan commits one by one. If a commit does
not look like a l10n commit (no file in "po/" has been changed), it
will immediately fail without checking for further commits. While for a
"pull_request_target" event, all new introduced commits will be scanned.

"git-po-helper" will generate two kinds of suggestions, errors and
warnings. A l10n contributor should try to fix all the errors, and
should pay attention to the warnings. All the errors and warnings will
be reported in the last step of the l10n workflow with two message
groups. For a "pull_request_target" event, will create additional
comments in the pull request to report the result.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .github/workflows/l10n.yml | 156 +++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
new file mode 100644
index 0000000..bb4d8b3
--- /dev/null
+++ b/.github/workflows/l10n.yml
@@ -0,0 +1,156 @@
+name: git-l10n
+
+on: [push, pull_request_target]
+
+jobs:
+  ci-config:
+    runs-on: ubuntu-latest
+    outputs:
+      enabled: ${{ steps.check-l10n.outputs.enabled }}
+    steps:
+      - name: try to clone ci-config branch
+        run: |
+          git -c protocol.version=2 clone \
+            --no-tags \
+            --single-branch \
+            -b ci-config \
+            --depth 1 \
+            --no-checkout \
+            --filter=blob:none \
+            https://github.com/${{ github.repository }} \
+            config-repo &&
+          cd config-repo &&
+          git checkout HEAD -- ci/config || : ignore
+      - id: check-l10n
+        name: check whether CI is enabled for l10n
+        run: |
+          enabled=no
+          if test -x config-repo/ci/config/allow-l10n &&
+             config-repo/ci/config/allow-l10n '${{ github.ref }}'
+          then
+            enabled=yes
+          fi
+          echo "::set-output name=enabled::$enabled"
+
+  git-po-helper:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+      with:
+        fetch-depth: '0'
+    - name: Fetch missing commits
+      id: fetch-commits
+      run: |
+        if test "${{ github.event_name }}" = "pull_request_target"
+        then
+          base=${{ github.event.pull_request.base.sha }}
+          head=${{ github.event.pull_request.head.sha }}
+        else
+          base=${{ github.event.before }}
+          head=${{ github.event.after }}
+        fi
+        for commit in $base $head
+        do
+          if echo $commit | grep -q "^00*$"
+          then
+            continue
+          fi
+          if ! git rev-parse --verify --end-of-options "$commit^{commit}" --
+          then
+            git fetch origin $commit
+          fi
+        done
+        echo "::set-output name=base::$base"
+        echo "::set-output name=head::$head"
+
+    - uses: actions/setup-go@v2
+      with:
+        go-version: ">=1.16"
+    - name: Install git-po-helper
+      run: |
+        go install github.com/git-l10n/git-po-helper@main
+    - name: Install other dependencies
+      run: |
+        sudo apt-get update -q &&
+        sudo apt-get install -q -y gettext
+    - name: Run git-po-helper
+      id: check-commits
+      run: |
+        exit_code=0
+        git-po-helper check-commits \
+            --github-action \
+            --github-action-event "${{ github.event_name }}" -- \
+            ${{ steps.fetch-commits.outputs.base }}..${{ steps.fetch-commits.outputs.head }} \
+            >git-po-helper.out 2>&1 ||
+          exit_code=$?
+        echo "::set-output name=exit_code::$exit_code"
+        has_error_msg=
+        has_warning_msg=
+        if test $exit_code -ne 0
+        then
+          has_error_msg=yes
+          if test "${{ github.event_name }}" = "pull_request_target"
+          then
+            echo "ERROR_MSG<<EOF" >>$GITHUB_ENV
+            grep -v -e "^level=warning" -e WARNING git-po-helper.out |
+              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
+            echo "EOF" >>$GITHUB_ENV
+          fi
+        fi
+        if grep -q -e "^level=warning" -e WARNING git-po-helper.out
+        then
+          has_warning_msg=yes
+          if test "${{ github.event_name }}" = "pull_request_target"
+          then
+            echo "WARNING_MSG<<EOF" >>$GITHUB_ENV
+            grep -v -e "^level=error" -e ERROR git-po-helper.out |
+              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
+            echo "EOF" >>$GITHUB_ENV
+          fi
+        fi
+        echo "::set-output name=has_error_msg::$has_error_msg"
+        echo "::set-output name=has_warning_msg::$has_warning_msg"
+    - name: Report errors in comment for pull request
+      uses: mshick/add-pr-comment@v1
+      if: steps.check-commits.outputs.has_error_msg == 'yes' && github.event_name == 'pull_request_target'
+      continue-on-error: true
+      with:
+        repo-token: ${{ secrets.GITHUB_TOKEN }}
+        repo-token-user-login: 'github-actions[bot]'
+        message: |
+          Errors found by git-po-helper in workflow ${{ github.workflow }}:
+          ```
+          ${{ env.ERROR_MSG }}
+          ```
+    - name: Report warnings in comment for pull request
+      uses: mshick/add-pr-comment@v1
+      if: steps.check-commits.outputs.has_warning_msg == 'yes' && github.event_name == 'pull_request_target'
+      continue-on-error: true
+      with:
+        repo-token: ${{ secrets.GITHUB_TOKEN }}
+        repo-token-user-login: 'github-actions[bot]'
+        message: |
+          Warnings found by git-po-helper in workflow ${{ github.workflow }}:
+          ```
+          ${{ env.WARNING_MSG }}
+          ```
+    - name: Final report
+      run: |
+        if test "${{ steps.check-commits.outputs.has_error_msg }}" = "yes"
+        then
+          echo "::group::Errors found by git-po-helper"
+          grep -v -e "^level=warning" -e WARNING git-po-helper.out
+          echo "::endgroup::"
+        fi
+        if test "${{ steps.check-commits.outputs.has_warning_msg }}" = "yes"
+        then
+          echo "::group::Warnings found by git-po-helper"
+          grep -v -e "^level=error" -e ERROR git-po-helper.out
+          echo "::endgroup::"
+        fi
+        if test ${{ steps.check-commits.outputs.exit_code }} -ne 0
+        then
+          exit ${{ steps.check-commits.outputs.exit_code }}
+        fi
-- 
2.33.0

