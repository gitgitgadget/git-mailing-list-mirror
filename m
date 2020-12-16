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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2603BC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1432342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgLPSvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732194AbgLPSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C1C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o13so27795340lfr.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7+kxG2Je6xTbjhWM72ew9MpnY8dUb3sC9xpIl03vZc=;
        b=kljodF9tbqKRk3ykes/dqk7I97EwI+GqcPUAmbCGOHuwfJHIVOfjbEH9rKQDfU+4FO
         sPFPZ9y6VwXq0hen9mApL9CN0tVUy7y1LaBZrnz+LI53VvW+tKEG575xJK8epKzGXxAj
         8NnwRGqWjdTzv+yPGkHzER+qAhx16AkwkRuPe1EkduhW/019pGPHpDMeHBdYAdhyOf8I
         31bHwYa+ueKU/zTT+EgZLNccxaMuHKkII+kNwR8eUm/OLRfJMM0A7Sr2K5Yp3bAk/kR+
         ai77zJveX9X8ztD+RnT+/Ya5gyinrduyhPLTi7obq6d5tuArnQaNbsvxDD2rdUYnP2FG
         Ww+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7+kxG2Je6xTbjhWM72ew9MpnY8dUb3sC9xpIl03vZc=;
        b=nLIFAN27Csg3nu3+o9nZKx49KX1tdQaK2HP2RVM5rbcqIDDYMHsy+LT2l9A2ptz+/v
         MyH7uoHmiL0iA4vwfZfb/xddwHI8xNMXC11TK4fU6J4c0bjzplXJzXraqv0CKbgnoIK5
         lbXSQ+beJHu/gfdh5DELhGKuYYpQVyN2SizsgIcv4Zi2JGLSoIhUAsksTP1thmLLSDeJ
         KustH6iZBR5qb+Em7749WGl1Vs0oxXs2KoRPWguoan23maGiXqp3GT1MfNSSuEZTPPyd
         AdL3mKr6SJ44sm+sHkmIfbOZ7xJLTvMMtqE/B9EUVdMj15O2lizi2OiDbEzaxWo7zpcW
         V5cA==
X-Gm-Message-State: AOAM5335Jyb3r6eebVACG8HVjsiu0PtKK+NukSpKOAw5EYwoJbHq1Hby
        5Z9rfJHC5wTRDA5/uXintgg=
X-Google-Smtp-Source: ABdhPJxi3XWSoqGH9mu/PYQJF4XRwniOIUkVJSzA4zVkY2vblp6ziBwYw5FswpSpnpCsCXi2trDdIw==
X-Received: by 2002:a05:651c:1031:: with SMTP id w17mr5816671ljm.92.1608144621755;
        Wed, 16 Dec 2020 10:50:21 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:20 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 00/33] git-log: implement new --diff-merge options
Date:   Wed, 16 Dec 2020 21:48:56 +0300
Message-Id: <20201216184929.3924-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patch series implement new set of options governing diff output
of merge commits, all under the umbrella of single
--diff-merges=<mode> option.

Unlike original -c/--cc options, these new options do not imply -p,
thus allowing for getting diffs for merge commits without provoking of
diff output for regular, non-merge commits. E.g.:

  git log --diff-merges=cc

will output diffs (in dense-combined format) only for merge commits,
whereas:

  git log --cc

enables diffs for all the commits being output, either merges or
simple ones.

There is also another additional functionality provided, allowing to
get the format of "-p --first-parent" without change in history
traversal that --first-parent option causes, like this:

  git log --diff-merges=first-parent

The net result of these series are the following new options:

--diff-merges=	  |  rough original equivalent
------------------+----------------
1|first-parent    | --first-parent (only diff format implications)
m|separate        | -m and enable diff for merges
c|combined        | -c and enable diff for merges, but not for regulars
cc|dense-combined | --cc and enable diff for merges, but not for
		  |      regulars

The series also cleanup logic of handling of diff merges options and
fix an issue found in the original implementation where logically
mutually exclusive options -m/-c/--cc failed to actually override each
other. Neither semantics of these old options nor their interactions
with other options, such as --first-parent and -p, is supposed to be
changed.

The series start with the set of pure refactoring commits that are expected
to introduce no functional changes. These are all commits up to and
including:

"diff-merges: revise revs->diff flag handling"

The aim of these commits is to isolate options handling for diff merges so
that it could be easily understood and tweaked to ease introduction of the
new options.

Then the fix of -m/-c/-cc overriding issue follows, starting with a failing
test and followed by the fix.

Then follows a little bit of additional refactoring in order to
prepare for introduction of the new options, and finally the series
are finished by the implementation, documentation updates, and
some testing for the new options.

Updates in v2:

  * Move logic of "-c/--cc imply -p" to this module and do not imply
    -p by new --diff-merges options. Instead enable corresponding diff
    output without affecting non-merge commits. This is the most
    significant change with respect to v1 and it starts at 24/33.

  * Add support for old mnemonics: --diff-merges=(m|c|cc) to help
    those who are used to them, and add --diff-merges=1 to cover all
    variants with short mnemonics.

  * Fixed functions definitions style to have open curly brace on its
    own line, pointed to by Junio C Hamano.

  * Tweak --diff-merges=first-parent description, requested by Elijah
    Newren.

  * Fixed git-show documentation not to include description chunk
    relevant to git-log only, noticed by Elijah Newren.

  * Fixed documentation mistake claiming that -p is needed for
    diff-merges options to take effect, noticed by Elijah Newren.

  * Fixed a case where a change was put into wrong commit. The change
    moved to 11/27 form 10/27. Didn't affect end-result in any way.

  * Added short module description to diff-merges.h, as suggested by
    Junio C Hamano.

  * Fixed not returning "argcount" from	diff_merges_parse_opts(),
    noticed by Junio C Hamano.

Updates in v1:

  * Added documentation fix for git-show to include --diff-merges.

  * Fixed typos in commit messages noticed by Philip Oakley.

Sergey Organov (33):
  revision: factor out parsing of diff-merge related options
  revision: factor out setup of diff-merge related settings
  revision: factor out initialization of diff-merge related settings
  revision: provide implementation for diff merges tweaks
  revision: move diff merges functions to its own diff-merges.c
  diff-merges: rename all functions to have common prefix
  diff-merges: move checks for first_parent_only out of the module
  diff-merges: rename diff_merges_default_to_enable() to match semantics
  diff-merges: re-arrange functions to match the order they are called
    in
  diff-merges: new function diff_merges_suppress()
  diff-merges: new function diff_merges_set_dense_combined_if_unset()
  diff-merges: introduce revs->first_parent_merges flag
  diff-merges: revise revs->diff flag handling
  t4013: support test_expect_failure through ':failure' magic
  t4013: add tests for -m failing to override -c/--cc
  diff-merges: fix -m to properly override -c/--cc
  diff-merges: split 'ignore_merges' field
  diff-merges: group diff-merge flags next to each other inside
    'rev_info'
  diff-merges: get rid of now empty diff_merges_init_revs()
  diff-merges: refactor opt settings into separate functions
  diff-merges: make -m/-c/--cc explicitly mutually exclusive
  diff-merges: implement new values for --diff-merges
  diff-merges: fix style of functions definitions
  diff-merges: handle imply -p on -c/--cc logic for log.c
  diff-merges: do not imply -p for new options
  diff-merges: let new options enable diff without -p
  diff-merges: add old mnemonic counterparts to --diff-merges
  diff-merges: add '--diff-merges=1' as synonym for 'first-parent'
  doc/git-log: describe new --diff-merges options
  doc/diff-generate-patch: mention new --diff-merges option
  doc/rev-list-options: document --first-parent changes merges format
  doc/git-show: include --diff-merges description
  t4013: add tests for --diff-merges=first-parent

 Documentation/diff-generate-patch.txt         |   6 +-
 Documentation/diff-options.txt                |  53 +++++
 Documentation/git-log.txt                     |  46 +---
 Documentation/git-show.txt                    |   7 +-
 Documentation/rev-list-options.txt            |   5 +
 Makefile                                      |   1 +
 builtin/diff-files.c                          |   5 +-
 builtin/diff.c                                |   9 +-
 builtin/log.c                                 |  22 +-
 builtin/merge.c                               |   3 +-
 diff-merges.c                                 | 151 +++++++++++++
 diff-merges.h                                 |  24 +++
 fmt-merge-msg.c                               |   3 +-
 log-tree.c                                    |  30 +--
 revision.c                                    |  38 +---
 revision.h                                    |   9 +-
 t/t4013-diff-various.sh                       |  11 +-
 t/t4013/diff.log_--cc_-m_-p_master            | 200 ++++++++++++++++++
 ...diff.log_--diff-merges=first-parent_master |  56 +++++
 t/t4013/diff.log_-c_-m_-p_master              | 200 ++++++++++++++++++
 ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++
 21 files changed, 900 insertions(+), 116 deletions(-)
 create mode 100644 diff-merges.c
 create mode 100644 diff-merges.h
 create mode 100644 t/t4013/diff.log_--cc_-m_-p_master
 create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_master
 create mode 100644 t/t4013/diff.log_-c_-m_-p_master
 create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master

-- 
2.25.1

