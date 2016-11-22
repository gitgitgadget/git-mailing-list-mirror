Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF5E1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbcKVSrq (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:47:46 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35770 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755903AbcKVSro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:47:44 -0500
Received: by mail-pg0-f49.google.com with SMTP id p66so10218448pga.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=j+v8CIOVFmHwddfebSGsUmE7txNc4SJYUWRRc+GvcfR2g56pPgaNDYFQKJiiTlvMZv
         4sdvaHHGYvl4H2ONwQ5gWXYFmHJSwHlvKeeIgp5TQ0MWhsKGK+ZCpzxY0oBduJUZsAgB
         MMb/H8Yy99QyQPxmSkk3STBv4BIe1a8/ouyjEeG5nC9EFlaAZpDhXQ6o6zwffKWSZURM
         7l+B+hrJbB8+Rq3wd4Fxb20XtWL9ivtx//siWhjy5Q812227Ar3kArdGh7eM5vxa43AB
         ihpvi5wdcynoCFk+zCX4MJ6j02E7Ngxmi/hetXXfSpB9aALLlirLSXMIMcZbg16ZxNS/
         KEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=lIuFpvtQIZTlFcaAHrttLUerAbxzyTOfsfH+KRQzXITbmT7iyMFOPhOaxTYTY2vg/k
         2npGR6z6EiIDCI0oWBu1e8XgUQoc4lehBeBlAONXP7XCctPb1s1q4etR9a7uKBdosTfP
         JA3UKr21akxuOyYkRqTdFKgDA9ScHn8V21gDEkhZtpXcFBhzng1Pke2SXHsPGM+6dtNb
         wdAAyNz6qUBX5ffge0ilQfkyC8tCs0b+MPXXQMYlJ3o/PkfO5i8DO6Ph8KhXB4P1swQX
         T8LiB5LCpoYG9KUh3SET7kgyou9CV8th+IekjRJ6RtupirU4dEbxCFKP9rkbAEA2MBnC
         RX1Q==
X-Gm-Message-State: AKaTC01JDtQ/wPdcCNTkdBRSQ+XjYYtlfvOCSuj51UR39lQY2zJhDm5jn4Y4UuArS6wNOiYs
X-Received: by 10.84.134.3 with SMTP id 3mr2435898plg.90.1479840410280;
        Tue, 22 Nov 2016 10:46:50 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id w5sm46932072pfl.31.2016.11.22.10.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 10:46:49 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v5 3/6] grep: add submodules as a grep source type
Date:   Tue, 22 Nov 2016 10:46:34 -0800
Message-Id: <1479840397-68264-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479840397-68264-1-git-send-email-bmwill@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479840397-68264-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add `GREP_SOURCE_SUBMODULE` as a grep_source type and cases for this new
type in the various switch statements in grep.c.

When initializing a grep_source with type `GREP_SOURCE_SUBMODULE` the
identifier can either be NULL (to indicate that the working tree will be
used) or a SHA1 (the REV of the submodule to be grep'd).  If the
identifier is a SHA1 then we want to fall through to the
`GREP_SOURCE_SHA1` case to handle the copying of the SHA1.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 grep.c | 16 +++++++++++++++-
 grep.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 1194d35..0dbdc1d 100644
--- a/grep.c
+++ b/grep.c
@@ -1735,12 +1735,23 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 	case GREP_SOURCE_FILE:
 		gs->identifier = xstrdup(identifier);
 		break;
+	case GREP_SOURCE_SUBMODULE:
+		if (!identifier) {
+			gs->identifier = NULL;
+			break;
+		}
+		/*
+		 * FALL THROUGH
+		 * If the identifier is non-NULL (in the submodule case) it
+		 * will be a SHA1 that needs to be copied.
+		 */
 	case GREP_SOURCE_SHA1:
 		gs->identifier = xmalloc(20);
 		hashcpy(gs->identifier, identifier);
 		break;
 	case GREP_SOURCE_BUF:
 		gs->identifier = NULL;
+		break;
 	}
 }
 
@@ -1760,6 +1771,7 @@ void grep_source_clear_data(struct grep_source *gs)
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_SHA1:
+	case GREP_SOURCE_SUBMODULE:
 		free(gs->buf);
 		gs->buf = NULL;
 		gs->size = 0;
@@ -1831,8 +1843,10 @@ static int grep_source_load(struct grep_source *gs)
 		return grep_source_load_sha1(gs);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
+	case GREP_SOURCE_SUBMODULE:
+		break;
 	}
-	die("BUG: invalid grep_source type");
+	die("BUG: invalid grep_source type to load");
 }
 
 void grep_source_load_driver(struct grep_source *gs)
diff --git a/grep.h b/grep.h
index 5856a23..267534c 100644
--- a/grep.h
+++ b/grep.h
@@ -161,6 +161,7 @@ struct grep_source {
 		GREP_SOURCE_SHA1,
 		GREP_SOURCE_FILE,
 		GREP_SOURCE_BUF,
+		GREP_SOURCE_SUBMODULE,
 	} type;
 	void *identifier;
 
-- 
2.8.0.rc3.226.g39d4020

