Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5042BC433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3584D600CC
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhKLJpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhKLJpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:45:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69935C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v20so7980381plo.7
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeI8zSoQcUSpyhENDCjUe66JdQx4/Rih8jSSFnaq1rc=;
        b=qCBe15iDUHwaL9CbXG/G27VMb57dgbkGXnLXDehg5fahf37DqmzUCzcMK3nYN5iTwJ
         ua7+e+3IICChV5d/JjGHOu8FMgjTH+tPYX7kwAssbFIMAiCcjPMo8XzD6Hnu+CsXgI/f
         5J0BIlxdT7klLUsP7lw0R2KAduudfTl8oLk9mFFOxgXGxragj07Zm+ytCfZy6CNEfxP0
         tGDyIIf12YrWfwZwV/VoHHWTmWMjlqPu3Ud0q6l5mrozvcXUbuIWJIKwyplOK0gQMYlQ
         KeWHJmywitVkE212IAEbHQhIpGGpOzve0oNE+9dfANyu8Wnb0ARZU9WZscxOEa8KXAOF
         lTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeI8zSoQcUSpyhENDCjUe66JdQx4/Rih8jSSFnaq1rc=;
        b=j37ooktVnfdYefCQ4tm/fI9zx2+JeA29gJHjMv7rCZvahVOIDSjoaKPyKBJtH3ERJz
         m4pfenY8IKMn6R9viN8Opm3eAWsBRnI3YDUzN8opuUvPqG/1kdh5D6o2B4jbpQWnEVdN
         iGwNe5YE43ubR8JTUDmjC2/qgkmTHIEHl5IL9ompuhmBHfA3rEvDaKbR6b9qWHrurVXP
         dGSefabS7Hqna+SfLdFeLMJIBGtV+ZcxgPp6KdmIJcgz3+lVIk5u6rmwNVN7aXPdknbJ
         z3G6bsBRXvBA/IiCS7yVHmMy2hIhZOSDMxnn5O9DhRV0CruzgJLzB5WS0Ayrr5cgdO0H
         ErkA==
X-Gm-Message-State: AOAM533wnFTbSKztJ+VjQf5SSj3+bAl4Wchdn+dGjOpspXKz17mwTPKP
        fv7h7vF+ChseIO9t5Sn6gs4=
X-Google-Smtp-Source: ABdhPJyEGYD4ll+I5hWALsR9c8X9SBUT4L4OgbFXfrqsL5Vbjd+IFEQC62TOK64S9hWX+p/hJ1Ztlg==
X-Received: by 2002:a17:902:8346:b0:142:9e66:2f54 with SMTP id z6-20020a170902834600b001429e662f54mr6367381pln.27.1636710129945;
        Fri, 12 Nov 2021 01:42:09 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id q18sm6310103pfj.46.2021.11.12.01.42.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:42:09 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v2 6/6] unpack-objects: unpack large object in stream
Date:   Fri, 12 Nov 2021 17:40:10 +0800
Message-Id: <20211112094010.73468-6-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When calling "unpack_non_delta_entry()", will allocate full memory for
the whole size of the unpacked object and write the buffer to loose file
on disk. This may lead to OOM for the git-unpack-objects process when
unpacking a very large object.

In function "unpack_delta_entry()", will also allocate full memory to
buffer the whole delta, but since there will be no delta for an object
larger than "core.bigFileThreshold", this issue is moderate.

To resolve the OOM issue in "git-unpack-objects", we can unpack large
object to file in stream, and use "core.bigFileThreshold" to avoid OOM
limits when called "get_data()".

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c          | 76 ++++++++++++++++++++++++-
 t/t5590-receive-unpack-objects.sh | 92 +++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100755 t/t5590-receive-unpack-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..6c757d823b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -320,11 +320,85 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
+struct input_data_from_zstream {
+	git_zstream *zstream;
+	unsigned char buf[4096];
+	int status;
+};
+
+static const char *read_inflate_in_stream(void *data, unsigned long *readlen)
+{
+	struct input_data_from_zstream *input = data;
+	git_zstream *zstream = input->zstream;
+	void *in = fill(1);
+
+	if (!len || input->status == Z_STREAM_END) {
+		*readlen = 0;
+		return NULL;
+	}
+
+	zstream->next_out = input->buf;
+	zstream->avail_out = sizeof(input->buf);
+	zstream->next_in = in;
+	zstream->avail_in = len;
+
+	input->status = git_inflate(zstream, 0);
+	use(len - zstream->avail_in);
+	*readlen = sizeof(input->buf) - zstream->avail_out;
+
+	return (const char *)input->buf;
+}
+
+static void write_stream_blob(unsigned nr, unsigned long size)
+{
+	char hdr[32];
+	int hdrlen;
+	git_zstream zstream;
+	struct input_data_from_zstream data;
+	struct input_stream in_stream = {
+		.read = read_inflate_in_stream,
+		.data = &data,
+	};
+	struct object_id *oid = &obj_list[nr].oid;
+	int ret;
+
+	memset(&zstream, 0, sizeof(zstream));
+	memset(&data, 0, sizeof(data));
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	/* Generate the header */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), (uintmax_t)size) + 1;
+
+	if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, dry_run, 0, 0)))
+		die(_("failed to write object in stream %d"), ret);
+
+	if (zstream.total_out != size || data.status != Z_STREAM_END)
+		die(_("inflate returned %d"), data.status);
+	git_inflate_end(&zstream);
+
+	if (strict && !dry_run) {
+		struct blob *blob = lookup_blob(the_repository, oid);
+		if (blob)
+			blob->object.flags |= FLAG_WRITTEN;
+		else
+			die("invalid blob object from stream");
+	}
+	obj_list[nr].obj = NULL;
+}
+
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf;
+
+	/* Write large blob in stream without allocating full buffer. */
+	if (type == OBJ_BLOB && size > big_file_threshold) {
+		write_stream_blob(nr, size);
+		return;
+	}
 
+	buf = get_data(size);
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
 	else
diff --git a/t/t5590-receive-unpack-objects.sh b/t/t5590-receive-unpack-objects.sh
new file mode 100755
index 0000000000..7e63dfc0db
--- /dev/null
+++ b/t/t5590-receive-unpack-objects.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Han Xin
+#
+
+test_description='Test unpack-objects when receive pack'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success "create commit with big blobs (1.5 MB)" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	(
+		cd .git &&
+		find objects/?? -type f | sort
+	) >expect &&
+	git repack -ad
+'
+
+test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'prepare dest repository' '
+	git init --bare dest.git &&
+	git -C dest.git config core.bigFileThreshold 2m &&
+	git -C dest.git config receive.unpacklimit 100
+'
+
+test_expect_success 'fail to push: cannot allocate' '
+	test_must_fail git push dest.git HEAD 2>err &&
+	test_i18ngrep "remote: fatal: attempting to allocate" err &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	! test_cmp expect actual
+'
+
+test_expect_success 'set a lower bigfile threshold' '
+	git -C dest.git config core.bigFileThreshold 1m
+'
+
+test_expect_success 'unpack big object in stream' '
+	git push dest.git HEAD &&
+	git -C dest.git fsck &&
+	(
+		cd dest.git &&
+		find objects/?? -type f | sort
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for unpack-objects dry-run test' '
+	PACK=$(echo main | git pack-objects --progress --revs test) &&
+	unset GIT_ALLOC_LIMIT &&
+	git init --bare unpack-test.git
+'
+
+test_expect_success 'unpack-objects dry-run with large threshold' '
+	(
+		cd unpack-test.git &&
+		git config core.bigFileThreshold 2m &&
+		git unpack-objects -n <../test-$PACK.pack
+	) &&
+	(
+		cd unpack-test.git &&
+		find objects/ -type f
+	) >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'unpack-objects dry-run with small threshold' '
+	(
+		cd unpack-test.git &&
+		git config core.bigFileThreshold 1m &&
+		git unpack-objects -n <../test-$PACK.pack
+	) &&
+	(
+		cd unpack-test.git &&
+		find objects/ -type f
+	) >actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
2.33.1.44.g9344627884.agit.6.5.4

