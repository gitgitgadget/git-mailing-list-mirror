Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7A01F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeEPW7t (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:49 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:34400 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeEPW7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:38 -0400
Received: by mail-yw0-f202.google.com with SMTP id t18-v6so1087462ywg.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=63GROcHmSJENLt8v4znk4ePCh2lmJWjz/pKjqFyvopY=;
        b=SMlIGGYRzMq/wi8fxBAKz0L18Gd/lVvS+We/DJ1viTF8+Jz+3+8xPbpzIYszGO1xig
         IFOjMPt/RSCRFfv8/cjHGTY+HiyZYiNHz9WLDb8eQYAgZR0zD9nlZ0dPo59NmKyRlgGh
         BLhBS2EG8yK/kI0gGciPXpucLq6TLoiIhh1fBXmVR6uxLCu7EPYpxwaqeeyoPTKYDLvg
         Eqw+i+h7FUowFsMqvj2/L5m6oNS25WKn8Ut/HXhYuDe9semBO7ewTkanwZMgrydLOSwZ
         MLQ5qgd+XBjJpLr9rOOSC9Sp4MY7IhfBMX2kUB16qn2cRYkwcRA7KwjHoaFUm0dzTrnm
         UdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=63GROcHmSJENLt8v4znk4ePCh2lmJWjz/pKjqFyvopY=;
        b=DcTfOAKfg6GY3cAZ8W0AtWhGNgwhqVIDtpzDyIg3xtftJgicKP915gw/jYpGGCKJoF
         UHRZotVQHsgZ8PftoH1DfFLRCAw1xfX0wTLeJWC0UsoDP/kGzQyFoW92Lusu5cmKAv/B
         K6Vnw7yBeNkY80FGxNBZ5YJy0qXtAT1K/KKMCyRSG03Dxxjee9SZfD02S8jl5vaMVBvM
         JHm+GwiJcMlHoS1/m8dRW02ClT1vbz9huojqX65KeBAduB/MscyZHLNZWWlNwGYa47pm
         c12MwnQnG6cm4xstd/RKO3RWAUXH8FjJQlYgIZauQicpXSb+QFM5bCY9+bWktedgdhwb
         etPw==
X-Gm-Message-State: ALKqPwd2+SK7EOo/ZI2OLM9V+9G/4nWGulsKZD24VfDZ15izzua6HyzE
        0xInxaiCXK4JQKsq48lrkOSavJfBDEtiJRDPADw6BL1nCBgZrkEsjMqFf9lYOA4M+nq2qYUdPaW
        uzbu+t0maDnoNhTKs8zjFcoZMmkGvt3294WsQK0J330vg8C43Fta+55xRgg==
X-Google-Smtp-Source: AB8JxZp50PSQQbPA5eCYgIDeyldjEy/qQWkTLdftK1YK4N3mz3z1uqALpFs2i+im6pD23T8ew7pBS0Vr69Y=
MIME-Version: 1.0
X-Received: by 2002:a81:7012:: with SMTP id l18-v6mr930800ywc.59.1526511577419;
 Wed, 16 May 2018 15:59:37 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:12 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-26-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 25/36] remote: convert query_refspecs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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
index 89415a263..dd68e6b22 100644
--- a/remote.c
+++ b/remote.c
@@ -725,7 +725,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	}
 }
 
-int query_refspecs(struct refspec_item *refs, int ref_count, struct refspec_item *query)
+int query_refspecs(struct refspec *rs, struct refspec_item *query)
 {
 	int i;
 	int find_src = !query->src;
@@ -735,8 +735,8 @@ int query_refspecs(struct refspec_item *refs, int ref_count, struct refspec_item
 	if (find_src && !query->dst)
 		return error("query_refspecs: need either src or dst");
 
-	for (i = 0; i < ref_count; i++) {
-		struct refspec_item *refspec = &refs[i];
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 
@@ -763,7 +763,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = (char *)name;
 
-	if (query_refspecs(rs->items, rs->nr, &query))
+	if (query_refspecs(rs, &query))
 		return NULL;
 
 	return query.dst;
@@ -771,7 +771,7 @@ char *apply_refspecs(struct refspec *rs, const char *name)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return query_refspecs(remote->fetch.items, remote->fetch.nr, refspec);
+	return query_refspecs(&remote->fetch, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
diff --git a/remote.h b/remote.h
index 0b1fcc051..9050ff75a 100644
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

