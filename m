Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080391F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbdA1CDj (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:39 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36243 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdA1CDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:03:31 -0500
Received: by mail-pg0-f47.google.com with SMTP id 3so26926796pgj.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y9a1umQOty3tFsDLDbovNa487TJsCUziId5cvmTjNMo=;
        b=Pufq9L9lhy+yPaZRXpgqdCi3HB2A33HZcmeOVup6BFiTLb8zxkONomf+sPfVaZ8dI4
         cwUeIhRS6qs+kn5Rm3Dg0dUHjGKfos6sjzkI7RGBWRIR8nweiwOq+FNSzvjJJ/lRKvXU
         NBEMWuJ++zED0WoxZq556qBXGQj981K37IC1/dKICBEC1Nu19sNBkwbxFnRXkPsMjr99
         LUHhsRmd+/wgjiL2K+oFgBRVs71al289nChA/VbFzqdy2OFgMADkruT/OvX3t9rQRS8/
         /SdI7lUCNaVjehIABciSop85BEnpcSbRnZHO7n8L9YoOMGqZd5E0RPfpDlZTdRjifK4Q
         EsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y9a1umQOty3tFsDLDbovNa487TJsCUziId5cvmTjNMo=;
        b=MiSvPMm6reNwHFaZlbTd3qNudIj8Fsn9sSHfF88baZyAwjde5lfL63J08FIQKyGitC
         zfdglGsfrOhFtCDVnFXjRhKMdSnJ0xEzXMWR+vV0z5ntCRXeAPAp7mgutA4RcfTOog/X
         +1xHmxe3F6zaf3gciIIe4FW+7y7LmD4sLBCL37hXOBqop2Xu2YpWjbQeX+deOxNceRBH
         5DWb8RnMmK1NHTAXP1c8+ajqwS9WEAkw/RL6hhZ34NxH+pFLypJRKlPmjiB2sT51UXrz
         qSRAelQJXEXJPovC/bsdBlxE0N5dcx4t0wUWUHk/ASI6Vw8iF0LmNJty3HnIbju0PQlr
         Unrw==
X-Gm-Message-State: AIkVDXKmaDaQvyRa2lqSQihhESfbII9b759d8HM/DvXa1gL0YsJS7aRfUyU5pDJTZTDY6dN7
X-Received: by 10.84.162.204 with SMTP id o12mr16584737plg.132.1485568985670;
        Fri, 27 Jan 2017 18:03:05 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:03:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 24/27] attr: tighten const correctness with git_attr and match_attr
Date:   Fri, 27 Jan 2017 18:02:04 -0800
Message-Id: <20170128020207.179015-25-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c               | 12 ++++++------
 attr.h               |  2 +-
 builtin/check-attr.c |  3 ++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/attr.c b/attr.c
index 8f4402ef3..69643ae77 100644
--- a/attr.c
+++ b/attr.c
@@ -220,7 +220,7 @@ static void report_invalid_attr(const char *name, size_t len,
  * dictionary.  If no entry is found, create a new attribute and store it in
  * the dictionary.
  */
-static struct git_attr *git_attr_internal(const char *name, int namelen)
+static const struct git_attr *git_attr_internal(const char *name, int namelen)
 {
 	struct git_attr *a;
 
@@ -244,14 +244,14 @@ static struct git_attr *git_attr_internal(const char *name, int namelen)
 	return a;
 }
 
-struct git_attr *git_attr(const char *name)
+const struct git_attr *git_attr(const char *name)
 {
 	return git_attr_internal(name, strlen(name));
 }
 
 /* What does a matched pattern decide? */
 struct attr_state {
-	struct git_attr *attr;
+	const struct git_attr *attr;
 	const char *setto;
 };
 
@@ -278,7 +278,7 @@ struct pattern {
 struct match_attr {
 	union {
 		struct pattern pat;
-		struct git_attr *attr;
+		const struct git_attr *attr;
 	} u;
 	char is_macro;
 	unsigned num_attr;
@@ -898,7 +898,7 @@ static int fill_one(const char *what, struct all_attrs_item *all_attrs,
 	int i;
 
 	for (i = a->num_attr - 1; rem > 0 && i >= 0; i--) {
-		struct git_attr *attr = a->state[i].attr;
+		const struct git_attr *attr = a->state[i].attr;
 		const char **n = &(all_attrs[attr->attr_nr].value);
 		const char *v = a->state[i].setto;
 
@@ -922,7 +922,7 @@ static int fill(const char *path, int pathlen, int basename_offset,
 	const char *base = stk->origin ? stk->origin : "";
 
 	for (i = stk->num_matches - 1; 0 < rem && 0 <= i; i--) {
-		struct match_attr *a = stk->attrs[i];
+		const struct match_attr *a = stk->attrs[i];
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen, basename_offset,
diff --git a/attr.h b/attr.h
index 5aaf55c3e..abebbc19c 100644
--- a/attr.h
+++ b/attr.h
@@ -11,7 +11,7 @@ struct all_attrs_item;
  * Given a string, return the gitattribute object that
  * corresponds to it.
  */
-struct git_attr *git_attr(const char *);
+const struct git_attr *git_attr(const char *);
 
 /* Internal use */
 extern const char git_attr__true[];
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 40cdff13e..4d01ca0c8 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -166,7 +166,8 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	check = attr_check_alloc();
 	if (!all_attrs) {
 		for (i = 0; i < cnt; i++) {
-			struct git_attr *a = git_attr(argv[i]);
+			const struct git_attr *a = git_attr(argv[i]);
+
 			if (!a)
 				return error("%s: not a valid attribute name",
 					     argv[i]);
-- 
2.11.0.483.g087da7b7c-goog

