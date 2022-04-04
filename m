Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4943FC35294
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380427AbiDDVVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379930AbiDDSXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 14:23:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C4722B20
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 11:21:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so21720104ejc.7
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=siYdfnul2+oO9/moMw6wWgDFYCyVVn4Sru5bpbesVg4=;
        b=qcvJKZC4O7OXihDOLeJZKGpqklg9/4cVXfQwUO7DyD+ikUbjcvBev38zEOqRsIQbHn
         0vdQ0qK2g4HsTQDyz0sr+hxtGLU22Xz5JPtR9tc6rHmTpO85n2czIh8Sn0Yu9WqmF4Ny
         kx8mH1yVpXiK6AdkJ3FAm/uYDjgyPYngy+f6cqBNc1ZrccbBqEl8Fn7MwHShrNxSqJjx
         mOZD4c/jDgQQ4VcZArJOacCOiVRHJNl9jis45lowCHpXNwqz3GIv/69B9AYcN6a6xYQZ
         v7ZB552UfW8Zf34DBVuKlcsaRS54ilkq059TPqZsLXj212Eoi46YJpwNDk576Q6hLXSQ
         sd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=siYdfnul2+oO9/moMw6wWgDFYCyVVn4Sru5bpbesVg4=;
        b=mGd+mhkMONqUVDCh152vLoWlvYp8OOQWIsRJ1PJGWp+4W46d7L0UIuDOUKHuHqDO79
         v0pBo1jmCd3ASeLm3vDUkWl00IxEyjxbz8gBJ+8xYhHu0FQfQQ6k64/POTJKnnZa5QLe
         c5cFCoBuCpZPg9518BG8N8D9osqdS0JAvK9ayStNknV8Y5eN+TlC3O9QNEXmL5uazI00
         h+pYwMhj0hRe1ZVGl+cBFFrLZ0jCmk7xuF86FukLd/i+qumYd+i7Bne738MAUEvNcRhy
         rsVvc0fI69tn7FGLRrD0Q7kCRVcrqZ0nzatvX/jmWlVeYiozs16yMZJgfq9ardscoA/Q
         cR1g==
X-Gm-Message-State: AOAM530RhriQgF8RE33xw7dCM7lCrAdWudD/hGTxa8e+sSrFQ8q+qzW4
        81UuNEikxUvKNhtsHXU/XgM=
X-Google-Smtp-Source: ABdhPJzXrDU6jtmuW8OkVIh8Yx3Y8/ook7N9GIRnfySPzs4C+V0/gj+hXJLiNkJ9pbO5e+f+bIrP+w==
X-Received: by 2002:a17:907:2d2a:b0:6df:c027:a3ac with SMTP id gs42-20020a1709072d2a00b006dfc027a3acmr1308148ejc.179.1649096506987;
        Mon, 04 Apr 2022 11:21:46 -0700 (PDT)
Received: from linuxerio.localdomain (j109098.upc-j.chello.nl. [24.132.109.98])
        by smtp.gmail.com with ESMTPSA id rk14-20020a170907214e00b006e803954400sm294451ejb.203.2022.04.04.11.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:21:46 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] blame: report correct number of lines in progress when using ranges
Date:   Mon,  4 Apr 2022 20:21:28 +0200
Message-Id: <20220404182129.33992-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using ranges, use their sizes as the limit for progress
instead of the size of the full file.

Before:
$ git blame --progress builtin/blame.c > /dev/null
Blaming lines: 100% (1210/1210), done.
$ git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
Blaming lines:  10% (122/1210), done.
$

After:
$ ./git blame --progress builtin/blame.c > /dev/null
Blaming lines: 100% (1210/1210), done.
$ ./git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
Blaming lines: 100% (122/122), done.
$

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/blame.c  |  6 +++++-
 t/t8002-blame.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc..e33372c56b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
+	long num_lines = 0;
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
@@ -1129,7 +1130,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	for (range_i = ranges.nr; range_i > 0; --range_i) {
 		const struct range *r = &ranges.ranges[range_i - 1];
 		ent = blame_entry_prepend(ent, r->start, r->end, o);
+		num_lines += (r->end - r->start);
 	}
+	if (!num_lines)
+		num_lines = sb.num_lines;
 
 	o->suspects = ent;
 	prio_queue_put(&sb.commits, o->commit);
@@ -1158,7 +1162,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
 	if (show_progress)
-		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
+		pi.progress = start_delayed_progress(_("Blaming lines"), num_lines);
 
 	assign_blame(&sb, opt);
 
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index ee4fdd8f18..151a6fddfd 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -129,6 +129,34 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git blame --exclude-promisor-objects one
 '
 
+test_expect_success 'blame progress on a full file' '
+	cat >progress.txt <<-\EOF &&
+	a simple test file
+
+	no relevant content is expected here
+
+	If the file is too short, we cannot test ranges
+
+	EOF
+	git add progress.txt &&
+	git commit -m "add a file for testing progress" &&
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress progress.txt > /dev/null 2> full_progress.txt &&
+	grep "Blaming lines: 100% (6/6), done." full_progress.txt
+'
+
+test_expect_success 'blame progress on a single range' '
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress -L 2,5 progress.txt > /dev/null 2> range_progress.txt &&
+	grep "Blaming lines: 100% (4/4), done." range_progress.txt
+'
+
+test_expect_success 'blame progress on multiple ranges' '
+	GIT_PROGRESS_DELAY=0 \
+	git blame --progress -L 1,2 -L 4,6 progress.txt > /dev/null 2> range_progress.txt &&
+	grep "Blaming lines: 100% (5/5), done." range_progress.txt
+'
+
 test_expect_success 'blame with uncommitted edits in partial clone does not crash' '
 	git init server &&
 	echo foo >server/file.txt &&
-- 
2.35.1

