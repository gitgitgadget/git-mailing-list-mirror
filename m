Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697391F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbcGKRXX (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36628 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcGKRXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so15279868wma.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uytxFtEPWmqqJPyvrC7SaFA8Jwvz2/UUIMK+xBIewBk=;
        b=O4yIGBYlcqhoZXraWx4c+fJEjyzkKo4XhtsG6aITUExqeRM3bKnd+Cj+z1AI1G+bXz
         lhv0eXn5bQ82bBmr3D5HVOGJXj256Ktemhiw8we5nC4DtHivcU9daNXYCzc5AFU92ly0
         Hb0pyFOTObr/wHmP0ZZld3HD2zVL4hQqS0uOydPFa5gfqnecpdPROJQyyfViDooBV/r2
         SgmtQTPaQUoT/EYsD1+Afkast+r28XZQS18PXGWIo9utE/iy5ptQ090rKTTN/t0t/qSE
         O8TcdQFUyafXkPDCOGryWsCTC81xfW6bxncZmyzwbZUhVb2PvXAas/1nxWUNYxKdhXdF
         wzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uytxFtEPWmqqJPyvrC7SaFA8Jwvz2/UUIMK+xBIewBk=;
        b=HTbwxHJ0u6samqc4YM0a3e0yGgSjsvROpxpl4bampHt+g02ZeAEIlq0S1e2cvn8yvu
         6NukPUZVkpr5mvt6K3N1vj125eufuxkinjfQvE4bxz07I730CHdFBpwqRczTMIPcQxCH
         DyyVXwpuGHzw5pTbXkJ8/pi+kkqi6pSH8Ml5dz+C6FHJHuL3+qlTyBwiYDpyjV6r8EsD
         HUvibOhRF76R+Y7dum32hVScHGtTUfO7d+rQ/QbA66UewnNWPinCIqWGBvcsqWQFd2tJ
         zx1ajGyNrApuxh37fX1FQKR+1er1MIVD2vZkcc4NK72Pv5AyfabXcpKM39+5qVK3sm/J
         cNag==
X-Gm-Message-State: ALyK8tKLV0MdAyDJ7A01L8RYJstieEg2v6Do7zMrk3EzjFp6+43nqanafyOcc0V5Wz9q0A==
X-Received: by 10.28.140.194 with SMTP id o185mr19483610wmd.86.1468257800563;
        Mon, 11 Jul 2016 10:23:20 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:19 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/8] split-index: add {add,remove}_split_index() functions
Date:	Mon, 11 Jul 2016 19:22:48 +0200
Message-Id: <20160711172254.13439-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Also use the functions in cmd_update_index() in
builtin/update-index.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 17 ++++-------------
 split-index.c          | 18 ++++++++++++++++++
 split-index.h          |  2 ++
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6cdfd5f..f06fe80 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1108,19 +1108,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
-	if (split_index > 0) {
-		init_split_index(&the_index);
-		the_index.cache_changed |= SPLIT_INDEX_ORDERED;
-	} else if (!split_index && the_index.split_index) {
-		/*
-		 * can't discard_split_index(&the_index); because that
-		 * will destroy split_index->base->cache[], which may
-		 * be shared with the_index.cache[]. So yeah we're
-		 * leaking a bit here.
-		 */
-		the_index.split_index = NULL;
-		the_index.cache_changed |= SOMETHING_CHANGED;
-	}
+	if (split_index > 0)
+		add_split_index(&the_index);
+	else if (!split_index && the_index.split_index)
+		remove_split_index(&the_index);
 
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
diff --git a/split-index.c b/split-index.c
index 3c75d4b..9466b69 100644
--- a/split-index.c
+++ b/split-index.c
@@ -319,3 +319,21 @@ void replace_index_entry_in_base(struct index_state *istate,
 		istate->split_index->base->cache[new->index - 1] = new;
 	}
 }
+
+void add_split_index(struct index_state *istate)
+{
+	init_split_index(istate);
+	istate->cache_changed |= SPLIT_INDEX_ORDERED;
+}
+
+void remove_split_index(struct index_state *istate)
+{
+	/*
+	 * can't discard_split_index(&the_index); because that
+	 * will destroy split_index->base->cache[], which may
+	 * be shared with the_index.cache[]. So yeah we're
+	 * leaking a bit here.
+	 */
+	istate->split_index = NULL;
+	istate->cache_changed |= SOMETHING_CHANGED;
+}
diff --git a/split-index.h b/split-index.h
index c1324f5..df91c1b 100644
--- a/split-index.h
+++ b/split-index.h
@@ -31,5 +31,7 @@ void merge_base_index(struct index_state *istate);
 void prepare_to_write_split_index(struct index_state *istate);
 void finish_writing_split_index(struct index_state *istate);
 void discard_split_index(struct index_state *istate);
+void add_split_index(struct index_state *istate);
+void remove_split_index(struct index_state *istate);
 
 #endif
-- 
2.9.0.250.g7087ccc.dirty

