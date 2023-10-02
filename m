Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B22BE784A8
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjJBClc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjJBClO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB9195
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:55 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fca042ec0so387508439f.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214455; x=1696819255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEXEDOM77zShgkhxlSm3FRtPftyWOh24/z/5gLCNmyk=;
        b=BSZxSLojKHwuQOyv2ifQv/q6F+fZ5UmnA2OibVhrUxQ+hsyuz9TthmAhSjTw3a5nB1
         nF5akWG0fg6bCHp6gOk9YjeFxZg6JxkAVciyT/iYlwbIxR/ZS0pJreunlsCqDypSVRS2
         3q3FJtFvhCDBED+u+yz+WFV1ExKnSkZHv9CrAeamLydNk2hlBsAyanR9vbkxYFJ+ut8v
         c0G6eEOaRFZoMz8q/Ck45CoEJnks6ERcEUxxCH9MwMWehRMrI1Gwmbu84JV2G4DcC7VJ
         IOeDl8faL9M06KO904FuQWjEtr6/5PNBbf7PKc4uILKmv54z4eZb7QGjDK+3jP2Dw7wu
         9aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214455; x=1696819255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEXEDOM77zShgkhxlSm3FRtPftyWOh24/z/5gLCNmyk=;
        b=X2ZbVm1rUrDjX7bLBzEno8hxJfRuH3ac0qsd7yBc0kPup+GcKHjHrioDyI5OlFGTlt
         FZ07eXof42Oa71KHLyzSuBAiCe0RCZrWQLQYGi8160jHkzzJ8P6T7E7CoQMDFCPWD40o
         ETIQ4iENsF1um3rxgAdCqoRN37JMYVyIotHsV0kN/DnJ2DCOwmmagRrevXOG0eX/2nkp
         xuOlZwJnPbWjz1mOtD6IRzI2xZVPIJrs2Gqj1S3QfiDIj5MtbYfSbnHIEyLdjwIFIBRq
         LPbrUv1yxcFTNiYDFzXTblSuG+pl5NhBGpgRx0hXjj5R0foJEhr9iQjQKmFPk/Tuht5Z
         Lqrg==
X-Gm-Message-State: AOJu0YwyovtmcYH9/AQ9gzdHERBzb5eho2bkoXJbkoncTtRZLkIpDMsC
        uHw9/rvmhRrSb/0DG/w03DE=
X-Google-Smtp-Source: AGHT+IGuQUgPD47R1119U48c4WL56770732I7sov1FV8i0/SWhIfy3C7uHap3uhTpEg+F/A5UPzVIw==
X-Received: by 2002:a05:6602:91:b0:794:da97:d194 with SMTP id h17-20020a056602009100b00794da97d194mr12880408iob.19.1696214455060;
        Sun, 01 Oct 2023 19:40:55 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:54 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 18/30] object-file-convert: convert commit objects when writing
Date:   Sun,  1 Oct 2023 21:40:22 -0500
Message-Id: <20231002024034.2611-18-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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
index 79e8e211ff95..0da081104ed4 100644
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
 		BUG("Refusing noop object file conversion");
 
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

