Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25431C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9489207FF
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjCxVfH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgAGExi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:38 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44266 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgAGExg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:36 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so41589691qkb.11
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZRvR2Y+JQoX3lzFkTjwKScWJiTweTmkNbDFZYlPaFI=;
        b=FjCxVfH8DrcoZJa521d3nhrdkJj41HODQaXKKsfIULV6JarzxJv+1Ch5xA4xIZP9x0
         mH9mMjwF/0+zSOV0YCIeNkN2wFA4Fb0VJtD5hWO14x/EuYVeVPZHaGF7t69RnKbjnnhq
         CzYzVfLWKU2VRHKoUocBJT8hp/jd3Fm63KgvHUDXkAL2p6xXkdHspSHqNciJ4P9vNJhZ
         yJA++IYLLAaaDVZk4YPnUO1wD7UIMHSWDXC/XWjYp2pkdGyxmkqLz4JHbzxMiuahQpYV
         T4UZmU/9eAdZOzJxBBJHDC4B6gvpv9KJzT1hlU9+SkkaPtQ+OrPt9pdxDY6lVtKhoj2p
         eGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZRvR2Y+JQoX3lzFkTjwKScWJiTweTmkNbDFZYlPaFI=;
        b=WphnOqO5BiVPQK5F12sxGGmuHLeS/3Suanff0NTAw37RZQyhWHMhTiZWie6kVO/+nF
         ob3yABuSKjHa6+mWa5HHLgF18391vuSPlYxt3MapxVn2JM9J7+4aV0BFrMnVc71CiUOV
         Tt0YsQeqTZSx+cRMfxclpCGCqjVk10dw03wiqzeku4sXCunQ76AbnwoDAgulUb1lbHDE
         F4dBrclCnP2Qkb8k2OMTR23P+EsKCLwPwSorJYRh4ijudDZb5Av8xtM0BURz4cm3U50W
         KwIJdquAKi1QPNAnQD4+M66j+uD5qQCsVgpRGRss9w4PA+6b6qbqixf1rjYBvQoUyGkS
         A1ow==
X-Gm-Message-State: APjAAAUarkEPpeie8jTPzgQlevNi7COFf/VL8EJfmYI1U2YRJMtTrsjR
        IcbDgbRIv1VZOBoR3TqEQDeL5KkX
X-Google-Smtp-Source: APXvYqynTGoT3xs16gaMYTjeaHDom7bej6woiBV5WdWq+LBaqrzgweg7ACnW0I+7dsnXyQREFdUN5g==
X-Received: by 2002:a05:620a:20c7:: with SMTP id f7mr86513904qka.440.1578372815095;
        Mon, 06 Jan 2020 20:53:35 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:34 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/16] t3310: extract common notes_merge_files_gone()
Date:   Mon,  6 Jan 2020 23:53:06 -0500
Message-Id: <46fe82b856d217265b01bf2bcf1ff78fa9474fc3.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have many statements which are duplicated. Extract and replace these
duplicate statements with notes_merge_files_gone().

While we're at it, replace the test_might_fail(), which should only be
used on git commands.

Also, remove the redirection from stderr to /dev/null. This is because
the test scripts automatically suppress output already. Otherwise, if a
developer asks for verbose output via the `-v` flag, the stderr output
may be useful for debugging.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 2dea846e25..d746f4ba55 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -32,6 +32,12 @@ verify_notes () {
 	test_cmp "expect_log_$notes_ref" "output_log_$notes_ref"
 }
 
+notes_merge_files_gone () {
+	# No .git/NOTES_MERGE_* files left
+	{ ls .git/NOTES_MERGE_* >output || :; } &&
+	test_must_be_empty output
+}
+
 cat <<EOF | sort >expect_notes_x
 6e8e3febca3c2bb896704335cc4d0c34cb2f8715 $commit_sha4
 e5388c10860456ee60673025345fe2e153eb8cf8 $commit_sha3
@@ -335,9 +341,7 @@ EOF
 y and z notes on 4th commit
 EOF
 	git notes merge --commit &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
 	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
@@ -397,9 +401,7 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 
 test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	notes_merge_files_gone &&
 	# m has not moved (still == y)
 	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
@@ -464,9 +466,7 @@ EOF
 	echo "new note on 5th commit" > .git/NOTES_MERGE_WORKTREE/$commit_sha5 &&
 	# Finalize merge
 	git notes merge --commit &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
 	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
@@ -553,9 +553,7 @@ EOF
 
 test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	notes_merge_files_gone &&
 	# m has not moved (still == w)
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
-- 
2.25.0.rc1.180.g49a268d3eb

