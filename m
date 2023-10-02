Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92654E784A9
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjJBClF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjJBCkx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:53 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68ECD9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:50 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79f8e4108c3so558932339f.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214450; x=1696819250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkhLsqo78Srsesp5Qst5wXtDzgDVzwUYy+O/4Wvj/rI=;
        b=MA3Awkj5GlwEqu/hEax+5SAB/TNk+Blh/yVSaEKVUcejovMJIsjuE/8y4gBrIPbRrA
         wmx8C7NuCOTD4OSKoilR/eG+Hs2qLjzmD3lYJt5kfh7187/J2jvulr3v78khXpe1m6fR
         SYGt5VQwxlpMS2blPwY60LDb0dUDEtvpcclJqv30afm5lcZPqij0mxht7LT8Z5bOnyd3
         ee8wgvOk+tEv3tIopvuY735iCoro42VpQm5kjlGrc5jSoTMaSaf0+qBhHHTvoMp3Q79Y
         WHNUSLD6Kewg2vhb9x+sj97XIi2qEAmKQLivqKVrjymDKo81JSkKob/FeMymGCmRXIEp
         S9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214450; x=1696819250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkhLsqo78Srsesp5Qst5wXtDzgDVzwUYy+O/4Wvj/rI=;
        b=i/i/yPSNpjB6jOK5FR0dJJeCVhEdGKCXdtL6Dq7gyA3WKqF5GWWnDhlIkgvVSkcp66
         nu3bHxH9fq84UAPokKMzX7j4qFdVvUDpBFLK9oMtKb0W/pjrgKoqn/KCD61sZReTFnUs
         qtibsAViFgcc9YCJ8WthCbUzvM4asbvLXgG7EZI14ul/4cu/S3HGWy+ZHNKL2n/y3X6p
         Lqdksi68wejLrU7So9Tyoynx/44bt4pxmalWnh0RWniNuE+kdl9/a7xC/Ej3dA4gVwjb
         s63AnTRyG64tDzhwpvFgQOpPf0uf79AyUob7h3oQIjCqX7q9K2UC8CCs1gXjJVgtBK28
         Jk3Q==
X-Gm-Message-State: AOJu0Yyk2PDEzV2JvVJuDRRYUpgAiQQlWt58ffjNo/52op9J3cK3Qczw
        ZPtjfQJsF1XNP/qgWWUsbck=
X-Google-Smtp-Source: AGHT+IGsaH8Yk13ecAaHTTUvBqnFjBZdHiFY+EpPOll0U8/AI9HGpvU7a4LT8uu25vzfg6bSOo4m/g==
X-Received: by 2002:a6b:db08:0:b0:791:385c:f8b0 with SMTP id t8-20020a6bdb08000000b00791385cf8b0mr11298595ioc.3.1696214450098;
        Sun, 01 Oct 2023 19:40:50 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:49 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 12/30] tag: sign both hashes
Date:   Sun,  1 Oct 2023 21:40:16 -0500
Message-Id: <20231002024034.2611-12-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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

