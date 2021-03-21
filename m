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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0166EC433E2
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFF561959
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCUQ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCUQ6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887FAC061762
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g25so8199095wmh.0
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dsdlIfBIWjFjjQUFEJkLCxf+5hhOr4wPB3YEkStWjUU=;
        b=sVBIpX4pKdzvaf2+JXwkFEktW1J0jaDZk/BHVjTT43iiTJOnIXEmhWO9H0nkYynIYR
         d7q6rZfBUpOnmZqKTRpffzOIe37FfsMtFMSwo/uz3NdCv9XaWYftKUmho0V1Y744iMTQ
         N+Pe9hmySpM8OFLGfMpejTzsovBeuB2CogPzzLxdMkqnPfZY9ob8rOVSixfqePQDiSx9
         F60cCjX+UqCEmEDQt6STqe6bCZ8QYpwW1DpggWgtR4pFwqZKxdphYYeU4z/NtgoCDrvz
         zWPtYveTOks7OzkYivuTNikSsuqGBMJoWokVHKXc6HOaDe2woidkGrUPDXxN8iVD2D5/
         PjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dsdlIfBIWjFjjQUFEJkLCxf+5hhOr4wPB3YEkStWjUU=;
        b=VPTKRIdkE5q1uKP+CslFxfuxdT07byj06Oht3wsF+wOHFwqyby2TlM0dBbpO8702ov
         ZCC4CVSP07o4v30Z5gmYqpFPzMz94TkrIRiQeCMCkEQMBCHp3NsjoUnCsQCVda96xW73
         p0dpe1rAGNMzbs3ryoVF/PDRt7oZwUnCPe2QKzr4+mviCZL3WK9scGbTmX4fbZ3zPbeW
         xcRbPHJXXbEfVwKpAjo6Go9VLgnGFuHxZDZMsPMsJU2qaWX5q0jenuWJTW+108A4Rh3R
         GCJ2nPB9TjgmsxfHkcWlRxTQ3Sqe1ZPpMsnsDLP80GVxIrc0Q1epmdYaOUg/C3rRCD1h
         6EoA==
X-Gm-Message-State: AOAM5315+CvdP5g/FXLBav8tEyrunt9eB2eR7S23VXTfgZo3VSo29hS2
        AymtOLGJ9367hCSHvO4Y9K1cx9vuPcY=
X-Google-Smtp-Source: ABdhPJxIjrI1xsGlshx7VWKxbV+iDvdWzWpNnVxFNb8c1YQiBIBCde7+l4hhb+IQHMdaU6h3gGl+Uw==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr12623662wmj.185.1616345921326;
        Sun, 21 Mar 2021 09:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm17835567wrg.80.2021.03.21.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:41 -0700 (PDT)
Message-Id: <963f291d53444243c5ed183815729cefaceab323.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:32 +0000
Subject: [PATCH v3 4/9] worktree: fix leak in dwim_branch()
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

