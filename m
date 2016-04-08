From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 14/18] Add --index-only support for ff_only merges
Date: Thu,  7 Apr 2016 23:58:42 -0700
Message-ID: <1460098726-5958-15-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@palantir.com>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOh-0002y6-MM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbcDHG7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:37 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33046 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbcDHG7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:14 -0400
Received: by mail-pa0-f67.google.com with SMTP id q6so8527244pav.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DCmCYe4joyX5QgvICVuK1oiL6/WrfrB03TjBqs/8fUI=;
        b=FjFIdAQlC1KHwl6aX0A0T39RBVGErNxFyi/I5VrCRtdsRNqdTu3+t0l8JHEs5Jss3r
         2vUWsdqV0kRZ0nfhzylfErkirrqAmMM1p4io+OnwwLGTZdHLVwm7Lz5lDl55TQ7nVc9v
         FPKXYvHgn5d0WmYPx9+gXUcim/ZWwS8PrOdD9vSRpwm89L/7UOV9QREIHlsTwrD4q9nC
         nkZTZ+8wrE/Dxred8eSuamPydQ/l7blFbAEBgTlNupIV4iAFL9qW4Tu1iQbSYwXWs5vg
         BzMq2F/eVowEVbXr5WyClnG8mcA3PVjsWj2zSXLWZ3cSRuW8KYSDd3wmQcDhf5xjXHcE
         KkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DCmCYe4joyX5QgvICVuK1oiL6/WrfrB03TjBqs/8fUI=;
        b=gApCi8KUEHZqjxy0xUitAIrEWNkPaQMDI/Pr/LlCBeqqRXJ6+/hCYXAg15qdBu3y4s
         asLg9l//iTxphTqYXa9lJ2oHXK4DErbtxhuhatGIubjksWm2qw7qYWoKFPcqJXQDAhu8
         uhNMPjWdfjmrlNCGqmzpbujvbvdDYgfguZQzBTl0K6d0qYbVLsiP/WDephg7RLzvSKQm
         VKX22hPYF6x7piEA1y6PkxTuxbvowDScYSmQIrfPgX3okfhbkAiry3LLgH2r23P+WxQq
         j2X9zSXeXy4DgVp9zDUwho9KhBesFaewmQbgBwt5qg/cJsRp2F+mmo7YPR625G1QCqes
         pzRg==
X-Gm-Message-State: AD7BkJLtwpY4c3+V9aoD2KJZefxMyQ84j9VbHJut1TBkFc1//PTBf4b+jcb1ZmbddKe/5g==
X-Received: by 10.66.248.163 with SMTP id yn3mr3990711pac.86.1460098753335;
        Thu, 07 Apr 2016 23:59:13 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291008>

From: Elijah Newren <newren@palantir.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c             | 1 +
 builtin/pull.c              | 4 ++--
 cache.h                     | 1 +
 merge.c                     | 4 +++-
 sequencer.c                 | 2 +-
 t/t6043-merge-index-only.sh | 6 +++---
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5f463ad..b791702 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1443,6 +1443,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (checkout_fast_forward(head_commit->object.oid.hash,
 					  commit->object.oid.hash,
+					  index_only,
 					  overwrite_ignore)) {
 			ret = 1;
 			goto done;
diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..4f33a89 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -569,7 +569,7 @@ static int pull_into_void(const unsigned char *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head, 0))
+	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head, 0, 0))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
@@ -871,7 +871,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"fast-forwarding your working tree from\n"
 			"commit %s."), sha1_to_hex(orig_head));
 
-		if (checkout_fast_forward(orig_head, curr_head, 0))
+		if (checkout_fast_forward(orig_head, curr_head, 0, 0))
 			die(_("Cannot fast-forward your working tree.\n"
 				"After making sure that you saved anything precious from\n"
 				"$ git diff %s\n"
diff --git a/cache.h b/cache.h
index b829410..d51fcbc 100644
--- a/cache.h
+++ b/cache.h
@@ -1785,6 +1785,7 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 		const char *head_arg, struct commit_list *remotes);
 int checkout_fast_forward(const unsigned char *from,
 			  const unsigned char *to,
+			  int index_only,
 			  int overwrite_ignore);
 
 
diff --git a/merge.c b/merge.c
index 5db7d56..a40307c 100644
--- a/merge.c
+++ b/merge.c
@@ -46,6 +46,7 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 
 int checkout_fast_forward(const unsigned char *head,
 			  const unsigned char *remote,
+			  int index_only,
 			  int overwrite_ignore)
 {
 	struct tree *trees[MAX_UNPACK_TREES];
@@ -72,7 +73,8 @@ int checkout_fast_forward(const unsigned char *head,
 	opts.head_idx = 1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	opts.update = 1;
+	opts.update = !index_only;
+	opts.index_only = index_only;
 	opts.verbose_update = 1;
 	opts.merge = 1;
 	opts.fn = twoway_merge;
diff --git a/sequencer.c b/sequencer.c
index e66f2fe..1b772fb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -222,7 +222,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
-	if (checkout_fast_forward(from, to, 1))
+	if (checkout_fast_forward(from, to, 0, 1))
 		exit(128); /* the callee should have complained already */
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index f79782c..cb860f2 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -224,7 +224,7 @@ test_expect_success 'setup simple merges' '
 	test_tick && git commit -m E
 '
 
-test_expect_failure '--index-only ff update, non-bare' '
+test_expect_success '--index-only ff update, non-bare' '
 	git reset --hard &&
 	git checkout A^0 &&
 
@@ -235,7 +235,7 @@ test_expect_failure '--index-only ff update, non-bare' '
 	test ! -d subdir
 '
 
-test_expect_failure '--index-only ff update, bare' '
+test_expect_success '--index-only ff update, bare' '
 	git clone --bare . bare.clone &&
 	(cd bare.clone &&
 
@@ -250,7 +250,7 @@ test_expect_failure '--index-only ff update, bare' '
 	)
 '
 
-test_expect_failure '--index-only ff update, non-bare with uncommitted changes' '
+test_expect_success '--index-only ff update, non-bare with uncommitted changes' '
 	git clean -fdx &&
 	git reset --hard &&
 	git checkout A^0 &&
-- 
2.8.0.18.gc685494
