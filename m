Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57211F404
	for <e@80x24.org>; Sun,  8 Apr 2018 12:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeDHM2u (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 08:28:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37726 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeDHM2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 08:28:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id l49so5654478wrl.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8YoKxMRjxPUNYvAckl51qp3Zpnob1shYxxfJiEG3iQ=;
        b=l5oSaRZpfMUyFyLKBsu4tEtOZZEC+/EwKnQ4rxRSuLBJ6qRODC2HU9ci19I8aj3eau
         ERghBDOhh/RqLiUGEpr1Yo+es3XGYtvnnN3PY/qymcRP8qZUnT92+NAld/ngFFlV67g2
         YAd1VE/x8LRyrD97zxLWpQHFHTf4BPQBKD+yDIODq4NJR3S8DMA+CVww4eG0IRT4Nfjn
         L/dVFeWO3PU+MtyVT2/adaCSAhuy7TXLQh+gpWsglFRdy727grZ1JnVEIxd1hsXFf3u0
         3xEUop+vdfddnXXvySfn7P+n0ljisMIf2DMWQeL4nT5LoEo49tzFlDHPjtKh/TF+Z89s
         Zpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8YoKxMRjxPUNYvAckl51qp3Zpnob1shYxxfJiEG3iQ=;
        b=QEkUodMxXkME8m8o7HB1FvnEsopfKNtMfKhSRP5sgsl8JIWgGP11XHiw059WW4xw0g
         kuGwnJaFqaMBgcPKP8vyInHf5DpmIt02cDR8WIcGHM3EexdqchlwJLfPTgfW0yN8BUNW
         i1mbU8UGKw9sN1XlxfTGRAVHZibratG/EqdXHf4rGRSPhASjFt/yscQ+l+HzjjC1QYVY
         uY7MY5SxX/b4s84H2ezZHxDfTrA6mUtnaactCvFu0nP3Simz7n2n91gyGhvqnwaPUYTa
         B1VnSSy/uoQtAD7zGZ29vF+OAaYk592p85rtUxYQDMiPcz2x2u9KBTntw8F6xO/q3VYn
         g1pQ==
X-Gm-Message-State: ALQs6tBgzNNXIcBu0mxKJKa03BB+2R87cJLeo5d02YKl3TQ6HZpNR+FW
        RP86/ZUPD8l4LziBD789InLsY6sywcM=
X-Google-Smtp-Source: AIpwx4/yEVLgAwE4GOOjv5T7pvuaoRQOB1rchcyIqBTL3wU79JncRrjWNOuGYaWv80GU/Vcm5SL9BA==
X-Received: by 2002:a19:9dc5:: with SMTP id g188-v6mr20706259lfe.95.1523190527566;
        Sun, 08 Apr 2018 05:28:47 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id p9-v6sm2965038lfh.93.2018.04.08.05.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 05:28:46 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v12 1/4] ref-filter: use "struct object_id" consistently
Date:   Sun,  8 Apr 2018 14:28:29 +0200
Message-Id: <20180408122832.65414-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180402005248.52418-1-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Internally we store a "struct object_id", and all of our
callers have one to pass us. But we insist that they peel it
to its bare-sha1 hash, which we then hashcpy() into place.
Let's pass it around as an object_id, which future-proofs us
for a post-sha1 world.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 ref-filter.c         | 10 +++++-----
 ref-filter.h         |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index da186691e..42278f516 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -117,7 +117,7 @@ static int verify_tag(const char *name, const char *ref,
 		return -1;
 
 	if (format->format)
-		pretty_print_ref(name, oid->hash, format);
+		pretty_print_ref(name, oid, format);
 
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ad7b79fa5..6fa04b751 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -72,7 +72,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		}
 
 		if (format.format)
-			pretty_print_ref(name, oid.hash, &format);
+			pretty_print_ref(name, &oid, &format);
 	}
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216..ade97a848 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1826,12 +1826,12 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const unsigned char *objectname,
+						 const struct object_id *oid,
 						 int flag)
 {
 	struct ref_array_item *ref;
 	FLEX_ALLOC_STR(ref, refname, refname);
-	hashcpy(ref->objectname.hash, objectname);
+	oidcpy(&ref->objectname, oid);
 	ref->flag = flag;
 
 	return ref;
@@ -1927,7 +1927,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid->hash, flag);
+	ref = new_ref_array_item(refname, oid, flag);
 	ref->commit = commit;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
@@ -2165,11 +2165,11 @@ void show_ref_array_item(struct ref_array_item *info,
 	putchar('\n');
 }
 
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
-	ref_item = new_ref_array_item(name, sha1, 0);
+	ref_item = new_ref_array_item(name, oid, 0);
 	ref_item->kind = ref_kind_from_refname(name);
 	show_ref_array_item(ref_item, format);
 	free_array_item(ref_item);
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b3..68268f9eb 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -132,7 +132,7 @@ void setup_ref_filter_porcelain_msg(void);
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
  */
-void pretty_print_ref(const char *name, const unsigned char *sha1,
+void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format);
 
 #endif /*  REF_FILTER_H  */
-- 
2.14.3 (Apple Git-98)

