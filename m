Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0582C2D0C3
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BB21582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+rlHnQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLRL0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38337 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLRL0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so1479798wmc.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lJGHpJsVA6sbzue4xMRRNCnCN/QUiH09Y1A4kW0pU0=;
        b=t+rlHnQ2aLqnXL+zCJsSGbJa2HzvMbYkSNfjBKFppDMNDArzNPaPK1HNOq3pDP9fML
         b+UX1ZKj9cPJPez4ju0/qtquUOE9tqVYGHAUoK5YMaz3EEsNb3Bxmwnm+UfuvhmforJk
         k8tL0MYncBidhOiqMDTbVOlcxBgvBj1JZgxhXMik2PzhwEEKJLBqKTzCXKAYgXvs9Omf
         1nZ4wWYA1mGDTev/7WqY+j6+wBW19yJIU9chSvhI8EmntERVFDfm35nrVhrnCirciKNP
         eGjjl/TKBO5E+ZSqbBgsVUHnw5QZsTaSp1Dg5A0gdhriRMYqpczigzMMxYGIiawHvDMn
         6ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lJGHpJsVA6sbzue4xMRRNCnCN/QUiH09Y1A4kW0pU0=;
        b=s2TgGpE40IShmLKHGcYn4M9sQyzLt9gtG317t6lNuWOlrqoZ15nInCcKbmZSUppjK9
         B/usNe05/PI60mKKvSh9/yENabXNcHox3uSwuawcvHpjVBQe3zMyRES7aYCamJQV77E4
         1bCbFgoLyzg7MyTi/6TpgzmGGwgDcU+42tE4DPXPRafVB/Vh9Ggr4wDPj/wu3B5LJuyp
         /sDMzxYvGax5YJYQK/Tfm4HLHlLh8Nq3MxGq++qaBUdbrAF/PyUFiBUOTlTeWZhpQaUQ
         2aY4O/f7V246sGRJe6znfz5sACFmbG7ImXmD+89r68dOjrz/1jyXgEIscJU1+f9p6ond
         flWg==
X-Gm-Message-State: APjAAAV95TN/G24jjcp46Lj/I1lkgA7KLIORiCZopUmkD8O5vSUSLvMn
        iLSevbQPU1yHxGF2Ix4pN3LcwlW0
X-Google-Smtp-Source: APXvYqwUUWiwlHgPV1igXzd6stUC4H+iSVfPd+v99t4TcH9G2G8VkWZwXnvLnesEe//rbwYfWvvnaw==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr2751364wmc.111.1576668376154;
        Wed, 18 Dec 2019 03:26:16 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:15 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 09/12] builtin/pack-objects: introduce obj_is_packed()
Date:   Wed, 18 Dec 2019 12:25:44 +0100
Message-Id: <20191218112547.4974-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's refactor the way we check if an object is packed by
introducing obj_is_packed(). This function is now a simple
wrapper around packlist_find(), but it will evolve in a
following commit.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 801e23dfe7..43730154ba 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2553,6 +2553,11 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	free(p);
 }
 
+static int obj_is_packed(const struct object_id *oid)
+{
+	return !!packlist_find(&to_pack, oid);
+}
+
 static void add_tag_chain(const struct object_id *oid)
 {
 	struct tag *tag;
@@ -2564,7 +2569,7 @@ static void add_tag_chain(const struct object_id *oid)
 	 * it was included via bitmaps, we would not have parsed it
 	 * previously).
 	 */
-	if (packlist_find(&to_pack, oid))
+	if (obj_is_packed(oid))
 		return;
 
 	tag = lookup_tag(the_repository, oid);
@@ -2588,7 +2593,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, &peeled)    && /* peelable? */
-	    packlist_find(&to_pack, &peeled))      /* object packed? */
+	    obj_is_packed(&peeled)) /* object packed? */
 		add_tag_chain(oid);
 	return 0;
 }
-- 
2.24.1.498.g561400140f

