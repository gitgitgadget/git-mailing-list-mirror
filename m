Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F171F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeBXAsc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:32 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42799 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeBXAs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:29 -0500
Received: by mail-pg0-f68.google.com with SMTP id y8so3977110pgr.9
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QVHEP64FinvuES9zMdcZ9K611HXHWxoMS+1zxgpaA5M=;
        b=eoTj0VjzmdvetCK/mYhHOR4dJjpLkq8Sw3XJ6Ahn0FSzn5ERZYUC0uPn7/qtk++A4o
         Z4m//l/c/C7Bzx4JyUDQ9pP5fLfXHLMewQhKbhlfJdd1mFD6c6OqMdPPTMshUtdSdGXx
         jbH5mnOrdnD3/8hu+cJfqbmJmR8PUzrsnRJLmGymkAuimRpZYJmHsAEG7oEoD2qwP7jB
         5RqlEQE7TFGJPkVVAOsBEIQbs8OEain0QCCaWKkbJleK95zXh4OIimWTmhkMX/uC7MAN
         90s5+Vtnx45O5vjGO2v29ras3qEXbh499chSjRAw879455Ox5Eqh1rNm0xJvOEeI8B6m
         i+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QVHEP64FinvuES9zMdcZ9K611HXHWxoMS+1zxgpaA5M=;
        b=qov5oMCwKdC3G8bcxpBDDYIS5i3F+sxK/6IZY73gPHPBKPxkLNgUTkdsgMe3d2dUfj
         Ucl22G8ce6SdkfJhtVAFyvwY+bSmBSg87Negp5JCOl4mNV4EIMVUDdpSwhFO9OO6HKjT
         uatX8TjPvRvNdONDTXRKA06DP7wANpg8gGaqvj7LWSz5pty06uHfZWX9JsXiznpmrSJE
         GXHIx06dtaqPaQtT+uxp2T/HvTtwUBqWq2kYpTNtCf08a3e1tDv81OWZ4BMMsSjbTocx
         Aqpdjvu6m6QCRYQbeuaVaubZKVpffcLaKc1IKhXQn/P39n775oFk6kMWVSwRj39nQLeT
         6kPA==
X-Gm-Message-State: APf1xPCVKvzMaJi9VKOHhtheVonxGwNxTlBWT7Sqj5XlJiRFn7/n4ShE
        P9j/aQYa1uA3TCKNoK9pue4OlKHAvgk=
X-Google-Smtp-Source: AH8x227egepj7r8B3xNRCUrp4UdtD0FrF23XPTXb+rD5niycM66HgTqNfFP2z+OnLz2MbISGpQxHcw==
X-Received: by 10.101.64.197 with SMTP id u5mr2797077pgp.23.1519433308549;
        Fri, 23 Feb 2018 16:48:28 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f12sm5792371pga.67.2018.02.23.16.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 22/27] sha1_file: allow sha1_file_name to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:49 -0800
Message-Id: <20180224004754.129721-23-sbeller@google.com>
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
 sha1_file.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index dbd589e0083..8b38330d256 100644
--- a/object-store.h
+++ b/object-store.h
@@ -117,8 +117,7 @@ void raw_object_store_clear(struct raw_object_store *o);
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified sha1.
  */
-#define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index 831e2da3572..59993a0878d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -321,9 +321,9 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addstr(buf, get_object_directory());
+	strbuf_addstr(buf, r->objects.objectdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
-- 
2.16.1.291.g4437f3f132-goog

