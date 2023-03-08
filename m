Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983EEC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 10:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCHKIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 05:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCHKI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 05:08:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D1828209
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 02:08:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k10so39569555edk.13
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 02:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678270103;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCwbzZQJZfeU6LjWG0pv9eci1gpqxld5Pbe78NruQcI=;
        b=jR8DuAi7vQZRmIdoYWSi7G1OBEmd86SlB4BaomgGRPjtVtk6+8FEL2F/fERV8W/ZpH
         80p0jLynqx4PbJC3vvqerIdQaN/1s+31o941CKBFAxkBoGsZUNsmT+GDV1SjaZvAeZrW
         mTL7j6IQd9g/p/jG/9u/ULEbD176P4AlXo5vaaIydWyfTSXachCmCmYQHASI2bFynH2D
         S9skmDwbLKjHWw2fHWcutFmPLp7lAtatutHS9axC8JVdGQ2GXTqbVTpudMsyw4ZF5IYo
         reZ1txH7OwHGr/iqKhgJgM5Cw6Q1ZogbvZJfP1CWwGI0eqZZH6ngpnK9Ua6FY4HsKW9n
         GgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270103;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCwbzZQJZfeU6LjWG0pv9eci1gpqxld5Pbe78NruQcI=;
        b=3kPdzFzqdq5eUVDY7xNdJhEqfXoSZgPOycd1METYXAojQ2I8j2xAdbS6g7PlII/RaM
         5ue3W6wRUKDwvOWMOBlYLhTjdKADJxjUY/8zOd+kBxPv2FIMlIcJDuhdr8Fvm7zkGahY
         SBbHagRuex/2uyD3t1a+7iXd1cjgtpHsLJNwJ+nOLpAMWuoukRxYZPpGf5G8CP20VS6J
         lpFq2okzsQNDPFDLM8Uox7oql4WRdJsvSkSGiC1EdBUXgLnZvRO2bKVBCoZKWATepOhP
         OpvIMLfQuBN7C8nr4RkelouqVoKOk+X3G2Seo8FKCVCKKmPzDBRVCIG/wYKld1+QfyKv
         0JlQ==
X-Gm-Message-State: AO0yUKWrdU5o1O7Rc88A52D9BRw1fKaoEWovPtXdKo7SwZOjAU+DI63S
        gwnrdhRm+dWS2FeKA8CMoGU=
X-Google-Smtp-Source: AK7set/LfeDTHT2xk79Z93cGwhhd8Rot71sIVtgtK5xiJlsL2oio7e/hdLfyBTHI7aDyE3Shp5AeNA==
X-Received: by 2002:a17:907:6e0f:b0:907:672b:736a with SMTP id sd15-20020a1709076e0f00b00907672b736amr21090376ejc.31.1678270103293;
        Wed, 08 Mar 2023 02:08:23 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v8-20020a50c408000000b004c09f0ba24dsm7953052edf.48.2023.03.08.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:08:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZqic-000tw0-0i;
        Wed, 08 Mar 2023 11:08:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 4/6] config.c: plumb the_reader through callbacks
Date:   Wed, 08 Mar 2023 10:54:12 +0100
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
 <74a63fed7054da8049d4a32ecdb582726368c5a8.1677631097.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <74a63fed7054da8049d4a32ecdb582726368c5a8.1677631097.git.gitgitgadget@gmail.com>
Message-ID: <230308.86356fzhbd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 01 2023, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> The remaining references to "cf" are in config callback functions.
> Remove them by plumbing "struct config_reader" via the "*data" arg.
>
> [...]
>  	 * All remote URLs discovered when reading all config files.
> @@ -461,6 +457,7 @@ static int include_condition_is_true(struct config_source *cs,
>  static int git_config_include(const char *var, const char *value, void *data)
>  {
>  	struct config_include_data *inc = data;
> +	struct config_source *cs = inc->config_reader->source;
>  	const char *cond, *key;
>  	size_t cond_len;
>  	int ret;
> @@ -474,16 +471,16 @@ static int git_config_include(const char *var, const char *value, void *data)
>  		return ret;
>  
>  	if (!strcmp(var, "include.path"))
> -		ret = handle_path_include(cf, value, inc);
> +		ret = handle_path_include(cs, value, inc);

So, there's a lot of churn in this topic from renaming "cf" to "cs" all
over the place, I really wish that could be avoided for the size of the
overall diff, but haven't looked into in detail how easy that is, but...

>  
>  	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> -	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
> +	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
>  	    !strcmp(key, "path")) {
>  		config_fn_t old_fn = inc->fn;
>  
>  		if (inc->opts->unconditional_remote_url)
>  			inc->fn = forbid_remote_url;
> -		ret = handle_path_include(cf, value, inc);
> +		ret = handle_path_include(cs, value, inc);
>  		inc->fn = old_fn;
>  	}
>  
> @@ -2224,6 +2221,7 @@ int config_with_options(config_fn_t fn, void *data,
>  		inc.data = data;
>  		inc.opts = opts;
>  		inc.config_source = config_source;
> +		inc.config_reader = &the_reader;
>  		fn = git_config_include;
>  		data = &inc;
>  	}
> @@ -2344,7 +2342,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
>  	return found_entry;
>  }
>  
> -static int configset_add_value(struct config_set *cs, const char *key, const char *value)
> +static int configset_add_value(struct config_reader *reader,
> +			       struct config_set *cs, const char *key,
> +			       const char *value)

...this is an existing name just seen in the context, but could we in
this topic at least avoid having a "cs" refer to both a "struct
config_set" and a "struct config_source" in the end-state?

I tried the below on top of this topic, and the overall diff looks much
nicer as a result:

diff --git a/config.c b/config.c
index 19bab84c47f..c27c128e3c0 100644
--- a/config.c
+++ b/config.c
@@ -199,7 +199,7 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cs, const char *path,
+static int handle_path_include(struct config_source *cf, const char *path,
 			       struct config_include_data *inc)
 {
 	int ret = 0;
@@ -221,14 +221,14 @@ static int handle_path_include(struct config_source *cs, const char *path,
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cs || !cs->path) {
+		if (!cf || !cf->path) {
 			ret = error(_("relative config includes must come from files"));
 			goto cleanup;
 		}
 
-		slash = find_last_dir_sep(cs->path);
+		slash = find_last_dir_sep(cf->path);
 		if (slash)
-			strbuf_add(&buf, cs->path, slash - cs->path + 1);
+			strbuf_add(&buf, cf->path, slash - cf->path + 1);
 		strbuf_addstr(&buf, path);
 		path = buf.buf;
 	}
@@ -236,8 +236,8 @@ static int handle_path_include(struct config_source *cs, const char *path,
 	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
-			    !cs ? "<unknown>" :
-			    cs->name ? cs->name :
+			    !cf ? "<unknown>" :
+			    cf->name ? cf->name :
 			    "the command line");
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
@@ -254,7 +254,7 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct config_source *cs,
+static int prepare_include_condition_pattern(struct config_source *cf,
 					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -271,11 +271,11 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
 		const char *slash;
 
-		if (!cs || !cs->path)
+		if (!cf || !cf->path)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_realpath(&path, cs->path, 1);
+		strbuf_realpath(&path, cf->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			BUG("how is this possible?");
@@ -290,7 +290,7 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	return prefix;
 }
 
-static int include_by_gitdir(struct config_source *cs,
+static int include_by_gitdir(struct config_source *cf,
 			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
@@ -307,7 +307,7 @@ static int include_by_gitdir(struct config_source *cs,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(cs, &pattern);
+	prefix = prepare_include_condition_pattern(cf, &pattern);
 
 again:
 	if (prefix < 0)
@@ -446,16 +446,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_source *cs,
+static int include_condition_is_true(struct config_source *cf,
 				     struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(cs, opts, cond, cond_len, 0);
+		return include_by_gitdir(cf, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(cs, opts, cond, cond_len, 1);
+		return include_by_gitdir(cf, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
@@ -469,7 +469,7 @@ static int include_condition_is_true(struct config_source *cs,
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
-	struct config_source *cs = inc->config_reader->source;
+	struct config_source *cf = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -483,16 +483,16 @@ static int git_config_include(const char *var, const char *value, void *data)
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(cf, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
+	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(cf, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -817,21 +817,21 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	return ret;
 }
 
-static int get_next_char(struct config_source *cs)
+static int get_next_char(struct config_source *cf)
 {
-	int c = cs->do_fgetc(cs);
+	int c = cf->do_fgetc(cf);
 
 	if (c == '\r') {
 		/* DOS like systems */
-		c = cs->do_fgetc(cs);
+		c = cf->do_fgetc(cf);
 		if (c != '\n') {
 			if (c != EOF)
-				cs->do_ungetc(c, cs);
+				cf->do_ungetc(c, cf);
 			c = '\r';
 		}
 	}
 
-	if (c != EOF && ++cs->total_len > INT_MAX) {
+	if (c != EOF && ++cf->total_len > INT_MAX) {
 		/*
 		 * This is an absurdly long config file; refuse to parse
 		 * further in order to protect downstream code from integer
@@ -839,38 +839,38 @@ static int get_next_char(struct config_source *cs)
 		 * but we can mark EOF and put trash in the return value,
 		 * which will trigger a parse error.
 		 */
-		cs->eof = 1;
+		cf->eof = 1;
 		return 0;
 	}
 
 	if (c == '\n')
-		cs->linenr++;
+		cf->linenr++;
 	if (c == EOF) {
-		cs->eof = 1;
-		cs->linenr++;
+		cf->eof = 1;
+		cf->linenr++;
 		c = '\n';
 	}
 	return c;
 }
 
-static char *parse_value(struct config_source *cs)
+static char *parse_value(struct config_source *cf)
 {
 	int quote = 0, comment = 0, space = 0;
 
-	strbuf_reset(&cs->value);
+	strbuf_reset(&cf->value);
 	for (;;) {
-		int c = get_next_char(cs);
+		int c = get_next_char(cf);
 		if (c == '\n') {
 			if (quote) {
-				cs->linenr--;
+				cf->linenr--;
 				return NULL;
 			}
-			return cs->value.buf;
+			return cf->value.buf;
 		}
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
-			if (cs->value.len)
+			if (cf->value.len)
 				space++;
 			continue;
 		}
@@ -881,9 +881,9 @@ static char *parse_value(struct config_source *cs)
 			}
 		}
 		for (; space; space--)
-			strbuf_addch(&cs->value, ' ');
+			strbuf_addch(&cf->value, ' ');
 		if (c == '\\') {
-			c = get_next_char(cs);
+			c = get_next_char(cf);
 			switch (c) {
 			case '\n':
 				continue;
@@ -903,18 +903,18 @@ static char *parse_value(struct config_source *cs)
 			default:
 				return NULL;
 			}
-			strbuf_addch(&cs->value, c);
+			strbuf_addch(&cf->value, c);
 			continue;
 		}
 		if (c == '"') {
 			quote = 1-quote;
 			continue;
 		}
-		strbuf_addch(&cs->value, c);
+		strbuf_addch(&cf->value, c);
 	}
 }
 
-static int get_value(struct config_source *cs, config_fn_t fn, void *data,
+static int get_value(struct config_source *cf, config_fn_t fn, void *data,
 		     struct strbuf *name)
 {
 	int c;
@@ -923,8 +923,8 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 
 	/* Get the full name */
 	for (;;) {
-		c = get_next_char(cs);
-		if (cs->eof)
+		c = get_next_char(cf);
+		if (cf->eof)
 			break;
 		if (!iskeychar(c))
 			break;
@@ -932,13 +932,13 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	}
 
 	while (c == ' ' || c == '\t')
-		c = get_next_char(cs);
+		c = get_next_char(cf);
 
 	value = NULL;
 	if (c != '\n') {
 		if (c != '=')
 			return -1;
-		value = parse_value(cs);
+		value = parse_value(cf);
 		if (!value)
 			return -1;
 	}
@@ -947,21 +947,21 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	 * the line we just parsed during the call to fn to get
 	 * accurate line number in error messages.
 	 */
-	cs->linenr--;
+	cf->linenr--;
 	ret = fn(name->buf, value, data);
 	if (ret >= 0)
-		cs->linenr++;
+		cf->linenr++;
 	return ret;
 }
 
-static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
+static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
 				 int c)
 {
-	cs->subsection_case_sensitive = 0;
+	cf->subsection_case_sensitive = 0;
 	do {
 		if (c == '\n')
 			goto error_incomplete_line;
-		c = get_next_char(cs);
+		c = get_next_char(cf);
 	} while (isspace(c));
 
 	/* We require the format to be '[base "extension"]' */
@@ -970,13 +970,13 @@ static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
 	strbuf_addch(name, '.');
 
 	for (;;) {
-		int c = get_next_char(cs);
+		int c = get_next_char(cf);
 		if (c == '\n')
 			goto error_incomplete_line;
 		if (c == '"')
 			break;
 		if (c == '\\') {
-			c = get_next_char(cs);
+			c = get_next_char(cf);
 			if (c == '\n')
 				goto error_incomplete_line;
 		}
@@ -984,25 +984,25 @@ static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
 	}
 
 	/* Final ']' */
-	if (get_next_char(cs) != ']')
+	if (get_next_char(cf) != ']')
 		return -1;
 	return 0;
 error_incomplete_line:
-	cs->linenr--;
+	cf->linenr--;
 	return -1;
 }
 
-static int get_base_var(struct config_source *cs, struct strbuf *name)
+static int get_base_var(struct config_source *cf, struct strbuf *name)
 {
-	cs->subsection_case_sensitive = 1;
+	cf->subsection_case_sensitive = 1;
 	for (;;) {
-		int c = get_next_char(cs);
-		if (cs->eof)
+		int c = get_next_char(cf);
+		if (cf->eof)
 			return -1;
 		if (c == ']')
 			return 0;
 		if (isspace(c))
-			return get_extended_base_var(cs, name, c);
+			return get_extended_base_var(cf, name, c);
 		if (!iskeychar(c) && c != '.')
 			return -1;
 		strbuf_addch(name, tolower(c));
@@ -1015,7 +1015,7 @@ struct parse_event_data {
 	const struct config_options *opts;
 };
 
-static int do_event(struct config_source *cs, enum config_event_t type,
+static int do_event(struct config_source *cf, enum config_event_t type,
 		    struct parse_event_data *data)
 {
 	size_t offset;
@@ -1027,7 +1027,7 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 	    data->previous_type == type)
 		return 0;
 
-	offset = cs->do_ftell(cs);
+	offset = cf->do_ftell(cf);
 	/*
 	 * At EOF, the parser always "inserts" an extra '\n', therefore
 	 * the end offset of the event is the current file position, otherwise
@@ -1047,12 +1047,12 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 	return 0;
 }
 
-static int git_parse_source(struct config_source *cs, config_fn_t fn,
+static int git_parse_source(struct config_source *cf, config_fn_t fn,
 			    void *data, const struct config_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
-	struct strbuf *var = &cs->var;
+	struct strbuf *var = &cf->var;
 	int error_return = 0;
 	char *error_msg = NULL;
 
@@ -1067,7 +1067,7 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 	for (;;) {
 		int c;
 
-		c = get_next_char(cs);
+		c = get_next_char(cf);
 		if (bomptr && *bomptr) {
 			/* We are at the file beginning; skip UTF8-encoded BOM
 			 * if present. Sane editors won't put this in on their
@@ -1084,12 +1084,12 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			}
 		}
 		if (c == '\n') {
-			if (cs->eof) {
-				if (do_event(cs, CONFIG_EVENT_EOF, &event_data) < 0)
+			if (cf->eof) {
+				if (do_event(cf, CONFIG_EVENT_EOF, &event_data) < 0)
 					return -1;
 				return 0;
 			}
-			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 				return -1;
 			comment = 0;
 			continue;
@@ -1097,23 +1097,23 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 		if (comment)
 			continue;
 		if (isspace(c)) {
-			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 					return -1;
 			continue;
 		}
 		if (c == '#' || c == ';') {
-			if (do_event(cs, CONFIG_EVENT_COMMENT, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_COMMENT, &event_data) < 0)
 					return -1;
 			comment = 1;
 			continue;
 		}
 		if (c == '[') {
-			if (do_event(cs, CONFIG_EVENT_SECTION, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_SECTION, &event_data) < 0)
 					return -1;
 
 			/* Reset prior to determining a new stem */
 			strbuf_reset(var);
-			if (get_base_var(cs, var) < 0 || var->len < 1)
+			if (get_base_var(cf, var) < 0 || var->len < 1)
 				break;
 			strbuf_addch(var, '.');
 			baselen = var->len;
@@ -1122,7 +1122,7 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 		if (!isalpha(c))
 			break;
 
-		if (do_event(cs, CONFIG_EVENT_ENTRY, &event_data) < 0)
+		if (do_event(cf, CONFIG_EVENT_ENTRY, &event_data) < 0)
 			return -1;
 
 		/*
@@ -1132,42 +1132,42 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(cs, fn, data, var) < 0)
+		if (get_value(cf, fn, data, var) < 0)
 			break;
 	}
 
-	if (do_event(cs, CONFIG_EVENT_ERROR, &event_data) < 0)
+	if (do_event(cf, CONFIG_EVENT_ERROR, &event_data) < 0)
 		return -1;
 
-	switch (cs->origin_type) {
+	switch (cf->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		error_msg = xstrfmt(_("bad config line %d in blob %s"),
-				      cs->linenr, cs->name);
+				      cf->linenr, cf->name);
 		break;
 	case CONFIG_ORIGIN_FILE:
 		error_msg = xstrfmt(_("bad config line %d in file %s"),
-				      cs->linenr, cs->name);
+				      cf->linenr, cf->name);
 		break;
 	case CONFIG_ORIGIN_STDIN:
 		error_msg = xstrfmt(_("bad config line %d in standard input"),
-				      cs->linenr);
+				      cf->linenr);
 		break;
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
-				       cs->linenr, cs->name);
+				       cf->linenr, cf->name);
 		break;
 	case CONFIG_ORIGIN_CMDLINE:
 		error_msg = xstrfmt(_("bad config line %d in command line %s"),
-				       cs->linenr, cs->name);
+				       cf->linenr, cf->name);
 		break;
 	default:
 		error_msg = xstrfmt(_("bad config line %d in %s"),
-				      cs->linenr, cs->name);
+				      cf->linenr, cf->name);
 	}
 
 	switch (opts && opts->error_action ?
 		opts->error_action :
-		cs->default_error_action) {
+		cf->default_error_action) {
 	case CONFIG_ERROR_DIE:
 		die("%s", error_msg);
 		break;
@@ -1309,7 +1309,7 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 }
 
 NORETURN
-static void die_bad_number(struct config_source *cs, const char *name,
+static void die_bad_number(struct config_source *cf, const char *name,
 			   const char *value)
 {
 	const char *error_type = (errno == ERANGE) ?
@@ -1319,28 +1319,28 @@ static void die_bad_number(struct config_source *cs, const char *name,
 	if (!value)
 		value = "";
 
-	if (!(cs && cs->name))
+	if (!(cf && cf->name))
 		die(_(bad_numeric), value, name, _(error_type));
 
-	switch (cs->origin_type) {
+	switch (cf->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, cf->name, _(error_type));
 	case CONFIG_ORIGIN_FILE:
 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, cf->name, _(error_type));
 	case CONFIG_ORIGIN_STDIN:
 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
 		    value, name, _(error_type));
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, cf->name, _(error_type));
 	case CONFIG_ORIGIN_CMDLINE:
 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, cf->name, _(error_type));
 	default:
 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, cf->name, _(error_type));
 	}
 }
 
@@ -2274,12 +2274,12 @@ struct configset_iter_data {
 };
 #define CONFIGSET_ITER_INIT { 0 }
 
-static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+static void configset_iter(struct config_set *cf, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
-	struct configset_list *list = &cs->list;
+	struct configset_list *list = &cf->list;
 	struct configset_iter_data *iter_data = data;
 
 	for (i = 0; i < list->nr; i++) {
@@ -2975,7 +2975,7 @@ static int store_aux_event(enum config_event_t type,
 			   size_t begin, size_t end, void *data)
 {
 	struct config_store_data *store = data;
-	struct config_source *cs = store->config_reader->source;
+	struct config_source *cf = store->config_reader->source;
 
 	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
 	store->parsed[store->parsed_nr].begin = begin;
@@ -2985,10 +2985,10 @@ static int store_aux_event(enum config_event_t type,
 	if (type == CONFIG_EVENT_SECTION) {
 		int (*cmpfn)(const char *, const char *, size_t);
 
-		if (cs->var.len < 2 || cs->var.buf[cs->var.len - 1] != '.')
-			return error(_("invalid section name '%s'"), cs->var.buf);
+		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
+			return error(_("invalid section name '%s'"), cf->var.buf);
 
-		if (cs->subsection_case_sensitive)
+		if (cf->subsection_case_sensitive)
 			cmpfn = strncasecmp;
 		else
 			cmpfn = strncmp;
@@ -2996,8 +2996,8 @@ static int store_aux_event(enum config_event_t type,
 		/* Is this the section we were looking for? */
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
-			cs->var.len - 1 == store->baselen &&
-			!cmpfn(cs->var.buf, store->key, store->baselen);
+			cf->var.len - 1 == store->baselen &&
+			!cmpfn(cf->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
diff --git a/config.h b/config.h
index 7606246531a..5421c48e287 100644
--- a/config.h
+++ b/config.h
@@ -614,7 +614,7 @@ int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t no
 
 struct key_value_info {
 	const char *filename;
-	int linenr;
+	int linenr2;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
 };
