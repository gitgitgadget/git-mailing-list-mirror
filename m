Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6413A1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeH3A5o (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:57:44 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35894 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3A5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:57:44 -0400
Received: by mail-pf1-f201.google.com with SMTP id d22-v6so3471181pfn.3
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o1YUwdoYm07dem0BeNq8L5KgnkfB3AjxuA+FLhMG7dI=;
        b=DBocfVXmzn4UHYXCo9PAQpQX/0RiKG5wHMQS9MW9UUKYSXry1uhu6dv1ap4ZbjJGen
         ld2szn3eAlEcJmQ8Q2F44liMEDu9l+epo/lQgS2paPnaRBrHndCrKSBWiqfq884gorIk
         rwhxsTeFnNYuHmzn/g6CGr4SHi2AZDCHTwWldBp0lwUyZEdPLpX5m/AZVTiixkjnnnA7
         qztwxqOAw3cB9gn5CCaPmRTE2co7h2v+SDMwJ8y2wTG4kzYxL7Px+TgtHiUIevUcz27J
         Wm+9H1FNQuMlmLR+wegbJptyYZ6XN7uYL/4Wj5+5IP+EALMKJ/7zNhqmooQrcrcF+X/t
         kCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o1YUwdoYm07dem0BeNq8L5KgnkfB3AjxuA+FLhMG7dI=;
        b=fY4DmBkd9Ad1ajftxfoXNX5IOW+tM91VPOIZSxd6ZLaVbjnRoNR2YaQEuCXldHyn8Y
         +1oKi4gCJfxwPvn124A/xelvdl0d8T4XC4DHd3A0sJ2Wtgwg7maBPH0tXbELG3gq1Ze0
         LtX3sr6XyPhEF6d6BuN6rTJUpU2sqORVX77S5cLoCpUamlx8HE1+sxwU282uvwBGlmW2
         wzJEpLd+2IOQkw4rIgH49JcJX0MChc4lyTnjtyCGjlopgX9qoSQ6XeAaCjxCh3yKOLb2
         xeQ4LP+CtfbY49QNgUo2H4ggQGkQta61Dj9kNtcdNfbBfmR7ByLqJ/5AG6o9irCsoJ82
         IjKw==
X-Gm-Message-State: APzg51D3chfTkKF3SFKsI1pOJopWRW0WmovG9xzFvQriVZCWj3LKkjjV
        9HOF1o8IsXlY/ioTsf87F1GRZ/ftQge5sBDTWGvs7YhWHwsJJdeOPpGT3Rb9vsJEPvQo3+v72Aj
        u6Rr2QBWhGgLouynYYYQ3bef0gsiNF2GxkMYO4bJFVZnIHupMZEBsI+U=
X-Google-Smtp-Source: ANB0Vda/3+HPdPI+SAWit8WQE92se1c0vqBsk/L/K8HLas6x7FnjIDlw+ElvVp36uT6m49RRmHgXnPptgg==
X-Received: by 2002:a63:1d57:: with SMTP id d23-v6mr2009539pgm.177.1535576345101;
 Wed, 29 Aug 2018 13:59:05 -0700 (PDT)
Date:   Wed, 29 Aug 2018 22:58:56 +0200
In-Reply-To: <20180829205857.77340-1-jannh@google.com>
Message-Id: <20180829205857.77340-2-jannh@google.com>
Mime-Version: 1.0
References: <20180829205857.77340-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 2/3] t/helper/test-delta: segfault on OOB access
From:   Jann Horn <jannh@google.com>
To:     git@vger.kernel.org, jannh@google.com
Cc:     gitster@pobox.com,
        "=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?=" 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures that any attempts to access memory directly after the input
buffer or delta buffer in a delta test will cause a segmentation fault.

Inspired by vsftpd.

Signed-off-by: Jann Horn <jannh@google.com>
---
 t/helper/test-delta.c | 78 +++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 34c725924..64d0ec902 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -16,45 +16,73 @@
 static const char usage_str[] =
 	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
 
-int cmd__delta(int argc, const char **argv)
+/*
+ * We want to detect OOB reads behind the resulting buffer, even in non-ASAN
+ * builds. This helper reads some data into memory, aligns the *end* of the
+ * buffer on a page boundary, and reserves the next virtual page. This ensures
+ * that a single-byte OOB access segfaults.
+ */
+static void *map_with_adjacent_trailing_guard(const char *path,
+					      unsigned long *sizep)
 {
 	int fd;
 	struct stat st;
-	void *from_buf, *data_buf, *out_buf;
-	unsigned long from_size, data_size, out_size;
+	unsigned long page_size = getpagesize();
+	unsigned long padded_size, padding;
 
-	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
-		fprintf(stderr, "usage: %s\n", usage_str);
-		return 1;
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		perror(path);
+		return NULL;
 	}
+	if (fstat(fd, &st)) {
+		perror(path);
+		close(fd);
+		return NULL;
+	}
+	*sizep = st.st_size;
 
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[2]);
-		return 1;
+	/* pad in front for alignment and add trailing page */
+	padded_size = ((page_size-1) + st.st_size + page_size) & ~(page_size-1);
+	padding = padded_size - (st.st_size + page_size);
+
+	char *mapping = mmap(NULL, padded_size, PROT_READ|PROT_WRITE,
+			     MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (mapping == MAP_FAILED ||
+	    mprotect(mapping + padded_size - page_size, page_size, PROT_NONE)) {
+		perror("mmap");
+		close(fd);
+		return NULL;
 	}
-	from_size = st.st_size;
-	from_buf = mmap(NULL, from_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (from_buf == MAP_FAILED) {
-		perror(argv[2]);
+	if (read_in_full(fd, mapping + padding, st.st_size) != st.st_size) {
+		perror("read_in_full");
+		munmap(mapping, padded_size);
 		close(fd);
-		return 1;
+		return NULL;
 	}
+	mprotect(mapping, padded_size - page_size, PROT_READ);
 	close(fd);
+	return mapping + padding;
+}
 
-	fd = open(argv[3], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[3]);
+int cmd__delta(int argc, const char **argv)
+{
+	int fd;
+	void *from_buf, *data_buf, *out_buf;
+	unsigned long from_size, data_size, out_size;
+
+	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
+		fprintf(stderr, "usage: %s\n", usage_str);
 		return 1;
 	}
-	data_size = st.st_size;
-	data_buf = mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (data_buf == MAP_FAILED) {
-		perror(argv[3]);
-		close(fd);
+
+	from_buf = map_with_adjacent_trailing_guard(argv[2], &from_size);
+	if (from_buf == NULL)
+		return 1;
+
+	data_buf = map_with_adjacent_trailing_guard(argv[3], &data_size);
+	if (data_buf == NULL)
 		return 1;
-	}
-	close(fd);
 
 	if (argv[1][1] == 'd')
 		out_buf = diff_delta(from_buf, from_size,
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

