Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FCA1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeB1TIS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:08:18 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52418 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbeB1TIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:08:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id t3so7076492wmc.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trRgM/76Ggfh1+l05d7I/hlGT1Ko8oZRptCskbqUlU0=;
        b=qwr3qvyuZlLuep9jtnqFTZEoOsVY+EniW84jwFOvkx99uWPprqmwAzSBBq20j7D0xB
         4IpGVILOan7IOcZQNB+8IXJwxgqd37zRpBOZzY2G1/58sY3pdhLUMBy0NDGLc44KzswP
         aHNFVLNJlmsCAHmt5K0X3jJfQW8vfmYJFBg5fX465NxEMv0+IaW13S+yWzrcQDGeCA0z
         rzGWxj2oLYmFVFIKpGQt4crJew8/cR2esgtkxAyabHUHl3RVn+n7+XKwLHLs9APlM9Gk
         VsljOETbGE5KlNSNfVbEt6EeEZWvdLGLJGdEfYEWLCTR2aiSub46+9r4zijIV9hdAu0s
         Mm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trRgM/76Ggfh1+l05d7I/hlGT1Ko8oZRptCskbqUlU0=;
        b=gVeXzQedOz/+oe8JGFRsarE7Yy1GRoVXRAMkyOYANCWxwwp7+ig/0mfGIR8ZOBCjhz
         Co7Ugchf4OStq7IthFqxLqJcKsExoAlS9CJXch4gG0ddGouMM1v92iyzz5/3cyMLi6KY
         SAwJM5OaryYm5g9/HZ9noRsJF5OqOzflod/38CQwFIat3QW5E/Yx9WQbS8Dus7uVWbGd
         QCxBSa2IM3eC16oDWYF0hxJPcfB2Ybt7GlXQLipZCJ/+t5Z2vAkeatAoR1rrYUUQmUT+
         PXZDRSkMRPjCNAAmFp46wRKV12q6FHUoobKZHhHPvaF/GnkqgA9FZ7xAzFPF8QaGB6t8
         JXxA==
X-Gm-Message-State: APf1xPBCgufeUKrstGhhjvMcJdU4/lKZ/oWWf1vYVtd6AAhbqbqHkyFE
        bvguHm7UEk9aCp40wLJbrlxhNKbj
X-Google-Smtp-Source: AG47ELtEkwjqyJuOuL5t4KFQ94wv8vvmx6lefA01IPUFe4aIImldRYDUmUgxPXg+aWl1hjBFyi5ogg==
X-Received: by 10.28.35.77 with SMTP id j74mr13831822wmj.96.1519844895892;
        Wed, 28 Feb 2018 11:08:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p76sm2832609wmb.19.2018.02.28.11.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 11:08:14 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/5] sequencer: make lockfiles non-static
Date:   Wed, 28 Feb 2018 20:07:54 +0100
Message-Id: <4572a84cfdcb1897b67c271a9d06ca38802a2352.1519843916.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519843916.git.martin.agren@gmail.com>
References: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com> <cover.1519843916.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05),
we can have lockfiles on the stack.

One of these functions fails to always roll back the lock. That will be
fixed in the next commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sequencer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4d3f60594c..90807c4559 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -290,7 +290,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 static int write_message(const void *buf, size_t len, const char *filename,
 			 int append_eol)
 {
-	static struct lock_file msg_file;
+	struct lock_file msg_file = LOCK_INIT;
 
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
 	if (msg_fd < 0)
@@ -436,7 +436,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	int clean;
 	char **xopt;
-	static struct lock_file index_lock;
+	struct lock_file index_lock = LOCK_INIT;
 
 	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
@@ -1183,7 +1183,7 @@ static int prepare_revs(struct replay_opts *opts)
 
 static int read_and_refresh_cache(struct replay_opts *opts)
 {
-	static struct lock_file index_lock;
+	struct lock_file index_lock = LOCK_INIT;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0) {
 		rollback_lock_file(&index_lock);
@@ -1577,7 +1577,7 @@ static int create_seq_dir(void)
 
 static int save_head(const char *head)
 {
-	static struct lock_file head_lock;
+	struct lock_file head_lock = LOCK_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
 	ssize_t written;
@@ -1702,7 +1702,7 @@ int sequencer_rollback(struct replay_opts *opts)
 
 static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 {
-	static struct lock_file todo_lock;
+	struct lock_file todo_lock = LOCK_INIT;
 	const char *todo_path = get_todo_path(opts);
 	int next = todo_list->current, offset, fd;
 
-- 
2.16.2.246.ga4ee44448f

