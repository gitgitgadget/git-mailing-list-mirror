Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6084B208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbdH3RuQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:16 -0400
Received: from mout.web.de ([212.227.17.12]:60040 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbdH3RuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:07 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqoJ-1de0K630Tr-009eF8 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:05 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 00/34] plug strbuf memory leaks
Date:   Wed, 30 Aug 2017 19:49:31 +0200
Message-Id: <20170830175005.20756-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
X-Provags-ID: V03:K0:LYSLhZ43B+7wDnZ2olnffDfRI3KuLPSbqDPiisfgjZzC6DH1EeS
 11t/AcICpCG46UPuFNwFoOQuiXcEgRWBTx2qXnPBiaizqPbqjCh+dOwiDsLOIvHn+XtWyPg
 BXZteKwNl2v8UmcJ6u5lwLOWqfILplVyDtAbetRjBDGUTyVA2j5t+sPaGykAIN/Kza+qD0L
 +Jiuq+blRa9GBoBdwfDUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PTMBrbAD0vY=:D9vgeIBnrsZSmgOv7ZLLW7
 I3G4UZ7yl1FitK9z5ahK1hXFZeH/aVX3gOdBlrjILta5n8c9/asJ9cyelOIViNYcOxEPxeVDb
 ISQxFzIKP289f/wkVbqGqqktOGxk5Q0iN47qKffpznrPAc8MVu4N1HNZpsXGoO0RnmI/oSda6
 1ZcFUCdPmD3jxljZ2zgPl4gsp5YdRxCTGJRU1DSvvq8ro2MBoZ2JOHZwoGc1MM4DPm499g1n3
 JX0+6/qDvVWCAmN2RCVAYWicdmADl7dsUk2e1itf0MvC1TtLyAbr7v0cARgV2QOoQ3dW5kiw8
 xCBr3ayYolhlNpjXOypVn8oKMRyVjjs3NqWYbGq824ragFJKGLr/CzfOPJjkBVdrUvmKxWcgr
 aRpp/OGxl9vNqrl105/WKhjwRGYKrZCUlXbNmzdHeNzzHdjMNd0/oGwvfv2ZjEFH/etql4+Jx
 jKFJa5pm1oxgXnzcAE7prOQGS9BqPAjY+mBRR5IkN3EX0wp63xrqB9zbUeXEVMFlHTiLXlfsN
 yhOJPitBrvo+tiDTfHqmeMeQMaoX9JpVf5fOfxj6FIvYJZ/akdqAdxwICQ+ZoWIPo00l9JnYx
 NPC5Msd0FpT7B8OAMVWXGZjqIHqC/rmemL1l28hGnOMBTRMh0vDXrHVP3umkz1GF4cGh0/sEu
 4Y5tdlt/q92stDalAjZyw74NQ1FUP42DqWfP4gg+q/qETuUMX+9lb5RpmDxXqFaGnIarBGKg+
 D0eq5ryxzpwydXIM2Kjntlpq7F7S6r+o4tKmoTf3RCjkA2T90xYQweZsDujYRouE9HrWr8oB4
 TxWiyrPhxa7eyCflmvNS98dsj1XvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release allocated strbufs in functions that are at least potentionally
library-like; cmd_*() functions are out of scope because the process
ends with them and the OS cleans up for us anyway.  The patches are
split by function and were generated with --function-context for easier
reviewing.

  am: release strbufs after use in detect_patch_format()
  am: release strbuf on error return in hg_patch_to_mail()
  am: release strbuf after use in safe_to_abort()
  check-ref-format: release strbuf after use in check_ref_format_branch()
  clean: release strbuf after use in remove_dirs()
  clone: release strbuf after use in remove_junk()
  commit: release strbuf on error return in commit_tree_extended()
  connect: release strbuf on error return in git_connect()
  convert: release strbuf on error return in filter_buffer_or_fd()
  diff: release strbuf after use in diff_summary()
  diff: release strbuf after use in show_rename_copy()
  diff: release strbuf after use in show_stats()
  help: release strbuf on error return in exec_man_konqueror()
  help: release strbuf on error return in exec_man_man()
  help: release strbuf on error return in exec_woman_emacs()
  mailinfo: release strbuf after use in handle_from()
  mailinfo: release strbuf on error return in handle_boundary()
  merge: release strbuf after use in save_state()
  merge: release strbuf after use in write_merge_heads()
  notes: release strbuf after use in notes_copy_from_stdin()
  refs: release strbuf on error return in write_pseudoref()
  remote: release strbuf after use in read_remote_branches()
  remote: release strbuf after use in migrate_file()
  remote: release strbuf after use in set_url()
  send-pack: release strbuf on error return in send_pack()
  sha1_file: release strbuf on error return in index_path()
  shortlog: release strbuf after use in insert_one_record()
  sequencer: release strbuf after use in save_head()
  transport-helper: release strbuf after use in process_connect_service()
  userdiff: release strbuf after use in userdiff_get_textconv()
  utf8: release strbuf on error return in strbuf_utf8_replace()
  vcs-svn: release strbuf after use in end_revision()
  wt-status: release strbuf after use in read_rebase_todolist()
  wt-status: release strbuf after use in wt_longstatus_print_tracking()

 builtin/am.c               | 34 ++++++++++++++++++++++------------
 builtin/check-ref-format.c |  1 +
 builtin/clean.c            |  7 +++++--
 builtin/clone.c            |  2 +-
 builtin/help.c             |  3 +++
 builtin/merge.c            |  9 +++++++--
 builtin/notes.c            |  1 +
 builtin/remote.c           |  8 +++++---
 builtin/shortlog.c         |  1 +
 commit.c                   |  7 +++++--
 connect.c                  |  4 +++-
 convert.c                  |  4 +++-
 diff.c                     |  3 +++
 mailinfo.c                 | 10 +++++-----
 refs.c                     |  2 +-
 send-pack.c                |  5 ++++-
 sequencer.c                |  5 ++++-
 sha1_file.c                |  6 +++---
 transport-helper.c         |  1 +
 userdiff.c                 |  1 +
 utf8.c                     |  3 ++-
 vcs-svn/svndump.c          |  1 +
 wt-status.c                |  2 ++
 23 files changed, 84 insertions(+), 36 deletions(-)

-- 
2.14.1

