Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736EB1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162416AbeBPRq7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:59 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44004 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162384AbeBPRq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:56 -0500
Received: by mail-pl0-f66.google.com with SMTP id f4so2044779plr.10
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ca0zachQodK4OfKYz6xGu+4rge5eJLrdteAEaGRh6A=;
        b=HsO/uN4b7YupfSx4HdpfIHSz4N1lo9S/jUiihS/aGu8sryGc1xlwu4YutjmGZ0dC2E
         lnlyiCuyB4G6tmRlyNu2qsMCB0ZH44K1A2e1OqEC+0cgMVRm0qiic8shY9OPnkSGC1fk
         VWC3H4hw4qGUAoWH5N2DeKbXUQFBhBR5uXOp0E9R7x3I0vTgMs2r5OKrn8ZyBz6h7O/u
         588TFADITO96jojgQHmSoeQVi5QvCCX+ayi2MILUBIPdkaZ48bqLJFbiavru/4dJfhw4
         XdErSt0I85A7PsTcqboDejH80j42/TVwpWPnNOx6dKQjnCoMX1X0nOXCY5IWKKfV0jsT
         1l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ca0zachQodK4OfKYz6xGu+4rge5eJLrdteAEaGRh6A=;
        b=bROzbPboXivTO7pBe6pp1otStdrJL/IKjdWzeAsc2jeQ4kCJMderEZCClZW5zi8Z7f
         y4dLUZI6KnpVsWEJ99RW9qFfEk70OciUMupKKQbvkzdewMEpGxDJQnC0DPP9RY/SkTzJ
         E5ZbDhga5f61OTOWtgM5V9iun0k0cCThrJVMyYpDl5htPvDsNiHS6EMfFAfusxz3LySV
         z28ntR0/sOChDiDrATs1ScK1ti1dw06EiF7/UXOiQJhTzpwGikZepqgbHRYWa2QvAcIw
         5z3GLZRuSoBCIZM59IdSUeK+Afe86cKx4OckKul4wrUDU5ZlVAffU4F08ANux7TtlwwF
         PxMA==
X-Gm-Message-State: APf1xPDG2Zj9zfFtbgQlLdRfqAxaPXFlmFSM0b/RGT9v3mB3NywprdzV
        8Eq4Yu6zykKzpIey9jQzYYnbFRt9y8U=
X-Google-Smtp-Source: AH8x224gAQco/pK5Zxl/gaZhKnRNnstxfHCdvNct3o/MjJw4w7gy/sDXLX9zDmrnOZK8a7bRMkljsw==
X-Received: by 2002:a17:902:e83:: with SMTP id 3-v6mr6521786plx.158.1518803215360;
        Fri, 16 Feb 2018 09:46:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p13sm13352911pfd.8.2018.02.16.09.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/16] sha1_file: allow map_sha1_file_1 to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:24 -0800
Message-Id: <20180216174626.24677-15-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3356f70dd2..aeb925a895 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -934,9 +934,8 @@ static int open_sha1_file(struct raw_object_store *o,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-static void *map_sha1_file_1(const char *path,
-			     const unsigned char *sha1,
-			     unsigned long *size)
+static void *map_sha1_file_1(struct raw_object_store *o, const char *path,
+			     const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -944,7 +943,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(&the_repository->objects, sha1, &path);
+		fd = open_sha1_file(o, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -965,7 +964,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(&the_repository->objects, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2195,7 +2194,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(&the_repository->objects, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.16.1.291.g4437f3f132-goog

