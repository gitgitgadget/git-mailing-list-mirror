Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF8FC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 09:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbhLCJjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbhLCJjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 04:39:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967ACC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 01:36:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so1985001pjb.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 01:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5JudBKYEm4k2ej1j7f2t6+wlXtYbrLm19orpVsDdgw=;
        b=lTO5khGw6yg3WuQomUcernM/QxLBfKZaXvLy5AWu6loMePLCLycqbqTy+VRZxbHatw
         qQTU7Da6GXRIdgWMlmVXpkNkd1jTwZemcQbH/PzGJjJBGKu8htm4w9Y5ZSb0ZT7p7SRM
         QdY3ppAXIvLZ0glGh1DJNRfpX77ESJ4BEeZxFgoJUA+y6Ydit7JIhRJNBfLpWcyCkGAy
         uBnR5nH4vWnVrGrZKqlDIXSTWZZ13KVqoFuKB7aJwSZUx9WZFln4ZAi0FJ0XQAJFxNVv
         l5zNfwYYkdRaD1SyssJIJu5/QwWFJQ4bJ0vOrjARZ8rZ0pfWgrtmkPj68rMsGmQQHYGM
         w2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5JudBKYEm4k2ej1j7f2t6+wlXtYbrLm19orpVsDdgw=;
        b=w7xfCv0qindE3CMLAOIOMRwblKyNf4mIrRX9FVg647No5+vpi56Xl9jUQczQ8dI7qG
         WJUrxU1G9IE5Y0Uzzfh6xJZfXzyEoYneZEmEmLzEFHfOvXiT/NPlQ9HXLhJN3ndBfMRa
         4OXKiDsijF7sG/15+5SREx1WTM5YGSIQhlC5I5YYaQ5C1SHxG43AIEWc8ybv5HewcVNs
         4S4WaOkuiNLhwv2q2AhXL0aQufwRD7XnQc4rw4NuBhOQ+R5HzBZgDogtq9z04CsUizkx
         Gq+O+Mrz5hoRNLxeFH586Mk6sj9WlqDHG4ZYFzCGh8YtXjM8gtEL0SgVoNWd+EMrZUX8
         riFQ==
X-Gm-Message-State: AOAM530oGGn2Z8uk7GbJ58QVTxUqMJN864zVOROrQPFEYAH6jPSge5a9
        vLc2Cj4qOORf7WzYk2sigV0=
X-Google-Smtp-Source: ABdhPJy4lhJe8z+3RuXLXknxl/vEweKnwUeOcWzroqFBCRaZsJ8EJwy4qFEAmrnbnD0AI3OwikGlHA==
X-Received: by 2002:a17:902:cecf:b0:141:e15d:4a2a with SMTP id d15-20020a170902cecf00b00141e15d4a2amr21626048plg.66.1638524176205;
        Fri, 03 Dec 2021 01:36:16 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id g9sm2708142pfj.160.2021.12.03.01.36.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 01:36:15 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v4 4/5] unpack-objects.c: add dry_run mode for get_data()
Date:   Fri,  3 Dec 2021 17:35:29 +0800
Message-Id: <20211203093530.93589-5-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122033220.32883-1-chiyutianyi@gmail.com>
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

In dry_run mode, "get_data()" is used to verify the inflation of data,
and the returned buffer will not be used at all and will be freed
immediately. Even in dry_run mode, it is dangerous to allocate a
full-size buffer for a large blob object. Therefore, only allocate a
low memory footprint when calling "get_data()" in dry_run mode.

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..8d68acd662 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,16 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
-static void *get_data(unsigned long size)
+static void *get_data(unsigned long size, int dry_run)
 {
 	git_zstream stream;
-	void *buf = xmallocz(size);
+	unsigned long bufsize = dry_run ? 4096 : size;
+	void *buf = xmallocz(bufsize);
 
 	memset(&stream, 0, sizeof(stream));
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -124,6 +125,11 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		if (dry_run) {
+			/* reuse the buffer in dry_run mode */
+			stream.next_out = buf;
+			stream.avail_out = bufsize;
+		}
 	}
 	git_inflate_end(&stream);
 	return buf;
@@ -323,7 +329,7 @@ static void added_object(unsigned nr, enum object_type type,
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 				   unsigned nr)
 {
-	void *buf = get_data(size);
+	void *buf = get_data(size, dry_run);
 
 	if (!dry_run && buf)
 		write_object(nr, type, buf, size);
@@ -357,7 +363,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (type == OBJ_REF_DELTA) {
 		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
@@ -396,7 +402,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		if (base_offset <= 0 || base_offset >= obj_list[nr].offset)
 			die("offset value out of bound for delta base object");
 
-		delta_data = get_data(delta_size);
+		delta_data = get_data(delta_size, dry_run);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
-- 
2.34.0

