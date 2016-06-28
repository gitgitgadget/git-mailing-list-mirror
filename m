Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C7F2018B
	for <e@80x24.org>; Tue, 28 Jun 2016 07:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbcF1Hxi (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 03:53:38 -0400
Received: from mout.web.de ([212.227.15.4]:61779 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcF1Hxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 03:53:34 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MGlGr-1b4rWc48oL-00DXDt; Tue, 28 Jun 2016 09:53:32
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 2/3] read-cache: factor out get_sha1_from_index() helper
Date:	Tue, 28 Jun 2016 10:01:15 +0200
Message-Id: <1467100875-2764-1-git-send-email-tboegi@web.de>
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:0MPawFnRZGVJ+K//GGfuIBXzGwTKtM3hFVZjBSxOFhIpE82I9DI
 rA+wz1UJQi2gfBdIUzqpY98woZ9zJyXbZ6+Nxjf/tOt+cfAlrokF1D5Wj31nunDo9EouiZi
 M26JuMPJZonEmFwymYtuoowsYWS9ecXIw7IDnor7c19q+PWlkKpW9S7jJlSuNoPw11wujIf
 9DGcHHf1fwp4f1RX2J01g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ltOWiutsYHI=:asSJIad96BdzSb5HU7UAri
 vkz7Y5wX5p6GGHXOdA9fVzn3Zwh7Ot1KDKqz6eukcfUgikaI6uUbVKq78ZYsSRCgdcHKgbBpe
 Wuw0tyXrp4oLEl1kqNrtPnxnBBK1hmvMupfs7mlQMkNHkcZnxiwl5Z4GO8FpCvbX2m/IcuWjd
 jnjE7OQZq8if2qVt2yqa7Z/YLZMqrredWXs9yS9QG68sYDOizBrBd7nVXrjdl8Pj8tMzQU/eh
 YP7yd7oDzrq6fS56rEyCNrjZM3meOFIH9lYuFnF7i5LazdgotmiDqM8Xh09O3qC7yQclSexnp
 f1oI3PlFACfZrHQZDQEV3XUZamwtsyM7SVDs5HFGX90BdauLU0XaSme8ZjM3vGvFzIyrHUvKU
 t8qGdFrR1/NyPiiHCE7dPMRlruaXxgShqXEP4U/g21WvbV3B7GzLXwd26a/uelaVxmZ1vXRdn
 NYlhJHRtSVo2HXTIKATo5Zj241EcJZf73fIUf6pRiVxUT4Kpam3YoBukU+tkOogdF2WXVKuW0
 DVoomWbWSfZcKMq/ID059lGo5O/0JRPkjqXpc6cC3qR0U1A9lUCw5k8XKOTXnEqehkEKNdQcS
 tUqFBsXp+YfVhK+gwDYN7E3rjFSEojwqSURlblgZmL+jz3jNV6Td3WqbIfEbrimpC79IZYOqO
 r0DimgSkZCI6a4YvLGGloD+jfq2QHAur5i4U8Tsq4MNWcr0q+yMF3+zoZnSXFla4VN2uuLxrx
 GKdBkCkYa+LSsMvCoP4Z4bUCbkmdq8r+Wl/D02irP/wawwLpGMNX40zImBjRnWINFVIWIPulz
 JPaYaxu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Factor out the retrieval of the sha1 for a given path in
read_blob_data_from_index() into the function get_sha1_from_index().

This will be used in the next commit, when convert.c can do the
analyze for "text=auto" without slurping the whole blob into memory
at once.

Add a wrapper definition get_sha1_from_cache().

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 cache.h      |  3 +++
 read-cache.c | 29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index b829410..bd1210a 100644
--- a/cache.h
+++ b/cache.h
@@ -379,6 +379,7 @@ extern void free_name_hash(struct index_state *istate);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
+#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, (path))
 #endif
 
 enum object_type {
@@ -1008,6 +1009,8 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
 }
 
+const unsigned char *get_sha1_from_index(struct index_state *istate, const char *path);
+
 /*
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
diff --git a/read-cache.c b/read-cache.c
index d9fb78b..a3ef967 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2263,13 +2263,27 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 
 void *read_blob_data_from_index(struct index_state *istate, const char *path, unsigned long *size)
 {
-	int pos, len;
+	const unsigned char *sha1;
 	unsigned long sz;
 	enum object_type type;
 	void *data;
 
-	len = strlen(path);
-	pos = index_name_pos(istate, path, len);
+	sha1 = get_sha1_from_index(istate, path);
+	if (!sha1)
+		return NULL;
+	data = read_sha1_file(sha1, &type, &sz);
+	if (!data || type != OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	if (size)
+		*size = sz;
+	return data;
+}
+
+const unsigned char *get_sha1_from_index(struct index_state *istate, const char *path)
+{
+	int pos = index_name_pos(istate, path, strlen(path));
 	if (pos < 0) {
 		/*
 		 * We might be in the middle of a merge, in which
@@ -2285,14 +2299,7 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
 	}
 	if (pos < 0)
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
-	if (!data || type != OBJ_BLOB) {
-		free(data);
-		return NULL;
-	}
-	if (size)
-		*size = sz;
-	return data;
+	return (istate->cache[pos]->sha1);
 }
 
 void stat_validity_clear(struct stat_validity *sv)
-- 
2.0.0.rc1.6318.g0c2c796

