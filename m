Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB68EE0207
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjIMTR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjIMTRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:17:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF9B199F
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:51 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59bbbeea69fso2107677b3.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632670; x=1695237470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCbI8tom2x+w7tUloBiTiRgIwhdRrRfsvucxp79vtW4=;
        b=tgcHaKV1CC7wyCwNhw8AicGu4OpakbqvzSrPw9QmesaiCd4+hQgeHR0Uz/QJoTY34h
         hgS7WZon20j87PUFKC1gWMlRgpWCP8Csb2qbtGMTd4xzRaclB7+9JpDg7eO3TiOnQQOK
         qo1adhAqjY7bd+VjFgzxAz7RIso1WTr1gh+r/sytv/mIP5JvRBttfOUqTKieXz3wiZX8
         gcICk6N6yV0OcI3+0caOGCJyg8XHCxP5pwUOZXtNk40smuwYz3RUzVwL2QM79GEqemou
         fWGg4GGS/T4+bFq/sescBrPdtmJWKZwjtwjMJ7zWiPLVEj67rs8BOZnHKTAcYKnLMQdD
         eZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632670; x=1695237470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCbI8tom2x+w7tUloBiTiRgIwhdRrRfsvucxp79vtW4=;
        b=ZJJXdYL/ML0ztaAFZVezvwofLM00EjMChBoBrVTDQBGgHHpW2x9N54ZnH9I6EmA+uS
         z7nS9N8zWuOZgMbySkgkE3elAunn+Vp96C7CRGv6Lqa4//vVav12xiZDWqhaARR4yj+M
         e3IV/AZttrtLi9A/my1zTM5pGcj3JhO49+YJiYvLMYjAy6TkptGg9LZwqZnd+wn8TIla
         KnAw9RSztOEmJ1jFnExetuBBljcbB/oOdOk0MYUpokszwEy+wRv58j909lwsyz39q7RO
         mf3rxzWbRLDUKs+4C5SuI4pWwhFK3tvZERhUKXkQSa12LzJOptfvRdKGMs/YaXML8vKI
         mNRA==
X-Gm-Message-State: AOJu0YytX2dCJc7DfHdVNJP6fKgv66jUxU2dMhqc6ebagwSZAWdvgiM6
        cxWh15pf5sLRAitHFctm25qUVipCU+FbycYtFGlUcA==
X-Google-Smtp-Source: AGHT+IEYLuvYlOliX2JzG/k+E/7Vtot3+9u0lmD19q37dWSyHJoVIp0fDogRhqY59YbvY9c0PPV/dg==
X-Received: by 2002:a0d:e2c3:0:b0:576:7dfc:e73e with SMTP id l186-20020a0de2c3000000b005767dfce73emr3946795ywe.32.1694632670104;
        Wed, 13 Sep 2023 12:17:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q62-20020a0dce41000000b005463e45458bsm3271191ywd.123.2023.09.13.12.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:17:49 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:17:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/8] builtin/repack.c: extract redundant pack cleanup for
 --geometric
Message-ID: <7ed45804ea02cdb709de1776daac857425f744fd.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To reduce the complexity of the already quite-long `cmd_repack()`
implementation, extract out the parts responsible for deleting redundant
packs from a geometric repack out into its own sub-routine.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0eee430951..71366811e9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -540,6 +540,32 @@ static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 	return NULL;
 }
 
+static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
+					    struct string_list *names,
+					    struct existing_packs *existing)
+{
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t i;
+
+	for (i = 0; i < geometry->split; i++) {
+		struct packed_git *p = geometry->pack[i];
+		if (string_list_has_string(names, hash_to_hex(p->hash)))
+			continue;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if ((p->pack_keep) ||
+		    (string_list_has_string(&existing->kept_packs, buf.buf)))
+			continue;
+
+		remove_redundant_pack(packdir, buf.buf);
+	}
+
+	strbuf_release(&buf);
+}
+
 static void free_pack_geometry(struct pack_geometry *geometry)
 {
 	if (!geometry)
@@ -1202,29 +1228,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			remove_redundant_pack(packdir, item->string);
 		}
 
-		if (geometry.split_factor) {
-			struct strbuf buf = STRBUF_INIT;
-
-			uint32_t i;
-			for (i = 0; i < geometry.split; i++) {
-				struct packed_git *p = geometry.pack[i];
-				if (string_list_has_string(&names,
-							   hash_to_hex(p->hash)))
-					continue;
-
-				strbuf_reset(&buf);
-				strbuf_addstr(&buf, pack_basename(p));
-				strbuf_strip_suffix(&buf, ".pack");
-
-				if ((p->pack_keep) ||
-				    (string_list_has_string(&existing.kept_packs,
-							    buf.buf)))
-					continue;
-
-				remove_redundant_pack(packdir, buf.buf);
-			}
-			strbuf_release(&buf);
-		}
+		if (geometry.split_factor)
+			geometry_remove_redundant_packs(&geometry, &names,
+							&existing);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
-- 
2.42.0.166.g68748eb9c8

