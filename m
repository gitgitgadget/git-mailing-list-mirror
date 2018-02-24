Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6BC1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeBXAsj (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:39 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33605 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeBXAse (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:34 -0500
Received: by mail-pl0-f67.google.com with SMTP id c11-v6so2432412plo.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rgXwenR26UYmjCxEESIUzEPl63SRgD+jRnZMisHn+Kw=;
        b=L5/QSgw3ncw/wUAkTRTjC1xMM5Ma5I3/JqB6FrwvgUps0qYydCJQoeHC+r+SPL2FcG
         v5gO8LO0cCeTqPQTgmYgJHJzrRH/AzkM9SeTvTzv4TinUqgWzi1ViNoejwRT5t7kX7e+
         plnkgmMByxYVuzKjsOh9d2rD3aSF4+0J/crrQ27gB3slZh2VkrAJ5lObVSCLUZ9G9U8N
         frriekkALqEuYVa7ODu2OYvbrq4R4Cdpcmfk7VuS8C0fAJdaFQ3jFcwJEUJPqT7sRHwe
         vvDIwsk7HkDGQNxr3N3y4f8GdFga3Ja2u+nFpS9gg+OVpVUPK3MVU2NJ8iqguQDHDBdH
         odWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rgXwenR26UYmjCxEESIUzEPl63SRgD+jRnZMisHn+Kw=;
        b=FsCX8emfPyBo0ouj3sgC7e0Pl2vXpGC0RoSO8mvDlJXIWiHe3l9nv104JLXwRgxuNc
         CkSAg4glrtMa9+XotoHDuyojt0+RjLNH24S2U9tKA9FM+A7p7AYVwtUaFCWalyhqxhCw
         okXvWkRPI1UdXZcF0lGWgkvoMysMNB87D9CBw0AefKSYwEnpZfnf/S46TVM86KbP7Ot6
         hGkNlst0YTo2z5izrIoO8yt7GgHKZJ2hPvMQ4vulsG2lwILahKaJX97BXjO5VZsOf6FL
         ALa7GqUuHfBnDU8Fq6ybwiutCbu6fWfQ8PkJh+7mpwNo2Wffywu0UJsbWtUPF6XV9VOL
         8JKQ==
X-Gm-Message-State: APf1xPCkowQ3+P2ZTnVtzpxtYJ5erldTTHkJjLyqtYRGCV6haUEFocj2
        hwhxbE21WAuKRSVpJAJOgyDWEw==
X-Google-Smtp-Source: AH8x225cKiGSyKfJ57oZOAXIZP+Kt9V/yvIOTIpp6G6mQ4kS5cQkthilFZA9TnIJ8ysFAvSuQycctw==
X-Received: by 2002:a17:902:718e:: with SMTP id b14-v6mr3448345pll.38.1519433313965;
        Fri, 23 Feb 2018 16:48:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q14sm5421110pgq.2.2018.02.23.16.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 26/27] sha1_file: allow map_sha1_file to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:53 -0800
Message-Id: <20180224004754.129721-27-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 8b38330d256..afe2f93459b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -119,7 +119,6 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
-#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index e32f1da6b69..902cba42106 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -959,9 +959,10 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct repository *r,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(the_repository, NULL, sha1, size);
+	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-- 
2.16.1.291.g4437f3f132-goog

