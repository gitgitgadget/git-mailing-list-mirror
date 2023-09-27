Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813EE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjI0T4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI0T4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249911F
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fb64b5265so309748639f.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844558; x=1696449358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMgSh1BaVc3GwM9knHHc1gAtOQJjYyR6B0N6ASPctTI=;
        b=W8kQJQ8gOtwm0j7fCUe4R6HwWmz772fifTICab0tLiWen+EoIr8i7bbIe9UDEs5LNW
         Ze9TxnIrVHaolniv9O8anUw9XLTEI2hyV5TXbAAqFi96Bpdhc0JCcfBtWkaYI4H8om+U
         UoPQr57jOW844mJ4iGJV7sr69GO1/bakQgkcESB2bzeie8y2pG7RB+mhnG/WkH9YYueP
         An6fsGEcrUlF0NeTnxlhjk1ugl0XrEgYjRsD8ox7Fz03/AJSFsjJ9+//+QvYZ3VVTCge
         7sSqlZ9cHQ+Rl2ODmvCVWSQfogFFKGHbd+Ks74645XihDnPGcnRt35nb7yAUjJ+PF3Op
         sU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844558; x=1696449358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMgSh1BaVc3GwM9knHHc1gAtOQJjYyR6B0N6ASPctTI=;
        b=mSVi7Tjmuyd4bwQvswmJ3GotFHaehnXZ8NG6LTUMBjlQuVGDkwQojrAvgFYGzPOx52
         tz+l9UkM4iL0IyjPLm5G2uqR01WlMywUwBb/3C1qXBzc7ndntXBa1S1b0Fa1y5wNkPlo
         vdbla1jTAdHGmfa4HSFhB/rS60Cx+WoolpgFFz47tOSJZenjvdcfGDzI950EgxqfTCwY
         00W5KCu7qarleoes2RJZ7u+JJYQEbx27976IkvxVnRJ6qajgnVl3fugfpo6aX4Oe3QX7
         DI9gIBbyGrYXvSy+/4VQ4Fmtr0NPeRc0g/q9+NPyxL/Faj9reDcWAG4x92owA92Su/cE
         LE5g==
X-Gm-Message-State: AOJu0YwWblnuRMfQIcAA07QpERpr7Ii9N3WboFBQmx7F3LEA3QrzZzNc
        Bes3wEY6I2hVn412YSIS38g=
X-Google-Smtp-Source: AGHT+IF7mfCaWe4yh5eE2yMTebtgBObqeNpaMJH2LKbYva3cVeAHEXneRDSGQClXMphdDd8aVidsFg==
X-Received: by 2002:a5d:9251:0:b0:792:9416:9c7f with SMTP id e17-20020a5d9251000000b0079294169c7fmr3353859iol.9.1695844558360;
        Wed, 27 Sep 2023 12:55:58 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:57 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 10/30] commit: Convert mergetag before computing the signature of a commit
Date:   Wed, 27 Sep 2023 14:55:17 -0500
Message-Id: <20230927195537.1682-10-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

It so happens that commit mergetag lines embed a tag object.  So to
compute the compatible signature of a commit object that has mergetag
lines the compatible embedded tag must be computed first.

Implement this by duplicating and converting the commit extra headers
into the compatible version of the commit extra headers, that need
to be passed to commit_tree_extended.

To handle merge tags only the compatible extra headers need to be
computed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 commit.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 46696ede8981..a6dac9a1957b 100644
--- a/commit.c
+++ b/commit.c
@@ -1355,6 +1355,39 @@ void append_merge_tag_headers(struct commit_list *parents,
 	}
 }
 
+static int convert_commit_extra_headers(struct commit_extra_header *orig,
+					struct commit_extra_header **result)
+{
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
+	const struct git_hash_algo *algo = the_repository->hash_algo;
+	struct commit_extra_header *extra = NULL, **tail = &extra;
+	struct strbuf out = STRBUF_INIT;
+	while (orig) {
+		struct commit_extra_header *new;
+		CALLOC_ARRAY(new, 1);
+		if (!strcmp(orig->key, "mergetag")) {
+			if (convert_object_file(&out, algo, compat,
+						orig->value, orig->len,
+						OBJ_TAG, 1)) {
+				free(new);
+				free_commit_extra_headers(extra);
+				return -1;
+			}
+			new->key = xstrdup("mergetag");
+			new->value = strbuf_detach(&out, &new->len);
+		} else {
+			new->key = xstrdup(orig->key);
+			new->len = orig->len;
+			new->value = xmemdupz(orig->value, orig->len);
+		}
+		*tail = new;
+		tail = &new->next;
+		orig = orig->next;
+	}
+	*result = extra;
+	return 0;
+}
+
 static void add_extra_header(struct strbuf *buffer,
 			     struct commit_extra_header *extra)
 {
@@ -1682,6 +1715,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		goto out;
 	}
 	if (r->compat_hash_algo) {
+		struct commit_extra_header *compat_extra = NULL;
 		struct object_id mapped_tree;
 		struct object_id *mapped_parents = xcalloc(nparents, sizeof(*mapped_parents));
 		if (repo_oid_to_algop(r, tree, r->compat_hash_algo, &mapped_tree)) {
@@ -1695,8 +1729,14 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 				free(mapped_parents);
 				goto out;
 			}
+		if (convert_commit_extra_headers(extra, &compat_extra)) {
+			result = -1;
+			free(mapped_parents);
+			goto out;
+		}
 		write_commit_tree(&compat_buffer, msg, msg_len, &mapped_tree,
-				  mapped_parents, nparents, author, committer, extra);
+				  mapped_parents, nparents, author, committer, compat_extra);
+		free_commit_extra_headers(compat_extra);
 
 		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
 			result = -1;
-- 
2.41.0

