Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E0C1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932667AbeDWXnm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:43:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42108 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932749AbeDWXnf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:43:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id e12so9453826pgn.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GBRfOUXFw/96BGE414fyNavYUkINQi4M4hDlT5yoX2k=;
        b=fnP4Py0KiMe1M1/W/DxSNNKim1dYtqhwJnRDTKHspWxP8UGkFfp5GcCKl7UNIsGSdD
         A2JJRDlUxrJNDkl89c9UjgVGcBJ5VXCNqNier50f2Mog+MK3HwnIdheU5s1gbR6EU14/
         4C9NdG/kxNW3P8Tw38gt0uKQmhFk78i5boDJSwcpnMAbVtokGVagapB2s4BSyAy5eWWo
         iuMy548+PxfSObXZaggt5mffx+PDSoJvpxhQFXwTQwMCXuGwNg+WlyQfbV9SjE2yMMKo
         KQSIrlr4hwzD+ylDL7giuLZq94Y41mOOm6Bf96hUw0ZkL9wdnrL4m8zMVLHg0LEw8IdC
         Vycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GBRfOUXFw/96BGE414fyNavYUkINQi4M4hDlT5yoX2k=;
        b=SQDtjySLY1jAYM1P28bBJvxpkJsaI65UpV7ONZcDvB5p1Rfpj1Rti62C3p3RnILNUH
         2uP5P/N+lGtDK0Dtg+dG3BIuup50kwczCpRJmdbyLH5hKOF6bC6QZk8X0zDkh2nOJfVt
         W1XOfeaxr5sDFS3vffYSvIGelkeDY3oiL/cr43zVn7Vx0EBZ0TlFK87bKfivtd6+sFyk
         PyCY0vhTImq/cowNpmMqL66zL13G3vAU9gIudcylAckug8a3PE6UNh2BRo5Axodve7Jv
         2Q+zH2HBzC+2FsdlMzIYpSvPZsTr3CBDoCGfTYQ1ysjoE52PGJ2L8kgFv93IH9l2pzkN
         nfGA==
X-Gm-Message-State: ALQs6tCEa9q18eJIBbquhN9chI5NZRPF9NnbAqqDX6KEyqvbLQlyMR0A
        SjoFUntcz4h9GmOh9U0P8a6vasJTqJc=
X-Google-Smtp-Source: AIpwx49uhrcxhrp36zVMO22RKVKS0Nq5FaNUZMIA70/w8iEznkrujiOjAvAXfaojD17nTBQwkBuvwg==
X-Received: by 10.99.127.89 with SMTP id p25mr18477171pgn.440.1524527014653;
        Mon, 23 Apr 2018 16:43:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 85sm24427140pfz.155.2018.04.23.16.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:43:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] packfile: add repository argument to retry_bad_packed_offset
Date:   Mon, 23 Apr 2018 16:43:21 -0700
Message-Id: <20180423234327.250484-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180423234327.250484-1-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
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
index 80c7fa734f..d2b3f3503b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1104,7 +1104,9 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
+#define retry_bad_packed_offset(r, p, o) \
+	retry_bad_packed_offset_##r(p, o)
+static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
@@ -1153,7 +1155,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
-			type = retry_bad_packed_offset(p, base_offset);
+			type = retry_bad_packed_offset(the_repository, p, base_offset);
 			if (type > OBJ_NONE)
 				goto out;
 			goto unwind;
@@ -1181,7 +1183,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 unwind:
 	while (poi_stack_nr) {
 		obj_offset = poi_stack[--poi_stack_nr];
-		type = retry_bad_packed_offset(p, obj_offset);
+		type = retry_bad_packed_offset(the_repository, p, obj_offset);
 		if (type > OBJ_NONE)
 			goto out;
 	}
-- 
2.17.0.484.g0c8726318c-goog

