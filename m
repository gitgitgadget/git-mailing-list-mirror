Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D766BC77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 04:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbjDZEFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 00:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDZEFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 00:05:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F01985
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 21:05:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso5259815b3a.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682481947; x=1685073947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnaYDMTK4V5iwApsUA/FpcvfVX4Opcq4WBYYrQ9kyGY=;
        b=gwlVZpqV75JYU3GZPyIh15Fvw/F9CLdkPekzDyR/QSv+k9A7VUM5Qc+oyNnnAasJwo
         kzwZwy8vPYOJmV8Rizq2lAVFI95KFCdiQQiqRji7INLWDnDKz7aTvBLQnCETAr+ahLcN
         hajeWFCdI37mpqlr5L31+dEMzJCm8qL4VdfHHvj5bTO9VxtYXsiS5rqWk385JKDVu81F
         A4i7Z65EJPY3v2Xqt8f3ISCckQFVM1G0oZJld5MBr9lJleBwXldlOd+fOY8wwua2yL5n
         qWyJD/zdJbiLFSCHSKy0PRc515GPZ0uOcXFbd0rtqRe1zXh77sJQQ7xkrnW89NNi5CxE
         CTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682481947; x=1685073947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnaYDMTK4V5iwApsUA/FpcvfVX4Opcq4WBYYrQ9kyGY=;
        b=WFXvFcyg/wNohnneD0oNCJaSJvy6TEV8olfUP0eFNIm0DuWFCxnLpTG7tBoyOzvAz6
         njDjDTmY6vAj3X/lBhM0xo9RKT2ZGgIqE3zRWKvxWGhJ9HswUIF/JJwHxFJdXmfN74pL
         rN2oKipj8C0SZrG/H8ADWojSVrK5851WUIDNQbmLegpiVGLNpyEGFp67UGcrI1aiUAZY
         hhLB1vCDSi0HGOK8faB/ev/yvIMbXj3sEYBcHH5TKx6Ra3sEecwBK8HqSdzehByP8dsc
         IwDFTibzm7ES/1mNtzuo8ltVd8eE4zs/WBcCH9KDcsanerHsvVAVfwjx92cmWTRqNegz
         YDqA==
X-Gm-Message-State: AAQBX9dfm3iJGSYxSz7eryyb7pjdFjZjrhbgMpMFTu9n/8Lg6u4pmViC
        +dCFrqcg+grMVzlIhRnSClgAHr3lTD2DuZCjpug=
X-Google-Smtp-Source: AKy350a+GVa6fKtPeNkaEUh6oc3y4kgIV8udOLEhpRu4HkFQJXclYwNUETO3pV8m2CChpO+SaHRg8Q==
X-Received: by 2002:a05:6a20:548e:b0:f2:5c65:b767 with SMTP id i14-20020a056a20548e00b000f25c65b767mr23274506pzk.42.1682481947089;
        Tue, 25 Apr 2023 21:05:47 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id t1-20020a056a0021c100b005d72e54a7e1sm10038156pfj.215.2023.04.25.21.05.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 21:05:46 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@bytedance.com>, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] negotiator/skipping: fix some problems in mark_common()
Date:   Wed, 26 Apr 2023 12:05:23 +0800
Message-Id: <abbb1bc0b35d03e13249ec2e5bb8229a0a123685.1682473718.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682473718.git.hanxin.hx@bytedance.com>
References: <20230424022318.80469-1-hanxin.hx@bytedance.com> <cover.1682473718.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed the following problems:

1. prio_queue() should be used with clear_prio_queue(), otherwise there
   will be a memory leak.
2. It does not do duplicate protection before prio_queue_put().
   (The COMMON bit would work here, too.)
3. When it translated from recursive to iterative it kept "return"
   statements that should probably be "continue" statements.
4. It does not attempt to parse commits, and instead returns
   immediately when finding an unparsed commit. This is something
   that it did in its original version, so maybe it is by design,
   but it doesn't match the doc comment for the method.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 negotiator/skipping.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index c7d6ab39bc..b06dcb197b 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -85,7 +85,7 @@ static int clear_marks(const char *refname, const struct object_id *oid,
 }
 
 /*
- * Mark this SEEN commit and all its SEEN ancestors as COMMON.
+ * Mark this SEEN commit and all its parsed SEEN ancestors as COMMON.
  */
 static void mark_common(struct data *data, struct commit *seen_commit)
 {
@@ -96,18 +96,20 @@ static void mark_common(struct data *data, struct commit *seen_commit)
 	while ((c = prio_queue_get(&queue))) {
 		struct commit_list *p;
 		if (c->object.flags & COMMON)
-			return;
+			continue;
 		c->object.flags |= COMMON;
 		if (!(c->object.flags & POPPED))
 			data->non_common_revs--;
 
 		if (!c->object.parsed)
-			return;
+			continue;
 		for (p = c->parents; p; p = p->next) {
-			if (p->item->object.flags & SEEN)
+			if (p->item->object.flags & SEEN || p->item->object.flags & COMMON)
 				prio_queue_put(&queue, p->item);
 		}
 	}
+
+	clear_prio_queue(&queue);
 }
 
 /*
-- 
2.40.0

