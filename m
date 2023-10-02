Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB94E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjJBClD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjJBCkw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C24CE
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:50 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79fe6da0095so276789039f.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214449; x=1696819249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KAF/A/gf2AQ43Th7UFJ8qLbpspkX1qh5IF2KzZ6tTo=;
        b=Y/A+DBq35rgRvGdH6fwiJGyqaSU7OWwdulh7UCppQAcVY19jxTb9+jnjVzO7hzHhK5
         wSo07Uq6NgVCziryEwEk9QA3AVfQq4IEm7ELnK2f7Iz4e9JATX5AQgpSHwyMonrt6zKP
         R5XYA8d3tBzxmWc0uAf8iy4VmVSOtpq51bW26PMvIu6wG+1TxJ+ceO+L5JB5FNChj3Ld
         BRXNEZpDxozCFeKu314rO4kvlRvIWm8OO0gQlfEdHVsBP3/+TriPGz5BL5TOHTmcuTlt
         vwFnSmiCMsVbl/Z2XZKuJxzOe0RsAesnU2FSmAVbFv6njEqfkiRmT9JUWtNQ8eIKrtVC
         IKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214449; x=1696819249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KAF/A/gf2AQ43Th7UFJ8qLbpspkX1qh5IF2KzZ6tTo=;
        b=B0bqYEOd9bJW0SpICY4HBNpRFI5LOiU9qciYgCTwAOqluDnJ/dtGQxTGksqDr5kWvx
         +FExvKxc6fR8Qy+rkeJabs+oJN11YTN1dZovKQ/NQq4QWF+0y3VBlTE7mutTAgCiNr7B
         CeugAAC0+nQkFxrIEAoyQscHM3SqKRm/qDAeKAKpnnGkkCg6pekkPiw4rRxqvD9yk0nc
         9ZjD+bhN3aj06N1r8t2s3O1f/yAjaG/9J0GIC7JHs/phj3HpIOSfLY/iMJyZTZCV5ZpH
         ItSKLuveak/8yGObZXvhZtZjx1N7xaL5UnUh4ZE+Eicgx9x/Vbx4kzq59eJT8zv6Y756
         TNUg==
X-Gm-Message-State: AOJu0YzVbGk4+gdferr0bIiijsBzFGn9C95rly7T8izED67s01R2WplB
        S/CioPKY7JpV8ar4QO7i/HQ=
X-Google-Smtp-Source: AGHT+IFVaFt7oOepXpth1VQLNY+3YZlMZrENZ5ISdB5vUIRo5G3aCfW1fp7roDfHxK5x8Ezz1NyupA==
X-Received: by 2002:a5d:8a14:0:b0:792:884b:209b with SMTP id w20-20020a5d8a14000000b00792884b209bmr11816162iod.9.1696214449271;
        Sun, 01 Oct 2023 19:40:49 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:48 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 11/30] commit: export add_header_signature to support handling signatures on tags
Date:   Sun,  1 Oct 2023 21:40:15 -0500
Message-Id: <20231002024034.2611-11-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Rename add_commit_signature as add_header_signature, and expose it so
that it can be used for converting tags from one object format to
another.

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 commit.c | 6 +++---
 commit.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 913e015966b4..2b61a4d0aa11 100644
--- a/commit.c
+++ b/commit.c
@@ -1101,7 +1101,7 @@ static const char *gpg_sig_headers[] = {
 	"gpgsig-sha256",
 };
 
-static int add_commit_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
+int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
 {
 	int inspos, copypos;
 	const char *eoh;
@@ -1770,9 +1770,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		for (i = 0; i < ARRAY_SIZE(bufs); i++) {
 			if (!bufs[i].algo)
 				continue;
-			add_commit_signature(&buffer, bufs[i].sig, bufs[i].algo);
+			add_header_signature(&buffer, bufs[i].sig, bufs[i].algo);
 			if (r->compat_hash_algo)
-				add_commit_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
+				add_header_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
 		}
 	}
 
diff --git a/commit.h b/commit.h
index 28928833c544..03edcec0129f 100644
--- a/commit.h
+++ b/commit.h
@@ -370,5 +370,6 @@ int parse_buffer_signed_by_header(const char *buffer,
 				  struct strbuf *payload,
 				  struct strbuf *signature,
 				  const struct git_hash_algo *algop);
+int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo);
 
 #endif /* COMMIT_H */
-- 
2.41.0

