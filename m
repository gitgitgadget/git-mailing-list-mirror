Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA071F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968580AbeE3AtL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:11 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:43313 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968089AbeE3As5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:57 -0400
Received: by mail-pl0-f43.google.com with SMTP id c41-v6so9940340plj.10
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SmwRml8ynmO5obJRzKmaQj8SceOerpt4acvg3yw76MU=;
        b=VmjKBf72Teg5Bfv9kOnWigxm9eHTHmuEsid3QNT6osWHM/Alwrt+Ruy57YPc5Sscub
         au9roc8M/4qBG+l61xiBNoP1wA0uljI8H8yk1G/YwzgXwqgx8cDNIfunlwmoMj8FQB8Q
         MG7zvldPM/UnmLy7CYyr9jc26Cu7LHG+d1cA/7tHtsRMJW4GqQAk0ikyMh7WchBbgMVi
         AuASdvcQqRh5SNVpJAwSHVOKOzRSZvR4MTocLvwpq3odP8s++zW6nvFhoEDw/kEiujLV
         VpKqq+22ULfp0UNCt871S8+CZYo8X+ZWF58gXa7n4lacq0t1fofO9H/qmd5jFy57xf17
         xldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SmwRml8ynmO5obJRzKmaQj8SceOerpt4acvg3yw76MU=;
        b=riFCy+QUbQdgHj32zguo6t32ao+kAhTN0rrZpSVaJUe8ZTVfZ3xLtNxpbL+mhUMkZX
         aKmVY9cQ6uGZABj8Y9EXoSC8izDC1Osx0t8eu6nutpEIsx46bK4276D/jvg+/TERjls4
         6T/TVklKXYdpcI605n+f3+GEoLWC2WfWiJroBLcqOJXmbZPwFpKpRdkhgS6dMKmXm1S+
         2AqPWZZaFRrWj9jveL+mHl/Wt6SypMPrhPuq61OWub+NFYeW3xcMQ3XoazrvXWW1SIF9
         Ao/nQtB4c4LFQbN/dbaoDVQID3jztrndRsDEulhxAKI419nURl10KsydT4xM43kSZCKK
         zHyg==
X-Gm-Message-State: ALKqPwe7AadnEt5nE0dKIWpp7AOcawNTENIudsv6r0eKcxgBF53aCVDr
        XrAHPaWo8/UJjY0Dt/ajKCY7Zr1ZvMo=
X-Google-Smtp-Source: ADUXVKJWQ9aJ3xmW7YVQADglWN+ElYzVzbixAneuWMmbCKfoZYMAHDlVqT+1+Frk+Dt8tkFF2U4grg==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10-v6mr646243plt.6.1527641335959;
        Tue, 29 May 2018 17:48:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y2-v6sm41796589pgp.92.2018.05.29.17.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 24/35] tag: allow lookup_tag to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:47:59 -0700
Message-Id: <20180530004810.30076-25-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 10 +++++-----
 tag.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index fbb4659325b..46b5882ee12 100644
--- a/tag.c
+++ b/tag.c
@@ -92,13 +92,13 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag_the_repository(const struct object_id *oid)
+struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_tag_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_TAG, 0);
+		return create_object(r, oid->hash,
+				     alloc_tag_node(r));
+	return object_as_type(r, obj, OBJ_TAG, 0);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tag.h b/tag.h
index 45b0b08b1f6..6a160c91875 100644
--- a/tag.h
+++ b/tag.h
@@ -11,8 +11,7 @@ struct tag {
 	char *tag;
 	timestamp_t date;
 };
-#define lookup_tag(r, o) lookup_tag_##r(o)
-extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
+extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
 #define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
 extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
-- 
2.17.0.582.gccdcbd54c44.dirty

