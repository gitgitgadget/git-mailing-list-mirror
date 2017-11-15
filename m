Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C95202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756534AbdKOAbS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:18 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:32998 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756228AbdKOAbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:31:00 -0500
Received: by mail-it0-f67.google.com with SMTP id n134so13596997itg.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rJuO1bs8B9UU/4Pk4WHjtb4Uf8ChhytmO6zrX+9Ksek=;
        b=HT7AUPrOA61WpZMapeuSh36y7+CZq+lJpUdC1dDwMw+4PMSKvKwjkyBqDfoVGyk1t3
         6Y2UVsOt/cBzNhAj8RUW18fPWNuvFwof5sIHcFflqoy/UaVbZeoqUVIjwph5VrzBIFsS
         Ls+ew6LnwwQSIJ01g9R4FBVPKI+GA/Y2SF8YpjO7x6DeOI9dMhDcn1q0h5MTsKxZnw5z
         i/uRv9Af9T3p2iquE0btnbzsc1P3PNxupA8lpWMTUVxDciAV+pHlLFB0Qx6Hu5CmIilF
         KGBCsQEIe6g/YMydQG5QNh4ZVO55aIJ9yCDtI+P0WAkVvQ0xKgt2jNgVYNISwERSVvll
         4ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rJuO1bs8B9UU/4Pk4WHjtb4Uf8ChhytmO6zrX+9Ksek=;
        b=gXS3HH42qs+NYO8SqIHpfCGeO+6j695EgzY9zMGs/XtVZtPp6wXwDYQFM/zMCfFvx5
         zp9e7xus1hUQZswEcYxiembHHoFS//usKMFqx1lyH8CSaSm3mc2BXlN7xZrYTni2tpzI
         aYXZKD9WRKX8FM6C3EmBQIEZZMxk1y2/t2J8SwPdnE9zJ9EUgHdxkAShi4DAr7cMIjCi
         0FBlXHs5J9JFNMmECD+YXO0KxJswfSTGLgmE8aLJoTXT6iMjkfizSPzegp1i6k9OhtBt
         KDSJj/7oM2IMX3MhwfuaUOUFkykQ4oDhi6T8fnA9ZU5y4iw2IhUvdeIE9I13p5dXvclX
         fMsw==
X-Gm-Message-State: AJaThX7FFvqCkhqgv+kBrpLvuoYYLtDXnIRDY1m8DFYj5L/bQP7Xh3L0
        Ehs9PpSYUKkTmfPd2ULkb5/Jg+NMqJc=
X-Google-Smtp-Source: AGs4zMa1UBSd/lYS4aCPqSsYZ0tNLIARxsvxpggsDkN+/LPyXvIBjaPUascPq8bXLSLVfkx7dM0+XA==
X-Received: by 10.36.179.1 with SMTP id e1mr17765464itf.27.1510705859147;
        Tue, 14 Nov 2017 16:30:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id a17sm9234956ioe.55.2017.11.14.16.30.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:30:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 6/7] builtin/describe.c: factor out describe_commit
Date:   Tue, 14 Nov 2017 16:30:42 -0800
Message-Id: <20171115003043.24080-7-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171115003043.24080-1-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.15.0.128.gcadd42da22

