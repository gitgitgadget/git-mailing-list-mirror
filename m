Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF9920D0C
	for <e@80x24.org>; Thu, 22 Jun 2017 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbdFVSUG (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:20:06 -0400
Received: from mout.web.de ([212.227.17.11]:52292 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753397AbdFVSUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:20:05 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilAv-1duPmt05hF-00czOD; Thu, 22
 Jun 2017 20:19:50 +0200
Subject: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
Date:   Thu, 22 Jun 2017 20:19:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:w+XfMC9PL8lGGzVMnnLT0ABTZCj9f4/sEgVMICn92YTkTzEATCB
 tOa+EPYO5LG5bwIATlJ8hSmxhe0yFpLnZgCi1hJjCK8JQwxT8JKhrohECu4ARRxuPnkdYcP
 0Tt8Re4+yP/dw1Eukh95dd/4TUnbsfdO1gAbwxeVi8NNgi+B1SWYB/B5G6qqBDtUMUYGpa2
 LVnCLPRQIdqsYebTNQ0bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DOPaELXhOQI=:Yb2i0fu18UEujAwMcwTPMn
 9WIqukekTEoIEbSg65opYcCUPRFNGzvn8+9NOV/3m6DnyYYP7qIMzxzVUF41xaiEdMMXU5ftf
 FNnw0y33wl/Ot+3JtFjxzfHLQPLl4iJU2JKxb/7MCu292pyMtWSKvzDI30b0wlC1/6WMDFNqQ
 mz9wCgNTBiHYDuYQ5KTxf/2Vvvm6G141KnfPA8qrL7k7zttlV4oJyNqQScLGhHXojE120h5Ml
 cQMH3d8zDGHMUf2gCpZClMv0bKGNRrOZP4MHxBCOZ7A+owxJPEnbE+/x8ARZpB6qMqpn9ZKzu
 q7PtCKR8KtUXtBO7fZd1dHNqyvPC4aXVmOIxh4KeTfvVHMEd6YIkqpSI+QBWIVLL40HvgCTed
 u9OQKi1AlWc9fC0W5LY5l79Uvx2cLROUOURXoq3BkMUmUj1Syem3UG+8wkARtSj2Z0Ah/8DT8
 HLK8HY/jDY+Nv9FLLh1cZi331dAS+UjBFeYGk4S7QvDugTtfMGyHM1KyKIKRyzCGRF3DuBGtC
 Ja2t+NCmIFaheT2cTtSCEdtt3Td5Y/AY8dZs61WEHDzUBTMsE65atFBRi5ZpskdPGDz2ku/yy
 +n45sIXOos/Kgg9QPNBiIaxZCO249xd7UP7UwNQiY8cc+YAxoj6XQhykFsiQyy6ZhDANfbnol
 bSi1C3E3WgHWURNghjPbbdxO2BtLUInOaAawflMQkEUxuAKfY5s6uDEujvWdlLva6tx3njnG4
 UCjdAnkOt4ugpULiU1urDg9T3WKtRPRGdhCWSqa2vbKFQhGw0ALBlcs9SKl6zaPgD0lun/KIX
 E84uxj8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Read each loose object subdirectory at most once when looking for unique
abbreviated hashes.  This speeds up commands like "git log --pretty=%h"
considerably, which previously caused one readdir(3) call for each
candidate, even for subdirectories that were visited before.

The new cache is kept until the program ends and never invalidated.  The
same is already true for pack indexes.  The inherent racy nature of
finding unique short hashes makes it still fit for this purpose -- a
conflicting new object may be added at any time.  Tasks with higher
consistency requirements should not use it, though.

The cached object names are stored in an oid_array, which is quite
compact.  The bitmap for remembering which subdir was already read is
stored as a char array, with one char per directory -- that's not quite
as compact, but really simple and incurs only an overhead equivalent to
11 hashes after all.

Suggested-by: Jeff King <peff@peff.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 cache.h     | 17 +++++++++++++++++
 sha1_file.c | 12 ++++++------
 sha1_name.c | 50 ++++++++++++++++++++++++++++++--------------------
 3 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index d6ba8a2f11..00a017dfcb 100644
--- a/cache.h
+++ b/cache.h
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
+#include "sha1-array.h"
 
 #ifndef platform_SHA_CTX
 /*
@@ -1593,6 +1594,16 @@ extern struct alternate_object_database {
 	struct strbuf scratch;
 	size_t base_len;
 
+	/*
+	 * Used to store the results of readdir(3) calls when searching
+	 * for unique abbreviated hashes.  This cache is never
+	 * invalidated, thus it's racy and not necessarily accurate.
+	 * That's fine for its purpose; don't use it for tasks requiring
+	 * greater accuracy!
+	 */
+	char loose_objects_subdir_seen[256];
+	struct oid_array loose_objects_cache;
+
 	char path[FLEX_ARRAY];
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
@@ -1811,6 +1822,12 @@ typedef int each_loose_cruft_fn(const char *basename,
 typedef int each_loose_subdir_fn(int nr,
 				 const char *path,
 				 void *data);
+int for_each_file_in_obj_subdir(int subdir_nr,
+				struct strbuf *path,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data);
 int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_object_fn obj_cb,
 				  each_loose_cruft_fn cruft_cb,
diff --git a/sha1_file.c b/sha1_file.c
index 59a4ed2ed3..5e0ee2b68b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3735,12 +3735,12 @@ void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static int for_each_file_in_obj_subdir(int subdir_nr,
-				       struct strbuf *path,
-				       each_loose_object_fn obj_cb,
-				       each_loose_cruft_fn cruft_cb,
-				       each_loose_subdir_fn subdir_cb,
-				       void *data)
+int for_each_file_in_obj_subdir(int subdir_nr,
+				struct strbuf *path,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data)
 {
 	size_t baselen = path->len;
 	DIR *dir = opendir(path->buf);
diff --git a/sha1_name.c b/sha1_name.c
index 5126853bb5..ccb5144d0d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -77,10 +77,19 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	/* otherwise, current can be discarded and candidate is still good */
 }
 
+static int append_loose_object(const struct object_id *oid, const char *path,
+			       void *data)
+{
+	oid_array_append(data, oid);
+	return 0;
+}
+
+static int match_sha(unsigned, const unsigned char *, const unsigned char *);
+
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
+	int subdir_nr = ds->bin_pfx.hash[0];
 	struct alternate_object_database *alt;
-	char hex[GIT_MAX_HEXSZ];
 	static struct alternate_object_database *fakeent;
 
 	if (!fakeent) {
@@ -95,29 +104,30 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	}
 	fakeent->next = alt_odb_list;
 
-	xsnprintf(hex, sizeof(hex), "%.2s", ds->hex_pfx);
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
-		struct strbuf *buf = alt_scratch_buf(alt);
-		struct dirent *de;
-		DIR *dir;
-
-		strbuf_addf(buf, "%.2s/", ds->hex_pfx);
-		dir = opendir(buf->buf);
-		if (!dir)
-			continue;
+		int pos;
 
-		while (!ds->ambiguous && (de = readdir(dir)) != NULL) {
-			struct object_id oid;
+		if (!alt->loose_objects_subdir_seen[subdir_nr]) {
+			struct strbuf *buf = alt_scratch_buf(alt);
+			strbuf_addf(buf, "%02x/", subdir_nr);
+			for_each_file_in_obj_subdir(subdir_nr, buf,
+						    append_loose_object,
+						    NULL, NULL,
+						    &alt->loose_objects_cache);
+			alt->loose_objects_subdir_seen[subdir_nr] = 1;
+		}
 
-			if (strlen(de->d_name) != GIT_SHA1_HEXSZ - 2)
-				continue;
-			if (memcmp(de->d_name, ds->hex_pfx + 2, ds->len - 2))
-				continue;
-			memcpy(hex + 2, de->d_name, GIT_SHA1_HEXSZ - 2);
-			if (!get_oid_hex(hex, &oid))
-				update_candidates(ds, &oid);
+		pos = oid_array_lookup(&alt->loose_objects_cache, &ds->bin_pfx);
+		if (pos < 0)
+			pos = -1 - pos;
+		while (!ds->ambiguous && pos < alt->loose_objects_cache.nr) {
+			const struct object_id *oid;
+			oid = alt->loose_objects_cache.oid + pos;
+			if (!match_sha(ds->len, ds->bin_pfx.hash, oid->hash))
+				break;
+			update_candidates(ds, oid);
+			pos++;
 		}
-		closedir(dir);
 	}
 }
 
-- 
2.13.1

