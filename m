Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9EE1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936032AbeFMXHI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:07:08 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:34950 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935976AbeFMXGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:24 -0400
Received: by mail-oi0-f73.google.com with SMTP id t133-v6so2691097oih.2
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=GhAGyVG/VOMtAwKnUC7mT4/QfR+Lo3p70vJr3qLgSOQ=;
        b=PR/Yj1gEddyI6LJIKElyttNocRaSDdhavYLmIUHWw2+kQrgxgWA7OoGP4H2HK0F6Oy
         H9MoNr5ClpPKKvvuEQxwxsf91e6fI0azd3+v3NzROfXDMENkPKFiNkOIvYq1t6niGAkt
         c6DtkyaO09Jg12ueJccoaMlFuNmcnVaScViuyerD6ZawhFA/zB/3pjghkDLvGhm7HB9F
         4XMTDPcCooWeV4S3lRW7CVRo92yapkfaM7GE/yvSv8TVCelmEBxzm0KWOwuMmCd9o84r
         gnrP7au5ojJbyW+buQbw9ngCSbS1TC7L+ZzMf25v/C4gxAYul0y7H5SXjXBFGroD1euH
         sGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=GhAGyVG/VOMtAwKnUC7mT4/QfR+Lo3p70vJr3qLgSOQ=;
        b=c9VXcewer97XTqDV+jWfy3+9CMQc3mib+aB4TZAYZHPbBl+uVEkv964h+gotdhqpVE
         YAEy6iSNzo4dSLzY1xSVcfMNWznDVdOAWCy0VEygKf4iPAHL5G8Skyj57zDPimz7Lq5O
         3cI7+i6aJa1URbIUtVOlNVvLKyXFsi+UH4JaEVaNd44Qb8qXLucYSEv0hq+W5hkvPB6p
         5xLLQaxongyTdjC2HJfLtNcnCWurG3wMSdNu7VWnmS9bMoMj4RG295ykmpkaUdpwceIf
         cHNxowGKpp5N1Qc33ZuUIfG09ylNNU1UlCJQieavNkrC/wndlA3cWN3dmdXkGhuZJp4E
         lKJw==
X-Gm-Message-State: APt69E22McXn0AKAEi961MANC/iVK7ObbEbPmoHPtr/sewDexEjamvCS
        O71evJZ0Og4EIftsIOi3FhJx6CZRrTlodr5/pQUFGixAWpHbSMYKLTD0Mq/OpkScXQszOo+OgfD
        mjddT5Bz8th8tUibmmT/pgogMaMLJV5VverjkaHWMAoLMePchPNrkZcNuxlr0
X-Google-Smtp-Source: ADUXVKJEdn0TKXkWb0wiSUiFezlHFZuQMbakBQtZGOZX6U62lFBC6UY9hWcD5xs68uGT1zHvQFKr3Bo6YrVk
MIME-Version: 1.0
X-Received: by 2002:aca:f5c5:: with SMTP id t188-v6mr69820oih.89.1528931184052;
 Wed, 13 Jun 2018 16:06:24 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:12 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-22-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 21/31] tag: allow parse_tag_buffer to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index 46b5882ee12..682e7793059 100644
--- a/tag.c
+++ b/tag.c
@@ -126,7 +126,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -154,13 +154,13 @@ int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
+		item->tagged = (struct object *)lookup_blob(r, &oid);
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tree(r, &oid);
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
+		item->tagged = (struct object *)lookup_commit(r, &oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index 6a160c91875..efd4c7da67c 100644
--- a/tag.h
+++ b/tag.h
@@ -12,8 +12,7 @@ struct tag {
 	timestamp_t date;
 };
 extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
-#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
-extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
+extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 #define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
-- 
2.18.0.rc1.244.gcf134e6275-goog

