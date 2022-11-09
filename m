Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94410C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 03:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKIDYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 22:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKIDYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 22:24:05 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD026D6
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 19:24:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m22so6215754eji.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 19:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4oOTUViScuV26OjcDeVP1JUDsvwA7X9GItCohjPmEB0=;
        b=hwEEerLXJn+buwclD6nxqykA9NKHZuf9JCzOGYmyjVYma454NGDcfW4Mpl20Uq73Ki
         1Y1IOb+c7RSfMbb2SNVNpX40TEsltrdjBqmE7jM/YMUKxaUmEEyb0dmr9BphVImeIkDj
         EVoDEKLGeDPIpUvkSFXybqdbPuCg8x36oz4tqfvalQM5Ae0TWopiFtM5DWVGYAixJ0ae
         bXUbTwcdbovVJh5Pd8K31OrzU84VfPvYbi/HfXVmALMpRffrV49Z30S5Zvc796r7WFsu
         jUVc5beeeLnvZltCRoncNWYLGdbXk8zzjtuzuzIOe3GvuY85fS0pn5msSKtZ8stVavgt
         43Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oOTUViScuV26OjcDeVP1JUDsvwA7X9GItCohjPmEB0=;
        b=7mpb/PCDql8UKDj/+g4AmCyUPa6nR5TfAZ6abNeMZFkn7G07DHe20ziauUXHQez+GW
         f9Z8HluaksJx2Z6Znmr+1B679p9V1I64TKHxlsTWUHJFPDpufiPOXbBZaPOUO3DIIoEb
         4udN3zTzbBNB0REr0tV0JBLz6KDYXXCZ+dsiBTHiT3sSKIJVLz4H3HFKD8yhKGtLrAx0
         dKw6lNBRe2aZ8QQratahXjFElbQ++Zu2dF408vsFtzvmjooYU+vpbw5dtfKL/NTWDUYW
         PLlowPrEXrsiWm4+rCfO+92vae3eWUJhtxv3dukw9bBAuxsx3K7douyWI4ggXVr4mcmg
         iv3w==
X-Gm-Message-State: ACrzQf2UAQBN0SrOS46Gl0ZB6VzhfdoYhBM5AuS3j/OOHTJ6SAK3cQ1I
        4dVjikRieGY4O+b0kWsw5HJ0mcloaUbAKQ==
X-Google-Smtp-Source: AMsMyM4q8m4Yw3AIDPuQeezhaN25wpmRhGI7p2pZvONncpo8OouRnAyESE4hs5usxDuy1E3hqFK3fQ==
X-Received: by 2002:a17:906:9253:b0:7ae:5a6:22f8 with SMTP id c19-20020a170906925300b007ae05a622f8mr35008561ejx.108.1667964242631;
        Tue, 08 Nov 2022 19:24:02 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b00734bfab4d59sm5453412ejy.170.2022.11.08.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:24:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osbh3-000pGK-2P;
        Wed, 09 Nov 2022 04:24:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] read-tree: teach --submodule-prefix
Date:   Wed, 09 Nov 2022 04:13:05 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <20221109004708.97668-4-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221109004708.97668-4-chooglen@google.com>
Message-ID: <221109.86y1skq08e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Glen Choo wrote:

Other things aside:

> This also fixes an existing bug where "git --super-prefix=<path>
> read-tree" (typically invoked by "git restore") in a partial clone with
> submodules could fail because we fetch promisor objects with "git
> fetch", but "git fetch" doesn't support "--super-prefix".
> [...]
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 037941b95d..9bec57a047 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor objects' '
>  	grep "loosen_unused_packed_objects/loosened:0" trace
>  '
>  
> +test_expect_success 'setup src repo with submodules' '
> +	test_config_global protocol.file.allow always &&
> +
> +	git init src-sub &&
> +	git -C src-sub config uploadpack.allowfilter 1 &&
> +	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
> +
> +	# This blob must be missing in the subsequent commit.
> +	echo foo >src-sub/file &&
> +	git -C src-sub add file &&
> +	git -C src-sub commit -m "submodule one" &&
> +	SUB_ONE=$(git -C src-sub rev-parse HEAD) &&
> +
> +	echo bar >src-sub/file &&
> +	git -C src-sub add file &&
> +	git -C src-sub commit -m "submodule two" &&
> +	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
> +
> +	git init src-super &&
> +	git -C src-super config uploadpack.allowfilter 1 &&
> +	git -C src-super config uploadpack.allowanysha1inwant 1 &&
> +	git -C src-super submodule add ../src-sub src-sub &&
> +
> +	git -C src-super/src-sub checkout $SUB_ONE &&
> +	git -C src-super add src-sub &&
> +	git -C src-super commit -m "superproject one" &&
> +
> +	git -C src-super/src-sub checkout $SUB_TWO &&
> +	git -C src-super add src-sub &&
> +	git -C src-super commit -m "superproject two"
> +'
> +
> +test_expect_success 'lazy-fetch in submodule succeeds' '
> +	test_when_finished "rm -rf src-super src-sub client" &&
> +
> +	test_config_global protocol.file.allow always &&
> +	git clone --filter=blob:none --also-filter-submodules \
> +		--recurse-submodules "file://$(pwd)/src-super" client &&
> +
> +	# Trigger lazy-fetch from the superproject
> +	git -C client restore --recurse-submodules --source=HEAD^ :/
> +'
> +

If I take this test addition on top of "master", and don't apply any of
the C changes on this topic it'll fail in "fetch", and then in
"index-pack"/"unpack-objects" etc., as "fetch" invokes those, due to us
using the --super-prefix.

But just this test addition and this code change would also "fix it":
	
	diff --git a/builtin/fetch.c b/builtin/fetch.c
	index 7378cafeec9..c5709a9e37b 100644
	--- a/builtin/fetch.c
	+++ b/builtin/fetch.c
	@@ -2114,6 +2114,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
	 	int result = 0;
	 	int prune_tags_ok = 1;
	 
	+	unsetenv(GIT_SUPER_PREFIX_ENVIRONMENT);
	+
	 	packet_trace_identity("fetch");
	 
	 	/* Record the command line for the reflog */
	diff --git a/git.c b/git.c
	index 10202a7f126..b5e63a0a57b 100644
	--- a/git.c
	+++ b/git.c
	@@ -531,7 +531,7 @@ static struct cmd_struct commands[] = {
	 	{ "env--helper", cmd_env__helper },
	 	{ "fast-export", cmd_fast_export, RUN_SETUP },
	 	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
	-	{ "fetch", cmd_fetch, RUN_SETUP },
	+	{ "fetch", cmd_fetch, RUN_SETUP | SUPPORT_SUPER_PREFIX /* not really* */ },
	 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
	 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
	 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },

Doesn't that do an end-run around the goals of this topic, but just in a
much simpler way?

I.e. I'm all for not propagating the --super-prefix any more than we
need to, but part of that is because once we start passing it, we set it
in the environment, and then we'll *keep* passing it. So we've had some
commands "accept" it, when really they don't care, they're just being
invoked by other commands that needed it originally.

But maybe we can just unsetenv() the prefix before invoking any built-in
that doesn't have SUPPORT_SUPER_PREFIX, or not set it in the environment
in the first place, but rather carry it forward more explicitly only
with the "--super-prefix" flag to "git" (adn then only to those specific
commands?

