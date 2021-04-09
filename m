Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC222C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82622610A4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhDIEFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhDIEFv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:05:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9DDC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x15so4220831wrq.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZlQVnJlcfP5CQHfTweQUh/UTESB0cGbzuBOo9SdDu8=;
        b=pM6K3mrYY70XQeBrNP1R84+NhtqPNN7kq95GNaHdsXvCt1q0mmJULJBs96mAPJYFES
         YHxFjwYH+GeklU+hbGosBQEgsjkPxP5eWU1LN0Q/533KrrnsXhuSzX3ZcRhS5qSI4NOm
         A8go4DdrhraZ/MOPZzleO2YRqOUYMknPgtOniwqAg/YMSdSd1+s9+7krifXnO86VkGmQ
         4JJdnc0D5RMIebT2TpG5KjVhEajHqKtlXGAS8bvHnzEJj0DbE47f3H8RWz69j0T7C9QH
         4YWO8j/3wApRO6i0k0ebu0RASecQLPn5Dhw+IfE1YIovzH0TCVVPE2nkdPlteAZEm7Fr
         khmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZlQVnJlcfP5CQHfTweQUh/UTESB0cGbzuBOo9SdDu8=;
        b=YHo1MebnuVgUEeQK7F1zF8OoFwURLEgUDLyQ4ByvRahccblrzpUn+1V+ON2ilsbuhJ
         SuUbabaBVjzLA1YTKObzhtWHYr2tjvLd5Ixj4MC8NxK4kibZ+PUf55MDXkC3UHRdbDgo
         q79RFikqAzkPV0y04n2LjTLARXiSzesXJAcV4nc2q+9FtDq4S80HxVk7hMMlH9SPw5j3
         ECIIdGNK/XRnZeUw/GTVptgPtk6QD0uDM3QtmsKqMoFvqHCO9vY1iPpnwoSDeqP39lZ5
         GIFiZsPuorw6yspe1DEgVFXPSa+nRwZe+aZrEbg0uW+xoMV6IzNE5mVJKs/uvuvrkbl7
         dl/g==
X-Gm-Message-State: AOAM533VKmHgV8flzaB/XykCEYTvZhYMF7CODvr0W04nA9vwHtTuAcwS
        w9XnFMVFXXhZS33/95JoJ592xUEKSfIq3A==
X-Google-Smtp-Source: ABdhPJzXcDXCAiExZ/EBsDhMPYFoj5mq/d6Y2cDOe8kJwIle6bZ+zs47XZtdBuQm2QIiBWAvZbKMSQ==
X-Received: by 2002:a5d:5407:: with SMTP id g7mr15522578wrv.163.1617941136643;
        Thu, 08 Apr 2021 21:05:36 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:36 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 00/13][GSoC] doc: (monospace) apply CodingGuidelines on a large-scale
Date:   Fri,  9 Apr 2021 06:02:48 +0200
Message-Id: <20210409040301.3260358-1-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series aims to make the documentation fully compliant to the
CodingGuidelines regarding monospace font. After it, new contributors
who just want to change a little portion of the documention could just
look around how it has been done without being confused by the
inconsistency between the documentation and the CodingGuidelines.

Concretely: unquoted, single-quoted or double-quoted entities detailed
below in the summary are wrapped or converted in backticks.

Except some easy cases, the methodology consists of using simple regex
to find relevant files, then interactively substitute targeted entities
with progressively smarter regex to exclude false positives. As the
review process could be very tedious, I have been very cautious and have
reviewed myself a couple of times every changes. Consequently, mistakes,
if there are any, are not due to the regex, but my personal
misinterpretation of the context.

Below is some changes I plan to make in v2 which request
comments/approvals of the community.

* Placeholders and option values should be in italic. (Cf. man man) 
    - e.g. `--date`='<format>', `--notes`[='<ref>'], `branch.`'<name>'`.remote`
    - e.g. `--date`='rfc2822'
    - Compare gcc and git-add
        - man gcc vs. man git-add 
        - https://linux.die.net/man/1/gcc vs. https://linux.die.net/man/1/git-add
* The Synopsis section should be formatted based on the current
CodingGuidelines plus the above suggestion. IOW, for instance, options should
be wrapped in backticks. Again, to have an idea, compare gcc and git-add. 

Best,

Firmin

Firmin Martin (13):
  doc: typeset command-line options in monospace
  doc: typeset branches and remotes in monospace
  doc: typeset configuration options in monospace
  doc: typeset git-related commands in monospace
  doc: typeset git-svn subcommands in monospace
  doc: typeset dummy URLs and protocols in monospace
  doc: typeset git dotfiles in monospace
  doc: typeset filepath and $variables in monospace
  doc: typeset command/option/value entries in monospace
  doc: typeset more command entries in monospace
  doc: typeset config option entries in monospace
  doc: typeset environment vars without $ in monospace
  doc: typeset common programs in monospace

 Documentation/CodingGuidelines                |   2 +-
 Documentation/MyFirstContribution.txt         |   8 +-
 Documentation/SubmittingPatches               |   2 +-
 Documentation/blame-options.txt               |  50 +-
 Documentation/config.txt                      |  38 +-
 Documentation/config/diff.txt                 |   2 +-
 Documentation/config/gitcvs.txt               |   6 +-
 Documentation/diff-format.txt                 |  12 +-
 Documentation/diff-generate-patch.txt         |   8 +-
 Documentation/diff-options.txt                | 252 +++----
 Documentation/fetch-options.txt               | 136 ++--
 Documentation/git-add.txt                     |  86 +--
 Documentation/git-am.txt                      | 116 +--
 Documentation/git-apply.txt                   |  84 +--
 Documentation/git-archimport.txt              |  34 +-
 Documentation/git-archive.txt                 |  52 +-
 Documentation/git-bisect-lk2009.txt           | 188 ++---
 Documentation/git-bisect.txt                  |  48 +-
 Documentation/git-blame.txt                   |  32 +-
 Documentation/git-branch.txt                  | 156 ++--
 Documentation/git-bugreport.txt               |  14 +-
 Documentation/git-bundle.txt                  |  74 +-
 Documentation/git-cat-file.txt                |  42 +-
 Documentation/git-check-attr.txt              |  18 +-
 Documentation/git-check-ignore.txt            |  16 +-
 Documentation/git-check-mailmap.txt           |   4 +-
 Documentation/git-check-ref-format.txt        |  16 +-
 Documentation/git-checkout-index.txt          |  42 +-
 Documentation/git-checkout.txt                | 114 +--
 Documentation/git-cherry-pick.txt             |  76 +-
 Documentation/git-cherry.txt                  |  20 +-
 Documentation/git-citool.txt                  |   6 +-
 Documentation/git-clean.txt                   |  66 +-
 Documentation/git-clone.txt                   | 104 +--
 Documentation/git-column.txt                  |  26 +-
 Documentation/git-commit-graph.txt            |  12 +-
 Documentation/git-commit-tree.txt             |  22 +-
 Documentation/git-commit.txt                  | 174 ++---
 Documentation/git-config.txt                  | 174 ++---
 Documentation/git-count-objects.txt           |  16 +-
 .../git-credential-cache--daemon.txt          |   2 +-
 Documentation/git-credential-cache.txt        |   8 +-
 Documentation/git-credential-store.txt        |  12 +-
 Documentation/git-credential.txt              |  16 +-
 Documentation/git-cvsexportcommit.txt         |  46 +-
 Documentation/git-cvsimport.txt               |  84 +--
 Documentation/git-cvsserver.txt               | 110 +--
 Documentation/git-daemon.txt                  | 150 ++--
 Documentation/git-describe.txt                |  80 +-
 Documentation/git-diff-files.txt              |  18 +-
 Documentation/git-diff-index.txt              |  34 +-
 Documentation/git-diff-tree.txt               |  46 +-
 Documentation/git-diff.txt                    |  64 +-
 Documentation/git-difftool.txt                |  78 +-
 Documentation/git-fast-export.txt             |  84 +--
 Documentation/git-fast-import.txt             | 140 ++--
 Documentation/git-fetch-pack.txt              |  72 +-
 Documentation/git-fetch.txt                   |  46 +-
 Documentation/git-filter-branch.txt           | 164 ++---
 Documentation/git-fmt-merge-msg.txt           |  30 +-
 Documentation/git-for-each-ref.txt            |  80 +-
 Documentation/git-for-each-repo.txt           |   4 +-
 Documentation/git-format-patch.txt            | 132 ++--
 Documentation/git-fsck-objects.txt            |   2 +-
 Documentation/git-fsck.txt                    |  74 +-
 Documentation/git-gc.txt                      |  36 +-
 Documentation/git-get-tar-commit-id.txt       |   8 +-
 Documentation/git-grep.txt                    | 178 ++---
 Documentation/git-gui.txt                     |  32 +-
 Documentation/git-hash-object.txt             |  20 +-
 Documentation/git-help.txt                    |  78 +-
 Documentation/git-http-backend.txt            |  72 +-
 Documentation/git-http-fetch.txt              |  24 +-
 Documentation/git-http-push.txt               |  22 +-
 Documentation/git-imap-send.txt               |  20 +-
 Documentation/git-index-pack.txt              |  48 +-
 Documentation/git-init-db.txt                 |   2 +-
 Documentation/git-init.txt                    |  28 +-
 Documentation/git-instaweb.txt                |  44 +-
 Documentation/git-interpret-trailers.txt      |  80 +-
 Documentation/git-log.txt                     |  56 +-
 Documentation/git-ls-files.txt                | 126 ++--
 Documentation/git-ls-remote.txt               |  46 +-
 Documentation/git-ls-tree.txt                 |  38 +-
 Documentation/git-mailinfo.txt                |  36 +-
 Documentation/git-mailsplit.txt               |  20 +-
 Documentation/git-maintenance.txt             |  32 +-
 Documentation/git-merge-base.txt              |  32 +-
 Documentation/git-merge-file.txt              |  26 +-
 Documentation/git-merge-index.txt             |  16 +-
 Documentation/git-merge-one-file.txt          |   6 +-
 Documentation/git-merge-tree.txt              |   4 +-
 Documentation/git-merge.txt                   |  78 +-
 Documentation/git-mergetool--lib.txt          |   8 +-
 Documentation/git-mergetool.txt               |  40 +-
 Documentation/git-mktag.txt                   |   4 +-
 Documentation/git-mktree.txt                  |   8 +-
 Documentation/git-multi-pack-index.txt        |  18 +-
 Documentation/git-mv.txt                      |  28 +-
 Documentation/git-name-rev.txt                |  32 +-
 Documentation/git-notes.txt                   | 170 ++---
 Documentation/git-p4.txt                      | 318 ++++----
 Documentation/git-pack-objects.txt            | 122 ++--
 Documentation/git-pack-redundant.txt          |  10 +-
 Documentation/git-pack-refs.txt               |  12 +-
 Documentation/git-patch-id.txt                |  22 +-
 Documentation/git-prune-packed.txt            |  10 +-
 Documentation/git-prune.txt                   |  30 +-
 Documentation/git-pull.txt                    |  42 +-
 Documentation/git-push.txt                    | 136 ++--
 Documentation/git-quiltimport.txt             |  18 +-
 Documentation/git-range-diff.txt              |  16 +-
 Documentation/git-read-tree.txt               | 118 +--
 Documentation/git-rebase.txt                  | 384 +++++-----
 Documentation/git-receive-pack.txt            |  48 +-
 Documentation/git-reflog.txt                  |  36 +-
 Documentation/git-remote-ext.txt              |  40 +-
 Documentation/git-remote-fd.txt               |  16 +-
 Documentation/git-remote.txt                  |  62 +-
 Documentation/git-repack.txt                  |  64 +-
 Documentation/git-replace.txt                 |  42 +-
 Documentation/git-request-pull.txt            |  12 +-
 Documentation/git-rerere.txt                  |  80 +-
 Documentation/git-reset.txt                   |  60 +-
 Documentation/git-restore.txt                 |  58 +-
 Documentation/git-rev-list.txt                |   6 +-
 Documentation/git-rev-parse.txt               | 148 ++--
 Documentation/git-revert.txt                  |  54 +-
 Documentation/git-rm.txt                      |  32 +-
 Documentation/git-send-email.txt              | 192 ++---
 Documentation/git-send-pack.txt               |  44 +-
 Documentation/git-sh-i18n--envsubst.txt       |   2 +-
 Documentation/git-sh-i18n.txt                 |   4 +-
 Documentation/git-sh-setup.txt                |  10 +-
 Documentation/git-shell.txt                   |  26 +-
 Documentation/git-shortlog.txt                |  32 +-
 Documentation/git-show-branch.txt             |  66 +-
 Documentation/git-show-index.txt              |   4 +-
 Documentation/git-show-ref.txt                |  58 +-
 Documentation/git-show.txt                    |  12 +-
 Documentation/git-sparse-checkout.txt         |  18 +-
 Documentation/git-stage.txt                   |   2 +-
 Documentation/git-stash.txt                   |  80 +-
 Documentation/git-status.txt                  |  78 +-
 Documentation/git-stripspace.txt              |  16 +-
 Documentation/git-submodule.txt               | 172 ++---
 Documentation/git-svn.txt                     | 690 +++++++++---------
 Documentation/git-switch.txt                  |  76 +-
 Documentation/git-symbolic-ref.txt            |  22 +-
 Documentation/git-tag.txt                     | 108 +--
 Documentation/git-unpack-file.txt             |   4 +-
 Documentation/git-unpack-objects.txt          |  12 +-
 Documentation/git-update-index.txt            | 132 ++--
 Documentation/git-update-ref.txt              |  40 +-
 Documentation/git-update-server-info.txt      |   6 +-
 Documentation/git-upload-archive.txt          |  10 +-
 Documentation/git-upload-pack.txt             |  20 +-
 Documentation/git-var.txt                     |  20 +-
 Documentation/git-verify-commit.txt           |  10 +-
 Documentation/git-verify-pack.txt             |  14 +-
 Documentation/git-verify-tag.txt              |  10 +-
 Documentation/git-web--browse.txt             |  26 +-
 Documentation/git-whatchanged.txt             |   8 +-
 Documentation/git-worktree.txt                |  74 +-
 Documentation/git-write-tree.txt              |  12 +-
 Documentation/git.txt                         | 142 ++--
 Documentation/gitattributes.txt               |  88 +--
 Documentation/gitcli.txt                      |   6 +-
 Documentation/gitcore-tutorial.txt            | 212 +++---
 Documentation/gitcredentials.txt              |  20 +-
 Documentation/gitcvs-migration.txt            |  14 +-
 Documentation/gitdiffcore.txt                 |  60 +-
 Documentation/giteveryday.txt                 |  24 +-
 Documentation/gitfaq.txt                      |   6 +-
 Documentation/githooks.txt                    |  26 +-
 Documentation/gitignore.txt                   |  16 +-
 Documentation/gitk.txt                        |  64 +-
 Documentation/gitmailmap.txt                  |   2 +-
 Documentation/gitmodules.txt                  |  26 +-
 Documentation/gitnamespaces.txt               |  12 +-
 Documentation/gitremote-helpers.txt           |  90 +--
 Documentation/gitrepository-layout.txt        | 114 +--
 Documentation/gitsubmodules.txt               |   2 +-
 Documentation/gittutorial-2.txt               |  38 +-
 Documentation/gittutorial.txt                 | 100 +--
 Documentation/gitweb.conf.txt                 | 320 ++++----
 Documentation/gitweb.txt                      | 168 ++---
 Documentation/gitworkflows.txt                |  76 +-
 Documentation/glossary-content.txt            |  38 +-
 Documentation/howto/revert-branch-rebase.txt  |   2 +-
 .../howto/setup-git-server-over-http.txt      |   2 +-
 Documentation/i18n.txt                        |   4 +-
 Documentation/merge-options.txt               | 100 +--
 Documentation/merge-strategies.txt            |  36 +-
 Documentation/pretty-formats.txt              |  16 +-
 Documentation/pretty-options.txt              |  52 +-
 Documentation/pull-fetch-param.txt            |  18 +-
 Documentation/rev-list-options.txt            | 242 +++---
 Documentation/revisions.txt                   |  76 +-
 Documentation/sequencer.txt                   |   8 +-
 Documentation/signoff-option.txt              |   8 +-
 Documentation/urls-remotes.txt                |  12 +-
 Documentation/urls.txt                        |  40 +-
 Documentation/user-manual.txt                 | 116 +--
 204 files changed, 5971 insertions(+), 5971 deletions(-)

-- 
2.31.1.133.g84d06cdc06

