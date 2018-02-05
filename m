Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8407A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeBFAIB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:08:01 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38161 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeBFAH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id l18so137958pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yp5HVby14IeTBrzMbRAAlFPz7/RIRUuFcYjv/Ol3tQw=;
        b=H6Hb6rmXYVBpExQu9IGZcsPwoNbZTMLG40haoDasss2ANLoijzHTypRh4nbP8ci0fL
         4T29PE6YvhDc8FsCy3V8K2fQ2wICHUv7NMT6YB48eoyo8ePAEdLJDbSHTxhOv4LvpcWv
         TGC/kGulAR9v84Jqmt9i5o0b95fXymueI29+A7B/dObPGz6WGVVVxJpWqaK/k7ytt0JW
         sMqnr9ASWN2Cne9W7vPmIHaHDEWMDUGnb3wdfUNUkfRjSjUueilqeBo9FKWuvk64xaW/
         pVanaB+Jy7AG2mrGMmdxS7XEM43BtYXxQuUTzoBaAnyO4a00xfcAtE5aw1OkC4J6jEJB
         goUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yp5HVby14IeTBrzMbRAAlFPz7/RIRUuFcYjv/Ol3tQw=;
        b=M2UsxO2+uoAx5KXT7bOsi3HcKPN3uEeKWbhlTcOieg/EHrM2vtjD66AYddlJ3H5MGy
         xbfm/DrpWKG9O2GcNZws63Te+JCOa/Y5S9eMqjJb/cncmkHAYPrIKubwHp4YEz/rICQG
         52I5cm7yETfehu0ytLtV1ght+1crcpD/8HkEZN6zQto9tuXqy8gwi3RRsfw5rFkcFbFj
         +61UWVu+1QmpmERDP+RoQet0VIWBIx8PpUtkxyvhrDdqWMMUIg2SQUBjeHnfTziGjfQG
         2Bwe17M5M4Kcurcq8WQ1tcJta3uftkV3gkL5nZkw/C1FyndF9UyQpFynnAqHBH7xwjwL
         /PeQ==
X-Gm-Message-State: APf1xPDvVRZG3pD9pSvobQWCiwn3OUu06u2/evXnZYC/0umc8jUduQTh
        EguwcZafzwinFMwbSL+w9Tg3naWfcY0=
X-Google-Smtp-Source: AH8x224c8KdJHLeqQILUJugeXFQdZNL5vohK/icoWc/ItWltbkt58/uLoUSbIO372ldeqDVa7aIqwA==
X-Received: by 10.98.144.213 with SMTP id q82mr506508pfk.59.1517875677138;
        Mon, 05 Feb 2018 16:07:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h11sm14660791pgq.91.2018.02.05.16.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:07:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 066/194] pack: add repository argument to retry_bad_packed_offset
Date:   Mon,  5 Feb 2018 15:55:27 -0800
Message-Id: <20180205235735.216710-46-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of retry_bad_packed_offset
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index a1c1b1a42e..66391b8a6f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1082,7 +1082,9 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
+#define retry_bad_packed_offset(r, p, o) \
+	retry_bad_packed_offset_##r(p, o)
+static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
@@ -1131,7 +1133,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
-			type = retry_bad_packed_offset(p, base_offset);
+			type = retry_bad_packed_offset(the_repository, p, base_offset);
 			if (type > OBJ_NONE)
 				goto out;
 			goto unwind;
@@ -1159,7 +1161,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 unwind:
 	while (poi_stack_nr) {
 		obj_offset = poi_stack[--poi_stack_nr];
-		type = retry_bad_packed_offset(p, obj_offset);
+		type = retry_bad_packed_offset(the_repository, p, obj_offset);
 		if (type > OBJ_NONE)
 			goto out;
 	}
-- 
2.15.1.433.g936d1b9894.dirty

