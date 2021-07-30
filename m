Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6BEC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAB560F00
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 19:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhG3THM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 15:07:12 -0400
Received: from mout.web.de ([212.227.15.4]:41275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhG3THL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 15:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1627672018;
        bh=cW2NUh9eJGPgyUnoQULQf4B1h37F1PXTscJKOOmywz4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=IkuaXENnvYL4tnyVlitT/qFkFpS0FNw6StV0wq3N8m68ojR5uDS+MBj0lctqrhWQW
         4a7n4qSzpvw+IRM7SMhBLW80VdRBlQOOQl6HNCNB4lS59oOTiMI50wSUQQzIH6oLJC
         zVQuX8V3r02zb5K4S5mgWYtPJgypbsQFUDUkWS3U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.106]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LeLin-1mxUWl3O1t-00q9I1; Fri, 30 Jul 2021 21:06:58 +0200
X-Mozilla-News-Host: news://public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use fspathhash() everywhere
Message-ID: <b85ed04f-ef9c-f460-e21b-bd1f8dfba9e2@web.de>
Date:   Fri, 30 Jul 2021 21:06:58 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ddUycUVC4VrtUayOCd+mLA5eJixkMoK/aITjbdZRVhj17x48qHv
 9sjZDZsizVmaogapucG3Fi6JrZN4vMTXSaJNnqubgxO7ufcRiSh4Y+ZE1pBg1Em2Qy1RPuP
 YKwSHN+20ZXV1IhIvgmShhC1QdeMNBgbhSkpuDa8Lx+lPPteRmKR6BnT+LGSd5D9/vu+Ax4
 oMTbxRd1FDQp5iDGSJcxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gf1WQxt102E=:V6hvQ7SYb7ywksDdESKYOM
 ZdrS6yvGuQq0V5eVbtfA9W2xOyJn6H2d4KqWSTktRkyZhOBnLF8WcCW7YT9YDGkAB3eTcpb8f
 RlOzIBpN4Pbno44zOCHfvD4CU0yIKA3H18OEloXR0JmAZTCeYlmFB3vNb4JTCxMXKFVmCBFfJ
 nUeEL/LQ35EbE3dyf2iv8iRMFHUIyUU3ajUUMy9gvE2uQvkPssz5c3fYQHb29Wu2HZ8KNqsmi
 NsKpCBJqYMEzjO3qdv9YMp6a0BSM5UoHmG2Fx2Uvh1wyoIeVpLCGOkgOdenuBIzGe6OZym/9n
 nPPTgNXsyLtfac6pPXY0YO9CMCF4dfzGukU3H0OZ7IKK62nUey2AIZ+f3Wc6AYbQeVoiQbe08
 FKjVd/Z+mn9weVDZ6nBuxs+HKV5zMG416Y827h8/nJ9PnrG03nGvN0BnelOEuyVpc2rA8YWzg
 vOozCQoucrfL/XEGEvzu89EDZFFIcXgCC1M5Q43n574qJiOG6Nctl+kcUkkcktwEV7TUggrTP
 dR1Aef7hJCpx8zy9hfBzuPyvoLf5wpZ/ayo2A/bbl6htfy0C3ewX0KDZfqqILFFohFH95ohvJ
 xOyNqY39GYmedAyMPJx+XDf8E7CQ+laKtGBV4sXyAty63WO2I/tt8QUWeIgc5vHKkGUd49txI
 OWhurxOqjK8ieMNp+iQ8QqyRxAwpeQ5SzY9hREYEwa6hEGXGTb45lHaJC7g7drFomZJGQw6H0
 Zh0J2zxyLOKJrvKOIGBb+VqIXYuTuxX8wPP4VKdpuN/xNuHlYpNvRgicY58E4vlqXZ8/00Cru
 fj4trpzLzAbHslkyj/9rmPN4jUDv1EsTn9j6H9fkavsdrjxjN0I793ZATmuQ8Q4OjEAE48oh/
 xUU/thcSDPREfL7d9pu8dflYmXpOQqqAgwWLalasKXyHkELaBRRYThBnNpekHP0C8q2QOiTOv
 P4mRG0C4DOH8LpV0sxifOz24j7+Ieya4Rli54NPclh8p4lrUSVUhDfB/bcj9SFRrEXvnntLD5
 7t7cIKx5Y7HWCNag/iWrUPkKe+wdLyXKdBHIe9tfyPT5JUPxczn8pdIusNakQoQzxDSUekfF4
 UqLQs+x5/7W76PzM0x2AoJS1bEGPc8zVBCE
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
introduced the function fspathhash() for calculating path hashes while
respecting the configuration option core.ignorecase.  Call it instead of
open-coding it; the resulting code is shorter and less repetitive.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/sparse-checkout.c | 10 ++--------
 dir.c                     | 13 +++----------
 merge-recursive.c         | 11 +++--------
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a4bdd7c494..8ba9f13787 100644
=2D-- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -380,10 +380,7 @@ static void insert_recursive_pattern(struct pattern_l=
ist *pl, struct strbuf *pat
 	struct pattern_entry *e =3D xmalloc(sizeof(*e));
 	e->patternlen =3D path->len;
 	e->pattern =3D strbuf_detach(path, NULL);
-	hashmap_entry_init(&e->ent,
-			   ignore_case ?
-			   strihash(e->pattern) :
-			   strhash(e->pattern));
+	hashmap_entry_init(&e->ent, fspathhash(e->pattern));

 	hashmap_add(&pl->recursive_hashmap, &e->ent);

@@ -399,10 +396,7 @@ static void insert_recursive_pattern(struct pattern_l=
ist *pl, struct strbuf *pat
 		e =3D xmalloc(sizeof(struct pattern_entry));
 		e->patternlen =3D newlen;
 		e->pattern =3D xstrndup(oldpattern, newlen);
-		hashmap_entry_init(&e->ent,
-				   ignore_case ?
-				   strihash(e->pattern) :
-				   strhash(e->pattern));
+		hashmap_entry_init(&e->ent, fspathhash(e->pattern));

 		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
 			hashmap_add(&pl->parent_hashmap, &e->ent);
diff --git a/dir.c b/dir.c
index 23b4417268..03c4d21267 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -782,9 +782,7 @@ static void add_pattern_to_hashsets(struct pattern_lis=
t *pl, struct path_pattern
 		translated->pattern =3D truncated;
 		translated->patternlen =3D given->patternlen - 2;
 		hashmap_entry_init(&translated->ent,
-				   ignore_case ?
-				   strihash(translated->pattern) :
-				   strhash(translated->pattern));
+				   fspathhash(translated->pattern));

 		if (!hashmap_get_entry(&pl->recursive_hashmap,
 				       translated, ent, NULL)) {
@@ -813,9 +811,7 @@ static void add_pattern_to_hashsets(struct pattern_lis=
t *pl, struct path_pattern
 	translated->pattern =3D dup_and_filter_pattern(given->pattern);
 	translated->patternlen =3D given->patternlen;
 	hashmap_entry_init(&translated->ent,
-			   ignore_case ?
-			   strihash(translated->pattern) :
-			   strhash(translated->pattern));
+			   fspathhash(translated->pattern));

 	hashmap_add(&pl->recursive_hashmap, &translated->ent);

@@ -845,10 +841,7 @@ static int hashmap_contains_path(struct hashmap *map,
 	/* Check straight mapping */
 	p.pattern =3D pattern->buf;
 	p.patternlen =3D pattern->len;
-	hashmap_entry_init(&p.ent,
-			   ignore_case ?
-			   strihash(p.pattern) :
-			   strhash(p.pattern));
+	hashmap_entry_init(&p.ent, fspathhash(p.pattern));
 	return !!hashmap_get_entry(map, &p, ent, NULL);
 }

diff --git a/merge-recursive.c b/merge-recursive.c
index 7008a90df5..3355d50e8a 100644
=2D-- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -61,11 +61,6 @@ static int path_hashmap_cmp(const void *cmp_data,
 		return strcmp(a->path, key ? key : b->path);
 }

-static unsigned int path_hash(const char *path)
-{
-	return ignore_case ? strihash(path) : strhash(path);
-}
-
 /*
  * For dir_rename_entry, directory names are stored as a full path from t=
he
  * toplevel of the repository and do not include a trailing '/'.  Also:
@@ -463,7 +458,7 @@ static int save_files_dirs(const struct object_id *oid=
,
 	strbuf_addstr(base, path);

 	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
-	hashmap_entry_init(&entry->e, path_hash(entry->path));
+	hashmap_entry_init(&entry->e, fspathhash(entry->path));
 	hashmap_add(&opt->priv->current_file_dir_set, &entry->e);

 	strbuf_setlen(base, baselen);
@@ -737,14 +732,14 @@ static char *unique_path(struct merge_options *opt,

 	base_len =3D newpath.len;
 	while (hashmap_get_from_hash(&opt->priv->current_file_dir_set,
-				     path_hash(newpath.buf), newpath.buf) ||
+				     fspathhash(newpath.buf), newpath.buf) ||
 	       (!opt->priv->call_depth && file_exists(newpath.buf))) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}

 	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
-	hashmap_entry_init(&entry->e, path_hash(entry->path));
+	hashmap_entry_init(&entry->e, fspathhash(entry->path));
 	hashmap_add(&opt->priv->current_file_dir_set, &entry->e);
 	return strbuf_detach(&newpath, NULL);
 }
=2D-
2.32.0

