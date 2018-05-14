Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F1B1F51A
	for <e@80x24.org>; Mon, 14 May 2018 21:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeENV5j (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:39 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:44161 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbeENV5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:37 -0400
Received: by mail-yb0-f202.google.com with SMTP id k188-v6so7373907ybc.11
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LXMkDgunIra9qPZoC0yK6QlkWfIfalaCwgIyts10HFE=;
        b=ohV16KLEfd9ALwvZgwsy9o3iIuVvHRJXMLk1Z82pu9bCjzHkyb7JZD3RQssahE6Qfh
         mJd58IMAQWzL+CMG6lRT7OqKMmlsLWdbEsxsWvJTu+Lbzdt+789CONxd2ib+RKGQcPp5
         et0LgBkT672CZ7m1d/QtYzkDdWaykdjU8+p+nt8ubvPwOk6ibPW9WCL7tJE57NSz5QTK
         Q9dYk0mRj9tDvB+bRsTVcQue6k4TvyM8IIxzovd30gEHBfvepbiLUkkp32/26jqqBJdg
         00sD7dtAwG3xfBOhXjVOUduhcwBOV4gFaZGIlGV/5gzz4aBvcWByxij4LDLI5E5lRpZx
         CvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LXMkDgunIra9qPZoC0yK6QlkWfIfalaCwgIyts10HFE=;
        b=kUDgn4KjLNuQs5zCZeYvNdCk0suYUoH8gwbIlyDfbrfKON5IiQ6abCsXrZy3tB6rbn
         r6Z7cYbCY92x4NVe/suf89tQQ454OCMOSnqXFT+9WsMfdciJCkkj7DhNzaTZAdCYiaVy
         TipCkk/wWU0mvGopNsODD+BFMchBlzkaoPKYgLLh0XKt3a5xx9WD0bTKXsmCKGA7H43h
         iFNDwFDAfaTBYpJSwXdWcHnWsvLm/UhtcXVgRG+f8nwQy1ckFmwitaTwpqaHW7Ne5ik/
         iCLFAeIJ+baYBDD/aaorYiBLP/cFGhr43cr1jEYvv0W/SWm3mn7uVSeXnrtIVsJDmFdd
         zrVw==
X-Gm-Message-State: ALKqPwcc9xaCA1/ZmMGDSQhgLoF/SiY1B6EE6l2kddk4cCin7GfbxnPV
        aZ4OAtY0SgjqhiE5uyKzLt5As9DxO9StmhFFE6vQbUvfMv9Y3qggjQ8PT68uciisGgs9z9L+YiG
        na67/N02fMoxRvCVRq3N9T5UnMX1+iu0QL7T2OojGmCOOhWSdU2VtE/Rq/A==
X-Google-Smtp-Source: AB8JxZrQZru5oml3LdT2eSGPFkXQ4L02s1NZmtjHgloVU+jCkdAA9JH76RafmiWs/ud1+itzjtkN2Hxlai4=
MIME-Version: 1.0
X-Received: by 2002:a25:4247:: with SMTP id p68-v6mr5006994yba.58.1526335056992;
 Mon, 14 May 2018 14:57:36 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:15 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-25-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 24/35] remote: convert query_refspecs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'query_refspecs()' to take a 'struct refspec' as a parameter instead
of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c |  3 +--
 remote.c       | 10 +++++-----
 remote.h       |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 509dc6677..6b7e45890 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -83,8 +83,7 @@ static const char *map_refspec(const char *ref,
 		struct refspec_item query;
 		memset(&query, 0, sizeof(struct refspec_item));
 		query.src = matched->name;
-		if (!query_refspecs(remote->push.items, remote->push.nr, &query) &&
-		    query.dst) {
+		if (!query_refspecs(&remote->push, &query) && query.dst) {
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addf(&buf, "%s%s:%s",
 				    query.force ? "+" : "",
diff --git a/remote.c b/remote.c
index 54297de3d..3d7bc7504 100644
--- a/remote.c
+++ b/remote.c
@@ -734,7 +734,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	}
 }
 
-int query_refspecs(struct refspec_item *refs, int ref_count, struct refspec_item *query)
+int query_refspecs(struct refspec *rs, struct refspec_item *query)
 {
 	int i;
 	int find_src = !query->src;
@@ -744,8 +744,8 @@ int query_refspecs(struct refspec_item *refs, int ref_count, struct refspec_item
 	if (find_src && !query->dst)
 		return error("query_refspecs: need either src or dst");
 
-	for (i = 0; i < ref_count; i++) {
-		struct refspec_item *refspec = &refs[i];
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 
@@ -772,7 +772,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = (char *)name;
 
-	if (query_refspecs(rs->items, rs->nr, &query))
+	if (query_refspecs(rs, &query))
 		return NULL;
 
 	return query.dst;
@@ -780,7 +780,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return query_refspecs(remote->fetch.items, remote->fetch.nr, refspec);
+	return query_refspecs(&remote->fetch, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
diff --git a/remote.h b/remote.h
index 4e7590b55..edcfc3600 100644
--- a/remote.h
+++ b/remote.h
@@ -158,7 +158,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-extern int query_refspecs(struct refspec_item *specs, int nr, struct refspec_item *query);
+int query_refspecs(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
-- 
2.17.0.441.gb46fe60e1d-goog

