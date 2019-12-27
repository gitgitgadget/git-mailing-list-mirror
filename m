Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4800C2D0CE
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FED20CC7
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMwH3Gxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfL0NsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:48:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45706 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfL0Nrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so21498264qkl.12
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UZESWUx3KrA60v6RRKj6VDQttqoC/p28mvonLMIIhQ0=;
        b=LMwH3GxjQAsIms7UdCDnQ4D8sY7TInsX1tTM7wx2a7qdU38NbTNndMjbZ3CwtAAzkI
         zsdSjTKlZAz7HnW1N/yiAkDlsWJnf8QXFmQSouX/Fxg6T7BdYfCDaKYw/TcnHvg8Qfa2
         X+fDpjzuehXcQaFUzJtXL8ShkDzWrOV1i/z+x9VnVLYI9X+XslOHp4yT1cvx2XbPpksd
         3CO/RdC5Elxh+f9yLa63fLCx0xZNqZ2rl5G/2/bAt0L7WFP5laz4Ec0Blif5g4k+x87L
         HWDnog3iofBGoZJiIk8cQdZvtC5go/7SH6unAacZvD6C3GwLRN9pMkaPrNAjFaKfHOkj
         1Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZESWUx3KrA60v6RRKj6VDQttqoC/p28mvonLMIIhQ0=;
        b=T9Bcy4a2H/TAL4TelQDVuWifbXx5ndNy6q1vcP86d8ay1dawqw2k0V5RjXvP1WOPWk
         zbPyvyzsUw9XDm/M9Hv/ZFGRAkBRwcTJhLDndS06Zri39A/O7GszN63+b00FaidKhWoE
         ZsBv49CGRMU+/b5JQzFQEXm7SxiKfGNQoKcaOjcnASCIPRrz/z37/+5jM7bU6YXTXr8R
         kJUOnuam0IEoapCzqdNZ0/z1LhvE2I+Ttbxvi6EGqjW64cQFly6kWOr5Jl+x1NlaVYE9
         YIBXZmrIjdUSHjoQCOUdWgqUnDLP7Pk0ahYBD+itf60ZfJf7g33DK8KJIMisEKcc4Lo1
         2gjA==
X-Gm-Message-State: APjAAAWZKjJQfox3HnrzPtrVgidgKUGJ6m2bIBMrDa/nKcioR4W+4Ald
        Zhob1p/xbR1vusGd9K9hnDiU0ZqL
X-Google-Smtp-Source: APXvYqwj6De2MGS8SQXeFY381vAi+ASr0u5sFU5QHePJem6UAUDdwhQ/g8JCRvajE3236UIgHjWOZw==
X-Received: by 2002:a37:4f8e:: with SMTP id d136mr43080728qkb.495.1577454462595;
        Fri, 27 Dec 2019 05:47:42 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:42 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 08/16] t3310: extract common no_notes_merge_left()
Date:   Fri, 27 Dec 2019 08:47:17 -0500
Message-Id: <68eb05e10edf1f4b09bc4e02587ac5b15fd2c6e3.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had many statements which were duplicated. Extract and replace these
duplicate statements with no_notes_merge_left().

While we're at it, replace the test_might_fail(), which should only be
used on git commands, with a compound command that always returns 0,
even if the underlying ls fails.

Also, remove the redirection from stderr to /dev/null. This is because
the test scripts automatically suppress output already. Otherwise, if a
developer asks for verbose output via the `-v` flag, the stderr output
may be useful for debugging.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 2dea846e25..1950764694 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -32,6 +32,11 @@ verify_notes () {
 	test_cmp "expect_log_$notes_ref" "output_log_$notes_ref"
 }
 
+no_notes_merge_left () {
+	{ ls .git/NOTES_MERGE_* >output || :; } &&
+	test_must_be_empty output
+}
+
 cat <<EOF | sort >expect_notes_x
 6e8e3febca3c2bb896704335cc4d0c34cb2f8715 $commit_sha4
 e5388c10860456ee60673025345fe2e153eb8cf8 $commit_sha3
@@ -335,9 +340,7 @@ EOF
 y and z notes on 4th commit
 EOF
 	git notes merge --commit &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	no_notes_merge_left &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
 	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
@@ -397,9 +400,7 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 
 test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	no_notes_merge_left &&
 	# m has not moved (still == y)
 	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
@@ -464,9 +465,7 @@ EOF
 	echo "new note on 5th commit" > .git/NOTES_MERGE_WORKTREE/$commit_sha5 &&
 	# Finalize merge
 	git notes merge --commit &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	no_notes_merge_left &&
 	# Merge commit has pre-merge y and pre-merge z as parents
 	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
 	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
@@ -553,9 +552,7 @@ EOF
 
 test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
-	# No .git/NOTES_MERGE_* files left
-	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
-	test_must_be_empty output &&
+	no_notes_merge_left &&
 	# m has not moved (still == w)
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
-- 
2.24.1.810.g65a2f617f4

