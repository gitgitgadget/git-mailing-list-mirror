From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 00/83] libify apply and use lib in am
Date: Sun, 24 Apr 2016 15:33:00 +0200
Message-ID: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:34:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBb-0007do-Q3
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbcDXNeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 09:34:46 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37412 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbcDXNep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:45 -0400
Received: by mail-wm0-f41.google.com with SMTP id n3so90191448wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2byGGNpue6b/+Kkd5hTsc+8kYzzMQnOZ4Mest6lMTk=;
        b=HYwrKPM2LZYf0Sh5Hd625XLd569JBtksHNcxRN6qXF6w/ljM5V5PqyRQNx8RkjKHv7
         63NM6xEp3KBKeHtimOB2AuwasSSF1sak9NIyHLzELJKwtoofFl14PNon8k4QvinNlIHm
         fMmJzBQmHeWZPDSLVBoWggJfSuOT6kXmEG95A/jzzw2WNqDaWry/jsE0IQ34kVOfzlsx
         Eu4Py4YGqWOobYud/x3w4m3dMaKMKL76yFtWXgwIf35qBpv/8Ug2ykMaeq4UIc2IKcq/
         LQtThm/1aArFD6INfRQDPDXGLJUsenBgJWKgVIE6A9DsqcYkRbAkYIb+ss3ljDiO0YWQ
         UYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2byGGNpue6b/+Kkd5hTsc+8kYzzMQnOZ4Mest6lMTk=;
        b=DHZ6jrVGfrsIH2PiZzl1Ox3I0FHNcZ5gIbBaZySM3lK8gB3mfoDvShMgJuqcsyMw3X
         qk3OOkO+vDS+5RN0S81dBldECR8hj642tdIoRrCc9kJ1DMo6gbDqe8AKvZ7lV6P2C13u
         oANMsH9P2ye6RuhnoJOyISH1PC/GbBb4onT5okZkDK7OcbvF3U3EXoqYzf0fjcrTExJ2
         HgX9QhTPjTLUQ34HKFUCN86q4RkdwOQsRbvO6Mkcsvc9FGngzucEgI7L1xdAS4Ey5zmj
         rKNmioWi0sL45PiqiboyKS6wropCLWYnP90fDA0zBMggMcAvz22ae4cP62ZYKPxTGcws
         Wv3A==
X-Gm-Message-State: AOPr4FV6peZX89ja5jFwvtkn6koO34LNs0T7Es7Mn2h0G3a5elSZUxBMZJK509nK44zEew==
X-Received: by 10.28.88.138 with SMTP id m132mr7064133wmb.7.1461504883550;
        Sun, 24 Apr 2016 06:34:43 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:42 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292324>

This is a patch series about libifying `git apply` functionality, and
using this libified functionality in `git am`, so that no 'git apply'
process is spawn anymore. This makes `git am` significantly faster, so
`git rebase`, when it uses the am backend, is also significantly
faster.

This has initially been discussed in the following thread:

http://thread.gmane.org/gmane.comp.version-control.git/287236/

A RFC patch series was sent previously that only got rid of the global
variables and refactored the code around a bit:

http://thread.gmane.org/gmane.comp.version-control.git/288489/

This new patch series is built on top of that previous work, so
patches 1/83 to 47/83 are from the previous RFC patch series and
patches after that are new.

Sorry if this patch series is a bit long. I can split it into two or
more series if it is prefered.

The benefits are not just related to not creating new processes. When
`git am` launched a `git apply` process, this new process had to read
the index from disk. Then after the `git apply`process had terminated,
`git am` dropped its index and read the index from disk to get the
index that had been modified by the `git apply`process. This was
inefficient and also prevented the split-index mechanism to provide
many performance benefits.

Performance numbers:

  - A few days ago =C3=86var did a huge many-hundred commit rebase on t=
he
    kernel with untracked cache.

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

=C3=86var used his Debian laptop with SSD.

  - Some days ago I tested rebasing 13 commits in Booking.com's
    monorepo on a Red Hat 6.5 server with split-index and
    GIT_TRACE_PERFORMANCE=3D1.

With Git v2.8.0, the rebase took 6.375888383 s, with the git am
command launched by the rebase command taking 3.705677431 s.

With this series on top of next, the rebase took 3.044529494 s, with
the git am command launched by the rebase command taking 0.583521168
s.

No tests on Windows have been performed, but it could be interesting
to test on this platform.

Christian Couder (83):
  builtin/apply: make gitdiff_verify_name() return void
  builtin/apply: avoid parameter shadowing 'p_value' global
  builtin/apply: avoid parameter shadowing 'linenr' global
  builtin/apply: avoid local variable shadowing 'len' parameter
  builtin/apply: extract line_by_line_fuzzy_match() from
    match_fragment()
  builtin/apply: move 'options' variable into cmd_apply()
  builtin/apply: introduce 'struct apply_state' to start libifying
  builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
  builtin/apply: move 'check' global into 'struct apply_state'
  builtin/apply: move 'check_index' global into 'struct apply_state'
  builtin/apply: move 'apply_in_reverse' global into 'struct
    apply_state'
  builtin/apply: move 'apply_with_reject' global into 'struct
    apply_state'
  builtin/apply: move 'apply_verbosely' global into 'struct apply_state=
'
  builtin/apply: move 'update_index' global into 'struct apply_state'
  builtin/apply: move 'allow_overlap' global into 'struct apply_state'
  builtin/apply: move 'cached' global into 'struct apply_state'
  builtin/apply: move 'diffstat' global into 'struct apply_state'
  builtin/apply: move 'numstat' global into 'struct apply_state'
  builtin/apply: move 'summary' global into 'struct apply_state'
  builtin/apply: move 'threeway' global into 'struct apply_state'
  builtin/apply: move 'no-add' global into 'struct apply_state'
  builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
  builtin/apply: move 'line_termination' global into 'struct
    apply_state'
  builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
  builtin/apply: move 'p_context' global into 'struct apply_state'
  builtin/apply: move 'apply' global into 'struct apply_state'
  builtin/apply: move 'read_stdin' global into cmd_apply()
  builtin/apply: move 'patch_input_file' global into 'struct
    apply_state'
  builtin/apply: move 'limit_by_name' global into 'struct apply_state'
  builtin/apply: move 'has_include' global into 'struct apply_state'
  builtin/apply: move 'p_value' global into 'struct apply_state'
  builtin/apply: move 'p_value_known' global into 'struct apply_state'
  builtin/apply: move 'root' global into 'struct apply_state'
  builtin/apply: move 'whitespace_error' global into 'struct
    apply_state'
  builtin/apply: move 'whitespace_option' into 'struct apply_state'
  builtin/apply: remove whitespace_option arg from
    set_default_whitespace_mode()
  builtin/apply: move 'squelch_whitespace_errors' into 'struct
    apply_state'
  builtin/apply: move 'applied_after_fixing_ws' into 'struct
    apply_state'
  builtin/apply: move 'ws_error_action' into 'struct apply_state'
  builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
  builtin/apply: move 'max_change' and 'max_len' into 'struct
    apply_state'
  builtin/apply: move 'linenr' global into 'struct apply_state'
  builtin/apply: move 'fn_table' global into 'struct apply_state'
  builtin/apply: move 'symlink_changes' global into 'struct apply_state=
'
  builtin/apply: move 'state' init into init_apply_state()
  builtin/apply: move 'state' check into check_apply_state()
  builtin/apply: move applying patches into apply_all_patches()
  builtin/apply: rename 'prefix_' parameter to 'prefix'
  builtin/apply: move 'lock_file' global into 'struct apply_state'
  builtin/apply: get rid of the 'newfd' global
  builtin/apply: make apply_patch() return -1 instead of die()ing
  builtin/apply: read_patch_file() return -1 instead of die()ing
  builtin/apply: make find_header() return -1 instead of die()ing
  builtin/apply: make parse_chunk() return a negative integer on error
  builtin/apply: make parse_single_patch() return -1 on error
  apply: move 'struct apply_state' to apply.h
  builtin/apply: libify parse_whitespace_option()
  builtin/apply: libify parse_ignorewhitespace_option()
  builtin/apply: move init_apply_state() to apply.c
  apply: libify init_apply_state()
  builtin/apply: libify check_apply_state()
  builtin/apply: move check_apply_state() to apply.c
  builtin/apply: make apply_all_patches() return -1 on error
  builtin/apply: make parse_traditional_patch() return -1 on error
  builtin/apply: make gitdiff_verify_name() return -1 on error
  builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
  builtin/apply: make build_fake_ancestor() return -1 on error
  builtin/apply: make remove_file() return -1 on error
  builtin/apply: make add_conflicted_stages_file() return -1 on error
  builtin/apply: make add_index_file() return -1 on error
  builtin/apply: make create_file() return -1 on error
  builtin/apply: make write_out_one_result() return -1 on error
  builtin/apply: make write_out_results() return -1 on error
  builtin/apply: make try_create_file() return -1 on error
  builtin/apply: make create_one_file() return -1 on error
  builtin/apply: rename option parsing functions
  apply: rename and move opt constants to apply.h
  Move libified code from builtin/apply.c to apply.{c,h}
  apply: make some parsing functions static again
  run-command: make dup_devnull() non static
  apply: roll back index in case of error
  environment: add set_index_file()
  builtin/am: use apply api in run_apply()

 Makefile               |    1 +
 apply.c                | 4796 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 apply.h                |  149 ++
 builtin/am.c           |  103 +-
 builtin/apply.c        | 4665 +---------------------------------------=
------
 cache.h                |    1 +
 environment.c          |    5 +
 run-command.c          |    2 +-
 run-command.h          |    6 +
 t/t4012-diff-binary.sh |    4 +-
 t/t4254-am-corrupt.sh  |    2 +-
 11 files changed, 5096 insertions(+), 4638 deletions(-)
 create mode 100644 apply.c
 create mode 100644 apply.h

--=20
2.8.1.300.g5fed0c0
