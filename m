Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583DF1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeB0Vap (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:30:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52545 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeB0Vao (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:30:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id t3so1269776wmc.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trRgM/76Ggfh1+l05d7I/hlGT1Ko8oZRptCskbqUlU0=;
        b=R+RY3cnQ5Lt56obpU88/HApcqWc+JEGUIM9xOQvNUPdWeFFzfpT1dXg++H2tHnTl7a
         BCYHrMQYPuNu9Pb41AE5ohe60s5NR6D6eNRGt50nTEDT9/yJ0F4bFBI/o1bm4TteuUyZ
         eQ/ZlYrE8fYHUhw9kBEdnYrSRoqqikEG8hLgu68MX8BMfKEKknvoVYpIoSiG0k5y5ntW
         +tvSwE6RG7lIeTQyEEkzmTJIqkk+0192vPhIbNpUeZytjZim6CV11IhnzaHmgdpU6wbv
         O+dYkBYzVV/D0SUlEye1ojSM//sn+KOyJABgh8j/lvn9nykK82qSC7JISuYHA3JleS5h
         9/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trRgM/76Ggfh1+l05d7I/hlGT1Ko8oZRptCskbqUlU0=;
        b=lZBNLGZdu/CVOrm/d9iRHtcdR1thZl2zjzBoIGTmwuq8L5NsqQkK/Y32Zsz0OSepUu
         JxKfZdJyKNZfdUa1+Knd1hBQC+cN8D9uqPZDQxpvGRPpKGbAT9bWNJBXB0GKWiaJ7Prr
         5ilG6NohydeDQnI6Ihze6XEIjCo4NOIrSoP+7VAYqCprCK9yck9D2801n1O1Xavhz5LB
         Yry6yOpeBQ2izt44voctWFAGwglYq/4w4cxpekjUsHq3icZ+E72n2fRgeZmJ1Hb+iW0N
         sdhTZvZGRng2NsdpG6vfgs3qQ6wN8M8yTd3X8ekxyl57mmH0p1AMMZuoD41MAQyXhs2/
         H+bw==
X-Gm-Message-State: APf1xPDTufZMwlO8dfHvI6bzn2ZZ1emhUwGvvvt4qsPJ2F8zeb7K+LAY
        +pU6umgy9lbBnHhKECVryLf8u6wO
X-Google-Smtp-Source: AG47ELvALV+sDoDzYqx+ETqrw042V5s6NDuinr9VLItoD3HEIkni6pcKHw0FVF+7vmrpmHURGQt0yg==
X-Received: by 10.28.196.200 with SMTP id u191mr12542780wmf.17.1519767042807;
        Tue, 27 Feb 2018 13:30:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t91sm126888wrc.21.2018.02.27.13.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 13:30:41 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/5] sequencer: make lockfiles non-static
Date:   Tue, 27 Feb 2018 22:30:09 +0100
Message-Id: <4572a84cfdcb1897b67c271a9d06ca38802a2352.1519763396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519763396.git.martin.agren@gmail.com>
References: <cover.1519763396.git.martin.agren@gmail.com>
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

