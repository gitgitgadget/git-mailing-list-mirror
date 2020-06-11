Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30BCC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7875A20760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgmw7fXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFKMGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgFKMFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DAC08C5C5
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q25so4808384wmj.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLlJTaNl6hMATl6VGkHQHEYRagKeJBNEb4tJvPE4YjY=;
        b=jgmw7fXSe9dYX8LQmB/gvlpiMhTz5cNn4U3TkeuaAQTnqw4wBM9BhD+0FDpUavLlW+
         Rz0geVIoHCyLEfKjHhV0W9Rr5o8nh9UbBNvADyYneWeAZwyzrxa3U7/lbb1uZEvIQOLh
         iNppTyhBvoVJ8RajhzkmSEHFw4ot9OkzjNy+qnuEN11dSZYqTJmNaiNW05NsAazoBdt6
         6YnA0wRvK8odlqRHcTgZxx6jtmhai/KQ9vsdD/Uj+JQ5HCDyoIELptCbQ9GxezbVkdf6
         OJJ/XW7sE2hB9mYKasNxPDYsg42/UimkMaF9RsmQbhkNJXo5pPfYBOdaclIL/otezK0k
         rd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLlJTaNl6hMATl6VGkHQHEYRagKeJBNEb4tJvPE4YjY=;
        b=D3Iihf1F4xyuf3I/WQDLnKkpIGS2hNvNTV34wTAOe3I9a7aPc0k96Ymad5LOFRonq3
         7asjHnrVgz1Kyq58Sz4kQjOrW2ueR2eQ9oUHAH5U70OUiPYyPTShnjV9/kRrZLTa6inD
         0JdcMttX+/kUnYvbqguDLaPpE1W2R8aOb+ms2ML+cK2Av8NmLG2yeSVQOCGXOHTc+Hpw
         JmKPlfT85pAAN+alL6Lg4x5Ravi9nkgU92GR4eVWWD/vHpePBnGN3Kbu4TMstSv8lse5
         x1o8Zqcp4DVlDURrl8pp7zFfU2keOI8As7J+2xU5j78gFiqVeTWm5zNg/pG5PpCxEUzv
         rZyA==
X-Gm-Message-State: AOAM533ALlHr8PuzgX+LgG66uYqmgKFQ7+8zhtublru5kyXUHqOKgWbC
        dkNKzQKh3d5Vvenx5JKuLuqD+afrgAU=
X-Google-Smtp-Source: ABdhPJzcVFAQo+XR9Sycg07RF36+NH2fgI7UfBVEWYKdmr7r8/1IM9NbY3LAhi3GqRkp29ERPTGwzQ==
X-Received: by 2002:a1c:2644:: with SMTP id m65mr7827584wmm.178.1591877152163;
        Thu, 11 Jun 2020 05:05:52 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 13/14] upload-pack: move oldest_have to upload_pack_data
Date:   Thu, 11 Jun 2020 14:05:17 +0200
Message-Id: <20200611120518.10771-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200611120518.10771-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200611120518.10771-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the 'oldest_have' static variable
into this struct.

It is used by both protocol v0 and protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 6729c17cf4..3d331bedfa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -42,8 +42,6 @@
 #define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
 		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
 
-static timestamp_t oldest_have;
-
 /* Enum for allowed unadvertised object request (UOR) */
 enum allow_uor {
 	/* Allow specifying sha1 if it is a ref tip. */
@@ -74,6 +72,7 @@ struct upload_pack_data {
 	int deepen_relative;
 	int keepalive;
 	int shallow_nr;
+	timestamp_t oldest_have;
 
 	unsigned int timeout;					/* v0 only */
 	enum {
@@ -414,8 +413,8 @@ static int got_oid(struct upload_pack_data *data,
 			we_knew_they_have = 1;
 		else
 			o->flags |= THEY_HAVE;
-		if (!oldest_have || (commit->date < oldest_have))
-			oldest_have = commit->date;
+		if (!data->oldest_have || (commit->date < data->oldest_have))
+			data->oldest_have = commit->date;
 		for (parents = commit->parents;
 		     parents;
 		     parents = parents->next)
@@ -436,7 +435,7 @@ static int ok_to_give_up(struct upload_pack_data *data)
 		return 0;
 
 	return can_all_from_reach_with_flag(&data->want_obj, THEY_HAVE,
-					    COMMON_KNOWN, oldest_have,
+					    COMMON_KNOWN, data->oldest_have,
 					    min_generation);
 }
 
@@ -1372,8 +1371,8 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 				we_knew_they_have = 1;
 			else
 				o->flags |= THEY_HAVE;
-			if (!oldest_have || (commit->date < oldest_have))
-				oldest_have = commit->date;
+			if (!data->oldest_have || (commit->date < data->oldest_have))
+				data->oldest_have = commit->date;
 			for (parents = commit->parents;
 			     parents;
 			     parents = parents->next)
-- 
2.27.0.90.gabb59f83a2

