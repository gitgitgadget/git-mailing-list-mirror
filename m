Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F8BC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 13:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbjDZNPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 09:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbjDZNPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 09:15:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9559E5
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:15:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b46186c03so8366640b3a.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682514919; x=1685106919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2B9iSqIUnxzQkQskMtn+VULQ9s0fec1cXZqhvKqJEA=;
        b=Bfye4MJivr1K+3xGFRrDSZdHOVC+JkGdMsUp3QgW3j1Ke35KUguh2wo9iT6fk4rMsS
         gjcyWvQI4apy4e85KI7cMTSA427W1LHRiDYZt+ju72z6BRVBLR/4+6D/iTJJwGLZ4ZKC
         x3DgaFTdKvx1fDFT4JX+MLuJL761WTgE3t7HXJcL7YL0vO3Nor2H6INN6myxi3u7Arud
         sR0Dk3sU8CiOA+vrQT3VIFNFVBh1miXX39F6MUkpSqB3PEtYZJN9NXzsVXH0eh7PXzgm
         +dmHSHFECbHe2UpU/3MwM1VnbQcjRpG8r/XXntbUD5sqq/OxalmsLm/VZ2txXd1oxxLi
         m1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514919; x=1685106919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2B9iSqIUnxzQkQskMtn+VULQ9s0fec1cXZqhvKqJEA=;
        b=km80u2sUctxH8J4K56iSuGVoIyrJMhiZ9dLXqkQWcEUElFCKOR0zFQxzEob91gUd5w
         RUMt/bpf8pEeoz7mJRC+pL511XEgPribzWXH5YIByV1ASyk59l7eEc2wvYE9V1sQrWMI
         W5hkJ5giCdWxthYyKC8mMXE9voIILhkTvEgm73RKcpOfzgQtX3aj4dfGYlMiDZ/RdrVY
         z3uk90hl3S8yFvuwqBskqM1eArctbtMTX8LYJNNnwsg10qSC5gWfjryVBIGZt8LSKeKM
         rSl9XqpClfpAa/7qb9rOwJMeWXwdvTNTnRGja/R5V/zvTdLifecxCzoZ02vDIhp9/vO9
         N9Ug==
X-Gm-Message-State: AAQBX9e8p6kgx2YNe4vkr/pOl+jKnC5dxDlVlvP5LX0DQvtQDZuFM5hW
        t6N2f3KAQnBukQLFZkT9ioAAbGgeHUPf613q2cI=
X-Google-Smtp-Source: AKy350aBRnuXP1wWtfcTZrfXMrV2VLyx8qV8G3BDi2zB8vLITDWm/cd9eMtmHLnHos23oKW4816/5A==
X-Received: by 2002:a05:6a20:2583:b0:f2:c2a3:3b4 with SMTP id k3-20020a056a20258300b000f2c2a303b4mr20586377pzd.41.1682514919309;
        Wed, 26 Apr 2023 06:15:19 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id m9-20020a629409000000b00639eae8816asm11173693pfe.130.2023.04.26.06.15.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Apr 2023 06:15:19 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@bytedance.com>, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] negotiator/skipping: fix some problems in mark_common()
Date:   Wed, 26 Apr 2023 21:15:04 +0800
Message-Id: <8b5c92a4d5d0927320f1e5fdb0136952f41be21c.1682513384.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682513384.git.hanxin.hx@bytedance.com>
References: <cover.1682473718.git.hanxin.hx@bytedance.com> <cover.1682513384.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mark_common() method in negotiator/skipping.c was converted
from recursive to iterative in 4654134976f (negotiator/skipping:
avoid stack overflow, 2022-10-25), but there is some more work
to do:

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
 negotiator/skipping.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index c7d6ab39bc..6a5450b460 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -85,29 +85,37 @@ static int clear_marks(const char *refname, const struct object_id *oid,
 }
 
 /*
- * Mark this SEEN commit and all its SEEN ancestors as COMMON.
+ * Mark this SEEN commit and all its parsed SEEN ancestors as COMMON.
  */
 static void mark_common(struct data *data, struct commit *seen_commit)
 {
 	struct prio_queue queue = { NULL };
 	struct commit *c;
 
+	if (seen_commit->object.flags & COMMON)
+		return;
+
 	prio_queue_put(&queue, seen_commit);
+	seen_commit->object.flags |= COMMON;
 	while ((c = prio_queue_get(&queue))) {
 		struct commit_list *p;
-		if (c->object.flags & COMMON)
-			return;
-		c->object.flags |= COMMON;
+
 		if (!(c->object.flags & POPPED))
 			data->non_common_revs--;
 
 		if (!c->object.parsed)
-			return;
+			continue;
 		for (p = c->parents; p; p = p->next) {
-			if (p->item->object.flags & SEEN)
-				prio_queue_put(&queue, p->item);
+			if (!(p->item->object.flags & SEEN) ||
+			    (p->item->object.flags & COMMON))
+				continue;
+
+			p->item->object.flags |= COMMON;
+			prio_queue_put(&queue, p->item);
 		}
 	}
+
+	clear_prio_queue(&queue);
 }
 
 /*
-- 
2.40.0

