Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5FC433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8594E6194C
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCUQ7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCUQ6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05277C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so14219609wrt.8
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n4+S2Pqpnjccom1Dygbobupx9Ufrm4jBnm7Kzcw1WCE=;
        b=XLUtlmwajkIUgtD1VwWcx2iuS/NeqsdsFjyYHtEvjlZqyz2AOaPc/V/RjGVMTPlTWJ
         GprlwxmQkE0uvtDipoohrQwdNGF9/V41dtR4+TfqRTsFNJQJRmLnV/bGMIgpsdqQLuWz
         M2FvmAPg9mvhrzpcGmA37R+th4lqtSojui4PfBazbNqYt1tkdSzrcMS4Jz4xD1RjTe0g
         2rs2hRk3vdcnI++CdEXpqYIrstHk4Wf1g3VW0HSgu76ldiiL7pOUv1D8Ub8mblHEn+Eq
         kwqYRWZYhme1Ybq/etpiyHeTI1/FsrBZGgslqDpZyHqU7kEUkdQVEobeQKPfJ39LGwNW
         ZC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n4+S2Pqpnjccom1Dygbobupx9Ufrm4jBnm7Kzcw1WCE=;
        b=bK3HglbvTP8+fOsynUNWDwF5muwegOk7sG2GMuntQ8IDV2kLIjh6l/kYqOYM9gMroo
         FCmthk/kPNIGDHfV87VFzOQ7fjhTZK0CdzErwTHQYijb2PxEyOWORtW8rqIejEoSUwU2
         cKeSj48tBvsv1EYDTmLsLXuDeHopPirJrfpvCmu0cZrdzkqx3Y6DAuiRx4o0yrZn7ftC
         X5F9CjfhJkutKNkDxPIhJr5+gZEQsnEjR1gNr6JkKHBTnfpaa24qrMaPmc02YMiIN27h
         2q6aWvF0CkHwOEWPB4mKOcNzkpu0Ak6Ra9AsCYRRpYKa/u/GKAWmA11RysoV0IqfMZ/+
         5V9w==
X-Gm-Message-State: AOAM532fTl0G0fIvB1OIJGDFvVrONXMvR2uZJq/D+lFDxDwvbiFWM+tz
        w93/31Df/Ccqawza9URSuyxwaTruM0Q=
X-Google-Smtp-Source: ABdhPJyEQYpadVsKmEZYb17Yxz9yN0gJCgAfigS73IMoHm77GrS0YDCH8fFABSlAdgnNaagsH2Jg+Q==
X-Received: by 2002:adf:ab52:: with SMTP id r18mr14226823wrc.65.1616345920770;
        Sun, 21 Mar 2021 09:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20sm13432249wmp.30.2021.03.21.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:40 -0700 (PDT)
Message-Id: <40c5c915fc1e818661fc272cdc8c37678e8f3fcf.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:31 +0000
Subject: [PATCH v3 3/9] clone: free or UNLEAK further pointers when finished
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

Most of these pointers can safely be freed when cmd_clone() completes,
therefore we make sure to free them. The one exception is that we
have to UNLEAK(repo) because it can point either to argv[0], or a
malloc'd string returned by absolute_pathdup().

We also have to free(path) in the middle of cmd_clone(): later during
cmd_clone(), path is unconditionally overwritten with a different path,
triggering a leak. Freeing the first path immediately after use (but
only in the case where it contains data) seems like the cleanest
solution, as opposed to freeing it unconditionally before path is reused
for another path. This leak appears to have been introduced in:
  f38aa83f9a (use local cloning if insteadOf makes a local URL, 2014-07-17)

These leaks were found when running t0001 with LSAN, see also an excerpt
of the LSAN output below (the full list is omitted because it's far too
long, and mostly consists of indirect leakage of members of the refs we
are freeing).

Direct leak of 178 byte(s) in 1 object(s) allocated from:
    #0 0x49a53d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9a6ff4 in do_xmalloc /home/ahunt/oss-fuzz/git/wrapper.c:41:8
    #2 0x9a6fca in xmalloc /home/ahunt/oss-fuzz/git/wrapper.c:62:9
    #3 0x8ce296 in copy_ref /home/ahunt/oss-fuzz/git/remote.c:885:8
    #4 0x8d2ebd in guess_remote_head /home/ahunt/oss-fuzz/git/remote.c:2215:10
    #5 0x51d0c5 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1308:4
    #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #10 0x69c45e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #11 0x7f6a459d5349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 165 byte(s) in 1 object(s) allocated from:
    #0 0x49a53d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9a6fc4 in do_xmalloc /home/ahunt/oss-fuzz/git/wrapper.c:41:8
    #2 0x9a6f9a in xmalloc /home/ahunt/oss-fuzz/git/wrapper.c:62:9
    #3 0x8ce266 in copy_ref /home/ahunt/oss-fuzz/git/remote.c:885:8
    #4 0x51e9bd in wanted_peer_refs /home/ahunt/oss-fuzz/git/builtin/clone.c:574:21
    #5 0x51cfe1 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1284:17
    #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #10 0x69c42e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #11 0x7f8fef0c2349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 178 byte(s) in 1 object(s) allocated from:
    #0 0x49a53d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9a6ff4 in do_xmalloc /home/ahunt/oss-fuzz/git/wrapper.c:41:8
    #2 0x9a6fca in xmalloc /home/ahunt/oss-fuzz/git/wrapper.c:62:9
    #3 0x8ce296 in copy_ref /home/ahunt/oss-fuzz/git/remote.c:885:8
    #4 0x8d2ebd in guess_remote_head /home/ahunt/oss-fuzz/git/remote.c:2215:10
    #5 0x51d0c5 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1308:4
    #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #10 0x69c45e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #11 0x7f6a459d5349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 165 byte(s) in 1 object(s) allocated from:
    #0 0x49a6b2 in calloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x9a72f2 in xcalloc /home/ahunt/oss-fuzz/git/wrapper.c:140:8
    #2 0x8ce203 in alloc_ref_with_prefix /home/ahunt/oss-fuzz/git/remote.c:867:20
    #3 0x8ce1a2 in alloc_ref /home/ahunt/oss-fuzz/git/remote.c:875:9
    #4 0x72f63e in process_ref_v2 /home/ahunt/oss-fuzz/git/connect.c:426:8
    #5 0x72f21a in get_remote_refs /home/ahunt/oss-fuzz/git/connect.c:525:8
    #6 0x979ab7 in handshake /home/ahunt/oss-fuzz/git/transport.c:305:4
    #7 0x97872d in get_refs_via_connect /home/ahunt/oss-fuzz/git/transport.c:339:9
    #8 0x9774b5 in transport_get_remote_refs /home/ahunt/oss-fuzz/git/transport.c:1388:4
    #9 0x51cf80 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1271:9
    #10 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #11 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #12 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #13 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #14 0x69c45e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #15 0x7f6a459d5349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 105 byte(s) in 1 object(s) allocated from:
    #0 0x49a859 in realloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9a71f6 in xrealloc /home/ahunt/oss-fuzz/git/wrapper.c:126:8
    #2 0x93622d in strbuf_grow /home/ahunt/oss-fuzz/git/strbuf.c:98:2
    #3 0x937a73 in strbuf_addch /home/ahunt/oss-fuzz/git/./strbuf.h:231:3
    #4 0x939fcd in strbuf_add_absolute_path /home/ahunt/oss-fuzz/git/strbuf.c:911:4
    #5 0x69d3ce in absolute_pathdup /home/ahunt/oss-fuzz/git/abspath.c:261:2
    #6 0x51c688 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1021:10
    #7 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #8 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #9 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #10 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #11 0x69c45e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #12 0x7f6a459d5349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/clone.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 51e844a2de0a..952fe3d8fc88 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -964,10 +964,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
 	const char *repo_name, *repo, *work_tree, *git_dir;
-	char *path, *dir, *display_repo = NULL;
+	char *path = NULL, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
 	const struct ref *refs, *remote_head;
-	const struct ref *remote_head_points_at;
+	struct ref *remote_head_points_at = NULL;
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
@@ -1017,9 +1017,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
-	if (path)
+	if (path) {
+		FREE_AND_NULL(path);
 		repo = absolute_pathdup(repo_name);
-	else if (strchr(repo_name, ':')) {
+	} else if (strchr(repo_name, ':')) {
 		repo = repo_name;
 		display_repo = transport_anonymize_url(repo);
 	} else
@@ -1393,6 +1394,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
+	free_refs(mapped_refs);
+	free_refs(remote_head_points_at);
+	free(dir);
+	free(path);
+	UNLEAK(repo);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	strvec_clear(&transport_ls_refs_options.ref_prefixes);
-- 
gitgitgadget

