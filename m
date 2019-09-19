Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9221F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404912AbfISVre (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36184 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404903AbfISVrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so61556wmc.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBKmt+/GE5lImNpjz5zmeTcxqlo181MlBlo8ZRWo/Tg=;
        b=MdjoTYWq0hys9CZva6j6v2yGh1srsoKMi3pQNdPznUXJgGBYZWex/h4+vpUwzAqVNV
         eoO01bBINbBngSeoxa79817AQ9JqYfQlRpDu7bGLKx0Nmda1oLqFLynWR74rL3cgG5cW
         g12+ugjpP9XLbKjjTWq9hXTnMwBuDcQKP5mzMvCutI4Qgoe/6fAC1AvJNnOAjECNNi1l
         0ClJRVuNhy5aa4rwhXxTfw1mjiu0k5Y8+biD6ke/zsuYiKQggjMQiHemjRGpE1ss7QRn
         s8mTlaa6BQc4whWuLFzjhpDI1w8jC/gHAQ22ppGNomdZIIcvfUZeYvp9H50EdGeRI8lC
         5eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBKmt+/GE5lImNpjz5zmeTcxqlo181MlBlo8ZRWo/Tg=;
        b=Trgw8liYPC+/01rDmr7l3SePeCzXnE1KJVywBkoQ8uTSLt09Z3DcGoCYkY5aYTSJ9I
         2v9Csk3J+0eQsiwvnz7vw81a3GuF9xXsUa5D5YBr+O8Yuwk9fP17AONUya2ShcD/+Aqs
         KsC6b8MwO6gnAITn4CppzOcxBtYbofuGwYbgVlWYKF92n7PEN5Y5kIx86xUMuywte8aq
         dnIfqKX+ZbyOmYMsM/2dmxFL1upjL0SpmskxCwNB/+CrOR8V4067SUFoImNgVRwSpWQk
         erGCVRdycbN21s8Jtc/r3Nae91vU/zsXfwC8RE9zRRKyB8ST037gsHCvo/24BLYD5ifm
         BfNw==
X-Gm-Message-State: APjAAAX1QW/R7tW8Sa5EY4QoWVVpS50TdHRE/GoBwgl4b7mODmAd4Cco
        TZ2p3KZ1bFmBpbq8L/didSo=
X-Google-Smtp-Source: APXvYqzHkoHEPH6Wlcqr+26oqJHh4eKNXr8/10jHvaGLBZi6LZFsGyYl0G2K6lizG5bh3Z1eerfdEA==
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr15847wma.119.1568929648879;
        Thu, 19 Sep 2019 14:47:28 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:28 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/15] name-rev: restructure parsing commits and applying date cutoff
Date:   Thu, 19 Sep 2019 23:47:04 +0200
Message-Id: <20190919214712.7348-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the beginning of the recursive name_rev() function it parses the
commit it got as parameter, and returns early if the commit is older
than a cutoff limit.

Restructure this so the caller parses the commit and checks its date,
and doesn't invoke name_rev() if the commit to be passed as parameter
is older than the cutoff, i.e. both name_ref() before calling
name_rev() and name_rev() itself as it iterates over the parent
commits.

This makes eliminating the recursion a bit easier to follow, and it
will be moved back to name_rev() after the recursion is eliminated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 42cea5c881..99643aa4dc 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -107,11 +107,6 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 
-	parse_commit(commit);
-
-	if (commit->date < cutoff)
-		return;
-
 	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
 				   distance, from_tag))
 		return;
@@ -119,6 +114,12 @@ static void name_rev(struct commit *commit,
 	for (parents = commit->parents;
 			parents;
 			parents = parents->next, parent_number++) {
+		struct commit *parent = parents->item;
+
+		parse_commit(parent);
+		if (parent->date < cutoff)
+			continue;
+
 		if (parent_number > 1) {
 			size_t len;
 			char *new_name;
@@ -131,11 +132,11 @@ static void name_rev(struct commit *commit,
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
 
-			name_rev(parents->item, new_name, taggerdate, 0,
+			name_rev(parent, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
 				 from_tag);
 		} else {
-			name_rev(parents->item, tip_name, taggerdate,
+			name_rev(parent, tip_name, taggerdate,
 				 generation + 1, distance + 1,
 				 from_tag);
 		}
@@ -269,16 +270,18 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
-		const char *tip_name;
 
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		if (deref)
-			tip_name = xstrfmt("%s^0", path);
-		else
-			tip_name = xstrdup(path);
-		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+		if (commit->date >= cutoff) {
+			const char *tip_name;
+			if (deref)
+				tip_name = xstrfmt("%s^0", path);
+			else
+				tip_name = xstrdup(path);
+			name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+		}
 	}
 	return 0;
 }
-- 
2.23.0.331.g4e51dcdf11

