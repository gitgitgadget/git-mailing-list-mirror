Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D45C4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EEE613CD
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhHWO3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhHWO3O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 10:29:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7AAC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:28:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j187so15515207pfg.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yn4oO28C1rssHuFrb5ZN0egs6RnNma54pMcQin+5ZYA=;
        b=RfvT2rDtr58/YxsvQ5lx1qxWAXIHfAbKA5fKCak9vmeqMUlz7djYRhhOjpBdMSwbnF
         Fyj2afmH7KuLHalLnW8LYNX0dXDcU2NFJD4tTQISWl7N4P5NniWGC/LcM1zAXqrIoPqe
         AZAtkpEJy8mau+EU7YBQzHEcSf1ilsvz/rcYQk0H5VNlUPkSGJKLLBTmoRvLNPQ2bntV
         tDI0FE5g1EXBsabZWw076z7dPA+L03AgcTxRcjEVMGUK9niLCadsNwg/u/UVZdk6DtM2
         DJsBb2EZC1y/GHFkuBirHWaIx1o7k5m66KEcaGFRVXO+dlYzJyx5+B33Sos6Ey5OSNm9
         k9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yn4oO28C1rssHuFrb5ZN0egs6RnNma54pMcQin+5ZYA=;
        b=S5B7x8NFT+EVPFHmFwP1yQLR3IG7+KWrP8v7bpXVfbX+pVriE+JQQdfLgf5kPkEt6E
         SocC1CEDva8kw2tBQwOFUXJDr3kVJgoDUtKl6lBcJo70HD1U4ObZO8VmYQKjBDmqzAjt
         04uZuwYx+85PAjPsL+Y93khgD5TescLVzTJDaBgoKg7RhnU3dCPyRtlu85edz1cjrMe9
         AiSFoMZmMEMwPxBQG+g559EY8ltG7KRNe38J6VIcBs/JiF1FZXEmJ/ikYziPBNPBDo2J
         0dfENSZb1Gl/o7DfuZfXMyNBqyNP0xjHwK0TOBx4/xbf1fvQ/VCzbYp+lo78cw6bhvRI
         4T5g==
X-Gm-Message-State: AOAM531/fBmvczzq8dJv6niA2Vfq5jJfg0llZzwdh1yZQV4xKKCM7/HN
        kMWJ9hrpIOqp/VKBb/4oQdM=
X-Google-Smtp-Source: ABdhPJy0Ayn8GXjVlsuScmVGfkA4oVgAwvGNURbV+CxXN3PSEkYQeAyaRU0L+3TR2YOvyIcw0WrPGA==
X-Received: by 2002:aa7:86c3:0:b0:3eb:1857:8ae9 with SMTP id h3-20020aa786c3000000b003eb18578ae9mr10795851pfo.52.1629728909683;
        Mon, 23 Aug 2021 07:28:29 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 143sm16125703pfx.1.2021.08.23.07.28.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Aug 2021 07:28:29 -0700 (PDT)
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
Subject: [PATCH v2 0/1] ci: new github-action for git-l10n code review
Date:   Mon, 23 Aug 2021 22:28:20 +0800
Message-Id: <20210823142821.26658-1-worldhello.net@gmail.com>
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

A repository is created for testing git-l10n CI workflow. L10n
contributors can fork and try.

- https://github.com/jiangxin/github-action-test


## Changes since v1

+ Listen to event "pull_request_target" instead of event "pull_request".
  Event "pull_request_target" provides write permissions for
  GITHUB_TOKEN, and the workflow triggered by a pull request from a fork
  repository can create new comment in the pull request.
 
+ Because for "pull_request_target", only checkout base commit of the
  target repository, add a new step "Fetch missing commits".

+ Add new option "--github-action-event <event>" for git-po-helper.

+ Add "--end-of-options" for "git rev-parse" command.


## Range diff v1...v2

1:  25c5645 ! 1:  c2618b9 ci: new github-action for git-l10n code review
    @@ Commit message
         "ci-config" and create a simple shell script at "ci/config/allow-l10n"
         in this branch.
     
    -    The new l10n workflow listens to two types of github events: push and
    -    pull_request.
    +    The new l10n workflow listens to two types of github events: "push" and
    +    "pull_request_target". The "pull_request_target" event is just like the
    +    "pull_request" event, but provides write permission to create comments
    +    for pull request.
     
    -    For a push event, it will scan commits one by one. If a commit does not
    -    look like a l10n commit (no file in "po/" has been changed), it will
    -    immediately fail without checking for further commits. While for a
    -    pull_request event, all new introduced commits will be scanned.
    +    For a "push" event, it will scan commits one by one. If a commit does
    +    not look like a l10n commit (no file in "po/" has been changed), it
    +    will immediately fail without checking for further commits. While for a
    +    "pull_request_target" event, all new introduced commits will be scanned.
     
         "git-po-helper" will generate two kinds of suggestions, errors and
         warnings. A l10n contributor should try to fix all the errors, and
         should pay attention to the warnings. All the errors and warnings will
    -    be reported in the last step of the l10n workflow as two message groups.
    -    For a pull_request event, will create additional comments in pull
    -    request to report the result.
    +    be reported in the last step of the l10n workflow with two message
    +    groups. For a "pull_request_target" event, will create additional
    +    comments in the pull request to report the result.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
    @@ .github/workflows/l10n.yml (new)
     @@
     +name: git-l10n
     +
    -+on: [push, pull_request]
    ++on: [push, pull_request_target]
     +
     +jobs:
     +  ci-config:
    @@ .github/workflows/l10n.yml (new)
     +    - uses: actions/checkout@v2
     +      with:
     +        fetch-depth: '0'
    ++    - name: Fetch missing commits
    ++      id: fetch-commits
    ++      run: |
    ++        if test "${{ github.event_name }}" = "pull_request_target"
    ++        then
    ++          base=${{ github.event.pull_request.base.sha }}
    ++          head=${{ github.event.pull_request.head.sha }}
    ++        else
    ++          base=${{ github.event.before }}
    ++          head=${{ github.event.after }}
    ++        fi
    ++        for commit in $base $head
    ++        do
    ++          if echo $commit | grep -q "^00*$"
    ++          then
    ++            continue
    ++          fi
    ++          if ! git rev-parse --verify --end-of-options "$commit^{commit}" --
    ++          then
    ++            git fetch origin $commit
    ++          fi
    ++        done
    ++        echo "::set-output name=base::$base"
    ++        echo "::set-output name=head::$head"
    ++
     +    - uses: actions/setup-go@v2
     +      with:
     +        go-version: ">=1.16"
    @@ .github/workflows/l10n.yml (new)
     +      run: |
     +        sudo apt-get update -q &&
     +        sudo apt-get install -q -y gettext
    -+    - id: check-commits
    -+      name: Run git-po-helper
    ++    - name: Run git-po-helper
    ++      id: check-commits
     +      run: |
    -+        if test "${{ github.event_name }}" = "pull_request"
    -+        then
    -+          commit_from=${{ github.event.pull_request.base.sha }}
    -+          commit_to=${{ github.event.pull_request.head.sha }}
    -+        else
    -+          commit_from=${{ github.event.before }}
    -+          commit_to=${{ github.event.after }}
    -+          if ! echo $commit_from | grep -q "^00*$"
    -+          then
    -+            if ! git rev-parse "$commit_from^{commit}"
    -+            then
    -+              git fetch origin $commit_from
    -+            fi
    -+          fi
    -+        fi
     +        exit_code=0
    -+        git-po-helper check-commits --github-action -- \
    -+          $commit_from..$commit_to >git-po-helper.out 2>&1 ||
    -+        exit_code=$?
    ++        git-po-helper check-commits \
    ++            --github-action \
    ++            --github-action-event "${{ github.event_name }}" -- \
    ++            ${{ steps.fetch-commits.outputs.base }}..${{ steps.fetch-commits.outputs.head }} \
    ++            >git-po-helper.out 2>&1 ||
    ++          exit_code=$?
     +        echo "::set-output name=exit_code::$exit_code"
     +        has_error_msg=
     +        has_warning_msg=
     +        if test $exit_code -ne 0
     +        then
     +          has_error_msg=yes
    -+          if test "${{ github.event_name }}" = "pull_request"
    ++          if test "${{ github.event_name }}" = "pull_request_target"
     +          then
     +            echo "ERROR_MSG<<EOF" >>$GITHUB_ENV
     +            grep -v -e "^level=warning" -e WARNING git-po-helper.out |
    @@ .github/workflows/l10n.yml (new)
     +        if grep -q -e "^level=warning" -e WARNING git-po-helper.out
     +        then
     +          has_warning_msg=yes
    -+          if test "${{ github.event_name }}" = "pull_request"
    ++          if test "${{ github.event_name }}" = "pull_request_target"
     +          then
     +            echo "WARNING_MSG<<EOF" >>$GITHUB_ENV
     +            grep -v -e "^level=error" -e ERROR git-po-helper.out |
    @@ .github/workflows/l10n.yml (new)
     +        echo "::set-output name=has_warning_msg::$has_warning_msg"
     +    - name: Report errors in comment for pull request
     +      uses: mshick/add-pr-comment@v1
    -+      if: steps.check-commits.outputs.has_error_msg == 'yes' && github.event_name == 'pull_request'
    ++      if: steps.check-commits.outputs.has_error_msg == 'yes' && github.event_name == 'pull_request_target'
     +      continue-on-error: true
     +      with:
     +        repo-token: ${{ secrets.GITHUB_TOKEN }}
    @@ .github/workflows/l10n.yml (new)
     +          ```
     +    - name: Report warnings in comment for pull request
     +      uses: mshick/add-pr-comment@v1
    -+      if: steps.check-commits.outputs.has_warning_msg == 'yes' && github.event_name == 'pull_request'
    ++      if: steps.check-commits.outputs.has_warning_msg == 'yes' && github.event_name == 'pull_request_target'
     +      continue-on-error: true
     +      with:
     +        repo-token: ${{ secrets.GITHUB_TOKEN }}
    @@ .github/workflows/l10n.yml (new)
     +          ```
     +          ${{ env.WARNING_MSG }}
     +          ```
    -+    - name: Report and quit
    ++    - name: Final report
     +      run: |
     +        if test "${{ steps.check-commits.outputs.has_error_msg }}" = "yes"
     +        then
