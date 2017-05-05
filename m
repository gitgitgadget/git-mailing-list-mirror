Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B13B207B3
	for <e@80x24.org>; Fri,  5 May 2017 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbdEESoE (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 14:44:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36334 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755278AbdEESoA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 14:44:00 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so2041176qka.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sbbkyS2qdUfcPA3ySd357jGNrGxDNn60daeXB1g+Kyg=;
        b=ncfTU29Ays7vO5EyLsabmoZIoHVH43vs3b/nZz/tRtfF17+fbegzdjirJxb9whlrFY
         vAhAZj4QV/cLIHXthT9T0EZSFOSQd3YzwgI+tUdKb6gEg6m+JPmh9/3YHgRZi450B1BS
         zF5bRg5d2Lm7AcqAkCFpZkgGhAemXkJsltVnK4DTKk7Mm1oEeZnGyRAjVusbopqdAXON
         5hlEzzfhmYxFry+quZdy4ZyKHn6wnkXvLipMp5B5DFzed+F1luD4IsY898xZ6tuHBokO
         H15VWDDjFn8ASQIvlbF/7JhQg025FnIObgtCVTsBoA2nXGZdWP3cWPnh1WHewfKEY5HL
         AEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sbbkyS2qdUfcPA3ySd357jGNrGxDNn60daeXB1g+Kyg=;
        b=kgdWbeC1Dnh/bnnusWWTNkanXFNKDZx0xjIhdhUadSEEOulk3yP7gHEiMz6QyVYDy9
         gaF1OYhy5Q+CiCjOkq/FwLEoP/D9dSgQ+SZts5Mj3oYaHapfCkBua62Jf8KfLj4jH7Q7
         hbLlECuLXctAYJ14JgUMBBqNu2nMOgIueSfTN339qvNN/mYVBI/dra1YB9f+RibZvPCX
         lnSP2l2iMqHNCWVgIEn24H8A/vx2SM+tgdoCWHUXFi0zbdactK8ItrPVg5/dy/T0KqMN
         o/wh6EjsascG0vF5FTh8jtc0DOsb+VMgPcBFEQM2tF9IP/oV0hzyR8Llbwu/kox+0lNf
         F5dQ==
X-Gm-Message-State: AODbwcDk9XMHHCqBZog1m3A6M50RN8P16YUUFV5wcTSWSxynsKqZ2IfM
        gW3FZ5WKrys3gg==
X-Received: by 10.55.200.218 with SMTP id t87mr15314390qkl.261.1494009839854;
        Fri, 05 May 2017 11:43:59 -0700 (PDT)
Received: from localhost.localdomain (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id p184sm3733369qkb.17.2017.05.05.11.43.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 11:43:58 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH 1/3] diff: export diffstat interface
Date:   Fri,  5 May 2017 15:43:38 -0300
Message-Id: <1494009820-2090-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the diffstat interface (namely, the diffstat_t struct and
diff_flush_stat) no longer be internal to diff.c and allow it to be used
by other parts of git.

This is helpful for code that may want to easily extract information
from files using the diff machinery, while flushing it differently from
how the show_* functions used by diff_flush() do it.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 diff.c | 17 +----------------
 diff.h | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9..7c073c2 100644
--- a/diff.c
+++ b/diff.c
@@ -1460,21 +1460,6 @@ static char *pprint_rename(const char *a, const char *b)
 	return strbuf_detach(&name, NULL);
 }
 
-struct diffstat_t {
-	int nr;
-	int alloc;
-	struct diffstat_file {
-		char *from_name;
-		char *name;
-		char *print_name;
-		unsigned is_unmerged:1;
-		unsigned is_binary:1;
-		unsigned is_renamed:1;
-		unsigned is_interesting:1;
-		uintmax_t added, deleted;
-	} **files;
-};
-
 static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 					  const char *name_a,
 					  const char *name_b)
@@ -4310,7 +4295,7 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 	run_diff(p, o);
 }
 
-static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
+void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
 			    struct diffstat_t *diffstat)
 {
 	if (diff_unmodified_pair(p))
diff --git a/diff.h b/diff.h
index 5be1ee7..4cdc72d 100644
--- a/diff.h
+++ b/diff.h
@@ -188,6 +188,21 @@ struct diff_options {
 	int diff_path_counter;
 };
 
+struct diffstat_t {
+	int nr;
+	int alloc;
+	struct diffstat_file {
+		char *from_name;
+		char *name;
+		char *print_name;
+		unsigned is_unmerged:1;
+		unsigned is_binary:1;
+		unsigned is_renamed:1;
+		unsigned is_interesting:1;
+		uintmax_t added, deleted;
+	} **files;
+};
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
@@ -206,7 +221,6 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix);
 
 const char *diff_line_prefix(struct diff_options *);
 
-
 extern const char mime_boundary_leader[];
 
 extern struct combine_diff_path *diff_tree_paths(
@@ -262,6 +276,9 @@ extern void diff_change(struct diff_options *,
 
 extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
+			    struct diffstat_t *diffstat);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
-- 
2.7.4 (Apple Git-66)

