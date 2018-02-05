Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15551F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBFAAb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:00:31 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45423 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBFAAa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:00:30 -0500
Received: by mail-pl0-f65.google.com with SMTP id p5so81669plo.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ojbo8oUUA9p5/T4Sb9I/ndYtCK9FbQpLlj0WNxpJjGc=;
        b=U04ZScMDhpn0qwywYkd/0cw9WO9khqkuPAlaLMvOFzzPhWO+qp9v/U1/tctWgXCYMk
         3C4JpspKwRCHwLI4uCE1mm+HlZp7nKpCJPJIk+L3hFlFROYZyP4CGmizGW2wxIL08pZI
         vQZ8MmflkLWt4EYez1OXalFRf7f1MiHpNhURysvFTSySd0/3HBhoJprmZPZ0bTGIa3ys
         p50XGMmj9LcPOo4P6joJpzYWS2db+rcmyTpReub3qS9jl1pWCLfRjkJVzrQxTtKtQET/
         hlnGL32TSwybhQ/80FhldeDwSM2tz/9yFaJNlS6iJHUgU5DOKJ86Do2FX5UMk0GhQk4H
         EATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ojbo8oUUA9p5/T4Sb9I/ndYtCK9FbQpLlj0WNxpJjGc=;
        b=NfJtZKV8KGFt3XI3dZDel4olDpRUvXH4zRm4qDxSpSP3yQc2KnWn7IczxKi0jRSjLm
         OqswNs14YYvbQIOyxKK7qCjX3TnivemV3Idgp0AHzigqDH597UoXdkerE4wxqXE6JZMM
         8yTucYDo2oNrK8l+sLoQKBPlapOsH3fz4yg82QawuIQZT28H9CVJ/Ke6yT+H1ekHufn8
         dWJf2u9+Kib7oHTFlWx9J6sWr0IukKiXixDQIrR5n8CRsH14hbnYq9ZMHzCkTx7zZXZ+
         aJ8wTR3o/obx7zb57vs4V9JJ24PdFAtc7Flp0AWGPbelbfIMlLCTePcLryP0/fxQMdSV
         guFQ==
X-Gm-Message-State: APf1xPCm1StNuZUCMe/uVNTPtUSLWmDNxm3/bAx2L+g7+2FF20AqOFRL
        zdJwMN++hqGEdw8sY6s4iRsPw6tEPzc=
X-Google-Smtp-Source: AH8x224GX96TRrf8P48iRAtoLi6A3oV00IjmRmQamitFRuXnE9I02gB+jqmoF+5MfhkNfQoRAbqMFA==
X-Received: by 2002:a17:902:7b8f:: with SMTP id w15-v6mr498470pll.219.1517875229284;
        Mon, 05 Feb 2018 16:00:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l188sm15691224pgl.72.2018.02.05.16.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:00:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 033/194] pack: allow sha1_file_name to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:54 -0800
Message-Id: <20180205235735.216710-13-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 518da80367..fe2187fd65 100644
--- a/object-store.h
+++ b/object-store.h
@@ -60,8 +60,7 @@ struct packed_git {
  * The return value is a pointer to a statically allocated buffer that
  * is overwritten each time the function is called.
  */
-#define sha1_file_name(r, s) sha1_file_name_##r(s)
-extern const char *sha1_file_name_the_repository(const unsigned char *sha1);
+extern const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
 
diff --git a/sha1_file.c b/sha1_file.c
index ca492eb741..5d4c39bd45 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -324,12 +324,12 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name_the_repository(const unsigned char *sha1)
+const char *sha1_file_name(struct repository *r, const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/", get_object_directory());
+	strbuf_addf(&buf, "%s/", r->objectdir);
 
 	fill_sha1_path(&buf, sha1);
 	return buf.buf;
-- 
2.15.1.433.g936d1b9894.dirty

