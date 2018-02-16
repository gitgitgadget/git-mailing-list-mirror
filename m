Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0908E1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162382AbeBPRqs (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45103 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756565AbeBPRqn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:43 -0500
Received: by mail-pg0-f67.google.com with SMTP id e11so2942859pgq.12
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FpT+2K1boDsSabVWHFHOrFuUSDuOHF2qfSHnMWd/MaY=;
        b=I6LCOkYQe96HHEgIHFGVgXX7niqeGEo+IL6SZf6LK7PPFJNW/9bppqpB9AutsSpxrA
         fBoUn1ZBkNg3V8eiBBtf4AqXj7BygrqBVIt/Bp7Lj5E2VQy2C3lF7jcpNUmT0VZA8+9E
         frAmBr2vYb16BMgjeivHFpmBRSK2Xjf8uARycf68SaIO2bODzc1VrX9gECd7D9cCaNa+
         3ss/eZv2fx9gSkEfdxwnRZQPkUvV8ISsbhO4ORdulwcxWomoru7qD9W7/Bn2h35oflb5
         5MGaK37j/JE7jYKn9GdAIoGJl5JkzEwAGwdx/+UsUrhRB0jTZKmzRIwx3qtmnsVKFVUX
         Wftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FpT+2K1boDsSabVWHFHOrFuUSDuOHF2qfSHnMWd/MaY=;
        b=ZpBBQ2/XMBDDuzAzeOfIt3TQa01FS/KzyTCv7s2pzMdMKuu+iSDzRHQQhcF+f5cuH8
         6CAcCEUGwVU6ed4Wbl1gsLgvYw6e3amee9XM8ABE4YBYvZFXCKrsHKFyhN4qtlmOX9XW
         FF/tQvA4r1kd31KS79kD+3Fm1QDvouDsaNYWm7RlFwb4Q1x5+p1upGeYnBgnqh74mYHA
         bEwRQTDg2S34UfCfGQIcf4uoxLYD+ekXkZXE9jalchv0NwUXtj9HjFhDKTFdyNO8+t+a
         o+BQqTlfCDxgub5VLmIA4wPuDj5dH5xE4iTPV/CCjVTsFODXZYMkwpnFEpTWg1GEjeUt
         7osg==
X-Gm-Message-State: APf1xPCvrowhmXuaYlbwaZPJKsy4553PG0JJpYRkQgs5jep3wCLNwezc
        ZqzppWI11sfdcTGqm5EUEKjbvg==
X-Google-Smtp-Source: AH8x226gDNsrYcRTJCLWTPF42Mnv4TuS2JT/krhibbfWwEKfvnpY56UQpL+4PKxLqgvJnLOrt7LEzg==
X-Received: by 10.99.174.69 with SMTP id e5mr5785140pgp.269.1518803202783;
        Fri, 16 Feb 2018 09:46:42 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f190sm21718695pfb.158.2018.02.16.09.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/16] pack: move prepare_packed_git_run_once to object store
Date:   Fri, 16 Feb 2018 09:46:16 -0800
Message-Id: <20180216174626.24677-7-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 +++++++-
 packfile.c     | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 024ccc91e9..794cb0af59 100644
--- a/object-store.h
+++ b/object-store.h
@@ -22,10 +22,16 @@ struct raw_object_store {
 	struct alternate_object_database **alt_odb_tail;
 
 	unsigned ignore_env : 1;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
 
 #define MRU_LIST_INIT {NULL, NULL}
-#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_LIST_INIT, NULL, NULL, 0 }
+#define RAW_OBJECT_STORE_INIT { NULL, NULL, MRU_LIST_INIT, NULL, NULL, 0, 0 }
 
 void raw_object_store_clear(struct raw_object_store *o);
 
diff --git a/packfile.c b/packfile.c
index 511a2b0cdf..a8a2e7fe43 100644
--- a/packfile.c
+++ b/packfile.c
@@ -884,12 +884,11 @@ static void prepare_packed_git_mru(void)
 		list_add_tail(&p->mru, &the_repository->objects.packed_git_mru);
 }
 
-static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
 
-	if (prepare_packed_git_run_once)
+	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -897,13 +896,13 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
+	the_repository->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git(void)
 {
 	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
+	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
 
-- 
2.16.1.291.g4437f3f132-goog

