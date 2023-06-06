Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A3C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjFFRKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjFFRKY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:10:24 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C59E171D
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:10:16 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2566b668cc5so3977479a91.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071416; x=1688663416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILY2IgEuSuByYYgQHyaNw7bKW4tRvKWYlHcmW/gmwXg=;
        b=5r8cBG38NI5rBaLjefakO89RZ2nTDLeUNWBIAOGtc5fPaV06DIYU9YdL+O3F3o6wyK
         Ux+ucpP8gwi5w5wXMhEsGivHC1X6DqEwEFP54glVKPH8gYyYseuDvnky1EzD8q6betTL
         xnIdUAA/AAMV+rWqCO2B+25dHlWz3FXH3Uc86ppUV3TusH/6INC73pnNv/ttSvRweHFR
         1PjyFPJ2U6THqQPVyvcXXVADTPzc8CpjQzzVdcP+FdFkbZ/eWiuvssJcScsogte8SoCp
         lHrP1oGYJATNUSPimw0LaTXTG+7Xp3mUBJ06EYlmi+T2KHW9F5CvR15hyrXwYEUHwGUF
         +DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071416; x=1688663416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILY2IgEuSuByYYgQHyaNw7bKW4tRvKWYlHcmW/gmwXg=;
        b=S3F44FnPQYu+uKpddGnlUMbwVZ6MFW78h7kbkObLc1Wi9Nz8wGjhxwhuoOZipbN7fQ
         GKaNFpZctUqmVu/3CwcmsMKFlGU8t0/iQh1P8AwxAaU5I+CcgcUovdxjZ+rfIbpuiqPa
         +/75CBl24XeZpxjIB5FJs6GUppY75Fi5+mFxB0AJIvRzZPQD77i/bR6aK7PFKr3jBVGy
         fqSrIKn7SvoVCWnqjU89I4S7BKLlRNqy6yVe1rrfyDJUr6TtAeeLXkVq+P7OZpC9aCZW
         gUsHqF/+OI5LvZnNp682c1OGqmN1+doAB+Z8QlGSuwr0a3L650Bgjgw5nND45fYpkMmR
         ervw==
X-Gm-Message-State: AC+VfDzUKLy1cUmir09QKSiLcsGTyuYnBmNN/NpqfQ4kD5QGIQD4a4aY
        IjenTz/5XNv2IoCW3bPu8qIu2ieguL2GqCmReGRN/h9BB6Go/xKxnsEcJYJrosb2j77O8yzgXY+
        smaeoh9YEyt4xmWPwJ4Z7vo7oeskaqzeuuLcEDstaE3nlVYNsX5k2zVZ1I52XfpnWxg==
X-Google-Smtp-Source: ACHHUZ63UdvHb2Fqoqv3bUBn9yDveSxuLE58dbkxsmD18FNZVkV/5r5RawuPx9mv1N85YIFj+6kjWTksLfk9jh8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:de06:b0:24e:18ff:5bad with SMTP
 id m6-20020a17090ade0600b0024e18ff5badmr824832pjv.0.1686071415681; Tue, 06
 Jun 2023 10:10:15 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:10:01 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606171002.914075-7-calvinwan@google.com>
Subject: [PATCH v3 7/8] treewide: remove unnecessary includes for wrapper.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
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
 merge-ll.c                       | 1 -
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
index 8bd0109fcc..99c2a91de7 100644
--- a/apply.c
+++ b/apply.c
@@ -37,7 +37,6 @@
 #include "symlinks.h"
 #include "wildmatch.h"
 #include "ws.h"
-#include "wrapper.h"
 
 struct gitdiff_data {
 	struct strbuf *root;
diff --git a/builtin/am.c b/builtin/am.c
index 5fab159599..dcb89439b1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -44,7 +44,6 @@
 #include "path.h"
 #include "repository.h"
 #include "pretty.h"
-#include "wrapper.h"
 
 /**
  * Returns the length of the first line of msg.
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 6478df3489..65478ef40f 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -15,7 +15,6 @@
 #include "prompt.h"
 #include "quote.h"
 #include "revision.h"
-#include "wrapper.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
diff --git a/builtin/branch.c b/builtin/branch.c
index 4e4e4c1083..5597f37da9 100644
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
index 687a686269..3fc0e5d7c0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -45,7 +45,6 @@
 #include "hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
-#include "wrapper.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/config.c b/builtin/config.c
index 30f6d9fe67..c01f136a2b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -14,7 +14,6 @@
 #include "setup.h"
 #include "strbuf.h"
 #include "worktree.h"
-#include "wrapper.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index ff3a47badb..43b9d0e5b1 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -3,7 +3,6 @@
 #include "parse-options.h"
 #include "path.h"
 #include "strbuf.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 #ifndef NO_UNIX_SOCKETS
diff --git a/builtin/difftool.c b/builtin/difftool.c
index e2c9ab7d5d..aeb0f92409 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -32,7 +32,6 @@
 #include "dir.h"
 #include "entry.h"
 #include "setup.h"
-#include "wrapper.h"
 
 static int trust_exit_code;
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2ee19c7373..4dbb10aff3 100644
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
index 91eec7703a..19d73067aa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -41,7 +41,6 @@
 #include "hook.h"
 #include "setup.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 9303e386cc..20d0dfe9cf 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -5,7 +5,6 @@
 #include "commit.h"
 #include "tar.h"
 #include "quote.h"
-#include "wrapper.h"
 
 static const char builtin_get_tar_commit_id_usage[] =
 "git get-tar-commit-id";
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 820860265d..f58f9db69d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -25,7 +25,6 @@
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "setup.h"
-#include "wrapper.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0d8bd4d721..cb727c826f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -13,7 +13,6 @@
 #include "path.h"
 #include "setup.h"
 #include "strbuf.h"
-#include "wrapper.h"
 
 static int guess_repository_type(const char *git_dir)
 {
diff --git a/builtin/merge.c b/builtin/merge.c
index 41fe0d8e5e..2f2f0a0b4c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -53,7 +53,6 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
-#include "wrapper.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index af9352b228..6409c07c7d 100644
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
index 555c5d3f02..6c23e7b25c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -37,7 +37,6 @@
 #include "reset.h"
 #include "trace2.h"
 #include "hook.h"
-#include "wrapper.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 91caaf8706..f3c7c5f6cc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -40,7 +40,6 @@
 #include "worktree.h"
 #include "shallow.h"
 #include "parse-options.h"
-#include "wrapper.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0458db9cad..07a9d37275 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -6,7 +6,6 @@
 #include "repository.h"
 #include "string-list.h"
 #include "rerere.h"
-#include "wrapper.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "pathspec.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 6842a6c499..c129e2bb6c 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -3,7 +3,6 @@
 #include "hex.h"
 #include "object-name.h"
 #include "object-store-ll.h"
-#include "wrapper.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6ba463f696..6ae0356a4e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -22,7 +22,6 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
-#include "wrapper.h"
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
diff --git a/bulk-checkin.c b/bulk-checkin.c
index e2f71db0f6..fec6816259 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -17,7 +17,6 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-store-ll.h"
-#include "wrapper.h"
 
 static int odb_transaction_nesting;
 
diff --git a/combine-diff.c b/combine-diff.c
index 11e9d7494a..f90f442482 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -17,7 +17,6 @@
 #include "userdiff.h"
 #include "oid-array.h"
 #include "revision.h"
-#include "wrapper.h"
 
 static int compare_paths(const struct combine_diff_path *one,
 			  const struct diff_filespec *two)
diff --git a/commit-graph.c b/commit-graph.c
index 9e989f4349..22cdfe5c17 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -26,7 +26,6 @@
 #include "trace2.h"
 #include "tree.h"
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
index e08e2332a6..cc97c18141 100644
--- a/config.c
+++ b/config.c
@@ -39,7 +39,6 @@
 #include "wildmatch.h"
 #include "worktree.h"
 #include "ws.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 struct config_source {
diff --git a/convert.c b/convert.c
index 3d8325d49e..4aef90a7b6 100644
--- a/convert.c
+++ b/convert.c
@@ -16,7 +16,6 @@
 #include "trace.h"
 #include "utf8.h"
 #include "merge-ll.h"
-#include "wrapper.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
diff --git a/copy.c b/copy.c
index 882c79cffb..23d84c6c1d 100644
--- a/copy.c
+++ b/copy.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "copy.h"
 #include "path.h"
-#include "wrapper.h"
 
 int copy_fd(int ifd, int ofd)
 {
diff --git a/csum-file.c b/csum-file.c
index daf9b06dff..cd01713244 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,7 +11,6 @@
 #include "progress.h"
 #include "csum-file.h"
 #include "hash.h"
-#include "wrapper.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
 				 const void *buf,
diff --git a/daemon.c b/daemon.c
index 7139cc201d..3722edf46c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -10,7 +10,6 @@
 #include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "wrapper.h"
 
 #ifdef NO_INITGROUPS
 #define initgroups(x, y) (0) /* nothing */
diff --git a/diff.c b/diff.c
index 86efea20f5..bdc4b07dde 100644
--- a/diff.c
+++ b/diff.c
@@ -43,7 +43,6 @@
 #include "setup.h"
 #include "strmap.h"
 #include "ws.h"
-#include "wrapper.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/dir.c b/dir.c
index 3acac7beb1..d270a1be36 100644
--- a/dir.c
+++ b/dir.c
@@ -32,7 +32,6 @@
 #include "symlinks.h"
 #include "trace2.h"
 #include "tree.h"
-#include "wrapper.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
diff --git a/editor.c b/editor.c
index 38c5dbbb79..b67b802ddf 100644
--- a/editor.c
+++ b/editor.c
@@ -11,7 +11,6 @@
 #include "strvec.h"
 #include "run-command.h"
 #include "sigchain.h"
-#include "wrapper.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
diff --git a/entry.c b/entry.c
index f9a7c726a4..43767f9043 100644
--- a/entry.c
+++ b/entry.c
@@ -14,7 +14,6 @@
 #include "fsmonitor.h"
 #include "entry.h"
 #include "parallel-checkout.h"
-#include "wrapper.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
diff --git a/environment.c b/environment.c
index 5e9b331279..73b5b59ecf 100644
--- a/environment.c
+++ b/environment.c
@@ -28,7 +28,6 @@
 #include "setup.h"
 #include "shallow.h"
 #include "trace.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 int trust_executable_bit = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index a432eacab9..84a24ff9b1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -34,7 +34,6 @@
 #include "commit-graph.h"
 #include "sigchain.h"
 #include "mergesort.h"
-#include "wrapper.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/gpg-interface.c b/gpg-interface.c
index 6a3817bbca..206ffdd79e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -12,7 +12,6 @@
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
-#include "wrapper.h"
 #include "environment.h"
 
 static int git_gpg_config(const char *, const char *, void *);
diff --git a/grep.c b/grep.c
index ebcd647478..a3cc8224db 100644
--- a/grep.c
+++ b/grep.c
@@ -12,7 +12,6 @@
 #include "commit.h"
 #include "quote.h"
 #include "help.h"
-#include "wrapper.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs,
diff --git a/http-backend.c b/http-backend.c
index e1969c05dc..25a19c21b9 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -19,7 +19,6 @@
 #include "object-store-ll.h"
 #include "protocol.h"
 #include "date.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 static const char content_type[] = "Content-Type";
diff --git a/imap-send.c b/imap-send.c
index 7f5426177a..ee5b98467b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -30,7 +30,6 @@
 #include "parse-options.h"
 #include "setup.h"
 #include "strbuf.h"
-#include "wrapper.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif
diff --git a/merge-ll.c b/merge-ll.c
index 740b8c6bfd..ad26d7e260 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -13,7 +13,6 @@
 #include "merge-ll.h"
 #include "quote.h"
 #include "strbuf.h"
-#include "wrapper.h"
 
 struct ll_merge_driver;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 43f6b2d036..6a4081bb0f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -38,7 +38,6 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
-#include "wrapper.h"
 #include "xdiff-interface.h"
 
 struct merge_options_internal {
diff --git a/notes-merge.c b/notes-merge.c
index 071947894e..8799b522a5 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -20,7 +20,6 @@
 #include "trace.h"
 #include "notes-utils.h"
 #include "commit-reach.h"
-#include "wrapper.h"
 
 struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
diff --git a/object-file.c b/object-file.c
index 8d87720dd5..527b740018 100644
--- a/object-file.c
+++ b/object-file.c
@@ -44,7 +44,6 @@
 #include "setup.h"
 #include "submodule.h"
 #include "fsck.h"
-#include "wrapper.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
diff --git a/pack-write.c b/pack-write.c
index af48813a9b..b19ddf15b2 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -12,7 +12,6 @@
 #include "pack-revindex.h"
 #include "path.h"
 #include "strbuf.h"
-#include "wrapper.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
diff --git a/packfile.c b/packfile.c
index c60aeb05ec..7683a6dbea 100644
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
index 602fbf19d3..8637723461 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -15,7 +15,6 @@
 #include "symlinks.h"
 #include "thread-utils.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 struct pc_worker {
 	struct child_process cp;
diff --git a/path.c b/path.c
index 044a50bad0..67e2690efe 100644
--- a/path.c
+++ b/path.c
@@ -18,7 +18,6 @@
 #include "object-store-ll.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
-#include "wrapper.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
diff --git a/pkt-line.c b/pkt-line.c
index 62b4208b66..6e4166132d 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -5,7 +5,6 @@
 #include "hex.h"
 #include "run-command.h"
 #include "trace.h"
-#include "wrapper.h"
 #include "write-or-die.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
diff --git a/read-cache.c b/read-cache.c
index b9a995e5a1..140b4f96a0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -46,7 +46,6 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
-#include "wrapper.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index f286404d4b..d9718409b3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -11,7 +11,6 @@
 #include "config.h"
 #include "dir.h"
 #include "object-name.h"
-#include "wrapper.h"
 
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
diff --git a/refs.c b/refs.c
index 54a827b45b..ad27ba12af 100644
--- a/refs.c
+++ b/refs.c
@@ -30,7 +30,6 @@
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"
-#include "wrapper.h"
 
 /*
  * List of all available backends
diff --git a/rerere.c b/rerere.c
index e2b8597f88..4227c9612a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -20,7 +20,6 @@
 #include "object-store-ll.h"
 #include "hash-lookup.h"
 #include "strmap.h"
-#include "wrapper.h"
 
 #define RESOLVED 0
 #define PUNTED 1
diff --git a/send-pack.c b/send-pack.c
index 9510bef856..89aca9d829 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -15,7 +15,6 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
-#include "wrapper.h"
 #include "oid-array.h"
 #include "gpg-interface.h"
 #include "shallow.h"
diff --git a/sequencer.c b/sequencer.c
index bd1e183a43..de5a89ca66 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -49,7 +49,6 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
-#include "wrapper.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
diff --git a/server-info.c b/server-info.c
index 382e481a2b..f350713ecf 100644
--- a/server-info.c
+++ b/server-info.c
@@ -14,7 +14,6 @@
 #include "object-store-ll.h"
 #include "server-info.h"
 #include "strbuf.h"
-#include "wrapper.h"
 
 struct update_info_ctx {
 	FILE *cur_fp;
diff --git a/setup.c b/setup.c
index 3c383c972c..1b2f16229b 100644
--- a/setup.c
+++ b/setup.c
@@ -17,7 +17,6 @@
 #include "quote.h"
 #include "trace2.h"
 #include "worktree.h"
-#include "wrapper.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
diff --git a/shallow.c b/shallow.c
index f3ef94d4c9..2fad3504b7 100644
--- a/shallow.c
+++ b/shallow.c
@@ -20,7 +20,6 @@
 #include "shallow.h"
 #include "statinfo.h"
 #include "trace.h"
-#include "wrapper.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
diff --git a/strbuf.c b/strbuf.c
index c2713371be..c86aa0e802 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -8,7 +8,6 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
-#include "wrapper.h"
 
 int starts_with(const char *str, const char *prefix)
 {
diff --git a/streaming.c b/streaming.c
index 49791ab958..10adf625b2 100644
--- a/streaming.c
+++ b/streaming.c
@@ -10,7 +10,6 @@
 #include "object-store-ll.h"
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
index 58d1dc5fc8..8280984d08 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -11,7 +11,6 @@
 #include "setup.h"
 #include "thread-utils.h"
 #include "trace2.h"
-#include "wrapper.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
 int cmd__fsmonitor_client(int argc UNUSED, const char **argv UNUSED)
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 56c2d25f35..1acd362346 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -4,7 +4,6 @@
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
-#include "wrapper.h"
 
 int cmd__read_cache(int argc, const char **argv)
 {
diff --git a/tag.c b/tag.c
index c5426484b2..fc3834db46 100644
--- a/tag.c
+++ b/tag.c
@@ -10,7 +10,6 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "packfile.h"
-#include "wrapper.h"
 
 const char *tag_type = "tag";
 
diff --git a/tempfile.c b/tempfile.c
index 6c88a63b42..ecdebf1afb 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -47,7 +47,6 @@
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
index 5c0bc6a896..49811ef176 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -19,7 +19,6 @@
 #include "refspec.h"
 #include "transport-internal.h"
 #include "protocol.h"
-#include "wrapper.h"
 
 static int debug;
 
diff --git a/transport.c b/transport.c
index 4dc187a388..0a5794a944 100644
--- a/transport.c
+++ b/transport.c
@@ -30,7 +30,6 @@
 #include "object-store-ll.h"
 #include "color.h"
 #include "bundle-uri.h"
-#include "wrapper.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
diff --git a/upload-pack.c b/upload-pack.c
index 318b650b1e..05b3ef461f 100644
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
index f9aa371ca7..2018c127ca 100644
--- a/worktree.c
+++ b/worktree.c
@@ -12,7 +12,6 @@
 #include "dir.h"
 #include "wt-status.h"
 #include "config.h"
-#include "wrapper.h"
 
 void free_worktrees(struct worktree **worktrees)
 {
diff --git a/wrapper.c b/wrapper.c
index 67f5f5dbe1..22be9812a7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -9,7 +9,6 @@
 #include "repository.h"
 #include "strbuf.h"
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
2.41.0.rc2.161.g9c6817b8e7-goog

