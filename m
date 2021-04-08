Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85F6C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986B2610A6
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhDHXYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXYM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:24:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8525C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:24:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hq27so5731302ejc.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LNgKVBA6MCqipTlZt4GmhTwnfRbMlH9oh/wPiPKB4YU=;
        b=tU3jIdGGBCOGmfjzPeYiTp80f2Bq24nvw33v3ySNhKzdaG31sNNXWTRu+LMd/4LDCu
         YHlLc24U59eE9o2LvLMenUZUEsDp7FHXDWkARkdrDipPC2ZZIVI7SjCANgqEqw/kPOH9
         BBO7EVUMXCQnDKSzuENwReCPK/Z4LElj/KXGZmiz2jCfLCXezXEm2tOopdXmCMuJlQyw
         jgNzkhuaep6E0X14ip0X241vjKEtBtpUdbPGTURGYHsd7EO6EyK2WGkE+5c+RMcyVd+/
         ip/KNB5KBSwre963rxZKxRjdX7iqI0n2OVLw47Hdv4ECFZJRfNBylHDwruuOwsDzyu7p
         AGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LNgKVBA6MCqipTlZt4GmhTwnfRbMlH9oh/wPiPKB4YU=;
        b=dTqgvKgmQT9ZX2EVDdGXCchBqVXTrOpxep6KzTctyPk5AvuympqvRM7sUxFZo3dp65
         iAOAOS9o9w5m872T9cx2EmmyturBzU5e04sVmQPuz2n7KJp8Ofw9RKJkCacagMq6glR5
         5jI1LiEVNiOxL7qoL1LQkH8shlZxAUUrPiYTp2hpVNSlHAgOsTYecIA6P/4h/EIJHe0J
         NS3MFYUTiVl1ZV/qbQ/zlboXFfCSLXpiblANTB/v24/zVdn/VwGZojLAZKRvlQKYGCFt
         nVY0fKBVu/ix+kxtzS7dlxyZ8zVs/ELOkGD/EFy/mKj97CdZ2VpJ2JnhU4Jz2eAiZv4e
         ANVA==
X-Gm-Message-State: AOAM530lNvqYBXOqqSXhRxExG8awx8mmNJbFyFEblF5wSZiIPJoLnwdu
        OSuKXXciyg3G9iCf3mxTLr0=
X-Google-Smtp-Source: ABdhPJztFteXIYl5Bcx6LIF49zqCgAuZr8bWatmAnzIWaa1y83/hsdaMnF5yTCIBBoUCXYIeheS3rA==
X-Received: by 2002:a17:906:c2cc:: with SMTP id ch12mr13367411ejb.258.1617924239296;
        Thu, 08 Apr 2021 16:23:59 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b24sm370270ejq.75.2021.04.08.16.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:23:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
 <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
 <xmqqa6q8tymu.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqa6q8tymu.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 01:23:58 +0200
Message-ID: <875z0wicmp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add "tristate" functions to go along with the "bool" functions and
>> migrate the common pattern of checking if something is "bool" or
>> "auto" in various places over to the new functions.
>>
>> We also have e.g. "repo_config_get_bool" and
>> "config_error_nonbool". I'm not adding corresponding "tristate"
>> functions as they're not needed by anything, but we could add those in
>> the future if they are.
>>
>> I'm not migrating over "core.abbrev" parsing as part of this
>> change. When "core.abbrev" was made optionally boolean in
>> a9ecaa06a7 (core.abbrev=3Dno disables abbreviations, 2020-09-01) the
>> "die if empty" code added in g48d5014dd4 (config.abbrev: document the
>> new default that auto-scales, 2016-11-01) wasn't adjusted. It thus
>> behaves unlike all other "maybe bool" config variables.
>>
>> I have a planned series to start adding some tests for "core.abbrev",
>> but AFAICT there's not even a test for "core.abbrev=3Dtrue", and I'd
>> like to focus on thing that have no behavior change here, so let's
>> leave it for now.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/log.c  | 13 +++++++------
>>  compat/mingw.c |  6 +++---
>>  config.c       | 16 ++++++++++++++++
>>  config.h       | 12 ++++++++++++
>>  http.c         |  5 +++--
>>  userdiff.c     |  6 ++----
>>  6 files changed, 43 insertions(+), 15 deletions(-)
>
>> diff --git a/config.c b/config.c
>> index fc28dbd97c..74d2b2c0df 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1257,6 +1257,14 @@ int git_parse_maybe_bool(const char *value)
>>  	return -1;
>>  }
>>=20=20
>> +int git_parse_maybe_tristate(const char *value)
>> +{
>> +	int v =3D git_parse_maybe_bool(value);
>> +	if (v < 0 && !strcasecmp(value, "auto"))
>> +		return 2;
>> +	return v;
>> +}
>
> This is not parse_mayb_bool_text(), so "1" and "-1" written in the
> configuration file are "true", "0" is "false", like the "bool" case.
>
> I wonder if written without an unnecessary extra variable, i.e.
>
> 	if (value && !strcasecmp(value, "auto"))
> 		return 2;
> 	return git_parse_maybe_bool(value);
>
> is easier to follow, though, as it is quite clear that it is mostly
> the same as maybe_bool and the only difference is when "auto" is
> given.

I guess it could be either way around, I think it makes more sense to
have git_parse_maybe_bool() handle as much as possible right from the
get-go, since it already handles NULL if we call it first we just need
to care about cases where it's looked at all the "is this bool-like"
permutations and decided to reject it.

>> +int git_config_tristate(const char *name, const char *value)
>> +{
>> +	int v =3D git_parse_maybe_tristate(value);
>> +	if (v < 0)
>> +		die(_("bad tristate config value '%s' for '%s'"), value, name);
>> +	return v;
>> +}
>
> OK.
>
>> diff --git a/config.h b/config.h
>> index 19a9adbaa9..c5129e4392 100644
>> --- a/config.h
>> +++ b/config.h
>> @@ -197,6 +197,12 @@ int git_parse_ulong(const char *, unsigned long *);
>>   */
>>  int git_parse_maybe_bool(const char *);
>>=20=20
>> +/**
>> + * Same as `git_parse_maybe_bool`, except that "auto" is recognized and
>> + * will return "2".
>> + */
>> +int git_parse_maybe_tristate(const char *);
>
> A false being 0 and a true being 1 is understandable for readers
> without symbolic constant, but "2" deserves to have a symbolic
> constant, doesn't it?
>
>> @@ -226,6 +232,12 @@ int git_config_bool_or_int(const char *, const char=
 *, int *);
>>   */
>>  int git_config_bool(const char *, const char *);
>>=20=20
>> +/**
>> + * Like git_config_bool() except "auto" is also recognized and will
>> + * return "2"
>> + */
>> +int git_config_tristate(const char *, const char *);
>
> Likewise.

I'd prefer to just make these "enum", which means we'll have the aid of
the compiler in checking all the callsites, as in the patch-on-top
(which I can squash appropriately, need to update the doc comments
though) at the end of this E-Mail.

It's a bit of boilerplate, and it's unfortunate that subset/supersets of
enums aren't better supported in C (so e.g. you could have different
types share some of the same label names), but I think being able to
look at any given use and know the compiler is checking whether the case
statements (there's no "default") are exhaustively enumerated is worth
it.

But I wasn't sure you'd prefet that, especially (and maybe I read too
much into it) with me replacing -1 with OBJ_BAD in another topic, as
GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_BAD does here.

In this case most of the callsites don't need to deal with the "BAD"
value, but for other things in config.c and this sort of code in general
if we're going to insist on "v < 0" over explicit labels the benefit of
using enum/switch pretty much goes away.

I mean, we could not do the enum/switch/case implementation and just
have a "#define" to give "2" a pretty name, but at that point anything
beyond that is pretty pointless, i.e. we can just make the function
return an "int" if we're not hoping to have the compiler check the enum
values.

diff --git a/builtin/config.c b/builtin/config.c
index 039a4f0961..a5d7efc8bc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -268,11 +268,18 @@ static int format_config(struct strbuf *buf, const ch=
ar *key_, const char *value
 			else
 				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type =3D=3D TYPE_BOOL_OR_AUTO) {
-			int v =3D git_config_tristate(key_, value_);
-			if (v =3D=3D 2)
+			enum git_config_type_bool_or_auto v =3D git_config_tristate(key_, value=
_);
+			switch (v) {
+			case GIT_CONFIG_TYPE_BOOL_OR_AUTO_FALSE:
+				strbuf_addstr(buf, "false");
+				break;
+			case GIT_CONFIG_TYPE_BOOL_OR_AUTO_TRUE:
+				strbuf_addstr(buf, "true");
+				break;
+			case GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO:
 				strbuf_addstr(buf, "auto");
-			else
-				strbuf_addstr(buf, v ? "true" : "false");
+				break;
+			}
 		} else if (type =3D=3D TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
@@ -446,13 +453,17 @@ static char *normalize_value(const char *key, const c=
har *value)
 			return xstrdup(v ? "true" : "false");
 	}
 	if (type =3D=3D TYPE_BOOL_OR_AUTO) {
-		int v =3D git_parse_maybe_tristate(value);
-		if (v < 0)
+		enum git_config_type_maybe_bool_or_auto v =3D git_parse_maybe_tristate(v=
alue);=20
+		switch (v) {
+		case GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_BAD:
 			return xstrdup(value);
-		else if (v =3D=3D 2)
-			xstrdup("auto");
-		else
-			return xstrdup(v ? "true" : "false");
+		case GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_FALSE:
+			return xstrdup("false");
+		case GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_TRUE:
+			return xstrdup("true");
+		case GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_AUTO:
+			return xstrdup("auto");
+		}
 	}
 	if (type =3D=3D TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
diff --git a/builtin/log.c b/builtin/log.c
index 0d945313d8..f363c841a7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -868,14 +868,17 @@ static int git_format_config(const char *var, const c=
har *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
-		int tristate =3D git_config_tristate(var, value);
-		if (tristate =3D=3D 2) {
+		enum git_config_type_bool_or_auto v =3D git_config_tristate(var, value);
+		switch (v) {
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_FALSE:
 			auto_number =3D 1;
 			return 0;
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_TRUE:
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO:
+			numbered =3D v;
+			auto_number =3D auto_number && numbered;
+			return 0;
 		}
-		numbered =3D tristate;
-		auto_number =3D auto_number && numbered;
-		return 0;
 	}
 	if (!strcmp(var, "format.attach")) {
 		if (value && *value)
@@ -905,12 +908,18 @@ static int git_format_config(const char *var, const c=
har *value, void *cb)
 	if (!strcmp(var, "format.signaturefile"))
 		return git_config_pathname(&signature_file, var, value);
 	if (!strcmp(var, "format.coverletter")) {
-		int tristate =3D git_config_tristate(var, value);
-		if (tristate =3D=3D 2)
+		enum git_config_type_bool_or_auto v =3D git_config_tristate(var, value);
+		switch (v) {
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_FALSE:
+			config_cover_letter =3D COVER_OFF;
+			return 0;
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_TRUE:
+			config_cover_letter =3D COVER_ON;
+			return 0;
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO:
 			config_cover_letter =3D COVER_AUTO;
-		else
-			config_cover_letter =3D tristate ? COVER_ON : COVER_OFF;
-		return 0;
+			return 0;
+		}
 	}
 	if (!strcmp(var, "format.outputdirectory"))
 		return git_config_string(&config_output_directory, var, value);
diff --git a/compat/mingw.c b/compat/mingw.c
index e6e85ae99a..b76ccc0a15 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -247,12 +247,16 @@ int mingw_core_config(const char *var, const char *va=
lue, void *cb)
 	}
=20
 	if (!strcmp(var, "core.restrictinheritedhandles")) {
-		int tristate =3D git_config_tristate(var, value);
-		if (tristate =3D=3D 2)
+		enum git_config_type_bool_or_auto v =3D git_config_tristate(var, value);
+		switch (v) {
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_FALSE:
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_TRUE:
+			core_restrict_inherited_handles =3D v;
+			return 0;
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO:
 			core_restrict_inherited_handles =3D -1;
-		else
-			core_restrict_inherited_handles =3D tristate;
-		return 0;
+			return 0;
+		}
 	}
=20
 	return 0;
diff --git a/config.c b/config.c
index 74d2b2c0df..3375895b80 100644
--- a/config.c
+++ b/config.c
@@ -1257,11 +1257,11 @@ int git_parse_maybe_bool(const char *value)
 	return -1;
 }
=20
-int git_parse_maybe_tristate(const char *value)
+enum git_config_type_maybe_bool_or_auto git_parse_maybe_tristate(const cha=
r *value)
 {
 	int v =3D git_parse_maybe_bool(value);
 	if (v < 0 && !strcasecmp(value, "auto"))
-		return 2;
+		return GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO;
 	return v;
 }
=20
@@ -1276,9 +1276,10 @@ int git_config_bool_or_int(const char *name, const c=
har *value, int *is_bool)
 	return git_config_int(name, value);
 }
=20
-int git_config_tristate(const char *name, const char *value)
+enum git_config_type_bool_or_auto git_config_tristate(const char *name,
+						      const char *value)
 {
-	int v =3D git_parse_maybe_tristate(value);
+	enum git_config_type_maybe_bool_or_auto v =3D git_parse_maybe_tristate(va=
lue);
 	if (v < 0)
 		die(_("bad tristate config value '%s' for '%s'"), value, name);
 	return v;
diff --git a/config.h b/config.h
index c5129e4392..70684ecb3c 100644
--- a/config.h
+++ b/config.h
@@ -201,7 +201,14 @@ int git_parse_maybe_bool(const char *);
  * Same as `git_parse_maybe_bool`, except that "auto" is recognized and
  * will return "2".
  */
-int git_parse_maybe_tristate(const char *);
+enum git_config_type_maybe_bool_or_auto {
+	GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_BAD   =3D -1,
+	GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_FALSE =3D 0,
+	GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_TRUE  =3D 1,
+	GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO_AUTO  =3D 2,
+};
+=09
+enum git_config_type_maybe_bool_or_auto git_parse_maybe_tristate(const cha=
r *);
=20
 /**
  * Parse the string to an integer, including unit factors. Dies on error;
@@ -236,7 +243,13 @@ int git_config_bool(const char *, const char *);
  * Like git_config_bool() except "auto" is also recognized and will
  * return "2"
  */
-int git_config_tristate(const char *, const char *);
+enum git_config_type_bool_or_auto {
+	GIT_CONFIG_TYPE_BOOL_OR_AUTO_FALSE =3D GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO=
_FALSE,
+	GIT_CONFIG_TYPE_BOOL_OR_AUTO_TRUE  =3D GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO=
_TRUE,
+	GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO  =3D GIT_CONFIG_TYPE_MAYBE_BOOL_OR_AUTO=
_AUTO,
+};
+enum git_config_type_bool_or_auto git_config_tristate(const char *name,
+						      const char *value);
=20
 /**
  * Allocates and copies the value string into the `dest` parameter; if no
diff --git a/http.c b/http.c
index b54a232e90..6dd6191517 100644
--- a/http.c
+++ b/http.c
@@ -406,12 +406,16 @@ static int http_options(const char *var, const char *=
value, void *cb)
 		return git_config_string(&user_agent, var, value);
=20
 	if (!strcmp("http.emptyauth", var)) {
-		int tristate =3D git_config_tristate(var, value);
-		if (tristate =3D=3D 2)
+		enum git_config_type_bool_or_auto v =3D git_config_tristate(var, value);
+		switch (v) {
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_FALSE:
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_TRUE:
+			curl_empty_auth =3D v;
+			return 0;
+		case GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO:
 			curl_empty_auth =3D -1;
-		else
-			curl_empty_auth =3D tristate;
-		return 0;
+			return 0;
+		}
 	}
=20
 	if (!strcmp("http.delegation", var)) {
diff --git a/userdiff.c b/userdiff.c
index 7ff010961f..fe001563c3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -277,8 +277,16 @@ static int parse_funcname(struct userdiff_funcname *f,=
 const char *k,
=20
 static int parse_tristate(int *b, const char *k, const char *v)
 {
-	int tristate =3D git_config_tristate(k, v);
-	*b =3D tristate =3D=3D 2 ? -1 : tristate;
+	enum git_config_type_bool_or_auto tristate =3D git_config_tristate(k, v);
+	switch (tristate) {
+	case GIT_CONFIG_TYPE_BOOL_OR_AUTO_FALSE:
+	case GIT_CONFIG_TYPE_BOOL_OR_AUTO_TRUE:
+		*b =3D tristate;
+		break;
+	case GIT_CONFIG_TYPE_BOOL_OR_AUTO_AUTO:
+		*b =3D -1;
+		break;
+	}
 	return 0;
 }
=20

