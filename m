Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D925BC433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA12F20758
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lATfGy0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIBVFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBVFn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 17:05:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A7BC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 14:05:43 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r4so272341qkb.12
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=brCfPuFtQ/XwkleWUqPm5IZoAJBgpkGbyOrDQA73xzs=;
        b=lATfGy0PwChLRL0H+4jJfBHn4HHsI9aa28+kccWiS3cE6ybx5TV8RBvSfJxgHXhO8l
         CqjJhUpXKnSrxoQ+zxUI7pddL7Kdc6eIIjMbY5oo71GDv+Ez7x5ewFbgry6rR3RQ0j28
         xat1oZCB3NL8fPoAzVKTHtO6PqUYdFi9gB7sWPO4E28HnP5cu5qa0Z/jnXooi9xQKouJ
         v2XNLWs8iOrrisyhC0c4irq09jZ3d6/wWA4f8bOX81uJGa+UIwxu4nj8MPgCAS1LfnOf
         y2jRo1p5nGdu1/OjsKT/G0jnqE4/JhpeGKc1pqDNwHuglyfXBhUs1fgAhvHgKP+zH0yV
         sTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=brCfPuFtQ/XwkleWUqPm5IZoAJBgpkGbyOrDQA73xzs=;
        b=UPxf5WYhTpW9ga1kr5RwnQ5fDeXGpDGFUrnCOqeWPOo9LnVKNx1u+zd0i9Y79PqtZe
         D1te0UXac7YN8IRjFFSnT7EA+Y71FBdgkExOw52/iV68Pi2bZN3Himns1D7JeqDKaMq6
         jkSirt9X6oiWJdMFQbItbZurzHS4SFJ4Mrf89Xa6UgadGCyQ1hITi2sz/+o9YjYN+mQD
         1mdpVUN0izEX1CrQGqwhiRDtDy0WZULYO15Z1QYWLZJCwKuUUVo+3Pt2K9cB9djE7Ib2
         h0Kxn7IAfg5B0GGOpX2nKpQDaXEZczoErA8SCR+FARsl25RmB9e2iVp0dcR2MIz48ofy
         PTbw==
X-Gm-Message-State: AOAM532IVoteP/cM4hybiyknZlh9BblFuSHLZisuyCOsbO8T9jLN9qsq
        xLsB1NzG0oVpBAaJ4C6zpYGfKbHnl6HNVtC1kOYij7BkM3qUSvTnCji9yWHI+RJdjLgB0cffDRv
        1dn2CEZ3D0GFv/oE/bX4SBxnM+D/JF4OLA5UVuHjFMfxQgW4RL9dEfgPA8J551G9QQdOS7Xgm54
        fN
X-Google-Smtp-Source: ABdhPJzy6DkBpDU71AdJEdc65gthTsh8sLqQUM/3KNh08At4w1I5NLKoY2hjYnZTYa9tBGUvGBV33Q+/xQFREpb9SuPp
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:55ce:: with SMTP id
 bt14mr359274qvb.2.1599080742266; Wed, 02 Sep 2020 14:05:42 -0700 (PDT)
Date:   Wed,  2 Sep 2020 14:05:39 -0700
In-Reply-To: <xmqq7dtcaqob.fsf@gitster.c.googlers.com>
Message-Id: <20200902210539.1981453-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq7dtcaqob.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2] fetch: no FETCH_HEAD display if --no-write-fetch-head
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

887952b8c6 ("fetch: optionally allow disabling FETCH_HEAD update",
2020-08-18) introduced the ability to disable writing to FETCH_HEAD
during fetch, but did not suppress the "<source> -> FETCH_HEAD" message
when this ability is used. This message is misleading in this case,
because FETCH_HEAD is not written. Also, because "fetch" is used to
lazy-fetch missing objects in a partial clone, this significantly
clutters up the output in that case since the objects to be fetched are
potentially numerous.

Therefore, suppress this message when --no-write-fetch-head is passed
(but not when --dry-run is set).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on origin/jt/lazy-fetch.

Junio writes [1]:

> Test also --dry-run, but that perhaps needs to be done outside the
> context of partial-clone.  The above "lazy fetching should be silent
> and should not bother users with mention of FETCH_HEAD" is good test
> in the context of partial-clone, though.
>
> jc/no-update-fetch-head added its own test to t/t5510, and both the
> "output lacks FETCH_HEAD when --no-write-fetch-head is given" test
> and the "output still mentions FETCH_HEAD with --dry-run" test
> belong there.

Ah, thanks for catching that. Here's an updated version.

[1] https://lore.kernel.org/git/xmqq7dtcaqob.fsf@gitster.c.googlers.com/
---
 builtin/fetch.c          |  8 +++++++-
 t/t0410-partial-clone.sh |  7 +++++--
 t/t5510-fetch.sh         | 18 ++++++++++--------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 320ba9471d..c6c4689250 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1023,11 +1023,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else
+			} else if (write_fetch_head || dry_run) {
+				/*
+				 * Display fetches written to FETCH_HEAD (or
+				 * would be written to FETCH_HEAD, if --dry-run
+				 * is set).
+				 */
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
+			}
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index d681e90640..584a039b85 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -183,7 +183,7 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
 '
 
 test_expect_success 'fetching of missing objects' '
-	rm -rf repo &&
+	rm -rf repo err &&
 	test_create_repo server &&
 	test_commit -C server foo &&
 	git -C server repack -a -d --write-bitmap-index &&
@@ -194,7 +194,10 @@ test_expect_success 'fetching of missing objects' '
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "origin" &&
-	git -C repo cat-file -p "$HASH" &&
+	git -C repo cat-file -p "$HASH" 2>err &&
+
+	# Ensure that no spurious FETCH_HEAD messages are written
+	! grep FETCH_HEAD err &&
 
 	# Ensure that the .promisor file is written, and check that its
 	# associated packfile contains the object
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2a1abe91f0..759aec9305 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -543,16 +543,18 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 
 '
 
-test_expect_success 'fetch --dry-run does not touch FETCH_HEAD' '
-	rm -f .git/FETCH_HEAD &&
-	git fetch --dry-run . &&
-	! test -f .git/FETCH_HEAD
+test_expect_success 'fetch --dry-run does not touch FETCH_HEAD, but still prints what would be written' '
+	rm -f .git/FETCH_HEAD err &&
+	git fetch --dry-run . 2>err &&
+	! test -f .git/FETCH_HEAD &&
+	grep FETCH_HEAD err
 '
 
-test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD' '
-	rm -f .git/FETCH_HEAD &&
-	git fetch --no-write-fetch-head . &&
-	! test -f .git/FETCH_HEAD
+test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD, and does not print what would be written' '
+	rm -f .git/FETCH_HEAD err &&
+	git fetch --no-write-fetch-head . 2>err &&
+	! test -f .git/FETCH_HEAD &&
+	! grep FETCH_HEAD err
 '
 
 test_expect_success '--write-fetch-head gets defeated by --dry-run' '
-- 
2.28.0.402.g5ffc5be6b7-goog

