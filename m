Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39331E95A96
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 10:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjJIKzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346076AbjJIKzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:55:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48B99
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 03:55:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so7267342a12.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696848941; x=1697453741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6TnQ1vaFjHTDr0P4PWPFgZC7Ma0ongoXkP+orTCGcI=;
        b=TH8Itg7QuCgRZVxoRMCzwlKOO2J8lJ+QFWiPBOYvbA4on+Ob/+oe6IFGGESsjQfQFJ
         nQSdr5cLKbO/sI17FRGFpGB6KayxBbXHd0X9N1TSbcBTP/qPSK1kG4jPVw6zS2CdeQNk
         RHhZBUkrQyiIpoEqQULbYTfe/5AeeXEj77NwiWfuZgTF9VVXM1s4UmAS62C6P4yAj/QG
         Weaxd/4XcvRerHapl6+MdvWxnG2T2Y4nQYIGR+66mUjJMrzR0pCv3NTfKGaXe10SnWsd
         gkY1BOGbk9qio7p+bqlMY1sX9RP8yOAV1oBQRXnQylld9x2O6GchQMCxnygLQI54tZ0w
         o1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696848941; x=1697453741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6TnQ1vaFjHTDr0P4PWPFgZC7Ma0ongoXkP+orTCGcI=;
        b=IR9eeUxWKNRbJflHh/WUXhJOBFFjuP9hmM9/40vHGbd9KHq9qIYKH66OBrX5NoTnh1
         xuDHP2ridv7Ec0ItrGipohjANymS/dkNkcLI3QZDXGdUG2LT4m8Fc+hHveyYK3pNP2q4
         EBPAEO7bmLPHfu+50ukDjAUvrSKBe3yk//ln1C7ywQNhzipLsu5oZSPKA6VenJsbJzeX
         hjdJ5I0BFlf6Z0sBVQkm0z9wNxrSX/VsOS0qTSFWf+I7hvy0kl5PuWDElu0MPTVQkx8P
         EUUxtPBIHGSRcA8lpoo14pL9H4AWc+i1fuY10yXpxEW10CPAIrxqQVv5Z8eLzig1qV8j
         9Lxw==
X-Gm-Message-State: AOJu0Yyrttroctw+wWjn/qU23qAhhmd6hHoWfiheQgZDvflv6XihszIf
        QGKoPPdL92MMc9NG1Gus43Qkc6ApzP/I0A==
X-Google-Smtp-Source: AGHT+IFSLO4cdoU9qpFk/zqqrZjRhqsYzunqjOJBdE0nDlNdFYp1zjuywBah4BSeRt7FSoiz5Wu6ig==
X-Received: by 2002:a05:6402:1b05:b0:523:bfec:490f with SMTP id by5-20020a0564021b0500b00523bfec490fmr13676297edb.0.1696848941324;
        Mon, 09 Oct 2023 03:55:41 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:47bc:9393:72b0:bdf2])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b005331f6d4a30sm5906800edb.56.2023.10.09.03.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:55:40 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/3] rev-list: move `show_commit()` to the bottom
Date:   Mon,  9 Oct 2023 12:55:27 +0200
Message-ID: <20231009105528.17777-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009105528.17777-1-karthik.188@gmail.com>
References: <20231009105528.17777-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `show_commit()` function already depends on `finish_commit()`, and
in the upcoming commit, we'll also add a dependency on
`finish_object__ma()`. Since in C symbols must be declared before
they're used, let's move `show_commit()` below both `finish_commit()`
and `finish_object__ma()`, so the code is cleaner as a whole without the
need for declarations.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/rev-list.c | 85 +++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ea77489c38..98542e8b3c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -100,7 +100,48 @@ static off_t get_object_disk_usage(struct object *obj)
 	return size;
 }
 
-static void finish_commit(struct commit *commit);
+static inline void finish_object__ma(struct object *obj)
+{
+	/*
+	 * Whether or not we try to dynamically fetch missing objects
+	 * from the server, we currently DO NOT have the object.  We
+	 * can either print, allow (ignore), or conditionally allow
+	 * (ignore) them.
+	 */
+	switch (arg_missing_action) {
+	case MA_ERROR:
+		die("missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
+		return;
+
+	case MA_ALLOW_ANY:
+		return;
+
+	case MA_PRINT:
+		oidset_insert(&missing_objects, &obj->oid);
+		return;
+
+	case MA_ALLOW_PROMISOR:
+		if (is_promisor_object(&obj->oid))
+			return;
+		die("unexpected missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
+		return;
+
+	default:
+		BUG("unhandled missing_action");
+		return;
+	}
+}
+
+static void finish_commit(struct commit *commit)
+{
+	free_commit_list(commit->parents);
+	commit->parents = NULL;
+	free_commit_buffer(the_repository->parsed_objects,
+			   commit);
+}
+
 static void show_commit(struct commit *commit, void *data)
 {
 	struct rev_list_info *info = data;
@@ -219,48 +260,6 @@ static void show_commit(struct commit *commit, void *data)
 	finish_commit(commit);
 }
 
-static void finish_commit(struct commit *commit)
-{
-	free_commit_list(commit->parents);
-	commit->parents = NULL;
-	free_commit_buffer(the_repository->parsed_objects,
-			   commit);
-}
-
-static inline void finish_object__ma(struct object *obj)
-{
-	/*
-	 * Whether or not we try to dynamically fetch missing objects
-	 * from the server, we currently DO NOT have the object.  We
-	 * can either print, allow (ignore), or conditionally allow
-	 * (ignore) them.
-	 */
-	switch (arg_missing_action) {
-	case MA_ERROR:
-		die("missing %s object '%s'",
-		    type_name(obj->type), oid_to_hex(&obj->oid));
-		return;
-
-	case MA_ALLOW_ANY:
-		return;
-
-	case MA_PRINT:
-		oidset_insert(&missing_objects, &obj->oid);
-		return;
-
-	case MA_ALLOW_PROMISOR:
-		if (is_promisor_object(&obj->oid))
-			return;
-		die("unexpected missing %s object '%s'",
-		    type_name(obj->type), oid_to_hex(&obj->oid));
-		return;
-
-	default:
-		BUG("unhandled missing_action");
-		return;
-	}
-}
-
 static int finish_object(struct object *obj, const char *name UNUSED,
 			 void *cb_data)
 {
-- 
2.41.0

