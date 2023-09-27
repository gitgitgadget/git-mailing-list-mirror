Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2576EE82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjI0T4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjI0T4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72560194
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79f9acc857cso368633339f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844560; x=1696449360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkhLsqo78Srsesp5Qst5wXtDzgDVzwUYy+O/4Wvj/rI=;
        b=MucLKlWE9wzdmO/8g1QmHYK5EHCAixSH+RqGehUzcRNAk+ARTXRpIzw2dRXRoBXgGY
         6PzzN/GmDAnE3fkjvsQBy0NzrmnLyY6t9FC9BDHk6FWtz4o0kNd8siXxfo/3HTFBSZDF
         wrGgz944YHVI6/Kr2oVNBWTKfnNZqKub/G3TDFI7XecNuDxf7QN4G3f3ZSg46G7AUjWe
         ArKaOaYsnMkoYEtW5ydTaBV6S97QP69YYviy3mCWgdOPtHofIUc8tvnV82CEv52G/gvp
         HuQL+u3oYtLpxBIOnfoUHOTUTy7LukMGKWLNm80H3US1B0zKPZ6aYmeIBiphWHDiF466
         bkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844560; x=1696449360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkhLsqo78Srsesp5Qst5wXtDzgDVzwUYy+O/4Wvj/rI=;
        b=PMPHcfahLq1MYeY2DigsqT1Q8fG5yIFyi5A60LzM9P7g6Q1o15Uw90Ikox4xs1uu+8
         71kqsNNHV+U6/5LVt7SdJXsuyFY7K3ueUBPOE1lT1Z7JDOx7e3IE8ukXuSsmZNJC647E
         iw8rNMQ8u0T4nveVc5fOEoU9UAHwFVa0R8HrtxYHTDVaRHgI8LVAMtmzHTlSo8oyfjod
         J/hVoPtWV5JE7kxMpsuyr9JOy0GhBamHPyuXUPOllsC7VpzZgx1byVq2k10M/Nw2BCK7
         YUDwAnWNE4Cszi+y6E5csEnoT4rApiOqNODHjH5OrRqJqekeO7MwJWrpmXrE1NcB4iN1
         0gbQ==
X-Gm-Message-State: AOJu0YwTq1hO9+XB1HoLBbExyeWYck651A62wmRMy5iB+aPmFbjdbPWg
        w5y2JUbxjc5Evjop8InB9wk=
X-Google-Smtp-Source: AGHT+IFnu5LD9rgA6y3mSKl/XdJ8FdaKzOEDT1sv7Sl8R/RQ7zTP+o5ngjJEQlWFDzOaYU+E4dwGVA==
X-Received: by 2002:a6b:4902:0:b0:780:d76c:b640 with SMTP id u2-20020a6b4902000000b00780d76cb640mr2966545iob.9.1695844559802;
        Wed, 27 Sep 2023 12:55:59 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:59 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 12/30] tag: sign both hashes
Date:   Wed, 27 Sep 2023 14:55:19 -0500
Message-Id: <20230927195537.1682-12-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

When we write a tag the object oid is specific to the hash algorithm.

This matters when a tag is signed.  The hash transition plan calls for
signatures on both the sha1 form and the sha256 form of the object,
and for both of those signatures to live in the tag object.

To generate tag object with multiple signatures, first compute the
unsigned form of the tag, and then if the tag is being signed compute
the unsigned form of the tag with the compatibilityr hash.  Then
compute compute the signatures of both buffers.

Once the signatures are computed add them to both buffers.  This
allows computing the compatibility hash in do_sign, saving
write_object_file the expense of recomputing the compatibility tag
just to compute it's hash.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 builtin/tag.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 3918eacbb57b..8c4bc28952c2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -28,6 +28,7 @@
 #include "ref-filter.h"
 #include "date.h"
 #include "write-or-die.h"
+#include "object-file-convert.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
@@ -174,9 +175,43 @@ static int verify_tag(const char *name, const char *ref UNUSED,
 	return 0;
 }
 
-static int do_sign(struct strbuf *buffer)
+static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
+		   struct object_id *compat_oid_buf)
 {
-	return sign_buffer(buffer, buffer, get_signing_key());
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
+	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
+	struct strbuf compat_buf = STRBUF_INIT;
+	const char *keyid = get_signing_key();
+	int ret = -1;
+
+	if (sign_buffer(buffer, &sig, keyid))
+		return -1;
+
+	if (compat) {
+		const struct git_hash_algo *algo = the_repository->hash_algo;
+
+		if (convert_object_file(&compat_buf, algo, compat,
+					buffer->buf, buffer->len, OBJ_TAG, 1))
+			goto out;
+		if (sign_buffer(&compat_buf, &compat_sig, keyid))
+			goto out;
+		add_header_signature(&compat_buf, &sig, algo);
+		strbuf_addbuf(&compat_buf, &compat_sig);
+		hash_object_file(compat, compat_buf.buf, compat_buf.len,
+				 OBJ_TAG, compat_oid_buf);
+		*compat_oid = compat_oid_buf;
+	}
+
+	if (compat_sig.len)
+		add_header_signature(buffer, &compat_sig, compat);
+
+	strbuf_addbuf(buffer, &sig);
+	ret = 0;
+out:
+	strbuf_release(&sig);
+	strbuf_release(&compat_sig);
+	strbuf_release(&compat_buf);
+	return ret;
 }
 
 static const char tag_template[] =
@@ -249,9 +284,11 @@ static void write_tag_body(int fd, const struct object_id *oid)
 
 static int build_tag_object(struct strbuf *buf, int sign, struct object_id *result)
 {
-	if (sign && do_sign(buf) < 0)
+	struct object_id *compat_oid = NULL, compat_oid_buf;
+	if (sign && do_sign(buf, &compat_oid, &compat_oid_buf) < 0)
 		return error(_("unable to sign the tag"));
-	if (write_object_file(buf->buf, buf->len, OBJ_TAG, result) < 0)
+	if (write_object_file_flags(buf->buf, buf->len, OBJ_TAG, result,
+				    compat_oid, 0) < 0)
 		return error(_("unable to write tag file"));
 	return 0;
 }
-- 
2.41.0

