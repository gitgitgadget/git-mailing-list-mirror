Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B3C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbiF1Iar (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbiF1Iaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:30:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A525EBA
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:30:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sb34so24117474ejc.11
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=txM3Au9F9xNLAv2SqNTyeRU7Xh887Na7l1Dk30qL+60=;
        b=Kd2gYK4ebEAmoyjBuYHxZ2jXHINguRW8KCzXwULZw+I0sy7NGw/C89N3+uiQ4lGtw+
         aHDMKcYje3WbYB05phxKeco8yW37CHEwbwJlS0IJaIRFQHjyW3EfHm0OZEcF8NuYbPjQ
         G3d3hI5GN+zGrmIWcAywCCOhCP1QKlW6rbAyBFUaWVGRLRaUrYQPkV8Smh5ai0tVp0rS
         XNXm23A0oubv6lpsouzUVTU8vViupq9DaDVPU1vQJinWsSqX5PIoLn1HjBc9laFOcajW
         QIXiXvhv5SJudfn8unQg7+2KAYAKuyV9vKFfxXOFzd3rSfSkT5NhCOkIYAuwyvRPsQhn
         +Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=txM3Au9F9xNLAv2SqNTyeRU7Xh887Na7l1Dk30qL+60=;
        b=yTgBP2TRPIkuWJB3kquAFfw4AIiOTSlXp2GWp/A4fQTedFvp1GRCzybkrkxO2Wna1/
         CiGTA82XowRH8Jl+LIq5F781xcpniUjH5k05jqYJfVRrACo8CH9n/PNkc50BkyPTsM3s
         jrUV0OjxPae4tyr/DzoIO6JLTA+G+Q49cCNYcCjSOpqi73wKA1wqs8//BnU//0vAt27X
         6A2pUfBuS9g7HQxW5t3x7vQt8aK33Hp8+8xTKEI5ziYVTJLH2tSqLuWZX89yvWI/ptWP
         YDjoJkdWBa+iGKW0OQbIaDZigvsLXLXtQsP4XxGVilJ4dCsfWUE79c3lCU24CiuzPYE+
         gMBA==
X-Gm-Message-State: AJIora97pP/lbLYL/63wALQN/ki6xWCjUPc0OwZORdj0+tF7w2UVLjWd
        vA4ug0KVLo/PTTG/GmrPezJl2ltqceE=
X-Google-Smtp-Source: AGRyM1sQbu7isqw+OHQeMtYPJPRPZR47+Yly1RMzoExe2CMhUzcU3FpB6dSkfetJiy9ERTFK/0pVGw==
X-Received: by 2002:a17:906:14d:b0:711:ff36:b1af with SMTP id 13-20020a170906014d00b00711ff36b1afmr16784349ejh.422.1656405035745;
        Tue, 28 Jun 2022 01:30:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709062cd300b006ff802baf5dsm6127358ejr.54.2022.06.28.01.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:30:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o66cE-001l0H-6b;
        Tue, 28 Jun 2022 10:30:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/5] submodule--helper update: use display path helper
Date:   Tue, 28 Jun 2022 10:23:22 +0200
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
 <473548f2fa473b9b94fcc099a81613c622a32022.1656372017.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <473548f2fa473b9b94fcc099a81613c622a32022.1656372017.git.gitgitgadget@gmail.com>
Message-ID: <220628.861qv9gpg5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> There are two locations in prepare_to_clone_next_submodule() that
> manually calculate the submodule display path, but should just use
> do_get_submodule_displaypath() for consistency.
>
> Do this replacement and reorder the code slightly to avoid computing
> the display path twice.
>
> This code was never tested, and adding tests shows that both these sites
> have been computing the display path incorrectly ever since they were
> introduced in 48308681b0 (git submodule update: have a dedicated helper
> for cloning, 2016-02-29) [1]:

I think the tests should really be split up as their own preceding
commit, so we're assured that this "git rebase -x 'make test'"'s
cleanly.

> [...]
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c597df7528e..63c661b26a6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1949,30 +1949,22 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  	const char *update_string;
>  	enum submodule_update_type update_type;
>  	char *key;
> -	struct strbuf displaypath_sb = STRBUF_INIT;
>  	struct strbuf sb = STRBUF_INIT;
> -	const char *displaypath = NULL;
> +	char *displaypath = NULL;

Don't init to NULL?...

>  	int needs_cloning = 0;
>  	int need_free_url = 0;
>  
> +	displaypath = do_get_submodule_displaypath(ce->name,

...because this will either die or return a valid string, and the init
is just suppressing compiler flow analysis, no?

> +						   suc->update_data->prefix,
> +						   suc->update_data->recursive_prefix);
> +
>  	if (ce_stage(ce)) {
> -		if (suc->update_data->recursive_prefix)
> -			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce->name);
> -		else
> -			strbuf_addstr(&sb, ce->name);
> -		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
> -		strbuf_addch(out, '\n');
> +		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypath);

Nit: The removal of strbuf_addch() here is bad, we try not to expose
translators to such formatting concerns, so let's leave the \n out of
the message still.

But more imporantly let's also split up the %s to '%s' change up, or
perhaps just drop it for now? Isn't it entirely unrelated?

>  		goto cleanup;
>  	}
>  
>  	sub = submodule_from_path(the_repository, null_oid(), ce->name);
>  
> -	if (suc->update_data->recursive_prefix)
> -		displaypath = relative_path(suc->update_data->recursive_prefix,
> -					    ce->name, &displaypath_sb);
> -	else
> -		displaypath = ce->name;
> -
>  	if (!sub) {
>  		next_submodule_warn_missing(suc, out, displaypath);
>  		goto cleanup;
> @@ -2062,7 +2054,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  					      "--no-single-branch");
>  
>  cleanup:
> -	strbuf_release(&displaypath_sb);
> +	free(displaypath);
>  	strbuf_release(&sb);
>  	if (need_free_url)
>  		free((void*)url);

I must admit I didn't spend too much time on the *actual* logic change
here, but nothing seems obviously incorrect...

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 43f779d751c..e1dc3b1041b 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1116,4 +1116,63 @@ test_expect_success 'submodule update --filter sets partial clone settings' '
>  	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
>  '
>  
> +# NEEDSWORK: Clean up the tests so that we can reuse the test setup.
> +# Don't reuse the existing repos because the earlier tests have
> +# intentionally disruptive configurations.

Yeah this does seem a bit repetative...

> +test_expect_success 'setup clean recursive superproject' '
> +	git init bottom &&
> +	test_commit -C bottom "bottom" &&
> +	git init middle &&
> +	git -C middle submodule add ../bottom bottom &&
> +	git -C middle commit -m "middle" &&
> +	git init top &&
> +	git -C top submodule add ../middle middle &&
> +	git -C top commit -m "top" &&
> +	git clone --recurse-submodules top top-clean
> +'
> +
> +test_expect_success 'submodule update should skip unmerged submodules' '
> +	test_when_finished "rm -fr top-cloned" &&
> +	cp -r top-clean top-cloned &&
> +
> +	# Create an upstream commit in each repo
> +	test_commit -C bottom upstream_commit &&
> +	(cd middle &&
> +	 git -C bottom fetch &&
> +	 git -C bottom checkout -f FETCH_HEAD &&
> +	 git add bottom &&
> +	 git commit -m "upstream_commit"
> +	) &&
> +	(cd top &&
> +	 git -C middle fetch &&
> +	 git -C middle checkout -f FETCH_HEAD &&
> +	 git add middle &&
> +	 git commit -m "upstream_commit"
> +	) &&

E.g. here the mixture of "cd" and "-C" is a bit odd, can't we just use:

    git -C middle/bottom ...
    ...
    git -C middle add 

I also wonder if this can't be a for-loop with the right params

> +
> +	# Create a downstream conflict
> +	(cd top-cloned/middle &&
> +	 test_commit -C bottom downstream_commit &&
> +	 git add bottom &&
> +	 git commit -m "downstream_commit" &&
> +	 git fetch --recurse-submodules origin &&
> +	 test_must_fail git merge origin/main
> +	) &&
> +	# Make the update of "middle" a no-op, otherwise we error out
> +	# because of its unmerged state
> +	test_config -C top-cloned submodule.middle.update !true &&
> +	git -C top-cloned submodule update --recursive 2>actual.err &&
> +	grep "Skipping unmerged submodule .middle/bottom." actual.err

Maybe use grep -F with ${SQ} instead?
> +'
> +
> +test_expect_success 'submodule update --recursive skip submodules with strategy=none' '
> +	test_when_finished "rm -fr top-cloned" &&
> +	cp -r top-clean top-cloned &&
> +
> +	test_commit -C top-cloned/middle/bottom downstream_commit &&
> +	git -C top-cloned/middle config submodule.bottom.update none &&
> +	git -C top-cloned submodule update --recursive 2>actual.err &&
> +	grep "Skipping submodule .middle/bottom." actual.err
> +'
> +
>  test_done

