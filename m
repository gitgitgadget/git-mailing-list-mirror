Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B013201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdEPEA4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:00:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35778 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEPEAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:00:55 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so20739560qke.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ix8NM6WC7WkdDqGlUYdIi99hxbybt06N+WYY9WJElrE=;
        b=BLKce0tduu/YSfqHwnJ4GNdGtRVexTKWq1jPX7jO9m8vktTIMUhPv1UhEThub30Eym
         iY7G8V6g+ZbCk+piTDlBq9xuXuvy46fwq1BzTJ32ZAs7pF6hXBGaKJm+Vd0TlOybLE82
         TRNxPKtjAwT0tdgNVV5Y7OI4laV8ywn/ZsMdMWRRaQ5ZQDnDTvtw4gaz93yqxCfgs5km
         3Q4ZdYPpf9Y/V+sTX+Hdp+189pQ9C2DfKLEa1OvSt4d7aOcHnmI3yLY4p4aC+1hZzHV1
         +1RRAVOnTaAVKrLa4Uc+OoqP7PJwmr3lV8mh8yzEQ7Q0D9xazlnZGpuDClZz2DE3iZ3H
         HgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ix8NM6WC7WkdDqGlUYdIi99hxbybt06N+WYY9WJElrE=;
        b=cXP32I+AeYo3XomXIs1XsiPcYau7lRjYH+RDycqZGRIga/zdMqqPoTY9u8+vkcoNum
         geifxLikwLYNdk39JhQMUahR+liOecVFrFX2D39LQMjj2M+V0x7T0Fky34sc6LGAN7IQ
         BN0LyqElohKXSby+/iNWjoSNCFwBICgAoYmRn8i4rsfTyF1N08MYMZzce/JcsxCsikWv
         d6bVPVx37cl+MQtG2Iz7VYYSgpyZBDyoIs3GySYQtayAiIXb8XP5fT49Zpzod4Q6JtQC
         +1wRK98XGLxFw50OWhCp1vb1FMMXhVMqdV86LL+KnO1D3TpNyqbSpaGnLDXN2Fuj9Wqg
         jyeg==
X-Gm-Message-State: AODbwcA0uZrlyhfNUpC5f1g17p28U8w9PTN0XzF8AQcwuMAX0EntVw6S
        co29YZIBl1oOqg==
X-Received: by 10.55.100.200 with SMTP id y191mr8265909qkb.87.1494907254908;
        Mon, 15 May 2017 21:00:54 -0700 (PDT)
Received: from localhost.localdomain ([189.62.40.36])
        by smtp.gmail.com with ESMTPSA id h14sm10068049qta.18.2017.05.15.21.00.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:00:53 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        jrnieder@gmail.com, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v2 1/4] diff: export diffstat interface
Date:   Tue, 16 May 2017 01:00:31 -0300
Message-Id: <1494907234-28903-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
References: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the diffstat interface (namely, the diffstat_t struct and
diff_flush_stat) no longer be internal to diff.c and allow it to be used
by other parts of git.

This is helpful for code that may want to easily extract information
from files using the diff machinery, while flushing it differently from
how the show_* functions used by diff_flush() do it. One example is the
builtin implementation of git-add--interactive's status.

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

