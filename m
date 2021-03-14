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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB8C4332B
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71B264EB0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhCNSsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhCNSrr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD430C061762
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g25so6841617wmh.0
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dsdlIfBIWjFjjQUFEJkLCxf+5hhOr4wPB3YEkStWjUU=;
        b=vIgDfkFPOz8Vd3yLBn3McFJ/FVnPLWbdTRvvSY2n9xwDJQFt8isvTUeCT8tTbT7MQ5
         4Y3akydBH++SRnr3Lds922i6Ox6lArmL3rXy7sP8lht8Ne6c2mQ9yGQchmGUyydiNPTp
         /WbpB2xMgxUCWmckuxWpWte5A6eDLAbz0Ug0AHE5kfGeMsw9YdT/1YTHYVlfNRSAKuV5
         0n5TEfpI5JbTGfWks38bYfO+9akvl5gMhgrw4TQt01DATdj5q9Xv7/V455q9suDeuU+g
         NYUuSTW6EFxD9HdXFRFocBa7xCp5S0/pUKYaWZ6tbkjuc4EZ9kCCr6RBLybRkI+98M4o
         A0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dsdlIfBIWjFjjQUFEJkLCxf+5hhOr4wPB3YEkStWjUU=;
        b=Q/VBbkDhcmk/Kh4t4UgYhWmsIZTEMnVCrbdNU8i00RWgffyvQ10d1j3dfXqkBTWoF/
         Py6yiwsNNsxPdw1kxblojfVCdNC26drzJ5FqpYMgh/n60qLSboRa1a6rX89COsV63kDo
         3kJiVYMmwxGbYtbjVsCeOxmoOsUYL8KEI+dtLv/ilOfTKeXlD3fyGFqpbMP/eytYch1A
         bFfMHSvrIpo5VA+w/mvLGXTL9Fmbz4FgmwdMvsxcR9SaMHzCEZlSqI6TnTPEeQxrOG2T
         H37V/mHlV+5b01JBe4Bq3vx2eh7zetnWzV2SJfNWwiYExZTSk+k9vjkohjKOHodMN9yQ
         MVHQ==
X-Gm-Message-State: AOAM533yw7WI46SuoGT92BYZh35QoYayWUdRC1aqzSEIZsxDd1BPbzD+
        sCj9tm9pZ9WxnoVX7drrC+TmjXZSZjg=
X-Google-Smtp-Source: ABdhPJypClUErR7rw+o1XFMj7/wOKiU5uhHzpczPWgC+pTWUaMIiXCAz4KiVPfQO0WsRSJXglIqI0w==
X-Received: by 2002:a1c:bc82:: with SMTP id m124mr22711540wmf.118.1615747665665;
        Sun, 14 Mar 2021 11:47:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm14122834wrp.31.2021.03.14.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:45 -0700 (PDT)
Message-Id: <a10ab9e68809e1045e4d181fa0cc807dbe6953cd.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:37 +0000
Subject: [PATCH v2 4/9] worktree: fix leak in dwim_branch()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

Make sure that we release the temporary strbuf during dwim_branch() for
all codepaths (and not just for the early return).

This leak appears to have been introduced in:
  f60a7b763f (worktree: teach "add" to check out existing branches, 2018-04-24)

Note that UNLEAK(branchname) is still needed: the returned result is
used in add(), and is stored in a pointer which is used to point at one
of:
  - a string literal ("HEAD")
  - member of argv (whatever the user specified in their invocation)
  - or our newly allocated string returned from dwim_branch()
Fixing the branchname leak isn't impossible, but does not seem
worthwhile given that add() is called directly from cmd_main(), and
cmd_main() returns immediately thereafter - UNLEAK is good enough.

This leak was found when running t0001 with LSAN, see also LSAN output
below:

Direct leak of 60 byte(s) in 1 object(s) allocated from:
    #0 0x49a859 in realloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9ab076 in xrealloc /home/ahunt/oss-fuzz/git/wrapper.c:126:8
    #2 0x939fcd in strbuf_grow /home/ahunt/oss-fuzz/git/strbuf.c:98:2
    #3 0x93af53 in strbuf_splice /home/ahunt/oss-fuzz/git/strbuf.c:239:3
    #4 0x83559a in strbuf_check_branch_ref /home/ahunt/oss-fuzz/git/object-name.c:1593:2
    #5 0x6988b9 in dwim_branch /home/ahunt/oss-fuzz/git/builtin/worktree.c:454:20
    #6 0x695f8f in add /home/ahunt/oss-fuzz/git/builtin/worktree.c:525:19
    #7 0x694a04 in cmd_worktree /home/ahunt/oss-fuzz/git/builtin/worktree.c:1036:10
    #8 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #9 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #10 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #11 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #12 0x69caee in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #13 0x7f7b7dd10349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/worktree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1cd5c2016e3f..b0563aef685f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -446,16 +446,18 @@ static void print_preparing_worktree_line(int detach,
 static const char *dwim_branch(const char *path, const char **new_branch)
 {
 	int n;
+	int branch_exists;
 	const char *s = worktree_basename(path, &n);
 	const char *branchname = xstrndup(s, n);
 	struct strbuf ref = STRBUF_INIT;
 
 	UNLEAK(branchname);
-	if (!strbuf_check_branch_ref(&ref, branchname) &&
-	    ref_exists(ref.buf)) {
-		strbuf_release(&ref);
+
+	branch_exists = !strbuf_check_branch_ref(&ref, branchname) &&
+	                ref_exists(ref.buf);
+	strbuf_release(&ref);
+	if (branch_exists)
 		return branchname;
-	}
 
 	*new_branch = branchname;
 	if (guess_remote) {
-- 
gitgitgadget

