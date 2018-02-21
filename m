Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2BE1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeBUB4D (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:56:03 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34878 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBUBzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:08 -0500
Received: by mail-pg0-f67.google.com with SMTP id l131so65214pga.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hJ5tRv5Ht7GJPgKVkAVO91PN1y9wT3f4ql6aDyrs/BA=;
        b=lX2w/1pKnPIUS1AT1OqhuYJyXiDfbU8WoJ7+RGQ5+1EHYhmp73F4UJa2/m93O2cm8Z
         g60VrrZMwiEJoeaelaGzCIKIk26AM1/cdZuVWwMXeFAuqVo/HK/3+VY/9MrEhnfb59M7
         P/bDSDvd1Bluu+JjWUhGEGcSyzeuye3/LmU5J33B+Em4AgM64fGi3RfKGNoeJotXllVh
         wVZMoyCY6duoQ57IGM2NlZVzxu0Xv7HL+1aUCJ8jJoHSquTe79X8X+btg9yZ8SIde0zc
         MVuCyxmvqUrLZO9x9CSQshrIAncog+w7L/YTJvTXX7q+LFSZK9P0Tp7OrTBrGIRSFn/x
         /PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hJ5tRv5Ht7GJPgKVkAVO91PN1y9wT3f4ql6aDyrs/BA=;
        b=nkPL0e5YVF97aps58LT9uKpHvaQ+hrZGaVrpz3PN5dVDM4OiYWVkygixbQMUtGTMVN
         tFzK7UsvrLPzw9ODu0fO+VYIRiz4qm1INe7txRyTZ2ucisH+SoeGD4SybHIfTj0/KvUV
         ZQ+weJEanW5Revfd8F3k/nnUcUZPYovSFW5UHQwAhfVYpxEpR68uwf9H9rBAzqu1uafI
         ImX+qxApHTzRJA6fEvrKeiQrJoE7yfHCptmlQtDPa4EHRNwdGkVACmpFTeDNNBtfl/5+
         XoJjde03OWIBwf49hTJzcJmWaPshJ5qft8L1Ui7PzK6JC9zYWuTs/NB5P3MJlma8wEWL
         Esfg==
X-Gm-Message-State: APf1xPBjiZcjY0ifNCfKgZ2sGnyY7gn5DCxgBpwXww5xjxzyw1ZY4gx7
        vpGS0lhWCZ1iitKw/8mIgpz0E5jBXOY=
X-Google-Smtp-Source: AH8x227mXUYcFO5i6oUS8unUVD94evxD2T08/BdYD+G/MeL6pSRdJCh+4ytOHRhtD+FrrVTCr+6rUA==
X-Received: by 10.101.83.194 with SMTP id z2mr1305263pgr.133.1519178107527;
        Tue, 20 Feb 2018 17:55:07 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a22sm28030069pff.119.2018.02.20.17.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/27] sha1_file: add repository argument to stat_sha1_file
Date:   Tue, 20 Feb 2018 17:54:20 -0800
Message-Id: <20180221015430.96054-18-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the stat_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 811ed9e53f..ed297773e5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -874,8 +874,9 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
-			  const char **path)
+#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
+static int stat_sha1_file_the_repository(const unsigned char *sha1,
+					 struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
@@ -1181,7 +1182,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1395,7 +1396,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(the_repository, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.16.1.291.g4437f3f132-goog

