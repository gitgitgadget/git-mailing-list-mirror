Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E7C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 20:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiI3UrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 16:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI3UrR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 16:47:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27DC1F89A1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 13:47:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b7so908547wrq.9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=lKR5UGmJLwJkBoxWNa1zodXyVhTTfMYLZPiQTyL/rdw=;
        b=hVvK18yADLeS6vSttVNoA3b3p/Ueewlev1iqZ21EevaMlyialiWw7crbPZ2TqRzIyU
         CwK3XnPv6g3Z1nejWf57CsZp/AiwVH3O74DHjJ7UQ9JuWjOTJhKyZLuNYpN5xer7Hgek
         E11J63CJyFrrp/aFyiVi9I2iIJ02gcsRL1fF3JwaVxt07vi74ngeQlea1LiPOEYK1VPa
         YZXKXzdVl1UW7ress5+ol3ShjjLghO/xbEbrFLJSsCE7kyqH3f8wdOLjFWQey6WQphbC
         lyLRr+/8asloPcF3TRhB6uaAldEqK0HO2ymueNw8G6LOwm0SPeJ/PT3IYbPME41ASe24
         UIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lKR5UGmJLwJkBoxWNa1zodXyVhTTfMYLZPiQTyL/rdw=;
        b=cMYT7ndKfnIbweom58gYmE9pTUokQUJ6Tj42PyPz0Z2YE3jNHy8BOH3cI+0jFy2589
         A8APP+vduExRVYZOQb9vtpNPm8OpzZGlBeFp/xsBuxk/yS1WA6/QoSXukDDKc3y/aWYS
         PZ14uV3/xUdEucIhwJrEs8r25BCTgqLjI6LzRl63IYgUY4tbEaDBx+jlwmFMk5XlRak4
         EUVReOhntSW9rhjT61yMOhK7jOIhqZNDOFDMmXofYcSratp7bsEKDN0L0tmNLa5Ct92p
         APv9I07pbumC8B1FP16k+onsdPTERo0bqEomvQP3tuAiJMTh6r24TlVcimPbriizGyFe
         808Q==
X-Gm-Message-State: ACrzQf0yLv/ZyX6QVnW6pc6Us7jw/EsyYY362Io+AXpSJiGS94t/SESb
        nXd83OPQvqDF6fw5PkYd6W/CHZ+8V6s=
X-Google-Smtp-Source: AMsMyM471OCNwLCEE+nif9iUMC6Ctz10kd99Hscs+tzLXx735F1rDRs1LkaXNTGvqI2goLpPYi9uZw==
X-Received: by 2002:a5d:598f:0:b0:22a:f74d:ae24 with SMTP id n15-20020a5d598f000000b0022af74dae24mr6863964wri.544.1664570832700;
        Fri, 30 Sep 2022 13:47:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a1c5409000000b003b486027c8asm7975904wmb.20.2022.09.30.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:47:12 -0700 (PDT)
Message-Id: <pull.1348.v4.git.git.1664570831583.gitgitgadget@gmail.com>
In-Reply-To: <pull.1348.v3.git.git.1664376956780.gitgitgadget@gmail.com>
References: <pull.1348.v3.git.git.1664376956780.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Sep 2022 20:47:11 +0000
Subject: [PATCH v4] tmp-objdir: skip clean up when handling a signal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
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
	git#6  0x0000557c19d81a4f in remove_tmp_objdir_on_signal ()
	#7  <signal handler called>
	git#8  _int_malloc (av=av@entry=0x7f621bbf8b80 <main_arena>,
		bytes=bytes@entry=7160) at malloc.c:4116
	git#9  0x00007f621baa62c9 in __GI___libc_malloc (bytes=7160)
		at malloc.c:3066
	git#10 0x00007f621bd1e987 in inflateInit2_ ()
		from /opt/gitlab/embedded/lib/libz.so.1
	git#11 0x0000557c19dbe5f4 in git_inflate_init ()
	git#12 0x0000557c19cee02a in unpack_compressed_entry ()
	git#13 0x0000557c19cf08cb in unpack_entry ()
	git#14 0x0000557c19cf0f32 in packed_object_info ()
	git#15 0x0000557c19cd68cd in do_oid_object_info_extended ()
	git#16 0x0000557c19cd6e2b in read_object_file_extended ()
	git#17 0x0000557c19cdec2f in parse_object ()
	git#18 0x0000557c19c34977 in lookup_commit_reference_gently ()
	git#19 0x0000557c19d69309 in mark_uninteresting ()
	git#20 0x0000557c19d2d180 in do_for_each_repo_ref_iterator ()
	git#21 0x0000557c19d21678 in for_each_ref ()
	git#22 0x0000557c19d6a94f in assign_shallow_commits_to_refs ()
	git#23 0x0000557c19bc02b2 in cmd_receive_pack ()
	git#24 0x0000557c19b29fdd in handle_builtin ()
	git#25 0x0000557c19b2a526 in cmd_main ()
	git#26 0x0000557c19b28ea2 in main ()

Since we can't do the cleanup in a portable and signal-safe way, skip
the cleanup when we're handling a signal.

This means that when signal handling, the temporary directory may not
get cleaned up properly. This is mitigated by b3cecf49ea (tmp-objdir: new
API for creating temporary writable databases, 2021-12-06) which changed
the default name and allows gc to clean up these temporary directories.

In the event of a normal exit, we should still be cleaning up via the
atexit() handler.

Helped-by: Jeff King <peff@peff.net>
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
    cleaning up lockfiles in async signals) The difference being in this
    case, the cleanup of the files will not happen when handling a signal.
    
    Changes since v3:
    
     * Updated commit message to clarify that we still clean up the tmp dir
       on atexit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1348%2Fjohn-cai%2Fjc%2Ffix-tmp-objdir-signal-handling-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1348/john-cai/jc/fix-tmp-objdir-signal-handling-v4
Pull-Request: https://github.com/git/git/pull/1348

Range-diff vs v3:

 1:  d96c44e309f ! 1:  0ea467f25ca tmp-objdir: skip clean up when handling a signal
     @@ Commit message
          API for creating temporary writable databases, 2021-12-06) which changed
          the default name and allows gc to clean up these temporary directories.
      
     +    In the event of a normal exit, we should still be cleaning up via the
     +    atexit() handler.
     +
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## tmp-objdir.c ##


 tmp-objdir.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index adf6033549e..2a2012eb6d0 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -18,7 +18,7 @@ struct tmp_objdir {
 
 /*
  * Allow only one tmp_objdir at a time in a running process, which simplifies
- * our signal/atexit cleanup routines.  It's doubtful callers will ever need
+ * our atexit cleanup routines.  It's doubtful callers will ever need
  * more than one, and we can expand later if so.  You can have many such
  * tmp_objdirs simultaneously in many processes, of course.
  */
@@ -31,7 +31,7 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 	free(t);
 }
 
-static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
+int tmp_objdir_destroy(struct tmp_objdir *t)
 {
 	int err;
 
@@ -41,44 +41,21 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
-	if (!on_signal && t->prev_odb)
+	if (t->prev_odb)
 		restore_primary_odb(t->prev_odb, t->path.buf);
 
-	/*
-	 * This may use malloc via strbuf_grow(), but we should
-	 * have pre-grown t->path sufficiently so that this
-	 * doesn't happen in practice.
-	 */
 	err = remove_dir_recursively(&t->path, 0);
 
-	/*
-	 * When we are cleaning up due to a signal, we won't bother
-	 * freeing memory; it may cause a deadlock if the signal
-	 * arrived while libc's allocator lock is held.
-	 */
-	if (!on_signal)
-		tmp_objdir_free(t);
+	tmp_objdir_free(t);
 
 	return err;
 }
 
-int tmp_objdir_destroy(struct tmp_objdir *t)
-{
-	return tmp_objdir_destroy_1(t, 0);
-}
-
 static void remove_tmp_objdir(void)
 {
 	tmp_objdir_destroy(the_tmp_objdir);
 }
 
-static void remove_tmp_objdir_on_signal(int signo)
-{
-	tmp_objdir_destroy_1(the_tmp_objdir, 1);
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 void tmp_objdir_discard_objects(struct tmp_objdir *t)
 {
 	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
@@ -152,14 +129,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	 */
 	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
 
-	/*
-	 * Grow the strbuf beyond any filename we expect to be placed in it.
-	 * If tmp_objdir_destroy() is called by a signal handler, then
-	 * we should be able to use the strbuf to remove files without
-	 * having to call malloc.
-	 */
-	strbuf_grow(&t->path, 1024);
-
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
@@ -169,7 +138,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	the_tmp_objdir = t;
 	if (!installed_handlers) {
 		atexit(remove_tmp_objdir);
-		sigchain_push_common(remove_tmp_objdir_on_signal);
 		installed_handlers++;
 	}
 

base-commit: 4fd6c5e44459e6444c2cd93383660134c95aabd1
-- 
gitgitgadget
