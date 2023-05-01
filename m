Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D9C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 11:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjEALhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjEALhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 07:37:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A8AFD
        for <git@vger.kernel.org>; Mon,  1 May 2023 04:37:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so415605866b.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682941029; x=1685533029;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt56xPBTMGA/DgCyM8dSHDCT4Mt4+tVJJclJZE5xMI4=;
        b=aBO07/FC17BrB8WYHHusfjxO1v/491NNrJzIDbRK2PSdHLqQiWrKVrzkIuSAFVCjta
         9CsMPs5qEW5He6edBL1HnLAxaatnU1itUohzhZXlkSm5jJYnG8dkTLyM7UL0aoXS9rRH
         10i6N9ercpsIu30fRi0egxzh5FVCKNfume9GBDsc1lumQ9EcnYBpZaHDsRD9v+MJmuMb
         bKOTAhzFkvc+tVx1IIjFpShVqrkJRCMTBAsFd16/FAzHu6+sYBSPoTMpuYuzJONqgh6g
         2nVsPNYcOKG218K9YNc1U7rxJzPC3K3u3mZpNY3pEaNWnjh1gD6cpWIuXtGGOG1wC2OL
         CThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682941029; x=1685533029;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt56xPBTMGA/DgCyM8dSHDCT4Mt4+tVJJclJZE5xMI4=;
        b=QfU9cvXDki2XGm0r1fGpE1zQA1LFeu1BDOHIRgIpRpPxxYK8KDx7GhpefyJUa6KHou
         1tjZhYfOjos6rHMARXPUq/DkEkbdl+nWmTwEZ95Cjl8oIKQIk46Q9S2ZZCCf77VSOLTG
         k1U0YhKDq+2KVCft0B5yu+5ML1ZjFHVTVpahf17to8V1GJmmL8/Az972dn1hytV+oxbU
         UvR8DxdxU7HS2kCjQXUc7Owtnkmo5XRC7j3pW/G6MfdRC6WNtin7LHLek6sGeM6I4n8W
         8esFrmlbNoFIPo0IyiGZdeHdeRZTppMD4/A3eN2OMT7mp3qVPqhBMvEvjhMQUEk7gr9j
         HZrQ==
X-Gm-Message-State: AC+VfDy0D4WFwqaP6YqWF3OAKQmeu9zJ90v7O8REvbWG7kMFWLC949HL
        dHAEqTGFffzFQ37Kx8FvgcCJncrN5w0=
X-Google-Smtp-Source: ACHHUZ5cO/GnAGidNQy/fKLD80suFFuoD38jYDttDvuTTqlNThRSZososDeKjBC1MUpbflgGZYAJuw==
X-Received: by 2002:a17:907:3f04:b0:94f:967d:e4f with SMTP id hq4-20020a1709073f0400b0094f967d0e4fmr13706718ejc.39.1682941028713;
        Mon, 01 May 2023 04:37:08 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id n2-20020a1709065e0200b00951755d0c79sm14794355eju.104.2023.05.01.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 04:37:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptRq7-00047z-2x;
        Mon, 01 May 2023 13:37:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 10/14] (RFC-only) config: finish config_fn_t refactor
Date:   Mon, 01 May 2023 13:19:48 +0200
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <1071e70c92892166e1ed2cf22bcd7eb49bdf3b20.1682104399.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <1071e70c92892166e1ed2cf22bcd7eb49bdf3b20.1682104399.git.gitgitgadget@gmail.com>
Message-ID: <230501.868re8jna4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 21 2023, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>

I like the general goal of this series, i.e. to get rid of the "reader"
callback, and pass stuff more explicitly.

But as I pointed out in
https://lore.kernel.org/git/RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com/
I think this part (and the preceding two commits) are really taking is
down the wrong path.

To demonstrate why, here's a patch-on-top of this topic as a whole where
I renamed the "kvi" struct members. I've excluded config.c itself (as
its internals aren't interesting for the purposes of this discussion):
	
	diff --git a/builtin/config.c b/builtin/config.c
	index c9e80a4b500..00cf8ffd791 100644
	--- a/builtin/config.c
	+++ b/builtin/config.c
	@@ -198,8 +198,8 @@ static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
	 
	-	strbuf_addstr(buf, config_origin_type_name(kvi->origin_type));
	+	strbuf_addstr(buf, config_origin_type_name(kvi->origin_type2));
	 	strbuf_addch(buf, ':');
	 	if (end_nul)
	-		strbuf_addstr(buf, kvi->filename ? kvi->filename : "");
	+		strbuf_addstr(buf, kvi->filename2 ? kvi->filename2 : "");
	 	else
	-		quote_c_style(kvi->filename ? kvi->filename : "", buf, NULL, 0);
	+		quote_c_style(kvi->filename2 ? kvi->filename2 : "", buf, NULL, 0);
	 	strbuf_addch(buf, term);
	@@ -210,3 +210,3 @@ static void show_config_scope(struct key_value_info *kvi, struct strbuf *buf)
	 	const char term = end_nul ? '\0' : '\t';
	-	const char *scope = config_scope_name(kvi->scope);
	+	const char *scope = config_scope_name(kvi->scope2);
	 
	diff --git a/builtin/remote.c b/builtin/remote.c
	index 034998a1205..81922af3f58 100644
	--- a/builtin/remote.c
	+++ b/builtin/remote.c
	@@ -655,6 +655,6 @@ static int config_read_push_default(const char *key, const char *value,
	 
	-	info->scope = kvi->scope;
	+	info->scope = kvi->scope2;
	 	strbuf_reset(&info->origin);
	-	strbuf_addstr(&info->origin, kvi->filename);
	-	info->linenr = kvi->linenr;
	+	strbuf_addstr(&info->origin, kvi->filename2);
	+	info->linenr = kvi->linenr2;
	 
	diff --git a/config.h b/config.h
	index ffb2d76823c..d9b0470e7b7 100644
	--- a/config.h
	+++ b/config.h
	@@ -120,8 +120,8 @@ struct config_options {
	 struct key_value_info {
	-	const char *filename;
	-	int linenr;
	-	enum config_origin_type origin_type;
	-	enum config_scope scope;
	-	const char *path;
	-	struct key_value_info *prev;
	+	const char *filename2;
	+	int linenr2;
	+	enum config_origin_type origin_type2;
	+	enum config_scope scope2;
	+	const char *path2;
	+	struct key_value_info *prev2;
	 };
	diff --git a/remote.c b/remote.c
	index 5239dfeab55..1cb465c6c17 100644
	--- a/remote.c
	+++ b/remote.c
	@@ -417,4 +417,4 @@ static int handle_config(const char *key, const char *value,
	 	remote->origin = REMOTE_CONFIG;
	-	if (kvi->scope == CONFIG_SCOPE_LOCAL ||
	-	    kvi->scope == CONFIG_SCOPE_WORKTREE)
	+	if (kvi->scope2 == CONFIG_SCOPE_LOCAL ||
	+	    kvi->scope2 == CONFIG_SCOPE_WORKTREE)
	 		remote->configured_in_repo = 1;
	diff --git a/t/helper/test-config.c b/t/helper/test-config.c
	index 737505583d4..fa89cdd084c 100644
	--- a/t/helper/test-config.c
	+++ b/t/helper/test-config.c
	@@ -54,6 +54,6 @@ static int iterate_cb(const char *var, const char *value,
	 	printf("value=%s\n", value ? value : "(null)");
	-	printf("origin=%s\n", config_origin_type_name(kvi->origin_type));
	-	printf("name=%s\n", kvi->filename ? kvi->filename : "");
	-	printf("lno=%d\n", kvi->linenr);
	-	printf("scope=%s\n", config_scope_name(kvi->scope));
	+	printf("origin=%s\n", config_origin_type_name(kvi->origin_type2));
	+	printf("name=%s\n", kvi->filename2 ? kvi->filename2 : "");
	+	printf("lno=%d\n", kvi->linenr2);
	+	printf("scope=%s\n", config_scope_name(kvi->scope2));
	 
	diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
	index 83db3c755bd..338c5a58bd9 100644
	--- a/trace2/tr2_tgt_event.c
	+++ b/trace2/tr2_tgt_event.c
	@@ -482,3 +482,3 @@ static void fn_param_fl(const char *file, int line, const char *param,
	 	struct json_writer jw = JSON_WRITER_INIT;
	-	enum config_scope scope = kvi->scope;
	+	enum config_scope scope = kvi->scope2;
	 	const char *scope_name = config_scope_name(scope);
	diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
	index 65e9be9c5a4..5a06042e7c3 100644
	--- a/trace2/tr2_tgt_normal.c
	+++ b/trace2/tr2_tgt_normal.c
	@@ -301,3 +301,3 @@ static void fn_param_fl(const char *file, int line, const char *param,
	 	struct strbuf buf_payload = STRBUF_INIT;
	-	enum config_scope scope = kvi->scope;
	+	enum config_scope scope = kvi->scope2;
	 	const char *scope_name = config_scope_name(scope);
	diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
	index f402f6e3813..96fa359183d 100644
	--- a/trace2/tr2_tgt_perf.c
	+++ b/trace2/tr2_tgt_perf.c
	@@ -445,3 +445,3 @@ static void fn_param_fl(const char *file, int line, const char *param,
	 	struct strbuf scope_payload = STRBUF_INIT;
	-	enum config_scope scope = kvi->scope;
	+	enum config_scope scope = kvi->scope2;
	 	const char *scope_name = config_scope_name(scope);

So, as this shows us your 08/14 has gone through the effort of passing
this "kvi" info to every single callback, but it's only this handful
that actually needs this information.

So, even if we *can* get this to work I don't think it's worth it,
especially as this would preclude giving these config callbacks some
"lighter" API that doesn't take the trouble of recording and ferrying
this information to them.

Of course *now* we need to always prepare this information anyway, as
anyone could access it via a global, but as the work you've done here
shows we're always doing that, but only need it for these few cases.

So I really think we could leave the vast majority of the current
callbacks alone, and just supply a new "kvi" callback. My
https://lore.kernel.org/git/RFC-patch-5.5-2b80d293c83-20230317T042408Z-avarab@gmail.com/
showed one way forward with that.

I think this should also neatly answer some of your outstanding
questions. Especially as the above shows that the only non-test caller
that needs "linenr" is the builtin/config.c caller that my proposed RFC
(linked above) tackled directly. Most of these callbacks just need the
more basic "scope".

So, in particular:

> Here's an exhaustive list of all of the changes:
>
> * Cases that need a judgement call
>
>   - trace2/tr2_cfg.c:tr2_cfg_set_fl()
>
>     This function needs to account for tr2_cfg_cb() now using "kvi".
>     Since this is only called (indirectly) by git_config_set(), config
>     source information has never been available here, so just pass NULL.
>     It will be tr2_cfg_cb()'s responsibility to not use "kvi".

Just adding a "CONFIG_SCOPE_IN_PROCESS", "CONFIG_SCOPE_SET" or whatever
you'd want to call it seems to make much more sense here, no? 

>   - builtin/checkout.c:checkout_main()
>
>     This calls git_xmerge_config() as a shorthand for parsing a CLI arg.
>     "kvi" doesn't apply, so just pass NULL. This might be worth
>     refactoring away, since git_xmerge_config() can call
>     git_default_config().

Another example of a caller which never actually cares about this data,
so if it doesn't need to have it passed to it, it doesn't need to fake
it up either.

>   - config.c:git_config_include()
>
>     Replace the local "kvi" variable with the "kvi" parameter. This
>     makes config_include_data.config_reader obsolete, so remove it.

No comment (internal to config.c, as noted above).

> * Hard for cocci to catch
>
>   - urlmatch.c
>
>     Manually refactor the custom config callbacks in "struct
>     urlmatch_config".
>
>   - diff.h, fsck.h, grep.h, ident.h, xdiff-interface.h
>
>     "struct key_value_info" hasn't been defined yet, so forward declare
>     it. Alternatively, maybe these files should "#include config.h".

All of these problems go away if you don't insist on changing every
single caller, you'll just have a step where you remove the current
global in favor of some "config callback with kvi" info, and "make" will
spot those callers that aren't converted yet.

Those changes will be trivial enough (just the callers I noted above) to
not require the tricky cocci patch in 08/14.

> * Likely deficiencies in .cocci patch
>
>   - submodule-config.c:gitmodules_cb()
>
>     Manually refactor a parse_config() call that gets missed because it
>     uses a different "*data" arg.
>
>   - grep.h, various
>
>     Manually refactor grep_config() calls. Not sure why these don't get
>     picked up.
>
>   - config.c:git_config_include(), http.c:http_options()
>
>     Manually add "kvi" where it was missed. Not sure why they get missed.
>
>   - builtin/clone.c:write_one_config()
>
>     Manually refactor a git_clone_config() call. Probably got missed
>     because I didn't include git_config_parse_parameter().
>
>   - ident.h
>
>     Remove the UNUSED attribute. Not sure why this is the only instance
>     of this.
>
>   - git-compat-util.h, compat/mingw.[h|c]
>
>     Manually refactor noop_core_config(), platform_core_config() and
>     mingw_core_config(). I can probably add these as "manual fixups" in
>     cocci.

ditto.
