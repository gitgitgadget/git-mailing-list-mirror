Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1449C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 15:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiIMPi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiIMPiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 11:38:02 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E361410A0
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 07:44:07 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id az6so9653352wmb.4
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=49WjGoOgDkgpkuPANvcaxQ6mZZZlfR1hWFe+/FfhLx4=;
        b=ArbnHORcqCpAb42argLbuHljSzRnEmVZ18O8up/Zri5GL6g8M65VBlZRfsV97W3p46
         Z8tOGrQ7XLfiYWEBlKd8XV1G4f8MMqvxjAUN6U9xUicPCpeo5FkM9Kv/wzjyqO08Egyh
         g/oqfu/kSNabC96GkvqY8YfjVgaZJKS8Gq5IRLR8GtvhmcuXZdugcfS7nss/AzJx0p3f
         +yY8DpyOcwQkUBqyrfbYQ61ycoIoEp+G3djv/OBzchonycYRkI/E7BSmIJ1lTRu19Nwp
         KllPpipr/G22OIoT6UQUE/10zeXfl7ycFyxbVhEE3Kbs4Rt0clTvHdd5b6pUlj29cxfr
         8jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=49WjGoOgDkgpkuPANvcaxQ6mZZZlfR1hWFe+/FfhLx4=;
        b=OfmUf3CV3V1YuHBaXuUgh8XnU8aH5yZyTO8KBkwLy0Slgdk3BGwlOEoy3npRoREzAL
         9vLtNYknaJ6ujjCADhfaFrPMz081dGZDg7Y4we9te/l23pLpwxTBCKHgIV0qsNOiAUW7
         qmnq/h9OVnD8p2dyepxGWmPRBkceYplwGzsxrOVHUDnrOtZS8o4drny/BcrK5O7PUpBT
         oWk28Y0T/ygkC4zOCrg6SxSKdxNWGP6AUBeXV0sUqcNCSeHdnST67sB4fHBjj43UdZBA
         mORN5pz4EnNhiHqQdhDPIgfVGJaNkkTFh7vmEsIt6RZxqte5ShAaxHwaxLydKBHemWWS
         wGFw==
X-Gm-Message-State: ACgBeo1VzwLz6CVAlRTN9/gOVBxnls3D5vkN7UNYbsknjUMlbkNBNEUr
        OOlXq+ARcmHbpx5jS0i6MCXh0nXHi28=
X-Google-Smtp-Source: AA6agR4rhTcKBH9HmG7a+modFgYhChT4U2jO88jK3ccWwlCCknmoMv9nrzGCdU5TSjvRhcPvUR6wOQ==
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:5547 with SMTP id iv16-20020a05600c549000b003b48db05547mr2590870wmb.77.1663078963535;
        Tue, 13 Sep 2022 07:22:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c47c400b003a541d893desm12837661wmo.38.2022.09.13.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:22:42 -0700 (PDT)
Message-Id: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
From:   "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 14:22:42 +0000
Subject: [PATCH] fuzz: add basic fuzz testing for git command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Arthur Chan <arthur.chan@adalogics.com>,
        Arthur Chan <arthur.chan@adalogics.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arthur Chan <arthur.chan@adalogics.com>

fuzz-cmd-base.c / fuzz-cmd-base.h provides base functions for
fuzzing on git command which are compatible with libFuzzer
(and possibly other fuzzing engines).
fuzz-cmd-status.c provides first git command fuzzing target
as a demonstration of the approach.

CC: Josh Steadmon <steadmon@google.com>
Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
---
    fuzz: add basic fuzz testing for git command
    
    An initial attempt to create LibFuzzer compatible fuzzer for git
    command. fuzz-cmd-base.c / fuzz-cmd-base.h provides base functions for
    fuzzing on git command which are compatible with libFuzzer (and possibly
    other fuzzing engines). fuzz-cmd-status.c provides first git command
    fuzzing target as a demonstration of the approach.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1351%2Farthurscchan%2Ffuzz-git-cmd-status-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1351/arthurscchan/fuzz-git-cmd-status-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1351

 .gitignore        |   2 +
 Makefile          |   2 +
 fuzz-cmd-base.c   | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 fuzz-cmd-base.h   |  13 ++++++
 fuzz-cmd-status.c |  68 +++++++++++++++++++++++++++
 5 files changed, 202 insertions(+)
 create mode 100644 fuzz-cmd-base.c
 create mode 100644 fuzz-cmd-base.h
 create mode 100644 fuzz-cmd-status.c

diff --git a/.gitignore b/.gitignore
index 80b530bbed2..5d0ce214164 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,8 @@
 /fuzz_corpora
 /fuzz-pack-headers
 /fuzz-pack-idx
+/fuzz-cmd-base
+/fuzz-cmd-status
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index c6e126e54c2..20742935073 100644
--- a/Makefile
+++ b/Makefile
@@ -689,6 +689,7 @@ ETAGS_TARGET = TAGS
 FUZZ_OBJS += fuzz-commit-graph.o
 FUZZ_OBJS += fuzz-pack-headers.o
 FUZZ_OBJS += fuzz-pack-idx.o
+FUZZ_OBJS += fuzz-cmd-status.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
@@ -961,6 +962,7 @@ LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += fsmonitor-settings.o
+LIB_OBJS += fuzz-cmd-base.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/fuzz-cmd-base.c b/fuzz-cmd-base.c
new file mode 100644
index 00000000000..98f05c78372
--- /dev/null
+++ b/fuzz-cmd-base.c
@@ -0,0 +1,117 @@
+#include "cache.h"
+#include "fuzz-cmd-base.h"
+
+
+/*
+ * This function is used to randomize the content of a file with the
+ * random data. The random data normally come from the fuzzing engine
+ * LibFuzzer in order to create randomization of the git file worktree
+ * and possibly messing up of certain git config file to fuzz different
+ * git command execution logic.
+ */
+void randomize_git_file(char *dir, char *name, char *data_chunk, int data_size) {
+   char fname[256];
+   FILE *fp;
+
+   snprintf(fname, 255, "%s/%s", dir, name);
+
+   fp = fopen(fname, "wb");
+   if (fp) {
+      fwrite(data_chunk, 1, data_size, fp);
+      fclose(fp);
+   }
+}
+
+/*
+ * This function is the variants of the above functions which takes
+ * in a set of target files to be processed. These target file are
+ * passing to the above function one by one for content rewrite.
+ */
+void randomize_git_files(char *dir, char *name_set[], int files_count, char *data, int size) {
+   int data_size = size / files_count;
+
+   for(int i=0; i<files_count; i++) {
+      char *data_chunk = malloc(data_size);
+      memcpy(data_chunk, data + (i * data_size), data_size);
+
+      randomize_git_file(dir, name_set[i], data_chunk, data_size);
+
+      free(data_chunk);
+   }
+}
+
+/*
+ * Instead of randomizing the content of existing files. This helper
+ * function helps generate a temp file with random file name before
+ * passing to the above functions to get randomized content for later
+ * fuzzing of git command
+ */
+void generate_random_file(char *data, int size) {
+   unsigned char *hash = malloc(size);
+   char *fname = malloc((size*2)+12);
+   char *data_chunk = malloc(size);
+
+   memcpy(hash, data, size);
+   memcpy(data_chunk, data + size, size);
+
+   snprintf(fname, size*2+11, "TEMP-%s-TEMP", hash_to_hex(hash));
+   randomize_git_file(".", fname, data_chunk, size);
+
+   free(hash);
+   free(fname);
+   free(data_chunk);
+}
+
+/*
+ * This function helps to generate random commit and build up a
+ * worktree with randomization to provide a target for the fuzzing
+ * of git commands.
+ */
+void generate_commit(char *data, int size) {
+   int ret = 0;
+   char *data_chunk = malloc(size * 2);
+   memcpy(data_chunk, data, size * 2);
+
+   generate_random_file(data_chunk, size);
+   ret += system("git add TEMP-*-TEMP");
+   ret += system("git commit -m\"New Commit\"");
+
+   free(data_chunk);
+}
+
+/*
+ * In some cases, there maybe some fuzzing logic that will mess
+ * up with the git repository and its configuration and settings.
+ * This function aims to reset the git repository into the default
+ * base settings before each round of fuzzing.
+ */
+int reset_git_folder(void) {
+   int ret = 0;
+
+   ret += system("rm -rf ./.git");
+   ret += system("rm -f ./TEMP-*-TEMP");
+   ret += system("git init");
+   ret += system("git config --global user.name \"FUZZ\"");
+   ret += system("git config --global user.email \"FUZZ@LOCALHOST\"");
+   ret += system("git config --global --add safe.directory '*'");
+   ret += system("git add ./TEMP_1 ./TEMP_2");
+   ret += system("git commit -m\"First Commit\"");
+
+   return ret;
+}
+
+/*
+ * This helper function returns the maximum number of commit can
+ * be generated by the provided random data without reusing the
+ * data to increase randomization of the fuzzing target and allow
+ * more path of fuzzing to be covered.
+ */
+int get_max_commit_count(int data_size, int git_files_count, int hash_size) {
+   int count = (data_size - 4 - git_files_count * 2) / (hash_size * 2);
+
+   if(count > 20) {
+      count = 20;
+   }
+
+   return count;
+}
diff --git a/fuzz-cmd-base.h b/fuzz-cmd-base.h
new file mode 100644
index 00000000000..d63e46eac75
--- /dev/null
+++ b/fuzz-cmd-base.h
@@ -0,0 +1,13 @@
+#ifndef FUZZ_CMD_BASE_H
+#define FUZZ_CMD_BASE_H
+
+#define HASH_SIZE 20
+
+void randomize_git_files(char *dir, char *name_set[], int files_count, char *data, int size);
+void randomize_git_file(char *dir, char *name, char *data_chunk, int data_size);
+void generate_random_file(char *data, int size);
+void generate_commit(char *data, int size);
+int reset_git_folder(void);
+int get_max_commit_count(int data_size, int git_files_count, int hash_size);
+
+#endif
diff --git a/fuzz-cmd-status.c b/fuzz-cmd-status.c
new file mode 100644
index 00000000000..b02410a1259
--- /dev/null
+++ b/fuzz-cmd-status.c
@@ -0,0 +1,68 @@
+#include "builtin.h"
+#include "repository.h"
+#include "fuzz-cmd-base.h"
+
+int cmd_status(int argc, const char **argv, const char *prefix);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
+   int no_of_commit;
+   int max_commit_count;
+   char *argv[2];
+   char *data_chunk;
+   char *basedir = "./.git";
+
+   /*
+    *  Initialize the repository
+    */
+   initialize_the_repository();
+
+   max_commit_count = get_max_commit_count(size, 0, HASH_SIZE);
+
+   /*
+    * End this round of fuzzing if the data is not large enough
+    */
+   if (size <= (HASH_SIZE * 2 + 4)) {
+      repo_clear(the_repository);
+      return 0;
+   }
+
+   if (reset_git_folder()) {
+      repo_clear(the_repository);
+      return 0;
+   }
+
+   /*
+    * Generate random commit
+    */
+   no_of_commit = (*((int *)data)) % max_commit_count + 1;
+   data += 4;
+   size -= 4;
+
+   for (int i=0; i<no_of_commit; i++) {
+      data_chunk = malloc(HASH_SIZE * 2);
+      memcpy(data_chunk, data, HASH_SIZE * 2);
+      generate_commit(data_chunk, HASH_SIZE);
+      data += (HASH_SIZE * 2);
+      size -= (HASH_SIZE * 2);
+      free(data_chunk);
+   }
+
+   /*
+    * Final preparing of the repository settings
+    */
+   repo_clear(the_repository);
+   repo_init(the_repository, basedir, ".");
+
+   /*
+    * Calling target git command
+    */
+   argv[0] = "status";
+   argv[1] = "-v";
+   cmd_status(2, (const char **)argv, (const char *)"");
+
+   repo_clear(the_repository);
+
+   return 0;
+}

base-commit: dd3f6c4cae7e3b15ce984dce8593ff7569650e24
-- 
gitgitgadget
