Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE61C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 11:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiLFLjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiLFLi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 06:38:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D981403F
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 03:38:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id x22so5437824ejs.11
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 03:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0W80pOoxCVr8vrzjr2Uh4DUcFId4MjPDfvVZh7eOF5I=;
        b=oA1fMKJo+IaQgwOWkjR9m66FvDyyl4aAdrViZ44gU1pzf3bTr+H8n1qvZpTbhA0rbh
         RM1wvywr4Zwr6o6s4PlxPLD5ZbIHbT4OLbUf5xxtHZnICCvFtC6MWpubBXnnkamrxxhc
         7hXTUWaIoOCjNEo385XcZYEK4EDFo8NVeu1z3keYympG86teGzoNMn90i20xG1C0LR4d
         GYCLMcA8m35ac8d5dFvs/elvZRG5bMcXpFWnUOYpxCF4uzU5MX+/qYs4GgXwB5oSdOiJ
         8fmkS5Ta0HrI7ERD3uLwqGYqtAJ1uxvGam8YP9UWRNgxCa7rpD2PWsMReuQYLGhQf4rq
         kwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0W80pOoxCVr8vrzjr2Uh4DUcFId4MjPDfvVZh7eOF5I=;
        b=5c6RWACrhgmb+8sLrjeA5PPY+stuQUTbQoJp/WWMq8OOEjOTNQwmoDzhW4owtbcbjX
         QFnO5P6CY+37Ah9BVLn+W/poKevtTeiw4RFemMXHRksfPKuHgDaxPD6yDjnZxsvs5hxr
         hsFgwzhOS5TY9bpxCHkioR5QB30CLCaGRjmT0T3P1rxT/Sr4MssPvmOxWJhToIQCnwia
         /f2GmqdEaEMF4PTqxh/mqLOPHOsRQIzxE6QzpMIWGgotLQ6HDgZVA4oQgkJX5n816+pf
         xhutrzV9YOIw0eh+oG/eugNcAsQcLmGdsa4GQYod4E8QeSUyYYo0mR95pAGbQm6GP6mG
         La1w==
X-Gm-Message-State: ANoB5pkOOzHtommCg2VjMQavxo/TeyBN69g/z3uwwGI/N5Lpta/bPpnm
        wEBwMQ1Y/BjPBwVE40G5boieIe4753G29Q==
X-Google-Smtp-Source: AA0mqf663JbTqCh1n1sgttYQmel/g/r5gCiyX4GWuwYi6fukIT7Bd1t6+P88szjC82puLgA6IKgITQ==
X-Received: by 2002:a17:906:7ad0:b0:7c0:f9eb:61fd with SMTP id k16-20020a1709067ad000b007c0f9eb61fdmr5951842ejo.562.1670326735756;
        Tue, 06 Dec 2022 03:38:55 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b0046c4553010fsm893110edu.1.2022.12.06.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:38:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2WHm-003qIq-2Q;
        Tue, 06 Dec 2022 12:38:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 08/11] strbuf: introduce strbuf_strip_file_from_path()
Date:   Tue, 06 Dec 2022 12:37:15 +0100
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <1eec3426aee12bbd674ebd646075f0d4c0b1f5af.1670262639.git.gitgitgadget@gmail.com>
 <221206.86a640dda3.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <221206.86a640dda3.gmgdl@evledraar.gmail.com>
Message-ID: <221206.86wn74bw35.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Dec 05 2022, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The strbuf_parent_directory() method was added as a static method in
>> contrib/scalar by d0feac4e8c0 (scalar: 'register' sets recommended
>> config and starts maintenance, 2021-12-03) and then removed in
>> 65f6a9eb0b9 (scalar: constrain enlistment search, 2022-08-18), but now
>> there is a need for a similar method in the bundle URI feature.
>>
>> Re-add the method, this time in strbuf.c, but with a new name:
>> strbuf_strip_file_from_path(). The method requirements are slightly
>> modified to allow a trailing slash, in which case nothing is done, which
>> makes the name change valuable.
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  strbuf.c |  6 ++++++
>>  strbuf.h | 11 +++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index 0890b1405c5..c383f41a3c5 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -1200,3 +1200,9 @@ int strbuf_edit_interactively(struct strbuf *buffe=
r, const char *path,
>>  	free(path2);
>>  	return res;
>>  }
>> +
>> +void strbuf_strip_file_from_path(struct strbuf *sb)
>> +{
>> +	char *path_sep =3D find_last_dir_sep(sb->buf);
>> +	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
>> +}
>> diff --git a/strbuf.h b/strbuf.h
>> index 76965a17d44..f6dbb9681ee 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -664,6 +664,17 @@ int launch_sequence_editor(const char *path, struct=
 strbuf *buffer,
>>  int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>>  			      const char *const *env);
>>=20=20
>> +/*
>> + * Remove the filename from the provided path string. If the path
>> + * contains a trailing separator, then the path is considered a directo=
ry
>> + * and nothing is modified.
>> + *
>> + * Examples:
>> + * - "/path/to/file" -> "/path/to/"
>> + * - "/path/to/dir/" -> "/path/to/dir/"
>> + */
>> +void strbuf_strip_file_from_path(struct strbuf *sb);
>> +
>>  void strbuf_add_lines(struct strbuf *sb,
>>  		      const char *prefix,
>>  		      const char *buf,
>
> Re your reply in
> https://lore.kernel.org/git/0980dcd4-30eb-4ef4-9369-279abe5ca5a2@github.c=
om/
> I still don't get how this is different from a 1-byte change to
> strbuf_trim_trailing_dir_sep(), and if it isn't I think it's confusing
> API design to have two very different ways to return the same data.
>
> There you said "The difference is all about whether or not we start with
> a slash _and_ no other slash appears in the path.".
>
> But I can't find a case where there's any difference between the two. I
> tried this ad-hoc test on top:
>=20=09
> 	diff --git a/help.c b/help.c
> 	index f1e090a4428..b0866b01439 100644
> 	--- a/help.c
> 	+++ b/help.c
> 	@@ -765,6 +765,16 @@ int cmd_version(int argc, const char **argv, const =
char *prefix)
> 	 			 "also print build options"),
> 	 		OPT_END()
> 	 	};
> 	+	struct strbuf sb1 =3D STRBUF_INIT;
> 	+	struct strbuf sb2 =3D STRBUF_INIT;
> 	+
> 	+	if (getenv("STR")) {
> 	+		strbuf_addstr(&sb1, getenv("STR"));
> 	+		strbuf_addstr(&sb2, getenv("STR"));
> 	+		strbuf_strip_file_from_path(&sb1);
> 	+		strbuf_trim_trailing_not_dir_sep(&sb2);
> 	+		fprintf(stderr, "%s: %s | %s\n", strcmp(sb1.buf, sb2.buf) ? "NEQ" : "=
EQ", sb1.buf, sb2.buf);
> 	+	}
>=20=09=20
> 	 	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>=20=09=20
> 	diff --git a/strbuf.c b/strbuf.c
> 	index c383f41a3c5..f75d94556fc 100644
> 	--- a/strbuf.c
> 	+++ b/strbuf.c
> 	@@ -114,13 +114,23 @@ void strbuf_rtrim(struct strbuf *sb)
> 	 	sb->buf[sb->len] =3D '\0';
> 	 }
>=20=09=20
> 	-void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
> 	+static void strbuf_trim_trailing_dir_sep_1(struct strbuf *sb, int flip)
> 	 {
> 	-	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
> 	+	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]) =
- flip)
> 	 		sb->len--;
> 	 	sb->buf[sb->len] =3D '\0';
> 	 }
>=20=09=20
> 	+void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
> 	+{
> 	+	strbuf_trim_trailing_dir_sep_1(sb, 1);
> 	+}
> 	+
> 	+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb)
> 	+{
> 	+	strbuf_trim_trailing_dir_sep_1(sb, 1);
> 	+}
> 	+
> 	 void strbuf_trim_trailing_newline(struct strbuf *sb)
> 	 {
> 	 	if (sb->len > 0 && sb->buf[sb->len - 1] =3D=3D '\n') {
> 	diff --git a/strbuf.h b/strbuf.h
> 	index f6dbb9681ee..b936f45ffad 100644
> 	--- a/strbuf.h
> 	+++ b/strbuf.h
> 	@@ -189,6 +189,8 @@ void strbuf_ltrim(struct strbuf *sb);
>=20=09=20
> 	 /* Strip trailing directory separators */
> 	 void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
> 	+/* Strip trailing not-directory separators */
> 	+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb);
>=20=09=20
> 	 /* Strip trailing LF or CR/LF */
> 	 void strbuf_trim_trailing_newline(struct strbuf *sb);
>
> Then:
>=20=09
> 	$ for str in a / b/ /c /d/ /e/ /f/g /h/i/ j/k l//m n/o/p //q/r/s/t; do S=
TR=3D$str ./git version; done 2>&1 | grep :
> 	EQ:  |=20
> 	EQ: / | /
> 	EQ: b/ | b/
> 	EQ: / | /
> 	EQ: /d/ | /d/
> 	EQ: /e/ | /e/
> 	EQ: /f/ | /f/
> 	EQ: /h/i/ | /h/i/
> 	EQ: j/ | j/
> 	EQ: l// | l//
> 	EQ: n/o/ | n/o/
> 	EQ: //q/r/s/ | //q/r/s/
>
> I.e. for those inputs it's the same as the existing
> strbuf_trim_trailing_dir_sep() with an inverted test. Is there some edge
> case that I'm missing?

FWIW the "overkill" change on top to do this via callbacks is the
below. Which I tested just to see how easy it was, and whether it would
fail your tests (it doesn't).

-- >8 --
Subject: [PATCH] strbuf: generalize "{,r,l}trim" to a callback interface

We've had all three variants of "trim" for isspace(), then since
c64a8d200f4 (worktree move: accept destination as directory,
2018-02-12) we've had a "is_dir_sep" variant.

A preceding change then added a "!is_dir_sep" variant. Let's
generalize this, and have all these functions that want to trim
characters matching some criteria be driven by the same logic.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 bundle-uri.c      |  7 +------
 git-compat-util.h |  5 +++++
 strbuf.c          | 44 ++++++++++++++++++++++++++++----------------
 strbuf.h          | 41 +++++++++++++++++++++++++++--------------
 4 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index c411b871bdd..7240dedcaee 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -195,13 +195,8 @@ int bundle_uri_parse_config_format(const char *uri,
 	if (!list->baseURI) {
 		struct strbuf baseURI =3D STRBUF_INIT;
 		strbuf_addstr(&baseURI, uri);
+		strbuf_trim_trailing_not_dir_sep(&baseURI);
=20
-		/*
-		 * If the URI does not end with a trailing slash, then
-		 * remove the filename portion of the path. This is
-		 * important for relative URIs.
-		 */
-		strbuf_strip_file_from_path(&baseURI);
 		list->baseURI =3D strbuf_detach(&baseURI, NULL);
 	}
 	result =3D git_config_from_file_with_options(config_to_bundle_list,
diff --git a/git-compat-util.h b/git-compat-util.h
index a76d0526f79..5bce9fa768c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -451,6 +451,11 @@ static inline int git_is_dir_sep(int c)
 #define is_dir_sep git_is_dir_sep
 #endif
=20
+static inline int is_not_dir_sep(int c)
+{
+	return !is_dir_sep(c);
+}
+
 #ifndef offset_1st_component
 static inline int git_offset_1st_component(const char *path)
 {
diff --git a/strbuf.c b/strbuf.c
index c383f41a3c5..a5a1c01d539 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -101,24 +101,37 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 		sb->buf[0] =3D '\0';
 }
=20
-void strbuf_trim(struct strbuf *sb)
+void strbuf_trim_fn(struct strbuf *sb, strbuf_ctype_fn_t fn)
 {
-	strbuf_rtrim(sb);
-	strbuf_ltrim(sb);
+	strbuf_rtrim_fn(sb, fn);
+	strbuf_ltrim_fn(sb, fn);
 }
=20
-void strbuf_rtrim(struct strbuf *sb)
+void strbuf_rtrim_fn(struct strbuf *sb, strbuf_ctype_fn_t fn)
 {
-	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
+	while (sb->len > 0 && fn((unsigned char)sb->buf[sb->len - 1]))
 		sb->len--;
 	sb->buf[sb->len] =3D '\0';
 }
=20
+void strbuf_trim(struct strbuf *sb)
+{
+	strbuf_trim_fn(sb, strbuf_ctype_isspace);
+}
+
+void strbuf_rtrim(struct strbuf *sb)
+{
+	strbuf_rtrim_fn(sb, strbuf_ctype_isspace);
+}
+
 void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 {
-	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
-		sb->len--;
-	sb->buf[sb->len] =3D '\0';
+	strbuf_rtrim_fn(sb, is_dir_sep);
+}
+
+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb)
+{
+	strbuf_rtrim_fn(sb, is_not_dir_sep);
 }
=20
 void strbuf_trim_trailing_newline(struct strbuf *sb)
@@ -130,10 +143,10 @@ void strbuf_trim_trailing_newline(struct strbuf *sb)
 	}
 }
=20
-void strbuf_ltrim(struct strbuf *sb)
+void strbuf_ltrim_fn(struct strbuf *sb, strbuf_ctype_fn_t fn)
 {
 	char *b =3D sb->buf;
-	while (sb->len > 0 && isspace(*b)) {
+	while (sb->len > 0 && fn(*b)) {
 		b++;
 		sb->len--;
 	}
@@ -141,6 +154,11 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] =3D '\0';
 }
=20
+void strbuf_ltrim(struct strbuf *sb)
+{
+	strbuf_ltrim_fn(sb, strbuf_ctype_isspace);
+}
+
 int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 {
 	char *out;
@@ -1200,9 +1218,3 @@ int strbuf_edit_interactively(struct strbuf *buffer, =
const char *path,
 	free(path2);
 	return res;
 }
-
-void strbuf_strip_file_from_path(struct strbuf *sb)
-{
-	char *path_sep =3D find_last_dir_sep(sb->buf);
-	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
-}
diff --git a/strbuf.h b/strbuf.h
index f6dbb9681ee..bb7aa38816f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -180,15 +180,39 @@ static inline void strbuf_setlen(struct strbuf *sb, s=
ize_t len)
  */
=20
 /**
- * Strip whitespace from the beginning (`ltrim`), end (`rtrim`), or both s=
ide
- * (`trim`) of a string.
+ * A callback function that acts like the macros defined in
+ * <ctype.h>. To be given to strbuf_{,r,l}trim() below.
+ */
+typedef int (*strbuf_ctype_fn_t)(int c);
+static inline int strbuf_ctype_isspace(int c) { return isspace(c); }
+
+/**
+ * Strip characters matching the 'strbuf_ctype_fn_t' from the
+ * beginning (`ltrim`), end (`rtrim`) or both sides (`trim`) of a
+ * string.
+ */
+void strbuf_trim_fn(struct strbuf *sb, strbuf_ctype_fn_t fn);
+void strbuf_rtrim_fn(struct strbuf *sb, strbuf_ctype_fn_t fn);
+void strbuf_ltrim_fn(struct strbuf *sb, strbuf_ctype_fn_t fn);
+
+/**
+ * The common-case wrapper for strbuf_{,r,l}trim_fn() uses the
+ * strbuf_ctype_isspace() callback function.
  */
 void strbuf_trim(struct strbuf *sb);
 void strbuf_rtrim(struct strbuf *sb);
 void strbuf_ltrim(struct strbuf *sb);
=20
-/* Strip trailing directory separators */
+/**
+ * Strip trailing directory separators. This is strbuf_rtrim_fn() with
+ * is_dir_sep() as the callback..
+ */
 void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
+/**
+ * Strip trailing not-directory separators. This is strbuf_rtrim_fn()
+ * with is_not_dir_sep() as the callback.
+ */
+void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb);
=20
 /* Strip trailing LF or CR/LF */
 void strbuf_trim_trailing_newline(struct strbuf *sb);
@@ -664,17 +688,6 @@ int launch_sequence_editor(const char *path, struct st=
rbuf *buffer,
 int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
 			      const char *const *env);
=20
-/*
- * Remove the filename from the provided path string. If the path
- * contains a trailing separator, then the path is considered a directory
- * and nothing is modified.
- *
- * Examples:
- * - "/path/to/file" -> "/path/to/"
- * - "/path/to/dir/" -> "/path/to/dir/"
- */
-void strbuf_strip_file_from_path(struct strbuf *sb);
-
 void strbuf_add_lines(struct strbuf *sb,
 		      const char *prefix,
 		      const char *buf,
--=20
2.39.0.rc1.1014.gc37e9814e18

