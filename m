Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B9DC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 14:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376623AbiFPObZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiFPObX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 10:31:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765512D37
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 07:31:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x62so2438633ede.10
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zBvpNtXYO/snBjCUywOUahvonRH6UfnNe0AXKV+L4kA=;
        b=O/gwa8hNS2u7mMJYKZaHvIJXVwE+jaR+AYJX9GSVOWBWfUw43UUB9RybATtuYlcfh9
         0wG9BRLO3U4d74l2uhKThRkoOME51l6ReSQDoJdSELhsAKLJ9lwOrfzYEGhip9AK/2Cr
         vxRP3K1bV0A46Q+z8lmj//3EwKa/x5XjkSlizcsC/Vbs8pzNNXJMougTZTjM4V0OEXZ+
         h2JArpu1m70cYDCcVxT4hMV/IAdYP4bs4lMT4QhDUkS+/08sLBMuqlaHdUSciWKOfzoE
         xK7Lfb3SyyCt0+ufqMCaM7FUHoF0/MLhIeKLvxUZmD9OM9sdMgedbEy0VKNPgKZ02a0T
         UBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zBvpNtXYO/snBjCUywOUahvonRH6UfnNe0AXKV+L4kA=;
        b=MZ6286b90pMvfatd3qTa+4Z9lsXf/2j4riiYZp4EO6fx0/ZKWdDOQ8yo3zZOpjUqjm
         zo9RU17NLsgqfnnWsx64hP+IG753TDqLTPL4ESr99AORYcfNy98JaplDh3TU4jPEYjdM
         ehDIHnPfdP5UWgO8DSrUB6jh1iT63EuH9hyWl1q1V6rPRsTncwyqn1cKCSf1BeAW7R4t
         busXufTLaKYZHESzW8mpNJr+Er94Ia5HxiLVJRBZgCDVRgrta83zfIIo3E1NeFx1BVC7
         +5H3IvLzIDGgJCgeFCNVvmlARyVN2k3mWm0s2pZXDDpt7dYTU3oBbO1KPzUjVjJ8XyT2
         dxFA==
X-Gm-Message-State: AJIora/G/eZTUHhgoKfSPN87z1ZH9htk74vm5E4NKFsh7Hhl0jMQEAMI
        pCBPCcMNZRzHH0VfsW+/byFNeagPj+Q=
X-Google-Smtp-Source: AGRyM1ufew9ziyDS2tIHFap1haKMOiRufXqwPkkmk4BFv+6OLTjajktJD0KCus5xfXF8FYnEEWHRng==
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id ew4-20020a056402538400b004316d84b451mr6899760edb.46.1655389880309;
        Thu, 16 Jun 2022 07:31:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907039100b006fed787478asm849880ejb.92.2022.06.16.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:31:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1qWk-0016cp-Tl;
        Thu, 16 Jun 2022 16:31:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Date:   Thu, 16 Jun 2022 16:10:12 +0200
References: <xmqqfskdieqz.fsf@gitster.g>
 <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
 <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
 <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
Message-ID: <220616.86bkuswuh5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 14 2022, Derrick Stolee wrote:

> On 6/13/2022 8:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Jun 13 2022, Derrick Stolee wrote:
>>=20
>>> On 6/9/2022 7:44 PM, Junio C Hamano wrote:
>>>
>>>> +	struct string_list *resolve_undo =3D istate->resolve_undo;
>>>> +
>>>> +	if (!resolve_undo)
>>>> +		return 0;
>>>> +
>>>> +	for_each_string_list_item(item, resolve_undo) {
>>>
>>> I see this is necessary since for_each_string_list_item() does
>>> not handle NULL lists. After attempting to allow it to handle
>>> NULL lists, I see that the compiler complains about the cases
>>> where it would _never_ be NULL, so that change appears to be
>>> impossible.
>>>=20=20
>>> The patch looks good. I liked the comments for the three phases
>>> of the test.
>>=20
>> I think it's probably good to keep for_each_string_list_item()
>> implemented the way it is, given that all existing callers of it feed
>> non-NULL lists to it.
>
> We are talking right now about an example where it would be cleaner to
> allow a NULL value.

First, I've read the thread and I see the compile error you ran into
below, and Jeff King's downthread workaround, so we could do this, and
I'm not at all opposed...

> This guarded example also exists in http.c (we would still need to guard
> on NULL options):
>
> 	/* Add additional headers here */
> 	if (options && options->extra_headers) {
> 		const struct string_list_item *item;
> 		for_each_string_list_item(item, options->extra_headers) {
> 			headers =3D curl_slist_append(headers, item->string);
> 		}
> 	}

I think this and probably many other examples you can find are ones
where we should just stop using a maybe-NULL "struct string_list", as in
the WIP (but segfaulting) patch below, but I think you get the
idea. I.e. in that case we're passing an "options" struct that can be
NULL, but could just have an initializer.

I.e. we should probably just have a non-NULL options with sensible
defaults, which would also allow for changing the adjacent "options &&
options->no_cache" etc. code to just "options->no_cache".

> These guarded examples in ref_filter_match() would be greatly simplified:
>
> 	if (exclude_patterns && exclude_patterns->nr) {
> 		for_each_string_list_item(item, exclude_patterns) {
> 			if (match_ref_pattern(refname, item))
> 				return 0;
> 		}
> 	}
>
> 	if (include_patterns && include_patterns->nr) {
> 		for_each_string_list_item(item, include_patterns) {
> 			if (match_ref_pattern(refname, item))
> 				return 1;
> 		}
> 		return 0;
> 	}
>
> 	if (exclude_patterns_config && exclude_patterns_config->nr) {
> 		for_each_string_list_item(item, exclude_patterns_config) {
> 			if (match_ref_pattern(refname, item))
> 				return 0;
> 		}
> 	}

First, regardless of any bigger change, I think all of those except the
middle one can drop the "nr" check.

But more generally, isn't something like [2] below a better change than
chasing the case of "what if it's NULL?".

Very WIP of course, and I just checked if it compiled, there's probably
more lurking bugs, but I think you get the idea.

One commit (of mine) on "master" that goes in that direction is
0000e81811b (builtin/remote.c: add and use SHOW_INFO_INIT, 2021-10-01).

> (The include_patterns check would still be needed for that extra
> return 0; in the middle.)
>
> There are more examples, but I'll stop listing them here.

Maybe there's better ones, but from my own past spelunking into "struct
string_list" users I've mostly found cases like 0000e81811b and the
below.

I.e. sure, handling NULL was a hassle, but the underlying problem was
usually *why is it NULL*. I.e. can't we just have the list be 0..N, why
do we need NULL, 0..N?

1.

diff --git a/http.c b/http.c
index 11c6f69facd..c2fa2b78db8 100644
--- a/http.c
+++ b/http.c
@@ -1808,6 +1808,7 @@ static int http_request(const char *url,
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *accept_language;
 	int ret;
+	const struct string_list_item *item;
=20
 	slot =3D get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
@@ -1844,12 +1845,8 @@ static int http_request(const char *url,
 	headers =3D curl_slist_append(headers, buf.buf);
=20
 	/* Add additional headers here */
-	if (options && options->extra_headers) {
-		const struct string_list_item *item;
-		for_each_string_list_item(item, options->extra_headers) {
-			headers =3D curl_slist_append(headers, item->string);
-		}
-	}
+	for_each_string_list_item(item, &options->extra_headers)
+		headers =3D curl_slist_append(headers, item->string);
=20
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
@@ -2055,7 +2052,7 @@ static char *fetch_pack_index(unsigned char *hash, co=
nst char *base_url)
 	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
 	tmp =3D strbuf_detach(&buf, NULL);
=20
-	if (http_get_file(url, tmp, NULL) !=3D HTTP_OK) {
+	if (http_get_file(url, tmp, NULL /* segfaults due to this */) !=3D HTTP_O=
K) {
 		error("Unable to get pack index %s", url);
 		FREE_AND_NULL(tmp);
 	}
diff --git a/http.h b/http.h
index ba303cfb372..41596fbf443 100644
--- a/http.h
+++ b/http.h
@@ -144,7 +144,7 @@ struct http_get_options {
 	 * request. The strings in the list must not be freed until after the
 	 * request has completed.
 	 */
-	struct string_list *extra_headers;
+	struct string_list extra_headers;
 };
=20
 /* Return values for http_get_*() */
diff --git a/remote-curl.c b/remote-curl.c
index 67f178b1120..30235577487 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -449,7 +449,6 @@ static struct discovery *discover_refs(const char *serv=
ice, int for_push)
 	struct strbuf refs_url =3D STRBUF_INIT;
 	struct strbuf effective_url =3D STRBUF_INIT;
 	struct strbuf protocol_header =3D STRBUF_INIT;
-	struct string_list extra_headers =3D STRING_LIST_INIT_DUP;
 	struct discovery *last =3D last_discovery;
 	int http_ret, maybe_smart =3D 0;
 	struct http_get_options http_options;
@@ -478,16 +477,18 @@ static struct discovery *discover_refs(const char *se=
rvice, int for_push)
 	if (version =3D=3D protocol_v2 && !strcmp("git-receive-pack", service))
 		version =3D protocol_v0;
=20
+	/* antipattern, we should have an initializer for "struct http_get_option=
s"... */
+	memset(&http_options, 0, sizeof(http_options));
+	string_list_init_nodup(&http_options.extra_headers);
+
 	/* Add the extra Git-Protocol header */
 	if (get_protocol_http_header(version, &protocol_header))
-		string_list_append(&extra_headers, protocol_header.buf);
+		string_list_append(&http_options.extra_headers, protocol_header.buf);
=20
-	memset(&http_options, 0, sizeof(http_options));
 	http_options.content_type =3D &type;
 	http_options.charset =3D &charset;
 	http_options.effective_url =3D &effective_url;
 	http_options.base_url =3D &url;
-	http_options.extra_headers =3D &extra_headers;
 	http_options.initial_request =3D 1;
 	http_options.no_cache =3D 1;
=20
@@ -538,7 +539,8 @@ static struct discovery *discover_refs(const char *serv=
ice, int for_push)
 	strbuf_release(&effective_url);
 	strbuf_release(&buffer);
 	strbuf_release(&protocol_header);
-	string_list_clear(&extra_headers, 0);
+	/*... and a proper destructor... */
+	string_list_clear(&http_options.extra_headers, 0);
 	last_discovery =3D last;
 	return last;
 }

2.

diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875a..4af1503887e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -168,12 +168,11 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
 	struct userformat_want w;
 	int quiet =3D 0, source =3D 0, mailmap;
 	static struct line_opt_callback_data line_cb =3D {NULL, NULL, STRING_LIST=
_INIT_DUP};
-	static struct string_list decorate_refs_exclude =3D STRING_LIST_INIT_NODU=
P;
-	static struct string_list decorate_refs_exclude_config =3D STRING_LIST_IN=
IT_NODUP;
-	static struct string_list decorate_refs_include =3D STRING_LIST_INIT_NODU=
P;
-	struct decoration_filter decoration_filter =3D {&decorate_refs_include,
-						      &decorate_refs_exclude,
-						      &decorate_refs_exclude_config};
+	struct decoration_filter decoration_filter =3D {
+		.include_ref_pattern =3D STRING_LIST_INIT_NODUP,
+		.exclude_ref_pattern =3D STRING_LIST_INIT_NODUP,
+		.exclude_ref_config_pattern =3D STRING_LIST_INIT_NODUP,
+	};
 	static struct revision_sources revision_sources;
=20
 	const struct option builtin_log_options[] =3D {
@@ -181,9 +180,9 @@ static void cmd_log_init_finish(int argc, const char **=
argv, const char *prefix,
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
-		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
+		OPT_STRING_LIST(0, "decorate-refs", &decoration_filter.include_ref_patte=
rn,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
-		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
+		OPT_STRING_LIST(0, "decorate-refs-exclude", &decoration_filter.exclude_r=
ef_pattern,
 				N_("pattern"), N_("do not decorate refs that match <pattern>")),
 		OPT_CALLBACK_F(0, "decorate", NULL, NULL, N_("decorate options"),
 			       PARSE_OPT_OPTARG, decorate_callback),
@@ -272,7 +271,7 @@ static void cmd_log_init_finish(int argc, const char **=
argv, const char *prefix,
 		if (config_exclude) {
 			struct string_list_item *item;
 			for_each_string_list_item(item, config_exclude)
-				string_list_append(&decorate_refs_exclude_config,
+				string_list_append(&decoration_filter.exclude_ref_config_pattern,
 						   item->string);
 		}
=20
diff --git a/log-tree.c b/log-tree.c
index d0ac0a6327a..f7d475f652f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -104,32 +104,23 @@ static int ref_filter_match(const char *refname,
 			    const struct decoration_filter *filter)
 {
 	struct string_list_item *item;
-	const struct string_list *exclude_patterns =3D filter->exclude_ref_patter=
n;
-	const struct string_list *include_patterns =3D filter->include_ref_patter=
n;
-	const struct string_list *exclude_patterns_config =3D
-				filter->exclude_ref_config_pattern;
=20
-	if (exclude_patterns && exclude_patterns->nr) {
-		for_each_string_list_item(item, exclude_patterns) {
-			if (match_ref_pattern(refname, item))
-				return 0;
-		}
-	}
+	for_each_string_list_item(item, &filter->exclude_ref_pattern)
+		if (match_ref_pattern(refname, item))
+			return 0;
=20
-	if (include_patterns && include_patterns->nr) {
-		for_each_string_list_item(item, include_patterns) {
+=09
+	if (filter->include_ref_pattern.nr) {
+		for_each_string_list_item(item, &filter->include_ref_pattern) {
 			if (match_ref_pattern(refname, item))
 				return 1;
+			return 0;
 		}
-		return 0;
 	}
=20
-	if (exclude_patterns_config && exclude_patterns_config->nr) {
-		for_each_string_list_item(item, exclude_patterns_config) {
-			if (match_ref_pattern(refname, item))
-				return 0;
-		}
-	}
+	for_each_string_list_item(item, &filter->exclude_ref_config_pattern)
+		if (match_ref_pattern(refname, item))
+			return 0;
=20
 	return 1;
 }
@@ -202,13 +193,13 @@ void load_ref_decorations(struct decoration_filter *f=
ilter, int flags)
 	if (!decoration_loaded) {
 		if (filter) {
 			struct string_list_item *item;
-			for_each_string_list_item(item, filter->exclude_ref_pattern) {
+			for_each_string_list_item(item, &filter->exclude_ref_pattern) {
 				normalize_glob_ref(item, NULL, item->string);
 			}
-			for_each_string_list_item(item, filter->include_ref_pattern) {
+			for_each_string_list_item(item, &filter->include_ref_pattern) {
 				normalize_glob_ref(item, NULL, item->string);
 			}
-			for_each_string_list_item(item, filter->exclude_ref_config_pattern) {
+			for_each_string_list_item(item, &filter->exclude_ref_config_pattern) {
 				normalize_glob_ref(item, NULL, item->string);
 			}
 		}
