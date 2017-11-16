Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192DF201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933689AbdKPCBJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:01:09 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35376 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757173AbdKPCA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:00:57 -0500
Received: by mail-it0-f65.google.com with SMTP id u132so4138910ita.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 18:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0QDwq7y7n/KVGNxi8qht6NrV54KW7KREB55Bz8vkqfE=;
        b=bSn9/3Z/6+XRFLkv0ef4F7UOPQo7RSsKuQkg9aOl5o2E8rjHFyPZuiP2FlEipLokde
         lHlm0unBFI6a4IDpnEA7W9nVDFSM08cnqWG1OUs2a0u/CS2SdGgYYdy/qLOLdmSAmR8B
         JRw9cA2oZ8VR3OyzYToMDv6lB/DHtOG2HWCh4bgpOri9ectGTdvJDoE0bIN2pBwJRYnV
         hZlSF0KqGXENCTwYPOdTPMVP4/w1ft8J18heeOh5XMCqcnxnf0yUAaIMD7UNNlZG54eV
         0II39AGL/eoQSvbL4Gq9qG2rs4LJB6RDHDSBVEgsWoNGNBRJ6gqjRu9nPRhCM7uArUlM
         kWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0QDwq7y7n/KVGNxi8qht6NrV54KW7KREB55Bz8vkqfE=;
        b=SIWeTy053/fuPBJoktkUxWDe3XpzC2LQp8RiPsQldrUyWTKfYXWr7ZVY9n1nKmsP+T
         wZqpqcuvf7Onhexw8urC3WuEd39FQvgoI87M9A6JnpCVRtByPJGeZWXNFw8VEyFThwCa
         lUylfYfYNjzQygtXr1Txo+P4xM4lSIOWhxEv5lwiFWGWm7CdIsOxn71IPEYzYRmO7x7R
         ayxDwrhJyTmhBNMILmFtaRFc/d6hvNDF9bBE0Ye/SBIUn85R7IJOaV3USPknt8pHCx7u
         qqZEeJ5yGxsSGNt4wMoYX2ZXEeOoOXTeiEafBEKrGFBbEIdVdxO9WNcC5jbav5aoK1uT
         frxw==
X-Gm-Message-State: AJaThX6pFVe3376Oq5NqxSLx0OFIJTCH0dbexpSxNKjXyCkIndl19Li6
        2+CQaKwwEdVLl1hFGqiQcfaHHeLHvDg=
X-Google-Smtp-Source: AGs4zMaWgurd7q82rEuwqHQEAwB/SsmM8IBgI8uPxdmf6s3QcVnIGbG6S0ZFMN6jBoK3m3lxPdntPQ==
X-Received: by 10.36.148.19 with SMTP id j19mr572011ite.51.1510797656496;
        Wed, 15 Nov 2017 18:00:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:34c9:3de6:9af7:a340])
        by smtp.gmail.com with ESMTPSA id o1sm191403ite.2.2017.11.15.18.00.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 18:00:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 6/7] builtin/describe.c: factor out describe_commit
Date:   Wed, 15 Nov 2017 18:00:38 -0800
Message-Id: <20171116020039.17810-7-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171116020039.17810-1-sbeller@google.com>
References: <20171116020039.17810-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out describing commits into its own function `describe_commit`,
which will put any output to stdout into a strbuf, to be printed
afterwards.

As the next patch will teach Git to describe blobs using a commit and path,
this refactor will make it easy to reuse the code describing commits.

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
2.15.0.128.gcadd42da22

