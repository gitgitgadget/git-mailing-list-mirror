Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29F71F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJLErF (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:05 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47925 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:05 -0400
Received: by mail-pg1-f201.google.com with SMTP id o18-v6so7559717pgv.14
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c4g6PS10JROHZRLjL5kGuzM/VPwtNxbm0jJv8njRjUM=;
        b=DLbEPM4ib7vHXYrCuEYVDXkJ707iRsBzU2mBA01xo2mVuf3ztB4kYTBwpk0MgZFHbg
         CmUSlz9jb8ePJDmU8zUpRsfYzfiFpx7rehgxAKwLrTW7bnOjHo+oqeWBm5vYk762SK+X
         5WqjvN/dIvsgZyC6EGdYg67sR4uH0+Ji1sR+Ctt1FEVZbD1pYO2znM3+a3UThz9wUTZ/
         hbUMz407Ll1plcf5UPNR4446mBD5kL8sANSW0WsWLzVwQ3W/et4PQQ1EVAxYn5tDHp9j
         zHODUay3Mt4szOC7rgL91L1GAlrb00hIj8n99piLzQW8c4r/MKu3pmWvCNTF6e8Ap/3e
         ZTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c4g6PS10JROHZRLjL5kGuzM/VPwtNxbm0jJv8njRjUM=;
        b=tMg3sJq4Xeg76sc9MQT/9G7yB40mcgYWZrTEomFadclL0QnTI5EHn2WoICAqYJNi/I
         Vvm2fiO3S3p7obugnYgM0gJ6u/hqwZUkDZrVT+HNA6MdK+OzligSfgO38qFXQnrTQRYU
         O2ipfxWZJw8UoXGvoWeRe/rsSxwCQIY/2QBExaXPQZ+Cp/3P5/7WACcgJOaM2Wz+tsoV
         eFIDJpzjpJ58hwdrG21HO7Gj+iBzuTczpk0lgW+Wt48XCOIuhmhd2A6p2DPZ10ZHMt6y
         dgJcwRTLxnV1VDBAcBUmLxQlvUNqO9JJDq3D4c8BfDDaNhBFsj3+Y17fsBgxUVFoVd+4
         rgbw==
X-Gm-Message-State: ABuFfojUGf71ocr/LLrxF8XqwUw2BKiCJWKwi5PzMLiay85YFSQLO9Nv
        iQF2MlLSzHidDsa9ql3xuEUXOX7E2yN+SqRANB4hAL+B81QiDMcIqPTUwlzxZKngiuQFzF3LfFp
        cFLATg5GStEhjK76tmIHOM9MQRLEra4VmFa3nLKvKbzYi72XzQyjqfAPhqbnq
X-Google-Smtp-Source: ACcGV61AKldR8kvoO+ejMF3PESwzRGm7gUZSNAYPmON/Zzs5WmgY3zB2yGx3+vqaMs7+Zez0d3qQcR2cmGp7
X-Received: by 2002:a65:4888:: with SMTP id n8-v6mr1647789pgs.15.1539292680154;
 Thu, 11 Oct 2018 14:18:00 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:36 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 01/19] sha1_file: allow read_object to read objects in
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow read_object (a file local functon in sha1_file) to
handle arbitrary repositories by passing the repository down
to oid_object_info_extended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1-file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 308d5e20e2..647068a836 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1361,7 +1361,9 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
+static void *read_object(struct repository *r,
+			 const unsigned char *sha1,
+			 enum object_type *type,
 			 unsigned long *size)
 {
 	struct object_id oid;
@@ -1373,7 +1375,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 	hashcpy(oid.hash, sha1);
 
-	if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
+	if (oid_object_info_extended(r, &oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1414,7 +1416,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		lookup_replace_object(the_repository, oid) : oid;
 
 	errno = 0;
-	data = read_object(repl->hash, type, size);
+	data = read_object(the_repository, repl->hash, type, size);
 	if (data)
 		return data;
 
@@ -1755,7 +1757,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(oid->hash, &type, &len);
+	buf = read_object(the_repository, oid->hash, &type, &len);
 	if (!buf)
 		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
-- 
2.19.0

