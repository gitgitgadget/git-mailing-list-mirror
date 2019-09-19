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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0A91F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404848AbfISVr3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36184 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404802AbfISVr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so61527wmc.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4an/fOqvfRRTzQ7r8M1pt9Zpcj++q5ANNBMS/TSRgA=;
        b=UPGMe+01nsSzM6aOLWZd+6dt36jPwh8biEMuaKT/zmqkpfglf4DSwl2u4u9CMMQvEh
         jjmlXdULZd7VSnxRj9g973GnY3iQh+ZyMxIsPdP13OPHNOY09ER4EEKF+89AcLhZXuQF
         85uSg0lCHRdO6/OPblTD7tqWkmyXon7L9MkzO6fpEvHKVZV30+8qlx2QOaf+XCGROLAF
         3Ev47ORP4+ccnST/OPOnT3te9CLr8sxkX3Yo29fegEqOOSKKOBYJsOOJkWv2qfaemsOM
         HA6MFglR3TrAj5Z6jaOkysTum2rnpgfNSF3VQjSYb04rs9e3oVRCaGp9FXDtMSLjHkQa
         iR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4an/fOqvfRRTzQ7r8M1pt9Zpcj++q5ANNBMS/TSRgA=;
        b=tzsU3bqsbWYwotM7ZxGgNSJZkxFG/EeP8WzG/4n3fzq1d20PWa7RZvqzROhKHukbnH
         1RzLneQPomGwA6CR7bYRxwzcCKemW+1fCRwEme9HNkkPlA3BpCu2sqf8UZIJrNLmsN5S
         262LjBOZ6r/8KSi0SqKwC96IxKuMVJyk4mnxB6ZidUwM6UzBJQmj0aPzf8D/N0ITMYek
         65ynLsvVWF97c2nMyz7scakXtvx2sxzPhUzb22b/pfwxYkwNP6jYHP2zdswT5JHEpNIN
         NpTUaA9ODX9mIbiU4KfNmmessEv3fMyfIguQYzHLdQeiUIYtgm7KEDzC90NpwZodR3Yg
         MsHQ==
X-Gm-Message-State: APjAAAX5Q6Elh6YcpjnnCuP8Vo+6xJtbMOZufy6aFjrTf97qQdA4AE8u
        T/X20WJcMqldWS8e2TO/Rrg=
X-Google-Smtp-Source: APXvYqwjmyHrY9gdo07Xpy5vdtOYbdCUUXgcQRFoHPbSdhVf4d01gNMwNTui20I6D3mbsZ7fRrzEPg==
X-Received: by 2002:a05:600c:54a:: with SMTP id k10mr17178wmc.127.1568929647803;
        Thu, 19 Sep 2019 14:47:27 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/15] name-rev: pull out deref handling from the recursion
Date:   Thu, 19 Sep 2019 23:47:03 +0200
Message-Id: <20190919214712.7348-9-szeder.dev@gmail.com>
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

The 'if (deref) { ... }' condition near the beginning of the recursive
name_rev() function can only ever be true in the first invocation,
because the 'deref' parameter is always 0 in the subsequent recursive
invocations.

Extract this condition from the recursion into name_rev()'s caller and
drop the function's 'deref' parameter.  This makes eliminating the
recursion a bit easier to follow, and it will be moved back into
name_rev() after the recursion is elminated.

Furthermore, drop the condition that die()s when both 'deref' and
'generation' are non-null (which should have been a BUG() to begin
with).

Note that this change reintroduces the memory leak that was plugged in
in commit 5308224633 (name-rev: avoid leaking memory in the `deref`
case, 2017-05-04), but a later patch in this series will plug it in
again.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index cb8ac2fa64..42cea5c881 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -102,30 +102,19 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int generation, int distance, int from_tag,
-		int deref)
+		int generation, int distance, int from_tag)
 {
 	struct commit_list *parents;
 	int parent_number = 1;
-	char *to_free = NULL;
 
 	parse_commit(commit);
 
 	if (commit->date < cutoff)
 		return;
 
-	if (deref) {
-		tip_name = to_free = xstrfmt("%s^0", tip_name);
-
-		if (generation)
-			die("generation: %d, but deref?", generation);
-	}
-
 	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
-				   distance, from_tag)) {
-		free(to_free);
+				   distance, from_tag))
 		return;
-	}
 
 	for (parents = commit->parents;
 			parents;
@@ -144,11 +133,11 @@ static void name_rev(struct commit *commit,
 
 			name_rev(parents->item, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag, 0);
+				 from_tag);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
 				 generation + 1, distance + 1,
-				 from_tag, 0);
+				 from_tag);
 		}
 	}
 }
@@ -280,12 +269,16 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
+		const char *tip_name;
 
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref);
+		if (deref)
+			tip_name = xstrfmt("%s^0", path);
+		else
+			tip_name = xstrdup(path);
+		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
 	}
 	return 0;
 }
-- 
2.23.0.331.g4e51dcdf11

