Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43741F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeFZHav (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:30:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36196 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeFZHat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:49 -0400
Received: by mail-it0-f67.google.com with SMTP id j135-v6so874128itj.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7h8+QGrK2IFjbUwnS00Hjfn4Foz9UOVuijzS1/usKKU=;
        b=W5K6an9lHysA3b2+jb4X044OCt+Gnd+l7diDnabmYdQ9a1UZp5M6ytuXDa9ErXoAjL
         +QQAb1/6wTmMKNJijI9OBOXnnc19KaBkDqZ8iMX1/cWLK/w1vCoSfXYypJHSgu+WTdaJ
         0iwNdsl6oZPWwpK9kkV8BwiNuLC5D12ZMcYmZQpBOAgaegr0ai72S1sRJKjdKD3gRc09
         5NNdGw4cP010+nYlBg8L1kKJ/xdalGea9twBFQJpnH2azwzBMaj8UJdeSXOZ9rgZcTIe
         9HCs3ftga/eeZdyNDWeeE0Gf9Ax8HGVYAj7v099YGIgjUQZiuzR6PNlxvhELvEsJkjI3
         hqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=7h8+QGrK2IFjbUwnS00Hjfn4Foz9UOVuijzS1/usKKU=;
        b=bHKlYwxA8S4q78F82CpTCCc5cfSaOAX5AIOWZoevJF5EGqoMN4HNJSSaiKkcyPRZxM
         Wj6pkKM5fwhmRT02IJEbygBZGHoZM3yFHK1vwQ49FE7gB1uytPXx1jwdr75DqChHt3JC
         7GnyPYTCFWBajoqFPtaMO+ksMj4Qbhi+/CAUwdpNA2Se9wLgFE6F85FHPNtlUB6nddt5
         Xh5uGXTijHxkBxaDA4N9EKysP068yQ25xmFll2EAMQFLEqzywf6hNNcfPQpW5ajw8+WU
         O2kRa2BEiwAd4wJYnYVuLoD1mkzASz1nAcIaQgMK7H2TvT1O2sq6PRblwTAH6wD5PcSH
         tG6w==
X-Gm-Message-State: APt69E0vxT150bm9kPSlhrMpRkx19TqnT1DL0VlALnfVGCL2YkQUFE2H
        k5DW0s/NeUYmHbE6OVgYJFWNyg==
X-Google-Smtp-Source: AAOMgpfpvpKKD1l8nj8VRBjvEyQxz3IFkiTvvCqMs9liwTd+lrvguMzv8UER03JmVr8yiAs5aeQtrg==
X-Received: by 2002:a24:9b82:: with SMTP id o124-v6mr506031itd.56.1529998248807;
        Tue, 26 Jun 2018 00:30:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:48 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:32 -0400
Message-Id: <20180626073001.6555-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --chain-lint[1] option detects breakage in the top-level &&-chain of
tests. This series undertakes the more complex task of teaching it to
also detect &&-chain breakage within subshells. See patch 29/29 for the
gory details of how that's done.

The series is built atop 'master', however, it has a conflict with an
in-flight topic. In particular, patch 1/29 rewrites a test in t7508 in
'master' to avoid &&-chain breakage. 'jc/clean-after-sanity-tests' in
'next' performs pretty much the same rewrite. If this series is queued
atop 'master', then it needs patch 1/29; if it is queued somewhere above
'jc/clean-after-sanity-tests', then 1/29 can be dropped.

Aside from identifying a rather significant number of &&-chain breaks,
repairing those broken chains uncovered genuine bugs in several tests
which were hidden by missing &&-chain links. Those bugs are also fixed
by this series. I would appreciate if the following people would
double-check my fixes:

Stefan Bellar - 8/29 "t7400" and (especially) 13/29 "lib-submodule-update"
Jonathan Tan - 10/29 "t9001"
Elijah Newren - 6/29 "t6036"

In order to keep the noise level down and ease review burden, please
take into account that I largely avoided modernizations and cleanups,
and limited changes to merely adding "&&" even when some other
transformation would have made the fix nicer overall. (For example, I
resisted the urge to replace a series of 'echo' statements in a subshell
with a simple here-doc.)

Finally, although all simple &&-chain fixes originally inhabited a
single patch, they were split out into several patches to avoid hitting
vger.kernel.org's message size limit. However, when queuing, all patches
titled "t????: fix broken &&-chains in subshells" could be squashed into
a single patch titled "t: fix broken &&-chains in subshells".

[1]: https://public-inbox.org/git/20150320100429.GA17354@peff.net/

Eric Sunshine (29):
  t7508: use test_when_finished() instead of managing exit code manually
  t0001: use "{...}" block around "||" expression rather than subshell
  t1300: use sane_unset() to avoid breaking &&-chain
  t3303: use standard here-doc tag "EOF" to avoid fooling --chain-lint
  t5505: modernize and simplify hard-to-digest test
  t6036: fix broken "merge fails but has appropriate contents" tests
  t7201: drop pointless "exit 0" at end of subshell
  t7400: fix broken "submodule add/reconfigure --force" test
  t7810: use test_expect_code() instead of hand-rolled comparison
  t9001: fix broken "invoke hook" test
  t9104: use "{...}" block around "||" expression rather than subshell
  t9401: drop unnecessary nested subshell
  t/lib-submodule-update: fix broken "replace submodule must-fail" test
  t: drop subshell with missing &&-chain in favor of simpler construct
  t: drop unnecessary terminating semicolons in subshell
  t: use test_might_fail() instead of manipulating exit code manually
  t: use test_must_fail() instead of checking exit code manually
  t0000-t0999: fix broken &&-chains in subshells
  t1000-t1999: fix broken &&-chains in subshells
  t2000-t2999: fix broken &&-chains in subshells
  t3000-t3999: fix broken &&-chains in subshells
  t3030: fix broken &&-chains in subshells
  t4000-t4999: fix broken &&-chains in subshells
  t5000-t5999: fix broken &&-chains in subshells
  t6000-t6999: fix broken &&-chains in subshells
  t7000-t7999: fix broken &&-chains in subshells
  t9000-t9999: fix broken &&-chains in subshells
  t9119: fix broken &&-chains in subshells
  t/test-lib: teach --chain-lint to detect broken &&-chains in subshells

 t/lib-submodule-update.sh                     |  10 +-
 t/t0000-basic.sh                              |   2 +-
 t/t0001-init.sh                               |   2 +-
 t/t0003-attributes.sh                         |  24 +-
 t/t0021-conversion.sh                         |   4 +-
 t/t0090-cache-tree.sh                         |   2 +-
 t/t1004-read-tree-m-u-wf.sh                   |   8 +-
 t/t1005-read-tree-reset.sh                    |  10 +-
 t/t1008-read-tree-overlay.sh                  |   2 +-
 t/t1020-subdirectory.sh                       |   2 +-
 t/t1050-large.sh                              |   6 +-
 t/t1300-config.sh                             |   2 +-
 t/t1411-reflog-show.sh                        |   6 +-
 t/t1507-rev-parse-upstream.sh                 |   6 +-
 t/t1512-rev-parse-disambiguation.sh           |   6 +-
 t/t1700-split-index.sh                        |   2 +-
 t/t2016-checkout-patch.sh                     |  24 +-
 t/t2103-update-index-ignore-missing.sh        |   2 +-
 t/t2202-add-addremove.sh                      |  14 +-
 t/t3000-ls-files-others.sh                    |   2 +-
 t/t3006-ls-files-long.sh                      |   2 +-
 t/t3008-ls-files-lazy-init-name-hash.sh       |   8 +-
 t/t3030-merge-recursive.sh                    | 340 +++++++++---------
 t/t3050-subprojects-fetch.sh                  |   8 +-
 t/t3102-ls-tree-wildcards.sh                  |   2 +-
 t/t3301-notes.sh                              |   8 +-
 t/t3303-notes-subtrees.sh                     |  12 +-
 t/t3400-rebase.sh                             |   8 +-
 t/t3402-rebase-merge.sh                       |   4 +-
 t/t3404-rebase-interactive.sh                 |   6 +-
 t/t3418-rebase-continue.sh                    |   4 +-
 t/t3700-add.sh                                |   8 +-
 t/t3701-add-interactive.sh                    |  16 +-
 t/t3904-stash-patch.sh                        |   8 +-
 t/t4001-diff-rename.sh                        |   2 +-
 t/t4010-diff-pathspec.sh                      |   4 +-
 t/t4012-diff-binary.sh                        |   6 +-
 t/t4025-hunk-header.sh                        |   8 +-
 t/t4041-diff-submodule-option.sh              |   4 +-
 t/t4060-diff-submodule-option-diff-format.sh  |   2 +-
 t/t4121-apply-diffs.sh                        |   2 +-
 t/t5300-pack-object.sh                        |   2 +-
 t/t5302-pack-index.sh                         |   2 +-
 t/t5400-send-pack.sh                          |   4 +-
 t/t5401-update-hooks.sh                       |   4 +-
 t/t5405-send-pack-rewind.sh                   |   3 +-
 t/t5406-remote-rejects.sh                     |   2 +-
 t/t5500-fetch-pack.sh                         |   2 +-
 t/t5505-remote.sh                             |  10 +-
 t/t5512-ls-remote.sh                          |   4 +-
 t/t5516-fetch-push.sh                         |  10 +-
 t/t5517-push-mirror.sh                        |  10 +-
 t/t5526-fetch-submodules.sh                   |   2 +-
 t/t5531-deep-submodule-push.sh                |   2 +-
 t/t5543-atomic-push.sh                        |   2 +-
 t/t5601-clone.sh                              |   2 +-
 t/t5605-clone-local.sh                        |   2 +-
 t/t5801-remote-helpers.sh                     |   2 +-
 t/t6010-merge-base.sh                         |   2 +-
 t/t6029-merge-subtree.sh                      |  16 +-
 t/t6036-recursive-corner-cases.sh             |  14 +-
 t/t6042-merge-rename-corner-cases.sh          |   8 +-
 t/t6043-merge-rename-directories.sh           |   2 +-
 t/t7001-mv.sh                                 |   2 +-
 t/t7105-reset-patch.sh                        |  12 +-
 t/t7201-co.sh                                 |  41 ++-
 t/t7301-clean-interactive.sh                  |  41 ++-
 t/t7400-submodule-basic.sh                    |  12 +-
 t/t7406-submodule-update.sh                   |   4 +-
 t/t7408-submodule-reference.sh                |   2 +-
 t/t7501-commit.sh                             |  56 +--
 t/t7506-status-submodule.sh                   |  10 +-
 t/t7508-status.sh                             |  20 +-
 t/t7610-mergetool.sh                          |   8 +-
 t/t7810-grep.sh                               |   7 +-
 t/t9001-send-email.sh                         |  10 +-
 t/t9100-git-svn-basic.sh                      |   2 +-
 t/t9101-git-svn-props.sh                      |   2 +-
 t/t9104-git-svn-follow-parent.sh              |   4 +-
 t/t9119-git-svn-info.sh                       | 120 +++----
 t/t9122-git-svn-author.sh                     |   6 +-
 t/t9129-git-svn-i18n-commitencoding.sh        |   2 +-
 t/t9130-git-svn-authors-file.sh               |   4 +-
 t/t9134-git-svn-ignore-paths.sh               |   6 +-
 t/t9137-git-svn-dcommit-clobber-series.sh     |   2 +-
 t/t9138-git-svn-authors-prog.sh               |   6 +-
 t/t9146-git-svn-empty-dirs.sh                 |  12 +-
 t/t9147-git-svn-include-paths.sh              |   6 +-
 t/t9164-git-svn-dcommit-concurrent.sh         |   2 +-
 ...65-git-svn-fetch-merge-branch-of-branch.sh |   2 +-
 t/t9200-git-cvsexportcommit.sh                |   6 +-
 t/t9400-git-cvsserver-server.sh               |   6 +-
 t/t9401-git-cvsserver-crlf.sh                 |   4 +-
 t/t9600-cvsimport.sh                          |   2 +-
 t/t9806-git-p4-options.sh                     |   2 +-
 t/t9810-git-p4-rcs.sh                         |   2 +-
 t/t9811-git-p4-label-import.sh                |   2 +-
 t/t9814-git-p4-rename.sh                      |  16 +-
 t/t9815-git-p4-submit-fail.sh                 |   2 +-
 t/t9830-git-p4-symlink-dir.sh                 |   2 +-
 t/t9831-git-p4-triggers.sh                    |   2 +-
 t/t9902-completion.sh                         |   4 +-
 t/t9903-bash-prompt.sh                        |   2 +-
 t/test-lib.sh                                 | 245 ++++++++++++-
 104 files changed, 810 insertions(+), 593 deletions(-)

-- 
2.18.0.419.gfe4b301394

