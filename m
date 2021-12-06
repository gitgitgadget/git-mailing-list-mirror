Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A4C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 19:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348297AbhLFTPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348289AbhLFTPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 14:15:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46147C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 11:11:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g14so46668726edb.8
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ITTveikVXxZOFDzo+Xzrdr0t6jIvQxgY0YAmckEElB8=;
        b=N0JKe6/CyynV0lrYxu/3mfKoPYeIb3ZEnD3ufXeEG1Yf7IjnWvnS7qU7MrDA6HDZHd
         k0I8kSxnuOpbF1nhOHgl+PN1WzHjRcVvjlm3Sp8OMbK1zMZjdhF0s4T9VxxS2/Ror6Ak
         06A9G7SwrAnvSVVnd25HqxX7io4J7JV+Uj8vHyj8+cIl+NA/p7fzTRMfoDsdxhQhGpGC
         YjUUSSUDGcuWrS1QSobt4SwdLBC3koxFg1t2Ek0hDKTCx6SeDMthPxF1v31TuwQfuWM0
         ZKRlQ2ikT90J+faf1UrDyMPXrLixcz7K5QLfqIxBQf213r1gsvGIu0nd+O9tBdLBcSUI
         L+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ITTveikVXxZOFDzo+Xzrdr0t6jIvQxgY0YAmckEElB8=;
        b=yL0cl4oioYfoNwEwir4/152ogtUgghAUA1OfuM3O0ahT7pEdHPw+9Nh42Z8r9/FObR
         gTfy1s16ynj3j+ZMeeN1QtDKWvDUNFl8MxuOEpvDn+oXNywamKcdsj0E+KPfzjLY9YGu
         nPdPRm8/RS3WL8RUfu+/Pw+F+kmrmR7qamrIox4Utrw9Eoh/+Sw1PWOPR/xWIHlpG/r/
         vzZCWf0Ea5uchOafoJOw9qtqhlgRvhH1cjEupEuQc21OaOHSlBHv9CGHxrVaz2iY1HJ8
         f46rUbdDnBxkxgSp4CMPE7BVOdf0eu7xsJv/st3zbs55wY93Nny6OmHhzliSIqDp1PsI
         BkxA==
X-Gm-Message-State: AOAM531j501MtDPRcDg2W186zkdoTl6Z6HCSsqWn2I2ECerTq8HkLPBY
        C7pbSPCZ6/88OorBUmIBip9DqgooqUFxjA==
X-Google-Smtp-Source: ABdhPJxFd6jvAHbORhkpF1UJdDmF6QaRiC3i+ugZxYKwc0hc0mfqaQYw6WwQUF81wS/XubG0nyPToA==
X-Received: by 2002:a05:6402:908:: with SMTP id g8mr1444916edz.59.1638817910270;
        Mon, 06 Dec 2021 11:11:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g15sm7033067ejt.10.2021.12.06.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:11:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muJOv-000sO4-41;
        Mon, 06 Dec 2021 20:11:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com
Subject: Re: [PATCH v5 0/2] Conditional config includes based on remote URL
Date:   Mon, 06 Dec 2021 19:57:42 +0100
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1638487815.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <cover.1638487815.git.jonathantanmy@google.com>
Message-ID: <211206.86zgpdpmyy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 02 2021, Jonathan Tan wrote:

> Thanks, Junio, for your comments. I think the code is more clearly laid                                  
> out now.                                                                                                 
>                                                                                                          
> The main changes from v4 are that I've maintained the existing code
> structure more, and changed the keyword used to something that hopefully
> will be more forwards compatible. I've also updated the documentation to
> explain the forwards compatibility idea.

I read through this and came up with the below as a proposed squash-in
just while reading through it. These may or may not help. Changes:

 * There was some needless "$(pwd)" in the tests
 * Inlining the "remote_urls" in the struct makes its management easier;
   and the free/NULL checks just check .nr now, and string_list_clear() can be
   unconditional.
 * Created a include_by_remote_url() function. Makes the overall diff smaller
   since you don't need to add braces to everything in include_condition_is_true()

Other comments (not related to the below):

 * It would be nice if e.g. the "includeIf.hasconfig:remote.*.url globs" test
   were split up by condition, but maybe that's a hassle (would need a small helper).

   Just something that would have helped while hacking on this, i.e. now most of it
   was an all-or-nothing failure & peek at the trace output

 * Your last test appears to entirely forbid recursion. I.e. we die if you include config
   which in turn tries to use this include mechanism, right?

   That's probably wise, and it is explicitly documented.

   But as far as the documentation about this being a forward-compatible facility, do we
   think that this limitation would apply to any future config key? I.e. if I include based
   on "user.email" nothing in that to-be-included can set user.email?

   That's probably OK, just wondering. In any case it can always be expanded later on.

diff --git a/config.c b/config.c
index 39ac38e0e78..91b0a328e59 100644
--- a/config.c
+++ b/config.c
@@ -130,9 +130,11 @@ struct config_include_data {
 	/*
 	 * All remote URLs discovered when reading all config files.
 	 */
-	struct string_list *remote_urls;
+	struct string_list remote_urls;
 };
-#define CONFIG_INCLUDE_INIT { 0 }
+#define CONFIG_INCLUDE_INIT { \
+	.remote_urls = STRING_LIST_INIT_DUP, \
+}
 
 static int git_config_include(const char *var, const char *value, void *data);
 
@@ -340,9 +342,7 @@ static void populate_remote_urls(struct config_include_data *inc)
 	current_config_kvi = NULL;
 	current_parsing_scope = 0;
 
-	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
-	string_list_init_dup(inc->remote_urls);
-	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
+	config_with_options(add_remote_url, &inc->remote_urls, inc->config_source, &opts);
 
 	cf = store_cf;
 	current_config_kvi = store_kvi;
@@ -381,26 +381,31 @@ static int at_least_one_url_matches_glob(const char *glob, int glob_len,
 	return found;
 }
 
+static int include_by_remote_url(struct config_include_data *inc,
+				 const char *cond, size_t cond_len)
+{
+	if (inc->opts->unconditional_remote_url)
+		return 1;
+	if (!inc->remote_urls.nr)
+		populate_remote_urls(inc);
+	return at_least_one_url_matches_glob(cond, cond_len,
+					     &inc->remote_urls);
+}
+
 static int include_condition_is_true(struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
 	const struct config_options *opts = inc->opts;
 
-	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len)) {
+	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 0);
-	} else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len)) {
+	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(opts, cond, cond_len, 1);
-	} else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len)) {
+	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
-	} else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
-				   &cond_len)) {
-		if (inc->opts->unconditional_remote_url)
-			return 1;
-		if (!inc->remote_urls)
-			populate_remote_urls(inc);
-		return at_least_one_url_matches_glob(cond, cond_len,
-						     inc->remote_urls);
-	}
+	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
+				   &cond_len))
+		return include_by_remote_url(inc, cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
@@ -2061,10 +2066,7 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = do_git_config_sequence(opts, fn, data);
 	}
 
-	if (inc.remote_urls) {
-		string_list_clear(inc.remote_urls, 0);
-		FREE_AND_NULL(inc.remote_urls);
-	}
+	string_list_clear(&inc.remote_urls, 0);
 	return ret;
 }
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 0f7bae31b4b..8310562b842 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2391,11 +2391,11 @@ test_expect_success 'includeIf.hasconfig:remote.*.url' '
 	git init hasremoteurlTest &&
 	test_when_finished "rm -rf hasremoteurlTest" &&
 
-	cat >"$(pwd)"/include-this <<-\EOF &&
+	cat >include-this <<-\EOF &&
 	[user]
 		this = this-is-included
 	EOF
-	cat >"$(pwd)"/dont-include-that <<-\EOF &&
+	cat >dont-include-that <<-\EOF &&
 	[user]
 		that = that-is-not-included
 	EOF
@@ -2419,7 +2419,7 @@ test_expect_success 'includeIf.hasconfig:remote.*.url respects last-config-wins'
 	git init hasremoteurlTest &&
 	test_when_finished "rm -rf hasremoteurlTest" &&
 
-	cat >"$(pwd)"/include-two-three <<-\EOF &&
+	cat >include-two-three <<-\EOF &&
 	[user]
 		two = included-config
 		three = included-config
@@ -2453,11 +2453,11 @@ test_expect_success 'includeIf.hasconfig:remote.*.url globs' '
 	git init hasremoteurlTest &&
 	test_when_finished "rm -rf hasremoteurlTest" &&
 
-	printf "[user]\ndss = yes\n" >"$(pwd)/double-star-start" &&
-	printf "[user]\ndse = yes\n" >"$(pwd)/double-star-end" &&
-	printf "[user]\ndsm = yes\n" >"$(pwd)/double-star-middle" &&
-	printf "[user]\nssm = yes\n" >"$(pwd)/single-star-middle" &&
-	printf "[user]\nno = no\n" >"$(pwd)/no" &&
+	printf "[user]\ndss = yes\n" >double-star-start &&
+	printf "[user]\ndse = yes\n" >double-star-end &&
+	printf "[user]\ndsm = yes\n" >double-star-middle &&
+	printf "[user]\nssm = yes\n" >single-star-middle &&
+	printf "[user]\nno = no\n" >no &&
 
 	cat >>hasremoteurlTest/.git/config <<-EOF &&
 	[remote "foo"]
@@ -2491,7 +2491,7 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
 	git init hasremoteurlTest &&
 	test_when_finished "rm -rf hasremoteurlTest" &&
 
-	cat >"$(pwd)"/include-with-url <<-\EOF &&
+	cat >include-with-url <<-\EOF &&
 	[remote "bar"]
 		url = bar
 	EOF

