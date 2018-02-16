Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B381F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162404AbeBPRqz (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:55 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40652 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162384AbeBPRqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:54 -0500
Received: by mail-pg0-f67.google.com with SMTP id g2so2959527pgn.7
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ILiMnTn9dRxO4wqI6g/5CZepCDO4njXyF0Jed6vKYO0=;
        b=VjnK7kQbtamF4NUqm+hMUWHsg6GF/LFv358r2W0QcMg4SokLlhs/znV6Se7zgEIWHn
         BJlWIH5a+UYHBuIfRcwvq8whdHS0476dp4HNp1CuTRWz7mHInp413CcbWBaeq5I2oXFs
         g4gYCltb9J/5xLZpjQQAimm8ADNKQ5JwzkXdDBD6xHKWrtl/5MqLT97EEjgdVsVE49x/
         v2KhKWhP08l002gpcKaOL+vbI/l7fJSMGzEFr1agGLBQ1sqC2LnupOo2ZI1b43onpl9i
         trh5ZgGxs13uD7jxN/AWWHKkwMeMqgAfXbgJen2nATPyaf15LZBtRX/G8K92i6ssKGtZ
         oipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILiMnTn9dRxO4wqI6g/5CZepCDO4njXyF0Jed6vKYO0=;
        b=GPYKPlhdiiro25NG7vAjDG6v6PwJLKlWwM5zSSGal9AVCITR674D+hg3am9jz9ayMg
         DRUAlIGFjxtW6fcqfiytZkgQCl/zv+uimEEHWTb/AGqaHwlFBoc4YZIQHB4UrdQqwWOr
         0FHxqAppZLQQu1Ijwwoo2wr9PF/dfDYWJWcGWUjNrJCnMq4dfJSziYPeg6qr7Y5rVcpL
         54lWg9Qu0n2dUbhP24HHfsn7OK94fqpROcp5BE/7MkeWxQ8cxPCbSrzvSVjAxzFAJOTf
         9KOtdAwifsRRUQoPkygbNs1QuYIZrwHpNuPwxsgvoaeJeZzzSWFno3F6IY0EB/MazVDi
         n3CA==
X-Gm-Message-State: APf1xPCqanKms6l+6sGb04BEksvrL63FQxVCx/bvlsVPU77Fe8tIa6+h
        +NlTT31swCh3GVj9Dp9fTMek0vnnKdc=
X-Google-Smtp-Source: AH8x226dz7MKTOjKhcU7O+KiW2g7qf1/WCh2IlQf1x2aXuReVV6rb6coO7fbS2RxN0Tc9EPxmEoNrg==
X-Received: by 10.99.163.9 with SMTP id s9mr5855670pge.264.1518803213782;
        Fri, 16 Feb 2018 09:46:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t3sm19747088pfl.116.2018.02.16.09.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/16] sha1_file: allow open_sha1_file to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:23 -0800
Message-Id: <20180216174626.24677-14-sbeller@google.com>
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
 sha1_file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index bd8b0331f0..3356f70dd2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -900,7 +900,8 @@ static int stat_sha1_file(struct raw_object_store *o, const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+static int open_sha1_file(struct raw_object_store *o,
+			  const unsigned char *sha1, const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -908,7 +909,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&the_repository->objects, &buf, sha1);
+	sha1_file_name(o, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -916,8 +917,8 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb(&the_repository->objects);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	prepare_alt_odb(o);
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
@@ -943,7 +944,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(&the_repository->objects, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.291.g4437f3f132-goog

