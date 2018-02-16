Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5D11F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162409AbeBPRq4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:56 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35394 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162393AbeBPRqx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:53 -0500
Received: by mail-pg0-f68.google.com with SMTP id l131so2968342pga.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fLfE57V/9Eh1gdcQUzXJy/Ku1ebZ4VXAAgfUs6jNi1E=;
        b=A+se/5nfKOsKrANkHXLQ3yJ50qCI3Dp6qB7rRckGb5G0gEO6OqsAymANxeH0lQO6vp
         4ieybhBB/Qg2velPhWadp8hy53aF19LkJ2tWUBFsKDkjB7i2GIjEaKArFlStdZmsH+bK
         TBG4hKFB1ILJ91gIK70/LZ9cLgI1xG4NPaa8cjOXyY85dpFplbQSHa384YhoTCyOZcoi
         7TEXJLCe/FEc34An1ZmlmZvX34G2VHAQCG17z7fqyTW2KbeNAOrpdazJ941ILQmBp2XX
         VoQhqAT4Re2xJaIV5S/yYm1yc04yuX4OE36YBYvTJttyL9CmRZhCwyIiT/DPcU8pjL7j
         UyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fLfE57V/9Eh1gdcQUzXJy/Ku1ebZ4VXAAgfUs6jNi1E=;
        b=JlRZFvP833okut4xv/h4F5HvggZy9QZ27//puHURlOrN2datReu4gZsUmLWaaWR/aO
         7HZbuTfNYYPD/9Gonoy9iau80QpFX9CSSFtl/Oi6Fmaq6JzFP5czy7WNoJxtfsbqpW65
         +UB5gxcgggyVjf6ZmthbYLHt6rz/gSjuK/Q3f11KvFErBOmWvDu9o/Ku7mWwGcQ9Ptv0
         gCi1PX/npreGwBRKqZu1pW30gswiNcIs8bhU8gVdNB4PSns9Cw9BEzB23KfGRQx2hYla
         DQ3dAAZPZbinPK0ZFtRuFYhTbodI9rQkuXVBUPveL4Ru14dD2vc1FUSTN8ezo1c9K2U5
         EJUQ==
X-Gm-Message-State: APf1xPBkgI9Y5vVB8RVbRnH48W4cAsAQqI+vHihY3MVurW19GWWfF/MK
        3LoNtO+wNTjaSuMvNGwJMCfCNw==
X-Google-Smtp-Source: AH8x226RZQuhNWTEx+yDABfVaysyScp5esERusDxavI2hwxDE02cWslyjZH6EduHCl5CX4LacDklOQ==
X-Received: by 10.101.66.6 with SMTP id c6mr3138616pgq.213.1518803212300;
        Fri, 16 Feb 2018 09:46:52 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l22sm31841221pff.64.2018.02.16.09.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/16] sha1_file: allow stat_sha1_file to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:22 -0800
Message-Id: <20180216174626.24677-13-sbeller@google.com>
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
 sha1_file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d64cdbb494..bd8b0331f0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -871,22 +871,23 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
-			  const char **path)
+static int stat_sha1_file(struct raw_object_store *o, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&the_repository->objects, &buf, sha1);
+	sha1_file_name(o, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(&the_repository->objects);
+	prepare_alt_odb(o);
+
 	errno = ENOENT;
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -1178,7 +1179,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(&the_repository->objects, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1392,7 +1393,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(&the_repository->objects, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.16.1.291.g4437f3f132-goog

