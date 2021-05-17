Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA9C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3743C61285
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhEQM0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbhEQM0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:26:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D0C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so1200968wmc.0
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ClO1IzNp/+NptSD5vjE/6PtbgR0czHv6zACBZRa0S+U=;
        b=Ha3/4coS4vONThTuJaBW+zfoKMlqZYbwQWld3oNBjIHAdqg9iabGq9YLOcJEhMiUFA
         juRuiim+z0TcZwj0DQUauA/qSSPiIQGu74MTFnYSufJzn+QHUIuLh2Qid9kkZF5xm16W
         mthCJFkTDtkcq9/JBsZ7Ejwg8I2+Ckjfltb98KZAmRQ+dk9iCQ/PISTE/sNvtoNbBB3+
         +VO4UdtImPwUiF8tFIpYs3UxKdO9Si5/zE0PHeWspXld/wsP8O5kDe3jVkn+oHQps8C/
         0hNRMXVZGaocYF+TdWpjUpYZvkWKtoKxnCAGa1W0e4jqn3iaN4uGehAu7D9d/xFZ0wVV
         Y2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ClO1IzNp/+NptSD5vjE/6PtbgR0czHv6zACBZRa0S+U=;
        b=uXlOSq1cfNfIXtZAgaN+8CF0wFxck/gNFkyrWsDpSMBVT81VrdxQg+54wm8b5p/oC2
         LK1o6bTEO8dnYMnjIu05tJaC0bsqpmT2vOqwFmJGf56LtzR3Y86ZZ9qydMlhzcbBlESN
         4H0zz5FC68+Z6otg0T3sOE7YIyvfQGxe8cXxlJXrNsymTBpDlSN4u/2r95lbCOXaG1XJ
         q1ralIXYU179HHJ4E/PCflx7aD77Zakjq1mdFpCFe6o6+7YbrNWMIPvkpwXkc5FrYfJF
         dM53L42ix8R+GAzXg+7hHm97pOFV47yXQjNZPLClVRTrMChc+SdnqnbK/ano6Ze4ORRI
         VJmw==
X-Gm-Message-State: AOAM531OuhQcq1ANwN3+NmxzxckJsee4eeEDmdtivQDf0HJUfOZF2Lja
        DC81gLQKWGK80LLC/9mP1hOhmz14clE=
X-Google-Smtp-Source: ABdhPJzg+eMijUMDFWQTs/zQzVO0zvwLzxdx3E7rbYVWCcYlxQejl5YiTkRHJG7+YA9rob4HMUAPsw==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr22704836wmh.32.1621254294796;
        Mon, 17 May 2021 05:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm11299237wrp.46.2021.05.17.05.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:24:54 -0700 (PDT)
Message-Id: <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
        <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 May 2021 12:24:50 +0000
Subject: [PATCH v2 2/4] csum-file.h: increase hashfile buffer size
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The hashfile API uses a hard-coded buffer size of 8KB and has ever since
it was introduced in c38138c (git-pack-objects: write the pack files
with a SHA1 csum, 2005-06-26). It performs a similar function to the
hashing buffers in read-cache.c, but that code was updated from 8KB to
128KB in f279894 (read-cache: make the index write buffer size 128K,
2021-02-18). The justification there was that do_write_index() improves
from 1.02s to 0.72s.

There is a buffer, check_buffer, that is used to verify the check_fd
file descriptor. When this buffer increases to 128K to fit the data
being flushed, it causes the stack to overflow the limits placed in the
test suite. By moving this to a static buffer, we stop using stack data
for this purpose, but we lose some thread-safety. This change makes it
unsafe to write to multiple hashfiles across different threads.

By adding a new trace2 region in the chunk-format API, we can see that
the writing portion of 'git multi-pack-index write' lowers from ~1.49s
to ~1.47s on a Linux machine. These effects may be more pronounced or
diminished on other filesystems. The end-to-end timing is too noisy to
have a definitive change either way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 12 ++++++++----
 csum-file.c    | 28 +++++++++++++++++-----------
 csum-file.h    |  4 +++-
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index da191e59a29d..1c3dca62e205 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -58,9 +58,11 @@ void add_chunk(struct chunkfile *cf,
 
 int write_chunkfile(struct chunkfile *cf, void *data)
 {
-	int i;
+	int i, result = 0;
 	uint64_t cur_offset = hashfile_total(cf->f);
 
+	trace2_region_enter("chunkfile", "write", the_repository);
+
 	/* Add the table of contents to the current offset */
 	cur_offset += (cf->chunks_nr + 1) * CHUNK_TOC_ENTRY_SIZE;
 
@@ -77,10 +79,10 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 
 	for (i = 0; i < cf->chunks_nr; i++) {
 		off_t start_offset = hashfile_total(cf->f);
-		int result = cf->chunks[i].write_fn(cf->f, data);
+		result = cf->chunks[i].write_fn(cf->f, data);
 
 		if (result)
-			return result;
+			goto cleanup;
 
 		if (hashfile_total(cf->f) - start_offset != cf->chunks[i].size)
 			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
@@ -88,7 +90,9 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 			    hashfile_total(cf->f) - start_offset);
 	}
 
-	return 0;
+cleanup:
+	trace2_region_leave("chunkfile", "write", the_repository);
+	return result;
 }
 
 int read_table_of_contents(struct chunkfile *cf,
diff --git a/csum-file.c b/csum-file.c
index 3c26389d4914..bd9939c49efa 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,19 +11,25 @@
 #include "progress.h"
 #include "csum-file.h"
 
+static void verify_buffer_or_die(struct hashfile *f,
+				 const void *buf,
+				 unsigned int count)
+{
+	static unsigned char check_buffer[WRITE_BUFFER_SIZE];
+	ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
+
+	if (ret < 0)
+		die_errno("%s: sha1 file read error", f->name);
+	if (ret != count)
+		die("%s: sha1 file truncated", f->name);
+	if (memcmp(buf, check_buffer, count))
+		die("sha1 file '%s' validation error", f->name);
+}
+
 static void flush(struct hashfile *f, const void *buf, unsigned int count)
 {
-	if (0 <= f->check_fd && count)  {
-		unsigned char check_buffer[8192];
-		ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
-
-		if (ret < 0)
-			die_errno("%s: sha1 file read error", f->name);
-		if (ret != count)
-			die("%s: sha1 file truncated", f->name);
-		if (memcmp(buf, check_buffer, count))
-			die("sha1 file '%s' validation error", f->name);
-	}
+	if (0 <= f->check_fd && count)
+		verify_buffer_or_die(f, buf, count);
 
 	if (write_in_full(f->fd, buf, count) < 0) {
 		if (errno == ENOSPC)
diff --git a/csum-file.h b/csum-file.h
index e54d53d1d0b3..bc88eb86fc28 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -5,6 +5,8 @@
 
 struct progress;
 
+#define WRITE_BUFFER_SIZE (128 * 1024)
+
 /* A SHA1-protected file */
 struct hashfile {
 	int fd;
@@ -16,7 +18,7 @@ struct hashfile {
 	const char *name;
 	int do_crc;
 	uint32_t crc32;
-	unsigned char buffer[8192];
+	unsigned char buffer[WRITE_BUFFER_SIZE];
 };
 
 /* Checkpoint */
-- 
gitgitgadget

