Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFBCF20281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964817AbdKBTmJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:42:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:55558 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934378AbdKBTmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:42:06 -0400
Received: by mail-io0-f195.google.com with SMTP id p186so1435436ioe.12
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/SEzNkuC/nYYk9t7RRhK86AcyRxbngPzy4XnnS+wjSY=;
        b=sgj+6qeQFw2fx3AMGgozZZHe9grE1oLZTzeqmhcQz9Dc24aTz1vMCc8BS+WhfPO7Dt
         o2Tyk0ueG1GbroJBZ3wyRNKlk9ghSOUywLKMCrEXFR84jXicjcAs5mOTBnW8Oqb7WfLr
         wNAw4yO7jVMOndtaGAKiDwjVYkkk0QB6pr1XSQ/mSEXXQuZW9kr9OijHcI8GmO2PovBX
         9L2rL9vYkwh7hH8ISdP7UHUOK5EmLqNtK+Wy2SPO7NTfL6NO/UUp91Wo2PwDpugkyxA1
         K7/ATlZLZwFfWDe4Gm0Fir+VX1TWud0odtnHd3xUAA8YjqLUym0ZxHQcMnUCNHswOs+x
         8xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/SEzNkuC/nYYk9t7RRhK86AcyRxbngPzy4XnnS+wjSY=;
        b=W3YYdEQXcpkoY4xiVy8bfquOiE00QBy9nv+Ee1dbn+VilewJI7j6BPl8Ha9sBDIwhg
         vpNULpFFEmcJKudX+erzO6tltpti6yFKxmLEp0G7rKU3It8jWD2mhR7EujSArNrRQDrI
         GF7Im3cjxTAixpNiY2BohRb7R6rrjUy+CTgD1bpRZ3U8DUrKgsftlb/JuYe5dt6765CH
         q1vjhM5a56DsJDyj50RHcHNZfzJxD/6w1Z35yV/OVWpd+Tq9SYt/edBqejCO+c7zwzJX
         S77xX8pfGAQO9jccP1AsEqrXBJAH8zNzQjvZ0DTOPHwVd4nyipZpEzTbcNEppII+W0Ak
         c92g==
X-Gm-Message-State: AMCzsaXDUcV/WtLhdhvvgMG9TUagEGjUXWFi5oqo0AcfVHTsTXxqF0+J
        mPhNpx+GoYSJxFFqQp45NJcVtA==
X-Google-Smtp-Source: ABhQp+R19yzHzcpDgGdmqtphhPjUYs9oc0kNqY7byDLPrLNEXwuxwyLB9NoW3KOtsNkKZOQmwiNnGQ==
X-Received: by 10.36.81.21 with SMTP id s21mr4329760ita.144.1509651725050;
        Thu, 02 Nov 2017 12:42:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id r16sm1877967ioi.61.2017.11.02.12.42.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 12:42:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: [PATCHv3 6/7] builtin/describe.c: factor out describe_commit
Date:   Thu,  2 Nov 2017 12:41:47 -0700
Message-Id: <20171102194148.2124-7-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171102194148.2124-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
 <20171102194148.2124-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch we'll learn how to describe more than just commits,
so factor out describing commits into its own function.  That will make
the next patches easy as we still need to describe a commit as part of
describing blobs.

While factoring out the functionality to describe_commit, make sure
that any output to stdout is put into a strbuf, which we can print
afterwards, using puts which also adds the line ending.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 63 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 3136efde31..9e9a5ed5d4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -256,7 +256,7 @@ static unsigned long finish_depth_computation(
 	return seen_commits;
 }
 
-static void display_name(struct commit_name *n)
+static void append_name(struct commit_name *n, struct strbuf *dst)
 {
 	if (n->prio == 2 && !n->tag) {
 		n->tag = lookup_tag(&n->oid);
@@ -272,19 +272,18 @@ static void display_name(struct commit_name *n)
 	}
 
 	if (n->tag)
-		printf("%s", n->tag->tag);
+		strbuf_addstr(dst, n->tag->tag);
 	else
-		printf("%s", n->path);
+		strbuf_addstr(dst, n->path);
 }
 
-static void show_suffix(int depth, const struct object_id *oid)
+static void append_suffix(int depth, const struct object_id *oid, struct strbuf *dst)
 {
-	printf("-%d-g%s", depth, find_unique_abbrev(oid->hash, abbrev));
+	strbuf_addf(dst, "-%d-g%s", depth, find_unique_abbrev(oid->hash, abbrev));
 }
 
-static void describe(const char *arg, int last_one)
+static void describe_commit(struct object_id *oid, struct strbuf *dst)
 {
-	struct object_id oid;
 	struct commit *cmit, *gave_up_on = NULL;
 	struct commit_list *list;
 	struct commit_name *n;
@@ -293,26 +292,18 @@ static void describe(const char *arg, int last_one)
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
-	if (debug)
-		fprintf(stderr, _("describe %s\n"), arg);
-
-	if (get_oid(arg, &oid))
-		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference(&oid);
-	if (!cmit)
-		die(_("%s is not a valid '%s' object"), arg, commit_type);
+	cmit = lookup_commit_reference(oid);
 
 	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
 		/*
 		 * Exact match to an existing ref.
 		 */
-		display_name(n);
+		append_name(n, dst);
 		if (longformat)
-			show_suffix(0, n->tag ? &n->tag->tagged->oid : &oid);
+			append_suffix(0, n->tag ? &n->tag->tagged->oid : oid, dst);
 		if (suffix)
-			printf("%s", suffix);
-		printf("\n");
+			strbuf_addstr(dst, suffix);
 		return;
 	}
 
@@ -386,10 +377,9 @@ static void describe(const char *arg, int last_one)
 	if (!match_cnt) {
 		struct object_id *cmit_oid = &cmit->object.oid;
 		if (always) {
-			printf("%s", find_unique_abbrev(cmit_oid->hash, abbrev));
+			strbuf_addstr(dst, find_unique_abbrev(cmit_oid->hash, abbrev));
 			if (suffix)
-				printf("%s", suffix);
-			printf("\n");
+				strbuf_addstr(dst, suffix);
 			return;
 		}
 		if (unannotated_cnt)
@@ -437,15 +427,36 @@ static void describe(const char *arg, int last_one)
 		}
 	}
 
-	display_name(all_matches[0].name);
+	append_name(all_matches[0].name, dst);
 	if (abbrev)
-		show_suffix(all_matches[0].depth, &cmit->object.oid);
+		append_suffix(all_matches[0].depth, &cmit->object.oid, dst);
 	if (suffix)
-		printf("%s", suffix);
-	printf("\n");
+		strbuf_addstr(dst, suffix);
+}
+
+static void describe(const char *arg, int last_one)
+{
+	struct object_id oid;
+	struct commit *cmit;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (debug)
+		fprintf(stderr, _("describe %s\n"), arg);
+
+	if (get_oid(arg, &oid))
+		die(_("Not a valid object name %s"), arg);
+	cmit = lookup_commit_reference(&oid);
+	if (!cmit)
+		die(_("%s is not a valid '%s' object"), arg, commit_type);
+
+	describe_commit(&oid, &sb);
+
+	puts(sb.buf);
 
 	if (!last_one)
 		clear_commit_marks(cmit, -1);
+
+	strbuf_release(&sb);
 }
 
 int cmd_describe(int argc, const char **argv, const char *prefix)
-- 
2.15.0.7.g980e40477f

