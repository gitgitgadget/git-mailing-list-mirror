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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22164C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 02:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0178B610CC
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 02:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243031AbhIBCcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 22:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhIBCcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 22:32:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03672C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 19:31:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id r13so458985pff.7
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBjPOzJcYX74tD3i9Jedka3TpDTjZ2dfskoHwJziW7w=;
        b=magv9bXwr46YmEH/Riulol6OUUv586bqkFTITvYjdVViN9ZQ3dOXLy81bTNpNPtik/
         FC4Kj3AQqZyXGPkxj/pSI76ufRXl8SEiVuPscFgXpmJ1/paWSZHGc8c8ne78Jh7GvJdE
         bIyQqjAIxJ6WGo1K/LEkEDtfJxjVJXio89VIpBSZvgCLvo8h6FhptBp6UnuRYjbcgEG7
         VVyHylDNaoOCB4vUkDvaIFEiL+WFg3lKeO6Zwyxl2MMgYWGMZzT3zoLZ+Q+vXJ7ugpin
         SfDwms//LHtm1qrAEBqzGXqLkbpAprgYk7VCHtfA3lf0GPZOqCzGTunroS8gmxagLwva
         MF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBjPOzJcYX74tD3i9Jedka3TpDTjZ2dfskoHwJziW7w=;
        b=WLP2NnOiAD0cYoLf9q2RnWv0iLqAkgTBDIAk146LSAkx0vun3+iQ6VDjG1K3SZPau7
         ze6Jdqm22okWXBQ9ImrNxvzeZNDZ4sa02rDmlWWmrlABvbv+iZ8VDYlvtRIm2YNxvr6P
         /Q9wQ7B6r1Nf8ZZLj8qT26389XkFEpnvwVXxZulqkGJE0Vit87F1TzOSNujTBbbSXA+y
         Euj+qQFHzCj5gEJgDKFoQScr4iuaLYgfxHQmppJHAz5vFHffxu1+08SbXskxIslhwXyR
         vBmuqRAc+UXLobtJHrjdi1FPu2ywR46gvh9JkN/MbIJbs6l6WjlBilKBZYQefj9S02t/
         hDcA==
X-Gm-Message-State: AOAM533NZ7uw0qx73ax7sBmTuJTuQAVFPjc/o+i/jfaMKSrLEKCaVceo
        xiYvvma4w2/9iLVw0Nz4PEiGAJ6x7zw=
X-Google-Smtp-Source: ABdhPJyZgR0eZVkf8UhuuYDoGhfNwycWVP2mtKsR8yrHSFrGkEoWUtU3JOUb3yhgkc84b6en25WiAw==
X-Received: by 2002:a05:6a00:230e:b029:3c4:24ff:969d with SMTP id h14-20020a056a00230eb02903c424ff969dmr988730pfh.44.1630549912071;
        Wed, 01 Sep 2021 19:31:52 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.109])
        by smtp.gmail.com with ESMTPSA id 186sm289518pfg.11.2021.09.01.19.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 19:31:51 -0700 (PDT)
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
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 0/1] ci: new github-action for git-l10n code review
Date:   Thu,  2 Sep 2021 10:31:38 +0800
Message-Id: <20210902023139.89251-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CANYiYbESO7bvyuRcypmVKvqAdLk5492q5fUPu5ArdCY5PHzFSQ@mail.gmail.com>
References: <CANYiYbESO7bvyuRcypmVKvqAdLk5492q5fUPu5ArdCY5PHzFSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v3

* Update commit message.

* Wrap the long if conditions to make them easier to read. See:
  https://yaml-multiline.info/

* Create partial clone using one command by adding "--filter=blob:none"
  option to "git fetch".

* In the if condition of the last step, use `env.COMMENT_BODY != ''`,
  and do not need "steps.check-commits.outputs.create_comment".


## range-diff v3...v4

1:  06a6c1c ! 1:  0067ccc ci: new github-action for git-l10n code review
    @@ Metadata
      ## Commit message ##
         ci: new github-action for git-l10n code review
     
    -    Repository of git-l10n is a fork from "git/git" on GitHub, and uses
    +    The repository of git-l10n is a fork of "git/git" on GitHub, and uses
         GitHub pull request for code review. A helper program "git-po-helper"
         can be used to check typos in ".po" files, validate syntax, and check
         commit messages. It would be convenient to integrate this helper program
         to CI and add comments in pull request.
     
    -    The new github-action workflow is added in ".github/workflows/". It will
    -    only be enabled for the following cases:
    +    The new github-action workflow will be enabled for l10n related
    +    operations, such as:
     
    -     * A repository named as "git-po", such as a repository forked from
    -       "git-l10n/git-po".
    +     * Operations on a repository named as "git-po", such as a repository
    +       forked from "git-l10n/git-po".
     
    -     * Push to the branch that contains "l10n" in the name.
    +     * Push to a branch that contains "l10n" in the name.
     
    -     * Pull reqeust from a remote branch which has "l10n" in the name, such
    +     * Pull request from a remote branch which has "l10n" in the name, such
            as: "l10n/fix-fuzzy-translations".
     
         The new l10n workflow listens to two types of github events:
    @@ Commit message
             on: [push, pull_request_target]
     
         The reason we use "pull_request_target" instead of "pull_request" is
    -    that for security reasons, pull requests from forks receive a read-only
    -    GITHUB_TOKEN and workflows cannot write comments back to pull requests.
    -    GitHub provides a "pull_request_target" event to resolve security risks
    -    by checking out the base commit from the target repository, and provide
    -    write permissions for the workflow.
    +    that pull requests from forks receive a read-only GITHUB_TOKEN and
    +    workflows cannot write comments back to pull requests for security
    +    reasons. GitHub provides a "pull_request_target" event to resolve
    +    security risks by checking out the base commit from the target
    +    repository, and provide write permissions for the workflow.
     
    -    By default, adminstrators can set strict permissions for workflows. The
    +    By default, administrators can set strict permissions for workflows. The
         following code is used to modify the permissions for the GITHUB_TOKEN
    -    and give write permission in order to create comments in pull-requests.
    +    and grant write permission in order to create comments in pull-requests.
     
             permissions:
               pull-requests: write
    @@ Commit message
         like a l10n commit (no file in "po/" has been changed), the scan process
         will stop immediately. For a "push" event, no error will be reported
         because it is normal to push non-l10n commits merged from upstream. But
    -    for the "pull_request_target" event, errors will be reported.
    -    For this reason, additional option is provided for "git-po-helper".
    +    for the "pull_request_target" event, errors will be reported. For this
    +    reason, additional option is provided for "git-po-helper".
     
             git-po-helper check-commits \
                 --github-action-event="${{ github.event_name }}" -- \
    @@ Commit message
         package named "logrus" for logging, and I use an additional option
         "ForceColor" to initialize "logrus" to print messages in a user-friendly
         format in logfile output. These color codes help produce beautiful
    -    output for logs of workflow, but they must be stripped off when creating
    -    comments for pull requests. E.g.:
    +    output for the log of workflow, but they must be stripped off when
    +    creating comments for pull requests. E.g.:
     
             perl -pe 's/\e\[[0-9;]*m//g' git-po-helper.out
     
         "git-po-helper" may generate two kinds of suggestions, errors and
    -    warnings. All the errors and warnings will be reported in the log
    -    the l10n workflow. For a "pull_request_target" event, an additional
    -    comment will be created in the pull request to report the result.
    -    A l10n contributor should try to fix all the errors, and should pay
    -    attention to the warnings.
    +    warnings. All the errors and warnings will be reported in the log of the
    +    l10n workflow. However, warnings in the log of the workflow for a
    +    successfully running "git-po-helper" can easily be ignored by users.
    +    For the "pull_request_target" event, this issue is resolved by creating
    +    an additional comment in the pull request. A l10n contributor should try
    +    to fix all the errors, and should pay attention to the warnings.
     
         Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    @@ .github/workflows/l10n.yml (new)
     +
     +jobs:
     +  git-po-helper:
    -+    if: endsWith(github.repository, '/git-po') || contains(github.head_ref, 'l10n') || contains(github.ref, 'l10n')
    ++    if: >-
    ++      endsWith(github.repository, '/git-po') ||
    ++      contains(github.head_ref, 'l10n') ||
    ++      contains(github.ref, 'l10n')
     +    runs-on: ubuntu-latest
     +    permissions:
     +      pull-requests: write
    @@ .github/workflows/l10n.yml (new)
     +      - name: Fetch missing commits
     +        id: fetch-commits
     +        run: |
    -+          # Setup partial clone.
    -+          git config remote.origin.promisor true
    -+          git config remote.origin.partialCloneFilter blob:none
     +          if test "${{ github.event_name }}" = "pull_request_target"
     +          then
     +            base=${{ github.event.pull_request.base.sha }}
    @@ .github/workflows/l10n.yml (new)
     +              ;;
     +            esac
     +          done
    -+          # Unshallow the repository, and fetch missing commits.
    -+          # "$base" may be missing due to forced push, and "$head"
    ++          # Unshallow the repository, and fetch missing commits using partial
    ++          # clone.  "$base" may be missing due to forced push, and "$head"
     +          # may be missing due to the "pull_request_target" event.
    -+          git fetch --unshallow origin $args
    ++          git fetch --unshallow --filter=blob:none origin $args
     +          echo "::set-output name=base::$base"
     +          echo "::set-output name=head::$head"
     +      - uses: actions/setup-go@v2
    @@ .github/workflows/l10n.yml (new)
     +        id: check-commits
     +        run: |
     +          exit_code=0
    -+          create_comment=
     +          git-po-helper check-commits \
     +              --github-action-event="${{ github.event_name }}" -- \
     +              ${{ steps.fetch-commits.outputs.base }}..${{ steps.fetch-commits.outputs.head }} \
     +              >git-po-helper.out 2>&1 ||
     +            exit_code=$?
    -+          if test $exit_code -ne 0 ||
    -+            grep -q -e "^level=warning" -e WARNING git-po-helper.out
    ++          if test $exit_code -ne 0 || grep -q WARNING git-po-helper.out
     +          then
    -+            create_comment=yes
     +            # Remove ANSI colors which are proper for console logs but not
     +            # proper for PR comment.
     +            echo "COMMENT_BODY<<EOF" >>$GITHUB_ENV
     +            perl -pe 's/\e\[[0-9;]*m//g; s/\bEOF$//g' git-po-helper.out >>$GITHUB_ENV
     +            echo "EOF" >>$GITHUB_ENV
     +          fi
    -+          echo "::set-output name=create_comment::$create_comment"
     +          cat git-po-helper.out
     +          exit $exit_code
    -+      - name: Report in comment for pull request
    ++      - name: Create comment in pull request for report
     +        uses: mshick/add-pr-comment@v1
    -+        if: always() && steps.check-commits.outputs.create_comment== 'yes' && github.event_name == 'pull_request_target'
    -+        continue-on-error: true
    ++        if: >-
    ++          always() &&
    ++          github.event_name == 'pull_request_target' &&
    ++          env.COMMENT_BODY != ''
     +        with:
     +          repo-token: ${{ secrets.GITHUB_TOKEN }}
     +          repo-token-user-login: 'github-actions[bot]'
    -+          message: |
    -+            ${{ steps.check-commits.outcome == 'failure' && 'Errors and warnings' || 'Warnings' }} found by [git-po-helper](https://github.com/git-l10n/git-po-helper#readme) in workflow [#${{ github.run_number }}](${{ env.GITHUB_SERVER_URL }}/${{ github.repository }}/actions/runs/${{ github.run_id }}):
    ++          message: >
    ++            ${{ steps.check-commits.outcome == 'failure' && 'Errors and warnings' || 'Warnings' }}
    ++            found by [git-po-helper](https://github.com/git-l10n/git-po-helper#readme) in workflow
    ++            [#${{ github.run_number }}](${{ env.GITHUB_SERVER_URL }}/${{ github.repository }}/actions/runs/${{ github.run_id }}):
     +
     +            ```
    ++
     +            ${{ env.COMMENT_BODY }}
    ++
     +            ```

## diff stat

Jiang Xin (1):
  ci: new github-action for git-l10n code review

 .github/workflows/l10n.yml | 93 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

-- 
2.33.0
