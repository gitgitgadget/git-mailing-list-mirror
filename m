Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9880420281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdKEU0y (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:26:54 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:49566 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdKEU0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:26:53 -0500
Received: by mail-wr0-f193.google.com with SMTP id g90so6770721wrd.6
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pBOtVfCmiJe019sSJ43Rc067FzGZS6jwt9ofSkgnLI=;
        b=KsSuL/pMnwb3Vwh0oCp7oorQYYQ0UFuJoqN7Hz60HGjIA5rbPhgu6n9cC3sBEldUnS
         +X5Hn9aW9dGDGN55x8HQeitfaiLinqiTjAQDLHVkLKX0xHhq28up5fKUbBqHTSqR3ntp
         TDCiFLtnyE1GmEMifUdE3BumfKHNh9JJccnRZ5YSlQfLTV8OmQuOdLC582feL7Y+/9CH
         lRuLGQOH46A4kWdJSzyQjOFcXNbGPLEUSUfRBz5/WC/o3A0ZzuiypyNzrjfE/zGiqQw1
         xHql19BXHyrFL/S4UjPqK2E2C+gQUvr8KLahlUH3CMyHz5O/+sQMwvP+K8Y5C+effd6D
         Cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pBOtVfCmiJe019sSJ43Rc067FzGZS6jwt9ofSkgnLI=;
        b=ceAFiEW9od2ArkfbgecfoqApdY1jW4CE8UAiFPQ5xglAyk87+4ui5xxpqnYE4F8AEg
         JSJWSBtrziyGOzzDiykcEiiAQqiBULUSB9VVdS2nTNpfSgTvr7e3uqQ9WKwSGELw2JJT
         ASBOTiXlSL3vS2mzIbtx+IphVsyuWf+yYvrtL9watdY7/gd/kqKDQo6VYUZfRP0fzFpZ
         igCghWHMqDq7BQ77MdUrQcc3cozlIjswBx83zeLWJeXEfY5vKJdnqqnXO2aFL1nO9h2L
         A+IuT+c2iCuCY3Xhiyi5Dm05iIwc/h26seZGRyMeGTVIlT4psyMzlNii1R1lb3YD5olM
         kxWg==
X-Gm-Message-State: AMCzsaXhlaMfgLGAfH3LbFCi7XHVkmjU0F9On445nm3S4mAGEp98Jusd
        PECCnOT6c+KMvsiNjXZcw3Ff7VJO
X-Google-Smtp-Source: ABhQp+QWXKu+w2DUpPTxZtt1ReqXXfEOUFnXOYPX95Y9qlQIcu12iixQxci2XKfDYY4gf9dViIvmDQ==
X-Received: by 10.223.163.143 with SMTP id l15mr10483429wrb.65.1509913611940;
        Sun, 05 Nov 2017 12:26:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u138sm11573033wmd.17.2017.11.05.12.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:26:51 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] builtin/merge-base: UNLEAK commit lists
Date:   Sun,  5 Nov 2017 21:26:30 +0100
Message-Id: <b06f593d3f8b0ad53754eeb394f77e7c3ee916bd.1509908607.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509908607.git.martin.agren@gmail.com>
References: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com> <cover.1509908607.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several functions, we iterate through a commit list by assigning
`result = result->next`. As a consequence, we lose the original pointer
and eventually leak the list.

These are immediate helpers to `cmd_merge_base()` which is just about to
return, so we can use UNLEAK. For example, we could `UNLEAK(result)`
before we start iterating. That would be a one-liner change per
function. Instead, leave the lists alone and iterate using a dedicated
pointer. Then UNLEAK immediately before returning.

After this change, it is clearer that the leaks happen as we return, and
not as we process the list. That is, we could just as well have used
`free_commit_list()`. Also, leaving a "result" unchanged as we display
it feels (marginally) better.

In `handle_independent()` we can drop `result` while we're here and
reuse the `revs`-variable instead. That matches several other users of
`reduce_heads()`. The memory-leak that this hides will be addressed in
the next commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/merge-base.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6dbd167d3..fd0eba14b 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -9,20 +9,20 @@
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
-	struct commit_list *result;
+	struct commit_list *result, *r;
 
 	result = get_merge_bases_many_dirty(rev[0], rev_nr - 1, rev + 1);
 
 	if (!result)
 		return 1;
 
-	while (result) {
-		printf("%s\n", oid_to_hex(&result->item->object.oid));
+	for (r = result; r; r = r->next) {
+		printf("%s\n", oid_to_hex(&r->item->object.oid));
 		if (!show_all)
-			return 0;
-		result = result->next;
+			break;
 	}
 
+	UNLEAK(result);
 	return 0;
 }
 
@@ -51,28 +51,28 @@ static struct commit *get_commit_reference(const char *arg)
 
 static int handle_independent(int count, const char **args)
 {
-	struct commit_list *revs = NULL;
-	struct commit_list *result;
+	struct commit_list *revs = NULL, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = reduce_heads(revs);
-	if (!result)
+	revs = reduce_heads(revs);
+
+	if (!revs)
 		return 1;
 
-	while (result) {
-		printf("%s\n", oid_to_hex(&result->item->object.oid));
-		result = result->next;
-	}
+	for (rev = revs; rev; rev = rev->next)
+		printf("%s\n", oid_to_hex(&rev->item->object.oid));
+
+	UNLEAK(revs);
 	return 0;
 }
 
 static int handle_octopus(int count, const char **args, int show_all)
 {
 	struct commit_list *revs = NULL;
-	struct commit_list *result;
+	struct commit_list *result, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
@@ -83,13 +83,13 @@ static int handle_octopus(int count, const char **args, int show_all)
 	if (!result)
 		return 1;
 
-	while (result) {
-		printf("%s\n", oid_to_hex(&result->item->object.oid));
+	for (rev = result; rev; rev = rev->next) {
+		printf("%s\n", oid_to_hex(&rev->item->object.oid));
 		if (!show_all)
-			return 0;
-		result = result->next;
+			break;
 	}
 
+	UNLEAK(result);
 	return 0;
 }
 
-- 
2.15.0.415.gac1375d7e

