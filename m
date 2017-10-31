Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C435B1FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbdJaAeM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45200 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbdJaAeI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:08 -0400
Received: by mail-io0-f194.google.com with SMTP id i38so31319522iod.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BouWvQsWQ/c6gOT9UMkyqByxGsvntLGACIlMfzkQmf0=;
        b=ZTw+svtDJwisUKzsMzhe5fq64kjX6MhCL0GimXW8sfw3DfS0G4tDRg45pNcE9P4smF
         fcGZHFORizN/bP1yCwVKSaVst1RMQdhazMRFRQ5HsmLb8AS7QWSqmxIz4nGC5IF/Z1Xl
         oV6kUu5QAQjjKwSENBluWDzvE/qOZ7ZgCsU30wS8SNXBm9oxLfz3mZvjIURrkmZGyKY0
         BZe/1WPryfUp/Uzfizn+3nZczdEYEthbDPTVAJIBNJPF3x2sHH08GECC7tcl1E572N+M
         7PMxQna2WGqhvxK+DklfTjjFj7PdSx8uF7ujtj4B4kGUGohaesDTWV4pIbVK8+ChoVY0
         sFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BouWvQsWQ/c6gOT9UMkyqByxGsvntLGACIlMfzkQmf0=;
        b=oTmF1jJcHBWdARKO978AkJLNOoP4TVmuDN5oM8GHB9FlvIoPfzkGAXa/ZkL5Yl80/p
         ykwTslB6vFTwRfLgCobLeBg9/MDemTBPehvROeZitAiz/GBwGYDNfrFepxh8snzUtVWp
         MpXZigmljM6s7Q97pn60w4cwqnZNr6CECyy8APAhBtLvJYIB7dLQE2fr8dYDpmd2b/nt
         wg13rztsDEyy206VKRZAwMKMihXz3xua1qnH/iYgRoMjQTZecXVJnnuFHDy/KzJpOvHz
         a2YPdG6l/5RPlH5F1bM2YKKeifuey7F38WGFnlFyClt9Crzs3ZjYM0keKYKoPXlmI0pD
         SsXA==
X-Gm-Message-State: AMCzsaVbqrgrO/2ERu5F4CbEoeswQ9o1i1KvnHnVCbHDu0ET5yxOsUXk
        Q1OduTAj3rSctJqa39n3JsBBKg==
X-Google-Smtp-Source: ABhQp+T/5RiYi9qzytokSP6vZ083ctGZ7VxwCW15GNkB2ekKQowHlVAYtNnAxRLZvTRxwuFYCFUErg==
X-Received: by 10.107.173.97 with SMTP id w94mr208656ioe.304.1509410047582;
        Mon, 30 Oct 2017 17:34:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id c13sm254425itd.32.2017.10.30.17.34.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:34:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 5/7] builtin/describe.c: factor out describe_commit
Date:   Mon, 30 Oct 2017 17:33:49 -0700
Message-Id: <20171031003351.22341-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171031003351.22341-1-sbeller@google.com>
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
2.15.0.rc2.443.gfcc3b81c0a

