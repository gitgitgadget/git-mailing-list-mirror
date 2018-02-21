Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246671F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeBUBzW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:22 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33365 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeBUBzT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:19 -0500
Received: by mail-pl0-f68.google.com with SMTP id x18so95868pln.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jakQWooQ1bzqE/egj8wMXbnUAwmZ5lJe1kp6QFK6khw=;
        b=hCylnH2ydewsrs4QrZuwvm3ZQSp6eCjRiEjvjEmfT01HobGPNw7SH9aLWWbMhmLUfi
         qqyuriVb6BH8NimkabQTG26y+FcPhbGBSEOuQjc8U33hu/UoAgevmDKqA5E/pO1UoJ9U
         hgSLrlanGOelwhSQiZQLsk5tOC4zZmlDgRZi8sCxYh9tM6hFLUEvua2za2PBmZAz7Eqd
         Aqzpby6dqEaVYm+UvgYGKKYItyE+hsRrMt4qRi4SLeattldc7V4TaRg+oa3O38RjA7Bb
         dyrvS9VEDh5+83ioEMeLmVO0Sb3bLEp6XozEGexunQoE2ZzsJe0i+6t7KSVddTPRZYIa
         tmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jakQWooQ1bzqE/egj8wMXbnUAwmZ5lJe1kp6QFK6khw=;
        b=Ie16i4wjA7pm+mKMrNY/WbRNEFaVdWGCCLS5pFR85EYdzNYlRPSHpOrvjFD5qcUC7C
         uTSdhfNvGLPD0zfJtyXuzMA2ZnWzf0rSSMkoXearMVt/+rbmHpKwdz3ktKADdNg+QLug
         qAQ5O2I75GkISm66JFQ4KJwmyQKpK8ba/cNV7tQm78iRQKxi9MOMclWkBex33/voBR8y
         tYrMXKpFNp4bvQ98kpF4Kv/W1AD0jcvAmHFjsUH1ik17LRYOQNFaE6NuKfiBrJW4Faf5
         Jcdn1mvCax6XMVElFxKxiT0B47rg+3TedqEUwwLrgUmJif5FaZLDnApd64HXnEFc0W08
         Cy2w==
X-Gm-Message-State: APf1xPD70hQqtJ4nkiV3AEMIh+yxJ6qyNItCofvaOw4ERIFM5+Wveopb
        hNPxmT6K35xFbwiRHBjPYtykJg==
X-Google-Smtp-Source: AH8x226IY645e0TmO1xKrCnI3GChUwtOjhsUAGx9tyvNSTIypPcdcI8EO96xE3e15OEAhlXcVj6g8g==
X-Received: by 2002:a17:902:5322:: with SMTP id b31-v6mr1479984pli.61.1519178119120;
        Tue, 20 Feb 2018 17:55:19 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e90sm13562386pfd.155.2018.02.20.17.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 24/27] sha1_file: allow open_sha1_file to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:27 -0800
Message-Id: <20180221015430.96054-25-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
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
index 6879af8993..598acc5410 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -902,9 +902,8 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
-static int open_sha1_file_the_repository(const unsigned char *sha1,
-					 const char **path)
+static int open_sha1_file(struct repository *r,
+			  const unsigned char *sha1, const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -912,7 +911,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -920,8 +919,8 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
-- 
2.16.1.291.g4437f3f132-goog

