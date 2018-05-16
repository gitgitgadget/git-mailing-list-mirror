Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B491F406
	for <e@80x24.org>; Wed, 16 May 2018 23:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEPXsa (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:48:30 -0400
Received: from mail-ot0-f202.google.com ([74.125.82.202]:34530 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeEPXs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 19:48:29 -0400
Received: by mail-ot0-f202.google.com with SMTP id a14-v6so2152933otf.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 16:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=cXhlFKLgARqphrTuOHrZNXScTL5h6BCs4+Qqy9NgMyI=;
        b=Lgg15ncE7cqG5g64HF2OHbRqAQJlhdDUkFJ8lmlF/9RJeBnBUEOaATx/yu3gUldFuc
         XpU+bJwrFeEPrwJS5oaQY5Tjnlpie+/SofMUjGQequ39/qgiXQVCdVAXkK7pAR+vcRU9
         NHnYIvHAyZI4yl8MkRsyjiD/Jb3f3qfF1gS1kNWs9Wlrvz6TV0yNAl3xnrtS2Wc0tU43
         Hu67Y5F4KetVapvG6bLvCzLj1DyMoUnvrUOlyZ1WUbFSy7icv1k4MMysaSX21SMX+tlO
         dEAXvhJC39Bt6DbcqmjWab+bbj8EXPNjvn+VfIZMM31lSOUDJ2zllK9+DxCotNy/VuNG
         gqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=cXhlFKLgARqphrTuOHrZNXScTL5h6BCs4+Qqy9NgMyI=;
        b=LxXPJxvcpohh7Gkm+P2t0abJ2LTyglwDK7/rnRaRr+lOyLaOM7PowIBYkfVLroDnQ2
         d5HPH7/8g2/8wpsoiQWYUd2bh2d620AJE/Uj8n9dNDG2GxgvngjMqv13Mekg5PSqRYc0
         MfXX6sjPWuo4sb5zkcMTSeV5fOX0fuw1Dxz7wXaqPGYiQq5Sl0/5iNP6YsJQhRtr/aia
         VfrIHF/h8DWTslr4ir6wKoynl7oX/HyRvPgY/9bZVdBpGHcr8WLhFKIV0x2lK9TpgOhU
         xxby+KuQk5bCC4HciDHXOeSoxRfuSXJpvP0mcX0x75WsGQVXOHA2rABk/c+6TkOAk06f
         TS8w==
X-Gm-Message-State: ALKqPweOnwzIdh00B0G4d47CsBdwlydPK3y3oGOpcBGUZPjkMKsRvs6Y
        URW7IZP3mIsVgUr3MZX7gcMldGkNnXzowXeuUNVZfx0U6Yj/1IhCI2QGp7irmhJONJHu8eDfJDz
        ahzVNGRdvJ9JkrTuSNWYIBELFg4gEj/I87IIs7pXuw58IJiJKJSOTxzDCrA==
X-Google-Smtp-Source: AB8JxZrzBM9gyxn1ZtRqZipTspl5hktNlFvFMuKuLLQkMEWiO63jXdk6vmgVcXu16PvEXiOpEDnbTymst0g=
MIME-Version: 1.0
X-Received: by 2002:aca:ba08:: with SMTP id k8-v6mr2406154oif.73.1526514508651;
 Wed, 16 May 2018 16:48:28 -0700 (PDT)
Date:   Wed, 16 May 2018 16:48:21 -0700
In-Reply-To: <20180516234822.182663-1-bmwill@google.com>
Message-Id: <20180516234822.182663-2-bmwill@google.com>
References: <20180516225823.235426-1-bmwill@google.com> <20180516234822.182663-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 1/2] refspec: consolidate ref-prefix generation logic
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using protocol v2 a client constructs a list of ref-prefixes which
are sent across the wire so that the server can do server-side filtering
of the ref-advertisement.  The logic that does this exists for both
fetch and push (even though no push support for v2 currently exists yet)
and is roughly the same so lets consolidate this logic and make it
general enough that it can be used for both the push and fetch cases.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 13 +------------
 refspec.c       | 29 +++++++++++++++++++++++++++++
 refspec.h       |  4 ++++
 transport.c     | 21 +--------------------
 4 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3fad1f0db..80bb14370 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -351,18 +351,7 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	const struct ref *remote_refs;
 
-	for (i = 0; i < rs->nr; i++) {
-		const struct refspec_item *item = &rs->items[i];
-		if (!item->exact_sha1) {
-			const char *glob = strchr(item->src, '*');
-			if (glob)
-				argv_array_pushf(&ref_prefixes, "%.*s",
-						 (int)(glob - item->src),
-						 item->src);
-			else
-				expand_ref_prefix(&ref_prefixes, item->src);
-		}
-	}
+	refspec_ref_prefixes(rs, &ref_prefixes);
 
 	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
 
diff --git a/refspec.c b/refspec.c
index 97e76e8b1..c59a4ccf1 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "argv-array.h"
 #include "refs.h"
 #include "refspec.h"
 
@@ -192,3 +193,31 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	refspec_item_clear(&refspec);
 	return ret;
 }
+
+void refspec_ref_prefixes(const struct refspec *rs,
+			  struct argv_array *ref_prefixes)
+{
+	int i;
+	for (i = 0; i < rs->nr; i++) {
+		const struct refspec_item *item = &rs->items[i];
+		const char *prefix = NULL;
+
+		if (rs->fetch == REFSPEC_FETCH)
+			prefix = item->src;
+		else if (item->dst)
+			prefix = item->dst;
+		else if (item->src && !item->exact_sha1)
+			prefix = item->src;
+
+		if (prefix) {
+			if (item->pattern) {
+				const char *glob = strchr(prefix, '*');
+				argv_array_pushf(ref_prefixes, "%.*s",
+						 (int)(glob - prefix),
+						 prefix);
+			} else {
+				expand_ref_prefix(ref_prefixes, prefix);
+			}
+		}
+	}
+}
diff --git a/refspec.h b/refspec.h
index 7e1ff94ac..01b700e09 100644
--- a/refspec.h
+++ b/refspec.h
@@ -41,4 +41,8 @@ void refspec_clear(struct refspec *rs);
 
 int valid_fetch_refspec(const char *refspec);
 
+struct argv_array;
+void refspec_ref_prefixes(const struct refspec *rs,
+			  struct argv_array *ref_prefixes);
+
 #endif /* REFSPEC_H */
diff --git a/transport.c b/transport.c
index 7e0b9abba..cbf0044c3 100644
--- a/transport.c
+++ b/transport.c
@@ -1088,30 +1088,11 @@ int transport_push(struct transport *transport,
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
 		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
-		int i;
 
 		if (check_push_refs(local_refs, rs) < 0)
 			return -1;
 
-		for (i = 0; i < rs->nr; i++) {
-			const struct refspec_item *item = &rs->items[i];
-			const char *prefix = NULL;
-
-			if (item->dst)
-				prefix = item->dst;
-			else if (item->src && !item->exact_sha1)
-				prefix = item->src;
-
-			if (prefix) {
-				const char *glob = strchr(prefix, '*');
-				if (glob)
-					argv_array_pushf(&ref_prefixes, "%.*s",
-							 (int)(glob - prefix),
-							 prefix);
-				else
-					expand_ref_prefix(&ref_prefixes, prefix);
-			}
-		}
+		refspec_ref_prefixes(rs, &ref_prefixes);
 
 		remote_refs = transport->vtable->get_refs_list(transport, 1,
 							       &ref_prefixes);
-- 
2.17.0.441.gb46fe60e1d-goog

