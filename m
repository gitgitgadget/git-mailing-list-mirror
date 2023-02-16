Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E946C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 18:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBPS1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBPS1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 13:27:47 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0895B521D5
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:27:25 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q3so990346iow.11
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPjc5v2khkKIUKBc/rfoeP3JUfnO91/4Vjkaz0a/nIQ=;
        b=lgk8PRra9AQUuuRBFTVSkBK64lCUUF+6vtu11/dAnIDx0fUsblpWEzD1lIa6aqF5Ed
         /5R3zlw4CXeHtncJbqBkFgUmJCuBMeMftNjojpnd4vSDZPJRHYEn4uXHoefaj4fsDASA
         CtGoHyLhBgetL14CL6w67DY6q4uwll2+I+FbS8Njp8aiglm6eB6a7wOl6Xxwg5KWPiVa
         ulLQJJUvp9E1N7+0bzX6qukl3dWMRbR/+nCw52d0ms2uxncCx3bosqN6vq1qForXUy7J
         UzbPql/0IN/Xz7GkHun2aGultzYz04SdrVXLQXe7X4MM9ntJ8Cr6+hQRYpEX6mPJOyhi
         rP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPjc5v2khkKIUKBc/rfoeP3JUfnO91/4Vjkaz0a/nIQ=;
        b=W9mQ+yjCqdPysEEquMo+tp77KDFbGnVEoiWwWTLp10v/+W2UvWwaO11tjOQMYwR1bL
         EZL1IxDPxLad5LlFtftGwXAYf/Y+jhy7tfe8hokyNBOi2Aib64dQ5qAeLryFvpuoTj6f
         LvHNOABi9Awb8hk+WPpMWGvYPyf7IZnVHxv9/8mJXphQWyvCRmssCHKO09b9CLEui5+P
         BPxQp9bjumpQZ2nIaLvpbMAuS6k2equB7r1pAGxfGiPW4GxIe13Pb7h68wJBOh2WNrC+
         Fur2ffsQlk+3TKdlnfLSeY2Uk7KTcmlW8kyKLtIsplm9cIpAX2lDjuriu5s+wSRRev/w
         jjVw==
X-Gm-Message-State: AO0yUKV/pF9C8vk8fn8yRs/DNAUdvUrNEoCxpnEy6ZSxn/KSWLG62StB
        wjRjDmBh/kjhgH3t8PGtJsYXFxTEfWNqc10HjJ0=
X-Google-Smtp-Source: AK7set8U/fVPloxhiDLhVgcz7CH8CH3naEG4COp+1ONANvGl3jfkhJuV6gq9ZiwK6SM9lpBsC62a7A==
X-Received: by 2002:a5d:9941:0:b0:707:a501:e788 with SMTP id v1-20020a5d9941000000b00707a501e788mr5493935ios.7.1676572041110;
        Thu, 16 Feb 2023 10:27:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cu3-20020a05663848c300b00363362cd476sm758290jab.101.2023.02.16.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:27:20 -0800 (PST)
Date:   Thu, 16 Feb 2023 13:27:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH] dir-iterator: drop unused `DIR_ITERATOR_FOLLOW_SYMLINKS`
Message-ID: <9bb10b607e46f867a3f8f5c71abf13c990d1ecfe.1676572031.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `FOLLOW_SYMLINKS` flag was added to the dir-iterator API in
fa1da7d2ee (dir-iterator: add flags parameter to dir_iterator_begin,
2019-07-10) in order to follow symbolic links while traversing through a
directory.

`FOLLOW_SYMLINKS` gained its first caller in ff7ccc8c9a (clone: use
dir-iterator to avoid explicit dir traversal, 2019-07-10), but it was
subsequently removed in 6f054f9fb3 (builtin/clone.c: disallow `--local`
clones with symlinks, 2022-07-28).

Since then, we've held on to the code for `DIR_ITERATOR_FOLLOW_SYMLINKS`
in the name of making minimally invasive changes during a security
embargo.

In fact, we even changed the dir-iterator API in bffc762f87
(dir-iterator: prevent top-level symlinks without FOLLOW_SYMLINKS,
2023-01-24) without having any non-test callers of that flag.

Now that we're past those security embargo(s), let's finalize our
cleanup of the `DIR_ITERATOR_FOLLOW_SYMLINKS` code and remove its
implementation since there are no remaining callers.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 dir-iterator.c               | 12 +++---------
 dir-iterator.h               | 20 +-------------------
 t/helper/test-dir-iterator.c |  6 ++----
 t/t0066-dir-iterator.sh      | 34 ----------------------------------
 4 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 3764dd81a1..cedd304759 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -112,10 +112,7 @@ static int prepare_next_entry_data(struct dir_iterator_int *iter,
 	iter->base.basename = iter->base.path.buf +
 			      iter->levels[iter->levels_nr - 1].prefix_len;
 
-	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
-		err = stat(iter->base.path.buf, &iter->base.st);
-	else
-		err = lstat(iter->base.path.buf, &iter->base.st);
+	err = lstat(iter->base.path.buf, &iter->base.st);
 
 	saved_errno = errno;
 	if (err && errno != ENOENT)
@@ -213,13 +210,10 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 	iter->flags = flags;
 
 	/*
-	 * Note: stat/lstat already checks for NULL or empty strings and
+	 * Note: lstat already checks for NULL or empty strings and
 	 * nonexistent paths.
 	 */
-	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
-		err = stat(iter->base.path.buf, &iter->base.st);
-	else
-		err = lstat(iter->base.path.buf, &iter->base.st);
+	err = lstat(iter->base.path.buf, &iter->base.st);
 
 	if (err < 0) {
 		saved_errno = errno;
diff --git a/dir-iterator.h b/dir-iterator.h
index e3b6ff2800..479e1ec784 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -54,24 +54,8 @@
  *   and ITER_ERROR is returned immediately. In both cases, a meaningful
  *   warning is emitted. Note: ENOENT errors are always ignored so that
  *   the API users may remove files during iteration.
- *
- * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks.
- *   i.e., linked directories' contents will be iterated over and
- *   iter->base.st will contain information on the referred files,
- *   not the symlinks themselves, which is the default behavior. Broken
- *   symlinks are ignored.
- *
- *   Note: setting DIR_ITERATOR_FOLLOW_SYMLINKS affects resolving the
- *   starting path as well (e.g., attempting to iterate starting at a
- *   symbolic link pointing to a directory without FOLLOW_SYMLINKS will
- *   result in an error).
- *
- * Warning: circular symlinks are also followed when
- * DIR_ITERATOR_FOLLOW_SYMLINKS is set. The iteration may end up with
- * an ELOOP if they happen and DIR_ITERATOR_PEDANTIC is set.
  */
 #define DIR_ITERATOR_PEDANTIC (1 << 0)
-#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
 
 struct dir_iterator {
 	/* The current path: */
@@ -88,9 +72,7 @@ struct dir_iterator {
 	const char *basename;
 
 	/*
-	 * The result of calling lstat() on path; or stat(), if the
-	 * DIR_ITERATOR_FOLLOW_SYMLINKS flag was set at
-	 * dir_iterator's initialization.
+	 * The result of calling lstat() on path.
 	 */
 	struct stat st;
 };
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 659b6bfa81..6b297bd753 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -15,7 +15,7 @@ static const char *error_name(int error_number)
 
 /*
  * usage:
- * tool-test dir-iterator [--follow-symlinks] [--pedantic] directory_path
+ * tool-test dir-iterator [--pedantic] directory_path
  */
 int cmd__dir_iterator(int argc, const char **argv)
 {
@@ -24,9 +24,7 @@ int cmd__dir_iterator(int argc, const char **argv)
 	int iter_status;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
-		if (strcmp(*argv, "--follow-symlinks") == 0)
-			flags |= DIR_ITERATOR_FOLLOW_SYMLINKS;
-		else if (strcmp(*argv, "--pedantic") == 0)
+		if (strcmp(*argv, "--pedantic") == 0)
 			flags |= DIR_ITERATOR_PEDANTIC;
 		else
 			die("invalid option '%s'", *argv);
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 04b811622b..4ed3136b00 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -131,44 +131,10 @@ test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default
 	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
 '
 
-test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
-	cat >expected-follow-sorted-output <<-EOF &&
-	[d] (a) [a] ./dir4/a
-	[d] (a/f) [f] ./dir4/a/f
-	[d] (a/f/c) [c] ./dir4/a/f/c
-	[d] (b) [b] ./dir4/b
-	[d] (b/c) [c] ./dir4/b/c
-	[f] (a/d) [d] ./dir4/a/d
-	[f] (a/e) [e] ./dir4/a/e
-	EOF
-
-	test-tool dir-iterator --follow-symlinks ./dir4 >out &&
-	sort out >actual-follow-sorted-output &&
-
-	test_cmp expected-follow-sorted-output actual-follow-sorted-output
-'
-
 test_expect_success SYMLINKS 'dir-iterator does not resolve top-level symlinks' '
 	test_must_fail test-tool dir-iterator ./dir6 >out &&
 
 	grep "ENOTDIR" out
 '
 
-test_expect_success SYMLINKS 'dir-iterator resolves top-level symlinks w/ follow flag' '
-	cat >expected-follow-sorted-output <<-EOF &&
-	[d] (a) [a] ./dir6/a
-	[d] (a/f) [f] ./dir6/a/f
-	[d] (a/f/c) [c] ./dir6/a/f/c
-	[d] (b) [b] ./dir6/b
-	[d] (b/c) [c] ./dir6/b/c
-	[f] (a/d) [d] ./dir6/a/d
-	[f] (a/e) [e] ./dir6/a/e
-	EOF
-
-	test-tool dir-iterator --follow-symlinks ./dir6 >out &&
-	sort out >actual-follow-sorted-output &&
-
-	test_cmp expected-follow-sorted-output actual-follow-sorted-output
-'
-
 test_done
-- 
2.38.0.16.g393fd4c6db
