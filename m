Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B06E784A8
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjJBCk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjJBCkv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F8C9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:49 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77acb04309dso577447939f.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214448; x=1696819248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfjtdZNXP497JCb5qMkab/9O6Ztt2eBtpACMqwRx5iQ=;
        b=CdCYAb5L/xGYa1ZnfdEvTavafRAMNT+1WvOIlVnIvg8iiP0LG8oJFYydwVuVTzRaQL
         xNKUmQPkKnrHgua7OwFzE5qdxKTKezOY5I6LjhVDtR3q3MJSYCZ1w/T6jXluX8dyteMi
         20ulhm0DiDowxxdue5qvqQru4mCf5LlQ33b8p0jp/3xjtjuIdSmymhzfGWlEhH8M6OOo
         SVR5Rpt8XEhOA+4/5Gplxok4rrXlm0Fdd9nSyUr9VverJTrPJq+vSKEjf3GStqS6xmLP
         wvpWNrKuoFNL7DX7SywmC1YSsRDpnmvF4x4P+do5z4PL/7ESlbCTW6ljbaRJtG+kILUu
         nFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214448; x=1696819248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfjtdZNXP497JCb5qMkab/9O6Ztt2eBtpACMqwRx5iQ=;
        b=fD695Xkk44q4xCzBe6hFZsl9MfkTLW1yjXmLJVIhXt+wWq5s1SIM9393usHLYObP/J
         6XVYPFVwO6bYmfvFJyxZnOcDmgwHCPVDXElAqfUaK3nM8eriTM/BV/sNRNeQvkTpw8Y6
         IqDYsQ7PIe0xCAOrcd3bl5ON5InjKzHT9kUJt11Ch6nvauzy5sRnZLVUr0w6YDZ1ERBL
         SdrZE9oowyCEehsWZb7cbQ5oV3L1GnAqvRkDvlASZdFxr0U8GDdQD/WRPzaZAbOubTuN
         8qxIEAlaP24UXp3MkwPRBXcdZy55CwoOR1ojiZQavjoGx0jkG6XTOsI9EXbbaMm51DYE
         P3wg==
X-Gm-Message-State: AOJu0YyJxOPsr7Pl83TwF5UR/eA5sh/qsP+vcBpd13dgLKLazEabWlqG
        XM/2cYaMdbnTuQfc0yNrRhg=
X-Google-Smtp-Source: AGHT+IEHxOF8b6LjGyAo7DZGKmTz/fE1dDy3tyUzJaSLnGTQwjT+j3ihlTYsW0/v2QUkHKC/fYNUWg==
X-Received: by 2002:a5e:c019:0:b0:79f:9edb:6e2d with SMTP id u25-20020a5ec019000000b0079f9edb6e2dmr11353695iol.18.1696214448406;
        Sun, 01 Oct 2023 19:40:48 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:48 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 10/30] commit: convert mergetag before computing the signature of a commit
Date:   Sun,  1 Oct 2023 21:40:14 -0500
Message-Id: <20231002024034.2611-10-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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
index 6765f3a82b9d..913e015966b4 100644
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
@@ -1679,6 +1712,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		goto out;
 	}
 	if (r->compat_hash_algo) {
+		struct commit_extra_header *compat_extra = NULL;
 		struct object_id mapped_tree;
 		struct object_id *mapped_parents;
 
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
 		free(mapped_parents);
 
 		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
-- 
2.41.0

