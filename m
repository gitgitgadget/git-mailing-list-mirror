Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ABCC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02552173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQaklJGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgA1VfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:35:13 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:57301 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgA1VfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 16:35:12 -0500
Received: by mail-pl1-f202.google.com with SMTP id 91so6268123plf.23
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 13:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1qDz9oAAMS3VGxPwmx1g5fXHL73euWg3+t8r/lkOtCU=;
        b=RQaklJGjRnGRUIUXffw9HLoZ9nDAB700m6IspX4L6zdFTOend/4z3tjspf70mJftK0
         CGX6a/fX75IdL5PJP5kfFKsPuye1LJiIhloUm4ATqccdslypjJvX85zh91AUoDqbAxFK
         18l9sZ36YFsA3kLpgwmZwpPOHxsHaIF1l1vndTFDWjYYPUMIh/g2Jod7MUaWPY31MWNN
         8BXz2Pz/+QRWW7mlzMhzeHPU9Pb1F0EKTkXtYHzMWgcUJo9J2zGYNpB1qrkYd5DaowtK
         fJaS4RpIun7nIVOqOw0k7VeoFtMtsHLcvdYaOzqZboPVc6Ysvy0z3IRu8GIH2cKTyhh7
         4r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1qDz9oAAMS3VGxPwmx1g5fXHL73euWg3+t8r/lkOtCU=;
        b=AAaMuxW4sKCiQMwkO8/yOQGKuNSbF9HtWxytTmRtorWtbTwCPlq5Bb4KCzHQLeJNpK
         d0okGES6AvW59Taph/8I+zTK4UdidIUwKjYus0Ra2Q1zwnVNdYPtDiBz3VyF3+qPWZKn
         7eKhH2pXHs7qm90ns0lRDES4VFViqf/2E+meOlyyhojmV9My5XVwRVLrypq7O+dLWF8y
         mr5LYH92MBEr8lmDaf62/lrpI0A4L/AFwOZ0LPIXlRtG1MwRJnIXvy3csoXYJ76EOtcf
         kdekNrmchftJ2uRzBVUPAn4u7IwKvg8Kuo3kyTeYHaej1MiYUtx61WjkRv8WOCi/CWLG
         jElA==
X-Gm-Message-State: APjAAAXjVB5QzoKOcBtC2eGQBNy+d/hZbjzfY3B326Loh1O/Tv9TDbk1
        JtuCI4BsFTxrg5i7AVz7xp7CAwwc4dK6L9aoUMpb/xSwAA+CPEL0n9FC5Y7EdUEYQ522iSwEkBU
        taX8ve+BQqJ4iwVJ8dfBbAK9uRpvH60jWOOfcSLmFJ2UbkX6ucoegE6ODSVNuN5H4ls/ecdfKN/
        9+
X-Google-Smtp-Source: APXvYqzlD++ARaJIeeYq1rsE+BWmBWhoZ0ZieQ4PNFslJsaP3CHxRF9Af4D4QD2BnChCeC3DBt0PJQQdK9QGFz4bko3m
X-Received: by 2002:a65:6794:: with SMTP id e20mr26852277pgr.152.1580247311562;
 Tue, 28 Jan 2020 13:35:11 -0800 (PST)
Date:   Tue, 28 Jan 2020 13:35:08 -0800
Message-Id: <20200128213508.31661-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [RFC PATCH] diff: only prefetch for certain output formats
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "git status" on a partial clone that was cloned with
"--no-checkout", like this:

  git clone --no-checkout --filter=blob:none <url> foo
  git -C foo status

results in an unnecessary lazy fetch. This is because of commit
7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08), which
optimized "diff" by prefetching, but inadvertently affected at least one
command ("status") that does not need prefetching. These 2 cases can be
distinguished by looking at output_format; the former uses
DIFF_FORMAT_PATCH and the latter uses DIFF_FORMAT_CALLBACK.

Therefore, restrict prefetching only to output_format values like the
one used by "diff".

(Note that other callers that use DIFF_FORMAT_CALLBACK will also lose
prefetching. I haven't investigated enough to see if this is a net
benefit or drawback, but I think this will need to be done on a
caller-by-caller basis and can be done in the future.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Points of discussion I can think of:

 - Is the whitelist of output_format constants the best?
 - Should we just have the callers pass a prefetch boolean arg instead
   of trying to guess it ourselves? I'm leaning towards no since I think
   we should avoid options unless they are necessary.

Perhaps there are others.
---
 diff.c                   | 10 +++++++++-
 t/t0410-partial-clone.sh | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 8e2914c031..8263491783 100644
--- a/diff.c
+++ b/diff.c
@@ -6504,7 +6504,15 @@ static void add_if_missing(struct repository *r,
 
 void diffcore_std(struct diff_options *options)
 {
-	if (options->repo == the_repository && has_promisor_remote()) {
+	int output_formats_to_prefetch = DIFF_FORMAT_RAW |
+		DIFF_FORMAT_DIFFSTAT |
+		DIFF_FORMAT_NUMSTAT |
+		DIFF_FORMAT_SUMMARY |
+		DIFF_FORMAT_PATCH |
+		DIFF_FORMAT_SHORTSTAT |
+		DIFF_FORMAT_DIRSTAT;
+	if ((options->output_format & output_formats_to_prefetch) &&
+	    options->repo == the_repository && has_promisor_remote()) {
 		/*
 		 * Prefetch the diff pairs that are about to be flushed.
 		 */
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a3988bd4b8..d72631a3a0 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -567,6 +567,19 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
 	git -C repo cherry-pick side1
 '
 
+test_expect_success 'do not fetch when running status against --no-checkout partial clone' '
+	rm -rf server client trace &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
+
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client status &&
+	! test_path_exists trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.25.0.341.g760bfbb309-goog

