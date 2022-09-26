Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6390BC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 23:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIZXxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIZXxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 19:53:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FA883EC
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 16:53:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s14so12611930wro.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 16:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=UdtWv8V6IF+24c9v9/KanJYVOvkZ5eKZKDIeRbblQBU=;
        b=BFgUOleUpYtXw1ncbM+/k8s/L1yec6FyGGWAFR5q2m6LO7YbvBTcEwMwA28Tac63Vm
         tGzsoSVlArchzu/Ahq+FsFNW+quV5h/I9fJEnX2Dfh3g1KCeOVoKRtiHbEUCJTDTnBIJ
         hq6zupNl5vmvXVUkQjAln3LQOK8fVyvztY8PQL51XizrlTUh0ZaljMtmOjtTKelIwpww
         Fm+5iDOx5pgpOTrk9panyZkUdvWvJeZbAQaui0oZQmBUR94NkrTIazB1CtcaOYkopyxz
         k18WeX+ZlVOfHU55YiXofMvjieqzHrcBpfDePe8FqY2EHHKgIu1OFZ80EHC0wTgRBSTN
         QsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=UdtWv8V6IF+24c9v9/KanJYVOvkZ5eKZKDIeRbblQBU=;
        b=qrAvszXi2jdIFmikl0++xelBSuUbClsUxS/RDw8FxFqTmcYGQ0ZYMO8AlnDlnO/Oo2
         AvRh/Ta2tXCr80+qIaaIZWE3FCuXRUpnXJXH5SXXivP7jPOjsNFXxD6xL8mgey/jE1jG
         Ofh5cwSm377t2mPnIAiPi4LKTFLt819V40CKuYai8FGHGCFEuzM3neFmZCHP4PSsdxDg
         EMpWBKTnHkI9SA2qgxp1nMOZ16NNcunsk1Wq6Ta/F8cOtuTxVGE2O72kFXHyIKX30+zE
         mOoDXSt2fcVTXaS9IKEEwLP1gHAPAV1R+0bbdG7ryyVMw8s6FX6dzgy/NGUsppiSxmGH
         eVHQ==
X-Gm-Message-State: ACrzQf0YWCr1Y/7FJ6EAeU6g0mpJy7XYwy9m8nNc7r6K0JqADhmGVrQk
        bxiwe4m6NyY+m29jHiXrV7OI3YcPPh8=
X-Google-Smtp-Source: AMsMyM49AY7lHUCVO5pV49DPkQPrBcVd6mlshSCAHYil4a4G+s9fJ5XcBL/SKjrsS233taPZiz/hJA==
X-Received: by 2002:a5d:59ae:0:b0:22a:ff17:db96 with SMTP id p14-20020a5d59ae000000b0022aff17db96mr15497039wrr.299.1664236384915;
        Mon, 26 Sep 2022 16:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020adffe10000000b0022b014fb0b7sm106690wrr.110.2022.09.26.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:53:04 -0700 (PDT)
Message-Id: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 23:53:03 +0000
Subject: [PATCH] tmp-objdir: do not opendir() when handling a signal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In the tmp-objdir api, tmp_objdir_create will create a temporary
directory but also register signal handlers responsible for removing
the directory's contents and the directory itself. However, the
function responsible for recursively removing the contents and
directory, remove_dir_recurse() calls opendir(3) and closedir(3).
This can be problematic because these functions allocate and free
memory, which are not async-signal-safe functions. This can lead to
deadlocks.

One place we call tmp_objdir_create() is in git-receive-pack, where
we create a temporary quarantine directory "incoming". Incoming
objects will be written to this directory before they get moved to
the object directory.

We have observed this code leading to a deadlock:

	Thread 1 (Thread 0x7f621ba0b200 (LWP 326305)):
	#0  __lll_lock_wait_private (futex=futex@entry=0x7f621bbf8b80
		<main_arena>) at ./lowlevellock.c:35
	#1  0x00007f621baa635b in __GI___libc_malloc
		(bytes=bytes@entry=32816) at malloc.c:3064
	#2  0x00007f621bae9f49 in __alloc_dir (statp=0x7fff2ea7ed60,
		flags=0, close_fd=true, fd=5)
		at ../sysdeps/posix/opendir.c:118
	#3  opendir_tail (fd=5) at ../sysdeps/posix/opendir.c:69
	#4  __opendir (name=<optimized out>)
		at ../sysdeps/posix/opendir.c:92
	#5  0x0000557c19c77de1 in remove_dir_recurse ()
	#6  0x0000557c19d81a4f in remove_tmp_objdir_on_signal ()
	#7  <signal handler called>
	#8  _int_malloc (av=av@entry=0x7f621bbf8b80 <main_arena>,
		bytes=bytes@entry=7160) at malloc.c:4116
	#9  0x00007f621baa62c9 in __GI___libc_malloc (bytes=7160)
		at malloc.c:3066
	#10 0x00007f621bd1e987 in inflateInit2_ ()
		from /opt/gitlab/embedded/lib/libz.so.1
	#11 0x0000557c19dbe5f4 in git_inflate_init ()
	#12 0x0000557c19cee02a in unpack_compressed_entry ()
	#13 0x0000557c19cf08cb in unpack_entry ()
	#14 0x0000557c19cf0f32 in packed_object_info ()
	#15 0x0000557c19cd68cd in do_oid_object_info_extended ()
	#16 0x0000557c19cd6e2b in read_object_file_extended ()
	#17 0x0000557c19cdec2f in parse_object ()
	#18 0x0000557c19c34977 in lookup_commit_reference_gently ()
	#19 0x0000557c19d69309 in mark_uninteresting ()
	#20 0x0000557c19d2d180 in do_for_each_repo_ref_iterator ()
	#21 0x0000557c19d21678 in for_each_ref ()
	#22 0x0000557c19d6a94f in assign_shallow_commits_to_refs ()
	#23 0x0000557c19bc02b2 in cmd_receive_pack ()
	#24 0x0000557c19b29fdd in handle_builtin ()
	#25 0x0000557c19b2a526 in cmd_main ()
	#26 0x0000557c19b28ea2 in main ()

To prevent this, add a flag REMOVE_DIR_SIGNAL that allows
remove_dir_recurse() to know that a signal is being handled and avoid
calling opendir(3). One implication of this change is that when
signal handling, the temporary directory may not get cleaned up
properly.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    tmp-objdir: do not closedir() when handling a signal
    
    We have recently observed a Git process hanging around for weeks. A
    backtrace revealed that a git-receive-pack(1) process was deadlocked
    when trying to remove the quarantine directory "incoming." It turns out
    that the tmp_objdir API calls opendir(3) and closedir(3) to observe a
    directory's contents in order to remove all the contents before removing
    the directory itself. These functions are not async signal save as they
    allocate and free memory.
    
    The fix is to avoid calling these functions when handling a signal in
    order to avoid a deadlock. The implication of such a fix however, is
    that temporary object directories may not get cleaned up properly when a
    signal is being handled. The tradeoff this fix is making is to prevent
    deadlocks at the cost of temporary object directory cleanup.
    
    This is similar to 58d4d7f1c5 (2022-01-07 fetch: fix deadlock when
    cleaning up lockfiles in async signals)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1348%2Fjohn-cai%2Fjc%2Ffix-tmp-objdir-signal-handling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1348/john-cai/jc/fix-tmp-objdir-signal-handling-v1
Pull-Request: https://github.com/git/git/pull/1348

 dir.c        | 7 +++++--
 dir.h        | 3 +++
 tmp-objdir.c | 7 ++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 75429508200..a3183cb043f 100644
--- a/dir.c
+++ b/dir.c
@@ -3244,7 +3244,7 @@ void strip_dir_trailing_slashes(char *dir)
 
 static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 {
-	DIR *dir;
+	DIR *dir = NULL;
 	struct dirent *e;
 	int ret = 0, original_len = path->len, len, kept_down = 0;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
@@ -3261,7 +3261,10 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	}
 
 	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
-	dir = opendir(path->buf);
+
+	if ((flag & REMOVE_DIR_SIGNAL) == 0)
+		dir = opendir(path->buf);
+
 	if (!dir) {
 		if (errno == ENOENT)
 			return keep_toplevel ? -1 : 0;
diff --git a/dir.h b/dir.h
index 674747d93af..ba159f4abeb 100644
--- a/dir.h
+++ b/dir.h
@@ -498,6 +498,9 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
 /* Remove the_original_cwd too */
 #define REMOVE_DIR_PURGE_ORIGINAL_CWD 0x08
 
+/* Indicates a signal is being handled */
+#define REMOVE_DIR_SIGNAL 0x16
+
 /*
  * Remove path and its contents, recursively. flags is a combination
  * of the above REMOVE_DIR_* constants. Return 0 on success.
diff --git a/tmp-objdir.c b/tmp-objdir.c
index adf6033549e..13943098738 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -34,6 +34,7 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 {
 	int err;
+	int flags = 0;
 
 	if (!t)
 		return 0;
@@ -49,7 +50,11 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	 * have pre-grown t->path sufficiently so that this
 	 * doesn't happen in practice.
 	 */
-	err = remove_dir_recursively(&t->path, 0);
+
+	if (on_signal)
+		flags = flags | REMOVE_DIR_SIGNAL;
+
+	err = remove_dir_recursively(&t->path, flags);
 
 	/*
 	 * When we are cleaning up due to a signal, we won't bother

base-commit: 4fd6c5e44459e6444c2cd93383660134c95aabd1
-- 
gitgitgadget
