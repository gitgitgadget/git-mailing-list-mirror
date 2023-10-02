Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3335EE784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjJBCkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJBCko (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:44 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE8C9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fd60f40ebso60581639f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214441; x=1696819241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXaIo4l7bppGgbiSoswt2zYWU1XZwpLqCFOmAhHkfkE=;
        b=dC3eoVOVnYExj691ZTUbtZKxoLWJvuYlx0nz//7FwGhiscEeZdHWdqJRtildB695uf
         LFima/IPKSABtp97OcQAkgs47OZjsP9TnWW1J4HrJVkRwDB8UifCyDKg4n2Ve0g4+Xyk
         cWv19IVezS356WSi09jR8NSUCk3MzhqWL9f/u99arVwgwhaBd/YeRBAA1Ywv6AAPm/d4
         Q2YqzhSTy6QbfCwt1VEU6ymwViYJ+jxYLeIbCom0bw+qGbX15GTyLHy34Q5VL6EtZgYg
         OuPUCz58ZgHD6/TkAyZ4YX9T4KrnJKPR39qIOF2VXxEv62QNiE4JtInPMXrqX2BGuLLz
         WT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214441; x=1696819241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXaIo4l7bppGgbiSoswt2zYWU1XZwpLqCFOmAhHkfkE=;
        b=BGzVo/KkdWFkHKzLwOxmHXc2mBYBkwkg9JHSwtx+wvgQNvfsZiXq+gojicqwqG6q5+
         fjKCbHpL5NKt5nR57XfsLMyyemguXnaNwqPcujaFYB4Lvn2LgHmwie7O3pSyfz8sK6N7
         XCFAwBBXAF4HKo5C1vkiZaGa+WNUV6eZxt+7C8VFsaV+Uf2CM7ktptewX++o59OKgM+e
         4CY9iUi+7SEb27NlSjbVuz6FkTilc9yaiXLw7uV0YPTp8RsZmPsskzSNQyOgmgw5s7MO
         Pwzym9LTHcf2Oy0XLCQ7wswOO1VHJAQtk1lwUsbZ24rVzysxy2y2rqOMN0GySNuf62q1
         Jv7w==
X-Gm-Message-State: AOJu0YwyvCDtZVM1VdtkzoQjAts7ru2fjCNnUeJOcr3Rn23d5qlBFxCb
        xVNuBqpqQouzQfA5JzaRC8I=
X-Google-Smtp-Source: AGHT+IH9TTUyjJQ6oB2DqUv9fUwlVmkzqpAi8e7x31M2r3J8q2s+SnMNuYEYv1mdiBzr7HH8BYUfuQ==
X-Received: by 2002:a05:6602:2577:b0:790:b44f:b9ee with SMTP id dj23-20020a056602257700b00790b44fb9eemr8016568iob.10.1696214441615;
        Sun, 01 Oct 2023 19:40:41 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:41 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 02/30] oid-array: teach oid-array to handle multiple kinds of oids
Date:   Sun,  1 Oct 2023 21:40:06 -0500
Message-Id: <20231002024034.2611-2-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

While looking at how to handle input of both SHA-1 and SHA-256 oids in
get_oid_with_context, I realized that the oid_array in
repo_for_each_abbrev might have more than one kind of oid stored in it
simultaneously.

Update to oid_array_append to ensure that oids added to an oid array
always have an algorithm set.

Update void_hashcmp to first verify two oids use the same hash algorithm
before comparing them to each other.

With that oid-array should be safe to use with different kinds of
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

