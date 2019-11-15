Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AABF1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKOOQN (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42110 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so11136732wrf.9
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fgbi3/EefnACkW8uEBLXho5/IwKreRzAADE3NdXRozg=;
        b=dyxalhFBiofs03Ha1dP5Lvf9xCVrzTLwpwqJu055U/9v+QxDhOFTEH+DWpP/Yt4ZFM
         M+IDK1+wAoxeh7XcwQW26b/IiNOFkvVCVJUdVLCG33YqKJ5LO8w22IArYZrAQjv4c6BD
         Zk7z+KoZChPfQnV/EyvErqoHIRSpwYYIU404bSjtbKJR6HEPnyKrt/MJIuerUQ/qpO3x
         lYK5GMwXqgn0Xfy1Nt9ekwRVIgPANB/ijJS13QWG0L5eWwJbJztgo4bp4a6cjdF2SpLZ
         FoXv0/jGUIrq4nGoyW/XFu5WZQC/73a9sd4OhVrLXwE+W7g58YJ0yaLBAQFkKIOvQpFj
         +g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fgbi3/EefnACkW8uEBLXho5/IwKreRzAADE3NdXRozg=;
        b=jAhOvWM0xBv1DSf1bMLKIzS9yxAQDQtZB8cYLSJidLkc0g55xphFj6rurvQiAmDZeS
         BPeRs5tCkuGpswd1YS0lc+hHw+x3YDei9IBFA4fWD4VPy8CIuu3V0lDw/thTckW2RUgf
         fJwN2RHpapz1ZCFcBmhgvli3r88EQ0dIN1zxpXHGY7k4L1bHdcUM61q9I0iP6BABLcbE
         umYE7nniV94i4xcUUWGY/Xa+hWF6Lt2hWTz6MOZr2phM+6R1CVd4ts6CEbRg0mtr6z8Z
         pu191YGgofIwIFfZ99amWlZk0w4SaL53v+EKPWXS1CcVdP4UoBq5hA2vfIN9gJkX4His
         mepg==
X-Gm-Message-State: APjAAAVmiKvu8KjY6vEWEchTGWVfi/pHZnqDgPjyjQcU28ghiFqZHLX6
        Kc8paMRPITs8w45FZGDstv4eOoQ6
X-Google-Smtp-Source: APXvYqyJ3Gitf2sb5ZoZmRowFTjcN55l1l9fUOBReLmykQfW28e5dD82NiURNaSbRrp6C5v7TrW+fA==
X-Received: by 2002:adf:9e05:: with SMTP id u5mr16145935wre.239.1573827368420;
        Fri, 15 Nov 2019 06:16:08 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:16:07 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 8/9] builtin/pack-objects: introduce obj_is_packed()
Date:   Fri, 15 Nov 2019 15:15:40 +0100
Message-Id: <20191115141541.11149-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
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
index 4fcfcf6097..08898331ef 100644
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
2.24.0-rc1

