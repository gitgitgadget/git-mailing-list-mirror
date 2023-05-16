Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBBCC7EE24
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjEPRKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjEPRKE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:10:04 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0EA9029
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-645538f6101so6050968b3a.1
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684256997; x=1686848997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBj6KTtKOOh3BcePf8fCx52eEGki+kYMSFRMVWo1SjE=;
        b=qJS6el7JYV53NTKuxdSObGWin86QdEJmnCgdzRhqx8TUIjfBnT64dEa90AyZtyC/+C
         15EtVZmEm5KHom7FfaM4dA1h35LW0Auk4+XKpNdDnu1/IeUEZ6CfIK9/Hk6/0AB3xhuq
         q0GfOvtBUzh4S17YTNeK4xNMpC/HXHmirHfgpy5CtfVMsv6k6jNwscEGkJIzPhSMrZOS
         Tj/TgOuCAiZPvQrwd5DYCSVS8bFOOF/HMPgyDH2fpYycns202N7OyDJg2R/w/yAFkph6
         sBoZgcp4CDEUSoUEkMWW6tLoe177rFwLKcB6iiD43KcZyvgaTG+Vha8sx8GGrd/MuGvM
         26UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256997; x=1686848997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBj6KTtKOOh3BcePf8fCx52eEGki+kYMSFRMVWo1SjE=;
        b=jweH+08qp8mhBTZzJ9slReWRYtOX03WCXAELJfguU8Ldq7MjmUjD/PaN1oex1QD1c5
         u9F2HYcRzxfNyAqhfsiYsLvbA34ntEGwhB3MvMGU5o6qztpcRG5HlIOijd8ppLxnFaL2
         xf74NSX3BCtR8N1zff4ouLDEYWEBAL2zAuZQpfcwpOEzi7JYgt3kuvfnUZFW1K2Waw+d
         r3ozj2yKz/j/a9eZegz3JZ1nzLEqRmVjf0KEuzNDuecEYB9trDi6Mk0HU2f9CXVO8Mtf
         gffYrJe+nisgOWYhFD+4WKWTfuCnGUaFccto6nf7wWyyNgYGxOuf1PeSIZXAaHq85yzc
         gbNQ==
X-Gm-Message-State: AC+VfDxC/0DPZWIctzxdOox8oDQ1vOARi8vqM4MHvUK6PT6QJHIRRJvr
        WVkUBUR8Zn6kX2ens1EEKh8Z483HxWeyTQDy7xCcRH8EbRsyfOXVcvveBfm5lj/vXOyI0BtYo3D
        fJn2EjYoszJC3L9UzVxYPULI1Y8i3/LGb7UBMgaT9q9LoS7uXQCarx4iYngqrbZ/fCw==
X-Google-Smtp-Source: ACHHUZ70eVphq373hR3YrKv/UgG5GEoLk0bsMcmHrJvktv3VokSPUwdqIFgf/jDLoVBHTUb9QTvbSL0wHkRcU1I=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:e804:b0:1ac:4d1d:bf75 with SMTP
 id u4-20020a170902e80400b001ac4d1dbf75mr13385536plg.3.1684256997252; Tue, 16
 May 2023 10:09:57 -0700 (PDT)
Date:   Tue, 16 May 2023 17:09:30 +0000
In-Reply-To: <20230516170932.1358685-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230516170932.1358685-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516170932.1358685-6-calvinwan@google.com>
Subject: [PATCH 5/6] treewide: remove unnecessary includes for wrapper.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 apply.c                          | 1 -
 builtin/am.c                     | 1 -
 builtin/bisect.c                 | 1 -
 builtin/branch.c                 | 1 -
 builtin/bugreport.c              | 1 -
 builtin/clone.c                  | 1 -
 builtin/config.c                 | 1 -
 builtin/credential-cache.c       | 1 -
 builtin/difftool.c               | 1 -
 builtin/fast-import.c            | 1 -
 builtin/fmt-merge-msg.c          | 1 -
 builtin/gc.c                     | 1 -
 builtin/get-tar-commit-id.c      | 1 -
 builtin/index-pack.c             | 1 -
 builtin/init-db.c                | 1 -
 builtin/merge.c                  | 1 -
 builtin/pack-objects.c           | 1 -
 builtin/rebase.c                 | 1 -
 builtin/receive-pack.c           | 1 -
 builtin/rerere.c                 | 1 -
 builtin/unpack-file.c            | 1 -
 builtin/worktree.c               | 1 -
 bulk-checkin.c                   | 1 -
 combine-diff.c                   | 1 -
 commit-graph.c                   | 1 -
 compat/terminal.c                | 1 -
 config.c                         | 1 -
 convert.c                        | 1 -
 copy.c                           | 1 -
 csum-file.c                      | 1 -
 daemon.c                         | 1 -
 diff.c                           | 1 -
 dir.c                            | 1 -
 editor.c                         | 1 -
 entry.c                          | 1 -
 environment.c                    | 1 -
 fetch-pack.c                     | 1 -
 gpg-interface.c                  | 1 -
 grep.c                           | 1 -
 http-backend.c                   | 1 -
 imap-send.c                      | 1 -
 ll-merge.c                       | 1 -
 merge-recursive.c                | 1 -
 notes-merge.c                    | 1 -
 object-file.c                    | 1 -
 pack-write.c                     | 1 -
 packfile.c                       | 1 -
 parallel-checkout.c              | 1 -
 path.c                           | 1 -
 pkt-line.c                       | 1 -
 read-cache.c                     | 1 -
 rebase-interactive.c             | 1 -
 refs.c                           | 1 -
 rerere.c                         | 1 -
 send-pack.c                      | 1 -
 sequencer.c                      | 1 -
 server-info.c                    | 1 -
 setup.c                          | 1 -
 shallow.c                        | 1 -
 strbuf.c                         | 1 -
 streaming.c                      | 1 -
 t/helper/test-delta.c            | 1 -
 t/helper/test-fsmonitor-client.c | 1 -
 t/helper/test-read-cache.c       | 1 -
 tag.c                            | 1 -
 tempfile.c                       | 1 -
 trace.c                          | 1 -
 transport-helper.c               | 1 -
 transport.c                      | 1 -
 upload-pack.c                    | 1 -
 usage.c                          | 1 -
 worktree.c                       | 1 -
 wrapper.c                        | 1 -
 write-or-die.c                   | 1 -
 74 files changed, 74 deletions(-)

diff --git a/apply.c b/apply.c
index 3636bc14c2..ef6020b18f 100644
--- a/apply.c
+++ b/apply.c
@@ -30,7 +30,6 @@
 #include "apply.h"
 #include "entry.h"
 #include "setup.h"
-#include "wrapper.h"
 
 struct gitdiff_data {
 	struct strbuf *root;
diff --git a/builtin/am.c b/builtin/am.c
index 5c83f2e003..5689ed44c4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -43,7 +43,6 @@
 #include "pager.h"
 #include "repository.h"
 #include "pretty.h"
-#include "wrapper.h"
 
 /**
  * Returns the length of the first line of msg.
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4b2143d455..dc3bd0c3a0 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -14,7 +14,6 @@
 #include "prompt.h"
 #include "quote.h"
 #include "revision.h"
-#include "wrapper.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
diff --git a/builtin/branch.c b/builtin/branch.c
index 501c47657c..728931f011 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,7 +28,6 @@
 #include "worktree.h"
 #include "help.h"
 #include "commit-reach.h"
-#include "wrapper.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index daf6c23657..d2ae5c305d 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -11,7 +11,6 @@
 #include "diagnose.h"
 #include "object-file.h"
 #include "setup.h"
-#include "wrapper.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
diff --git a/builtin/clone.c b/builtin/clone.c
index 186845ef0b..c632ad4a9a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -42,7 +42,6 @@
 #include "hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
-#include "wrapper.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/config.c b/builtin/config.c
index 9401f1e5e3..71bb376fb3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -12,7 +12,6 @@
 #include "quote.h"
 #include "setup.h"
 #include "worktree.h"
-#include "wrapper.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 508da4c6e4..c84920a3c1 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,7 +1,6 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 #ifndef NO_UNIX_SOCKETS
diff --git a/builtin/difftool.c b/builtin/difftool.c
index f09d24d37f..785105c61c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -30,7 +30,6 @@
 #include "dir.h"
 #include "entry.h"
 #include "setup.h"
-#include "wrapper.h"
 
 static int trust_exit_code;
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index bbd9b2b3e7..7473f3a42e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -26,7 +26,6 @@
 #include "commit-reach.h"
 #include "khash.h"
 #include "date.h"
-#include "wrapper.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index cc81241642..0f9855b680 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -3,7 +3,6 @@
 #include "fmt-merge-msg.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "wrapper.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	N_("git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log] [--file <file>]"),
diff --git a/builtin/gc.c b/builtin/gc.c
index c9f8557335..15b60273fc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -39,7 +39,6 @@
 #include "hook.h"
 #include "setup.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 564cfcac4f..a458a925f1 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -6,7 +6,6 @@
 #include "tar.h"
 #include "builtin.h"
 #include "quote.h"
-#include "wrapper.h"
 
 static const char builtin_get_tar_commit_id_usage[] =
 "git get-tar-commit-id";
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bb67e16655..1e065e9ce3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,6 @@
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "setup.h"
-#include "wrapper.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6183f3fb3f..81da7fcd75 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -15,7 +15,6 @@
 #include "parse-options.h"
 #include "setup.h"
 #include "worktree.h"
-#include "wrapper.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
diff --git a/builtin/merge.c b/builtin/merge.c
index 8da3e46abb..b800d4e189 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -52,7 +52,6 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
-#include "wrapper.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a5b466839b..79f3a2f300 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -43,7 +43,6 @@
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
-#include "wrapper.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ace1d5e8d1..e28e24b4fd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -36,7 +36,6 @@
 #include "reset.h"
 #include "trace2.h"
 #include "hook.h"
-#include "wrapper.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d22180435c..a548424c93 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -38,7 +38,6 @@
 #include "worktree.h"
 #include "shallow.h"
 #include "parse-options.h"
-#include "wrapper.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/rerere.c b/builtin/rerere.c
index d4a03707b1..24c7875572 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -6,7 +6,6 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "rerere.h"
-#include "wrapper.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "pathspec.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index b35a4b9dfe..3b8b8da5f6 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -3,7 +3,6 @@
 #include "hex.h"
 #include "object-name.h"
 #include "object-store.h"
-#include "wrapper.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a61bc32189..dce9106757 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -19,7 +19,6 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
-#include "wrapper.h"
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
diff --git a/bulk-checkin.c b/bulk-checkin.c
index d843279715..9192298db6 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -17,7 +17,6 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-store.h"
-#include "wrapper.h"
 
 static int odb_transaction_nesting;
 
diff --git a/combine-diff.c b/combine-diff.c
index f7e9fb5747..cd5f39f22f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -16,7 +16,6 @@
 #include "userdiff.h"
 #include "oid-array.h"
 #include "revision.h"
-#include "wrapper.h"
 
 static int compare_paths(const struct combine_diff_path *one,
 			  const struct diff_filespec *two)
diff --git a/commit-graph.c b/commit-graph.c
index 43558b4d9b..b07e22ce66 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -24,7 +24,6 @@
 #include "json-writer.h"
 #include "trace2.h"
 #include "chunk-format.h"
-#include "wrapper.h"
 
 void git_test_write_commit_graph_or_die(void)
 {
diff --git a/compat/terminal.c b/compat/terminal.c
index d87e321189..83d95e8656 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -6,7 +6,6 @@
 #include "run-command.h"
 #include "string-list.h"
 #include "hashmap.h"
-#include "wrapper.h"
 
 #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
diff --git a/config.c b/config.c
index 43b0d3fb57..b7cccbe245 100644
--- a/config.c
+++ b/config.c
@@ -35,7 +35,6 @@
 #include "setup.h"
 #include "trace2.h"
 #include "worktree.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 struct config_source {
diff --git a/convert.c b/convert.c
index 5a2ea5308d..93e9ebe6d8 100644
--- a/convert.c
+++ b/convert.c
@@ -14,7 +14,6 @@
 #include "trace.h"
 #include "utf8.h"
 #include "ll-merge.h"
-#include "wrapper.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
diff --git a/copy.c b/copy.c
index c3250f0822..4de6a110f0 100644
--- a/copy.c
+++ b/copy.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "wrapper.h"
 
 int copy_fd(int ifd, int ofd)
 {
diff --git a/csum-file.c b/csum-file.c
index 82ae2973d3..ddfc685d52 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -10,7 +10,6 @@
 #include "git-compat-util.h"
 #include "progress.h"
 #include "csum-file.h"
-#include "wrapper.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
 				 const void *buf,
diff --git a/daemon.c b/daemon.c
index 75c3c06457..4047b0cf27 100644
--- a/daemon.c
+++ b/daemon.c
@@ -9,7 +9,6 @@
 #include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "wrapper.h"
 
 #ifdef NO_INITGROUPS
 #define initgroups(x, y) (0) /* nothing */
diff --git a/diff.c b/diff.c
index 067846b13c..4033358cf4 100644
--- a/diff.c
+++ b/diff.c
@@ -40,7 +40,6 @@
 #include "object-name.h"
 #include "setup.h"
 #include "strmap.h"
-#include "wrapper.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/dir.c b/dir.c
index aa840995c4..f235df015e 100644
--- a/dir.c
+++ b/dir.c
@@ -26,7 +26,6 @@
 #include "setup.h"
 #include "submodule-config.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
diff --git a/editor.c b/editor.c
index b34e10606d..d6c00f2b6d 100644
--- a/editor.c
+++ b/editor.c
@@ -10,7 +10,6 @@
 #include "strvec.h"
 #include "run-command.h"
 #include "sigchain.h"
-#include "wrapper.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
diff --git a/entry.c b/entry.c
index d89e61fa64..eaee78a526 100644
--- a/entry.c
+++ b/entry.c
@@ -11,7 +11,6 @@
 #include "fsmonitor.h"
 #include "entry.h"
 #include "parallel-checkout.h"
-#include "wrapper.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
diff --git a/environment.c b/environment.c
index 8a96997539..330277ff43 100644
--- a/environment.c
+++ b/environment.c
@@ -27,7 +27,6 @@
 #include "setup.h"
 #include "shallow.h"
 #include "trace.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 int trust_executable_bit = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 6fa6e8af9a..5e3e875670 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -32,7 +32,6 @@
 #include "commit-graph.h"
 #include "sigchain.h"
 #include "mergesort.h"
-#include "wrapper.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/gpg-interface.c b/gpg-interface.c
index f3ac5acdd9..75ce234ddf 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -10,7 +10,6 @@
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
-#include "wrapper.h"
 
 static int git_gpg_config(const char *, const char *, void *);
 
diff --git a/grep.c b/grep.c
index 073559f2cd..b86462a12a 100644
--- a/grep.c
+++ b/grep.c
@@ -11,7 +11,6 @@
 #include "commit.h"
 #include "quote.h"
 #include "help.h"
-#include "wrapper.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs,
diff --git a/http-backend.c b/http-backend.c
index ac146d85c5..4491cdee39 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -18,7 +18,6 @@
 #include "object-store.h"
 #include "protocol.h"
 #include "date.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 static const char content_type[] = "Content-Type";
diff --git a/imap-send.c b/imap-send.c
index a62424e90a..ad5474643c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,7 +29,6 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "setup.h"
-#include "wrapper.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif
diff --git a/ll-merge.c b/ll-merge.c
index 28bc94c45d..f0763f7016 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -12,7 +12,6 @@
 #include "run-command.h"
 #include "ll-merge.h"
 #include "quote.h"
-#include "wrapper.h"
 
 struct ll_merge_driver;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 9875bdb11c..8bf84c9339 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -33,7 +33,6 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
-#include "wrapper.h"
 #include "xdiff-interface.h"
 
 struct merge_options_internal {
diff --git a/notes-merge.c b/notes-merge.c
index 233e49e319..434090634e 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -19,7 +19,6 @@
 #include "trace.h"
 #include "notes-utils.h"
 #include "commit-reach.h"
-#include "wrapper.h"
 
 struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
diff --git a/object-file.c b/object-file.c
index af18e38527..43c1585aa7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -42,7 +42,6 @@
 #include "setup.h"
 #include "submodule.h"
 #include "fsck.h"
-#include "wrapper.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
diff --git a/pack-write.c b/pack-write.c
index 3b3ce89de6..7dd8882830 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -10,7 +10,6 @@
 #include "oidmap.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
-#include "wrapper.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
diff --git a/packfile.c b/packfile.c
index 57df0c1956..96727e63a8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -24,7 +24,6 @@
 #include "commit-graph.h"
 #include "pack-revindex.h"
 #include "promisor-remote.h"
-#include "wrapper.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *hash,
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 50fd7fe31e..38c4dc665d 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -12,7 +12,6 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 struct pc_worker {
 	struct child_process cp;
diff --git a/path.c b/path.c
index 7c1cd8182a..dff215ac69 100644
--- a/path.c
+++ b/path.c
@@ -18,7 +18,6 @@
 #include "object-store.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
-#include "wrapper.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
diff --git a/pkt-line.c b/pkt-line.c
index 3561d85358..9cf6f12c4e 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -4,7 +4,6 @@
 #include "hex.h"
 #include "run-command.h"
 #include "trace.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
diff --git a/read-cache.c b/read-cache.c
index e919af3c77..7fa89c684d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -38,7 +38,6 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
-#include "wrapper.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 789f407361..8c52d2170a 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -10,7 +10,6 @@
 #include "config.h"
 #include "dir.h"
 #include "object-name.h"
-#include "wrapper.h"
 
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
diff --git a/refs.c b/refs.c
index d2a98e1c21..379217b03e 100644
--- a/refs.c
+++ b/refs.c
@@ -28,7 +28,6 @@
 #include "sigchain.h"
 #include "date.h"
 #include "commit.h"
-#include "wrapper.h"
 
 /*
  * List of all available backends
diff --git a/rerere.c b/rerere.c
index 7abc94bf44..7ed2493891 100644
--- a/rerere.c
+++ b/rerere.c
@@ -17,7 +17,6 @@
 #include "object-store.h"
 #include "hash-lookup.h"
 #include "strmap.h"
-#include "wrapper.h"
 
 #define RESOLVED 0
 #define PUNTED 1
diff --git a/send-pack.c b/send-pack.c
index 2089143555..97344b629e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -14,7 +14,6 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
-#include "wrapper.h"
 #include "oid-array.h"
 #include "gpg-interface.h"
 #include "shallow.h"
diff --git a/sequencer.c b/sequencer.c
index c88d1d9553..e773b4999b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -45,7 +45,6 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
-#include "wrapper.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
diff --git a/server-info.c b/server-info.c
index 68098ddd1a..67ce4ad529 100644
--- a/server-info.c
+++ b/server-info.c
@@ -12,7 +12,6 @@
 #include "object-file.h"
 #include "object-store.h"
 #include "strbuf.h"
-#include "wrapper.h"
 
 struct update_info_ctx {
 	FILE *cur_fp;
diff --git a/setup.c b/setup.c
index 59abc16ba6..a546da755f 100644
--- a/setup.c
+++ b/setup.c
@@ -12,7 +12,6 @@
 #include "promisor-remote.h"
 #include "quote.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
diff --git a/shallow.c b/shallow.c
index 128f56179e..9ff8923ccf 100644
--- a/shallow.c
+++ b/shallow.c
@@ -18,7 +18,6 @@
 #include "commit-reach.h"
 #include "shallow.h"
 #include "trace.h"
-#include "wrapper.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
diff --git a/strbuf.c b/strbuf.c
index 729378ec82..d486189303 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -9,7 +9,6 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
-#include "wrapper.h"
 
 int starts_with(const char *str, const char *prefix)
 {
diff --git a/streaming.c b/streaming.c
index 21e39585e8..83b1530419 100644
--- a/streaming.c
+++ b/streaming.c
@@ -10,7 +10,6 @@
 #include "object-store.h"
 #include "replace-object.h"
 #include "packfile.h"
-#include "wrapper.h"
 
 typedef int (*open_istream_fn)(struct git_istream *,
 			       struct repository *,
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index e7d134ec25..6bc787a474 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -11,7 +11,6 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "delta.h"
-#include "wrapper.h"
 
 static const char usage_str[] =
 	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 14522b4c47..a3427e048b 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -10,7 +10,6 @@
 #include "setup.h"
 #include "thread-utils.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
 int cmd__fsmonitor_client(int argc UNUSED, const char **argv UNUSED)
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index a4c24d0e42..e4c3e8f01c 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -3,7 +3,6 @@
 #include "cache.h"
 #include "config.h"
 #include "setup.h"
-#include "wrapper.h"
 
 int cmd__read_cache(int argc, const char **argv)
 {
diff --git a/tag.c b/tag.c
index 96dbd5b2d5..fb0eaa5595 100644
--- a/tag.c
+++ b/tag.c
@@ -10,7 +10,6 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "packfile.h"
-#include "wrapper.h"
 
 const char *tag_type = "tag";
 
diff --git a/tempfile.c b/tempfile.c
index 50c377134c..423266e4c7 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -46,7 +46,6 @@
 #include "path.h"
 #include "tempfile.h"
 #include "sigchain.h"
-#include "wrapper.h"
 
 static VOLATILE_LIST_HEAD(tempfile_list);
 
diff --git a/trace.c b/trace.c
index 592c141d78..971a68abe8 100644
--- a/trace.c
+++ b/trace.c
@@ -27,7 +27,6 @@
 #include "quote.h"
 #include "setup.h"
 #include "trace.h"
-#include "wrapper.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
diff --git a/transport-helper.c b/transport-helper.c
index 6b816940dc..28a0309e06 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -18,7 +18,6 @@
 #include "refspec.h"
 #include "transport-internal.h"
 #include "protocol.h"
-#include "wrapper.h"
 
 static int debug;
 
diff --git a/transport.c b/transport.c
index 67afdae57c..cd4b7f5528 100644
--- a/transport.c
+++ b/transport.c
@@ -30,7 +30,6 @@
 #include "object-store.h"
 #include "color.h"
 #include "bundle-uri.h"
-#include "wrapper.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
diff --git a/upload-pack.c b/upload-pack.c
index 08633dc121..7990a2037c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -32,7 +32,6 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/usage.c b/usage.c
index 46d99f8bd4..09f0ed509b 100644
--- a/usage.c
+++ b/usage.c
@@ -6,7 +6,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 static void vreportf(const char *prefix, const char *err, va_list params)
 {
diff --git a/worktree.c b/worktree.c
index b5ee71c5eb..7afeaf49fe 100644
--- a/worktree.c
+++ b/worktree.c
@@ -11,7 +11,6 @@
 #include "dir.h"
 #include "wt-status.h"
 #include "config.h"
-#include "wrapper.h"
 
 void free_worktrees(struct worktree **worktrees)
 {
diff --git a/wrapper.c b/wrapper.c
index c130d7518b..98321531ec 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -6,7 +6,6 @@
 #include "config.h"
 #include "gettext.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 static intmax_t count_fsync_writeout_only;
 static intmax_t count_fsync_hardware_flush;
diff --git a/write-or-die.c b/write-or-die.c
index cc9e0787a1..d8355c0c3e 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "run-command.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 /*
-- 
2.40.1.606.ga4b1b128d6-goog

