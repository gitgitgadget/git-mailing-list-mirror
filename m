Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E221FC433E0
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7472064C
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 23:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUYPPxRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGQXY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQXY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 19:24:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCECC0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 16:24:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so8020630wmm.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 16:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=R796q2XMRT6VhCWScwHiTGKApxishjmBM2A2TLbyTHE=;
        b=eUYPPxRvMdYJWAuZFSfZacvVtzfbmd4Y7yYhN1lgV4tQ2SrvsDPFvZ3mnD2ZHBqwL3
         d3keYMTEqq5bo8HJQAB5Yru068Y1m2Wlij2hjGMQUI8RPEkec54lm06qBpqc8r4L6drs
         I3n/2YpAuVYdLz/xhpxn1vNTa3mrc772WzDmSTEBStLLW79vTCJ76Q5AJAEKH9sAT/iM
         XJCnqQIAZ5aPcdBb3MW9dABA6WAF/TYSg80NZ4LdmVY8aF60MdgI2Q990Cu+7uAMLjRo
         LUUdNP9tH33MP8mXZW2TlmVuSXnvD7qdSilIaNapehc6H0jRVdK1s9ZzXrFHkYfePBu3
         SK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R796q2XMRT6VhCWScwHiTGKApxishjmBM2A2TLbyTHE=;
        b=srlri/9z0R11QNPKERl1QjL05TTPO9DJRDYqUQG4bDxFzhxVPuDqfvHRjtRASOWjlb
         lpqJBf21Y9E1WRCG/wIsp/XTL/GUxykUlL/XLGzyr7Dtd4MI+6e8Q/YwBpVpxT2IwmJu
         SADwlRZ8UwPu0SDm4w22MTPV1Rshy4aY78Klh3ACC98DMEJs6nLBWXgvnjtW01+OFE0D
         +9HzTV2MjLbJbMXJQAPlNAwE/snabDeZ89D9Mu7Tse73DAhbZVp0G7QO+Al7DAMOwy0G
         nI/7JlPDtCb7bnMXuygCDIIeIA5EOiL4dakKKtSrJ6YvKBHCGOnWnHGYCHNKvB/DVliP
         IVCw==
X-Gm-Message-State: AOAM531v/PMIpJtxj0e7ExrfXAEEfq7VgPQJk2XVDiaagFg+XUzWW24Y
        IQpXnZQ3BvIKy6iq1uauIBC9es/E
X-Google-Smtp-Source: ABdhPJwOw/SJ31FGRBCNQbyTYti04Rn/xPm7xNLRI7cqdHsSAMtV69bSuyqoMxc3xuPdA6tqpIikFw==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr11038826wmb.75.1595028295698;
        Fri, 17 Jul 2020 16:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm15585693wmj.44.2020.07.17.16.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 16:24:54 -0700 (PDT)
Message-Id: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jul 2020 23:24:53 +0000
Subject: [PATCH] git-mv: improve error message for conflicted file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

'git mv' has always complained about renaming a conflicted
file, as it cannot handle multiple index entries for one file.
However, the error message it uses has been the same as the
one for an untracked file:

    fatal: not under version control, src=...

which is patently wrong.  Distinguish the two cases and
add a test to make sure we produce the correct message.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
    git-mv: improve error message for conflicted file
    
    'git mv' has always complained about renaming a conflicted file, as it
    cannot handle multiple index entries for one file. However, the error
    message it uses has been the same as the one for an untracked file:
    
    fatal: not under version control, src=...
    
    which is patently wrong. Distinguish the two cases and add a test to
    make sure we produce the correct message.
    
    Signed-off-by: Chris Torek chris.torek@gmail.com [chris.torek@gmail.com]
    
    
    ------------------------------------------------------------------------
    
    A small note on the test: I originally had a different message text, so
    the grep is slightly more general than necessary here. This leaves room
    for a better message, though; I'm not sure mine is that great.
    
    The error messages in general from 'git mv' could probably stand a lot
    of cleanup. This is just a minimal fix for some particularly bad
    behavior.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-678%2Fchris3torek%2Fgit-mv-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-678/chris3torek/git-mv-message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/678

 builtin/mv.c  | 15 ++++++++++++---
 t/t7001-mv.sh | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index be15ba7044..7dff121629 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -220,9 +220,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (cache_name_pos(src, length) < 0)
-			bad = _("not under version control");
-		else if (lstat(dst, &st) == 0 &&
+		} else if (cache_name_pos(src, length) < 0) {
+			/*
+			 * This occurs for both untracked files *and*
+			 * files that are in merge-conflict state, so
+			 * let's distinguish between those two.
+			 */
+			struct cache_entry *ce = cache_file_exists(src, length, ignore_case);
+			if (ce == NULL)
+				bad = _("not under version control");
+			else
+				bad = _("must resolve merge conflict first");
+		} else if (lstat(dst, &st) == 0 &&
 			 (!ignore_case || strcasecmp(src, dst))) {
 			bad = _("destination exists");
 			if (force) {
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 36b50d0b4c..b4974f9385 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -248,6 +248,24 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 
 rm -f dirty dirty2
 
+# NB: This test is about the error message
+# as well as the failure.
+test_expect_success 'git mv error on conflicted file' '
+	rm -fr .git &&
+	git init &&
+	touch conflicted &&
+	cfhash=$(git hash-object -w conflicted) &&
+	git update-index --index-info <<-EOF &&
+	$(printf "0 $cfhash 0\tconflicted\n")
+	$(printf "100644 $cfhash 1\tconflicted\n")
+	EOF
+
+	test_must_fail git mv conflicted newname 2>actual &&
+	test_i18ngrep "merge.conflict" actual
+'
+
+rm -f conflicted
+
 test_expect_success 'git mv should overwrite symlink to a file' '
 
 	rm -fr .git &&

base-commit: b6a658bd00c9c29e07f833cabfc0ef12224e277a
-- 
gitgitgadget
