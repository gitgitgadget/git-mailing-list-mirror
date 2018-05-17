Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8331F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeEQWww (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:52 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:38786 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeEQWwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:30 -0400
Received: by mail-pf0-f173.google.com with SMTP id o76-v6so2782155pfi.5
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kng7SkoLbcjDsoOnFQ+jZZbQqIoaQSTjrbhHPLFFXwo=;
        b=YSybHwVNokbTkjoVO0p1nkQFj8E08lBdk7+oa1ZrU5nD/3dnB13us+uKMguOd5GYE/
         4nsXmmKNFV2i22PVJcXUVkDXfU6B7BZBO2se5L80/03IA6fzHBSwOH/ATT/qbUxKscu6
         MA5asnXNEkR++49/cAPkqdRYe3V/WuF7OYRrIAcJ5F0rGkqMtvVk6jPurNMPPQ9Yt5Fc
         nunuVkEb8jR+iiBrBaCv6AgMteCtggnZAiWSjqreQ5TjbObZHZkHJlRaNXYDJvAEzbte
         /vUf3W97ew2S4jM485/BKI9SOBN9G8/6ELwLEIAoBQ+Pe3L2vtAV02BkLxBjwqCxozLQ
         1Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kng7SkoLbcjDsoOnFQ+jZZbQqIoaQSTjrbhHPLFFXwo=;
        b=GDY78fl07H4zcX7c1SnQ51U+KouWRNbPZj2eVlHd1RQinUhgylUr0jjO3SUTcmZ0fN
         teTRAmKDX9R+ONWEY1x8/D1MrW6cLImw/1Bt0v54Eo/dQcA+w8+8UhTF5VMwv+enMI3c
         2BCPv2VdMRm+hfUKXodUwQgWWZAygDSUaHYHOaepg990vBKk8z8tvk6w2h6xeZXKBlIa
         2NUuxdQ+cduNN4GFKaZCKkA31e0LZqjo7DOgELn9tU+IZjlc7zcE65RFyMq0/U7E7lPn
         thawhAw/11Cgj/dDIqi1V/Bji7fvVYpa22rUkpKS/q6Fb5So7mJ0aXIY1nWFvspI/6x0
         hUcg==
X-Gm-Message-State: ALKqPwe3I43MHnRQcT8IrBdqxLF5TLJGbi8GnZT1YdvddLSt3ccOhx2p
        tPzYXmcAjstEAOJYAIrXpuQokQ==
X-Google-Smtp-Source: AB8JxZrLBg2cvqWQbPhTkjmdRrJpLkt9IBCIM+WEsAjCmsQtTi/PQ4XTB1cm05rsYJMKBn+4V4YMzg==
X-Received: by 2002:a62:5959:: with SMTP id n86-v6mr6838978pfb.217.1526597549455;
        Thu, 17 May 2018 15:52:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a3-v6sm7511340pgw.14.2018.05.17.15.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/19] commit: convert register_commit_graft to handle arbitrary repositories
Date:   Thu, 17 May 2018 15:51:48 -0700
Message-Id: <20180517225154.9200-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 29 +++++++++++++++--------------
 commit.h |  3 +--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/commit.c b/commit.c
index 0ec3d22813a..8a2ab53fc67 100644
--- a/commit.c
+++ b/commit.c
@@ -111,30 +111,31 @@ static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 			commit_graft_sha1_access);
 }
 
-int register_commit_graft_the_repository(struct commit_graft *graft, int ignore_dups)
+int register_commit_graft(struct repository *r, struct commit_graft *graft,
+			  int ignore_dups)
 {
-	int pos = commit_graft_pos(the_repository, graft->oid.hash);
+	int pos = commit_graft_pos(r, graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
 			free(graft);
 		else {
-			free(the_repository->parsed_objects->grafts[pos]);
-			the_repository->parsed_objects->grafts[pos] = graft;
+			free(r->parsed_objects->grafts[pos]);
+			r->parsed_objects->grafts[pos] = graft;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(the_repository->parsed_objects->grafts,
-		   the_repository->parsed_objects->grafts_nr + 1,
-		   the_repository->parsed_objects->grafts_alloc);
-	the_repository->parsed_objects->grafts_nr++;
-	if (pos < the_repository->parsed_objects->grafts_nr)
-		memmove(the_repository->parsed_objects->grafts + pos + 1,
-			the_repository->parsed_objects->grafts + pos,
-			(the_repository->parsed_objects->grafts_nr - pos - 1) *
-			sizeof(*the_repository->parsed_objects->grafts));
-	the_repository->parsed_objects->grafts[pos] = graft;
+	ALLOC_GROW(r->parsed_objects->grafts,
+		   r->parsed_objects->grafts_nr + 1,
+		   r->parsed_objects->grafts_alloc);
+	r->parsed_objects->grafts_nr++;
+	if (pos < r->parsed_objects->grafts_nr)
+		memmove(r->parsed_objects->grafts + pos + 1,
+			r->parsed_objects->grafts + pos,
+			(r->parsed_objects->grafts_nr - pos - 1) *
+			sizeof(*r->parsed_objects->grafts));
+	r->parsed_objects->grafts[pos] = graft;
 	return 0;
 }
 
diff --git a/commit.h b/commit.h
index c7f25d6490a..d04bbed81cf 100644
--- a/commit.h
+++ b/commit.h
@@ -174,8 +174,7 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
-#define register_commit_graft(r, g, i) register_commit_graft_##r(g, i)
-int register_commit_graft_the_repository(struct commit_graft *, int);
+int register_commit_graft(struct repository *r, struct commit_graft *, int);
 #define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
 struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
 
-- 
2.17.0.582.gccdcbd54c44.dirty

