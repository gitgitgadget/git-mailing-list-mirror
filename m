Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25755E784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjJBClS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjJBClB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B04EFD
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a26fbfcf8eso91522839f.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214452; x=1696819252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UQ12IiVRZf6rc/H6QZj+3H9gwwx4IxYNbtpQetqEnY=;
        b=dYt2y+e4WtTCOc0TUfiwvPbaDY0DUJyiFHHIE5oXatOOsYZetTNa3vMZhVKREbpTk9
         tRRODjrzo7hZMW1dkg6H0SmRHFoKqMUtepYzdpJQkXAlFISnyDNNXcdiWUHP4YHZJjMS
         gpsd7oDsChiY2OwIIVyjuHtATKi+WAPGHjBneBAI4LJnmIlyVDIZFgVVs07/Y/7vGo31
         KxxwDL6UKHklK9hLXjMsX5sl6odZndCnwLN5sip6y/kZ4EuLl9muvRAz3zNMjUSRPo3y
         dt7QeIgvgotKFC7ZCCDqBhw1gqYxsTFfdUJzmxld2Uh4YPynPVrPC0hg1R/rt8qWQcLK
         MpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214452; x=1696819252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UQ12IiVRZf6rc/H6QZj+3H9gwwx4IxYNbtpQetqEnY=;
        b=U7ZwHadaJF18fr+AGMSKzD2YLuE1QKKCA+mNCrZYH5jdH1PN2jqf45eBWQlkReGgKq
         sa99G1NUvUEDdynDwvetMDEvWqJUn4k/LvUVkqnSYsSQI30Qwegx2Zyud/ZKXfb5KWLA
         joyuSDtvqBU9CbINtWThT3h+KsqeykAu+g97pi/Apt4xVmTIOngREvZ8VgSzcJCPqgjz
         P23gVsHZf8EavnCHAy9fyLT8DsAJdeOzcBw905vJ4vhQ2c/gajV0LRrH+/WXbmuyypRj
         ltf9Om1VoOKAJvETVwb130Oz2oubh1teuoSb/SjGQrOnlHtmyqlhDai+gmdGj9cQSyYt
         ymww==
X-Gm-Message-State: AOJu0Yx6aZQPvzqY0imyMXFWgP4K9iDkZ9XpDbUlRjz0IezrYEYSqg0D
        Nw6DkiUjAhW5H4+yLkfBgQ4=
X-Google-Smtp-Source: AGHT+IENIjd23Cg+lLyZl1mC/Lm1x7gl5iRu9+/zafEjvsjuCfycmY7ZGCFdlFI/NbQ0XA48s7lAkA==
X-Received: by 2002:a6b:dc02:0:b0:79f:ce11:c1b0 with SMTP id s2-20020a6bdc02000000b0079fce11c1b0mr11878279ioc.6.1696214452591;
        Sun, 01 Oct 2023 19:40:52 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:52 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 15/30] object-file-convert: add a function to convert trees between algorithms
Date:   Sun,  1 Oct 2023 21:40:19 -0500
Message-Id: <20231002024034.2611-15-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

In the future, we're going to want to provide SHA-256 repositories that
have compatibility support for SHA-1 as well.  In order to do so, we'll
need to be able to convert tree objects from SHA-256 to SHA-1 by writing
a tree with each SHA-256 object ID mapped to a SHA-1 object ID.

We implement a function, convert_tree_object, that takes an existing
tree buffer and writes it to a new strbuf, converting between
algorithms.  Let's make this function generic, because while we only
need it to convert from the main algorithm to the compatibility
algorithm now, we may need to do the other way around in the future,
such as for transport.

We avoid reusing the code in decode_tree_entry because that code
normalizes data, and we don't want that here.  We want to produce a
complete round trip of data, so if, for example, the old entry had a
wrongly zero-padded mode, we'd want to preserve that when converting to
ensure a stable hash value.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 1ec945eaa17f..70b80fb61e54 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -1,8 +1,10 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "hex.h"
 #include "repository.h"
 #include "hash-ll.h"
+#include "hash.h"
 #include "object.h"
 #include "loose.h"
 #include "object-file-convert.h"
@@ -36,6 +38,51 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 	return 0;
 }
 
+static int decode_tree_entry_raw(struct object_id *oid, const char **path,
+				 size_t *len, const struct git_hash_algo *algo,
+				 const char *buf, unsigned long size)
+{
+	uint16_t mode;
+	const unsigned hashsz = algo->rawsz;
+
+	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
+		return -1;
+	}
+
+	*path = parse_mode(buf, &mode);
+	if (!*path || !**path)
+		return -1;
+	*len = strlen(*path) + 1;
+
+	oidread_algop(oid, (const unsigned char *)*path + *len, algo);
+	return 0;
+}
+
+static int convert_tree_object(struct strbuf *out,
+			       const struct git_hash_algo *from,
+			       const struct git_hash_algo *to,
+			       const char *buffer, size_t size)
+{
+	const char *p = buffer, *end = buffer + size;
+
+	while (p < end) {
+		struct object_id entry_oid, mapped_oid;
+		const char *path = NULL;
+		size_t pathlen;
+
+		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, from, p,
+					  end - p))
+			return error(_("failed to decode tree entry"));
+		if (repo_oid_to_algop(the_repository, &entry_oid, to, &mapped_oid))
+			return error(_("failed to map tree entry for %s"), oid_to_hex(&entry_oid));
+		strbuf_add(out, p, path - p);
+		strbuf_add(out, path, pathlen);
+		strbuf_add(out, mapped_oid.hash, to->rawsz);
+		p = path + pathlen + from->rawsz;
+	}
+	return 0;
+}
+
 int convert_object_file(struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
@@ -50,8 +97,10 @@ int convert_object_file(struct strbuf *outbuf,
 		BUG("Refusing noop object file conversion");
 
 	switch (type) {
-	case OBJ_COMMIT:
 	case OBJ_TREE:
+		ret = convert_tree_object(outbuf, from, to, buf, len);
+		break;
+	case OBJ_COMMIT:
 	case OBJ_TAG:
 	default:
 		/* Not implemented yet, so fail. */
-- 
2.41.0

