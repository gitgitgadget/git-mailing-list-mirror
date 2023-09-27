Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C14E82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjI0Tz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjI0Tzz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:55:55 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0257114
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fb70402a7so294042739f.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844552; x=1696449352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKRqigMmBJjt+jVVA0IpgumX4pWEUQkfZwHO4CKzSaU=;
        b=SdAzkteXgf4kb3EYLSAztXqgTenz7Y04NYOk89UHTqvjz1Xyp4pQLGRbEhp5aoCf3o
         ZJbfcuZURILb5j3Y/d1ZPvZM2900OUwYHaJ8miyaifAbo/2YWjy/3ta+c0EtRBLC45FH
         akPZODOPAYLx/gOjuz46hqC9rIjLqVkxfbmtNKfFKgskmOaVLFsbFJtgjBYRbQmO3yES
         elw/ArO4IZ1USy3R0O9ZOK678nwKWJOfzPPqe8IIyMNu244XginrzfljAIy6yFRsr2Ea
         +Iam2EHQ+bA05hxV7GsKTrWCVjJCT4FUTDzUknsjv+1M5UWhIMlt7tkrpieXhzp2nqZU
         ndew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844552; x=1696449352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKRqigMmBJjt+jVVA0IpgumX4pWEUQkfZwHO4CKzSaU=;
        b=kr/ClcDMIEPTztbPIlvIuu3mIntFA21RE9Y6vNItXLRPXJdwlwRQJljpBnnu2RTkhZ
         bkIBr8xIwqA9bJXBlQNNzigPQCNZMZN8j4058M6CQAnCnWhg4unfdD1niil8tE3sEQUd
         QYRwf4jWTwQZmjD1LOWn+0x1vgyYEYz1MMofq62hT6KQD8lhmKDQRSdy/xFPUrleL9Hh
         6Hq0Z1k/Vu189VlgWUpQJR3cUZeOGIqf4EbUBZ3rW1TDfN/1kk1xd2ICJGl0SRoM3UtP
         1YCng0vfLFQ4emzld7hSm9ePsxUYPBCEG4SybEhGBUYqrwUOJsmnDPFbQFtUGkKNEp3j
         NA+A==
X-Gm-Message-State: AOJu0YwjhEafA9D1aPeepTw75WZWndaUKiGT2kjaMUYMsZXFL/g0oETV
        preW9sH6iuHckXqbhqopUV4=
X-Google-Smtp-Source: AGHT+IFeS2lbywd2eWZoIlw8tJnWosFjWhuwGNOTsS9MenJFgHMpv5VfqZoLuypLm+WlXJOpxoysvg==
X-Received: by 2002:a6b:ea0a:0:b0:79f:9574:b93c with SMTP id m10-20020a6bea0a000000b0079f9574b93cmr2949717ioc.0.1695844552031;
        Wed, 27 Sep 2023 12:55:52 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:51 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 02/30] oid-array: Teach oid-array to handle multiple kinds of oids
Date:   Wed, 27 Sep 2023 14:55:09 -0500
Message-Id: <20230927195537.1682-2-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

While looking at how to handle input of both SHA-1 and SHA-256 oids in
get_oid_with_context, I realized that the oid_array in
repo_for_each_abbrev might have more than one kind of oid stored in it
simulataneously.

Update to oid_array_append to ensure that oids added to an oid array
always have an algorithm set.

Update void_hashcmp to first verify two oids use the same hash algorithm
before comparing them to each other.

With that oid-array should be safe to use with differnt kinds of
oids simultaneously.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 oid-array.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/oid-array.c b/oid-array.c
index 8e4717746c31..1f36651754ed 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -6,12 +6,20 @@ void oid_array_append(struct oid_array *array, const struct object_id *oid)
 {
 	ALLOC_GROW(array->oid, array->nr + 1, array->alloc);
 	oidcpy(&array->oid[array->nr++], oid);
+	if (!oid->algo)
+		oid_set_algo(&array->oid[array->nr - 1], the_hash_algo);
 	array->sorted = 0;
 }
 
-static int void_hashcmp(const void *a, const void *b)
+static int void_hashcmp(const void *va, const void *vb)
 {
-	return oidcmp(a, b);
+	const struct object_id *a = va, *b = vb;
+	int ret;
+	if (a->algo == b->algo)
+		ret = oidcmp(a, b);
+	else
+		ret = a->algo > b->algo ? 1 : -1;
+	return ret;
 }
 
 void oid_array_sort(struct oid_array *array)
-- 
2.41.0

