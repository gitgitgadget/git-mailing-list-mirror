Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56167E82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjI0T4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjI0T4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8271BB
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79faba5fe12so325523239f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844564; x=1696449364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVMkft9MkWAd0VHZsoOdepZnaQ7p0NDdLzvbL/PLqXc=;
        b=QZbZ2yDCUCoz73IL5BarJpQbDfM9u8/rtmpQIxLZqhfG4A79AbzF3FxwGKt0UsqwYr
         dIESJyP/lGIowvIL6dOc1OSjoLz5NvYms31v0v3HZPpipHVWutzm63f9lz4LE9ppwvpH
         qmDZduVXJApH3NdQTxOC3z1+fU2bPW2HYUt3vg1lEU6mMgxL5Ot62s/HZRZgfZdDdl9h
         doMMCNIWosqHck3/Azv2r4QKfXKg00QJ20WNXE/rsw/7eyXSFPKse5nF23yxdnfWJv6h
         iPeCaMPkwjQaIOEJxhkMimOiuLxQlboEqbmJoAcyu/1B7TreNlYLxh3k47Mlaec1qPcv
         dGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844564; x=1696449364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVMkft9MkWAd0VHZsoOdepZnaQ7p0NDdLzvbL/PLqXc=;
        b=wU6/4aBJgl2yBDsR0Q3o3CMBxd6GWVXjd46nRo1sWCQUy623SCEUGsT7dRXcjHMopJ
         MNvdQh5VHlEvo8LDs2pE9a4iy9zRB64q0OZzVehwGKKiCiud1kr9i24ps+t/sRowHltK
         ykHePSPv6zEvlwLlw3QRXBXySyK5a6EwnPi9qDS8PbarMEKDjpmiSn1e6sTLDxSYIcVs
         vr1RTBjR7ZMthZd0dA73qxGxteCWrW+bROHixygJgMjl8a1LzY9T3xPludQIwbfXX6bG
         lh2epoo4u+nTPeCTRt/DoHSG/6NVu4LSSMKO3qVeCf3wdAJhIrsPWZ0hQugXZOowzuMR
         cWhw==
X-Gm-Message-State: AOJu0YwI59PhX3yQZ9h10fae7nlSyIktoaxJl/iIdfqHdD/RlBDehOyA
        r090/bv/+9Vn6itiJFsgjRk=
X-Google-Smtp-Source: AGHT+IHXPI3jbS0CLal6t5sXxErHbsNbhv6v1hlZsvA8fl0euiGUQXyqtktofb7rjr9KnhYaaIBJCw==
X-Received: by 2002:a6b:cf10:0:b0:790:6629:b222 with SMTP id o16-20020a6bcf10000000b007906629b222mr2696930ioa.5.1695844563891;
        Wed, 27 Sep 2023 12:56:03 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:03 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 18/30] object-file-convert: convert commit objects when writing
Date:   Wed, 27 Sep 2023 14:55:25 -0500
Message-Id: <20230927195537.1682-18-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

When writing a commit object in a repository with both SHA-1 and
SHA-256, we'll need to convert our commit objects so that we can write
the hash values for both into the repository.  To do so, let's add a
function to convert commit objects.

Read the commit object and map the tree value and any of the parent
values, and copy the rest of the commit through unmodified.  Note that
we don't need to modify the signature headers, because they are the
same under both algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 822be9d0fdb8..f53e14e5a170 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -136,6 +136,48 @@ static int convert_tag_object(struct strbuf *out,
 	return 0;
 }
 
+static int convert_commit_object(struct strbuf *out,
+				 const struct git_hash_algo *from,
+				 const struct git_hash_algo *to,
+				 const char *buffer, size_t size)
+{
+	const char *tail = buffer;
+	const char *bufptr = buffer;
+	const int tree_entry_len = from->hexsz + 5;
+	const int parent_entry_len = from->hexsz + 7;
+	struct object_id oid, mapped_oid;
+	const char *p;
+
+	tail += size;
+	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
+			bufptr[tree_entry_len] != '\n')
+		return error("bogus commit object");
+	if (parse_oid_hex_algop(bufptr + 5, &oid, &p, from) < 0)
+		return error("bad tree pointer");
+
+	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+		return error("unable to map tree %s in commit object",
+			     oid_to_hex(&oid));
+	strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
+	bufptr = p + 1;
+
+	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
+		if (tail <= bufptr + parent_entry_len + 1 ||
+		    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
+		    *p != '\n')
+			return error("bad parents in commit");
+
+		if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+			return error("unable to map parent %s in commit object",
+				     oid_to_hex(&oid));
+
+		strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
+		bufptr = p + 1;
+	}
+	strbuf_add(out, bufptr, tail - bufptr);
+	return 0;
+}
+
 int convert_object_file(struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
@@ -150,13 +192,15 @@ int convert_object_file(struct strbuf *outbuf,
 		die("Refusing noop object file conversion");
 
 	switch (type) {
+	case OBJ_COMMIT:
+		ret = convert_commit_object(outbuf, from, to, buf, len);
+		break;
 	case OBJ_TREE:
 		ret = convert_tree_object(outbuf, from, to, buf, len);
 		break;
 	case OBJ_TAG:
 		ret = convert_tag_object(outbuf, from, to, buf, len);
 		break;
-	case OBJ_COMMIT:
 	default:
 		/* Not implemented yet, so fail. */
 		ret = -1;
-- 
2.41.0

