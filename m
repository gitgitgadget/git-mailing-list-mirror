Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF36C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 02:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349053AbiBCCkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 21:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiBCCkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 21:40:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9AC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 18:40:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id s13so3578521ejy.3
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 18:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wrXmTvCwKnK0vEFJgBNg9u2DDb3H6wGmjhNYRxAS938=;
        b=YmXq//Y9PL228+eg+EhF6KJbgWx5R9YZ9KcmOt1wH49b5v2GGoizSL2SWQO2oq/9Au
         BDoqMlEF+b238KLLjCYtnpSG+ywU5EGBIcz1wqbwe/zWR81B0UsPyCPKxgVaCpXbzmsy
         U0JqAUO5qv/yhgY7sH95DhQUWel92NDy7GEmixwTBn01JDuVkcMwLwQ0O9aGHm9I7zSy
         p9ohFNBjTVmATC4/PJm9ODBL4IO8tyv2gWcJTDJyMzTdAAYr07vuh+z4M8HS5d21aS8z
         MXpxWHPCeQpUFd1fm87+bZhHK6YBX3QM57Z7B9r5ZJ0yOezgkGMF5sNYXn0LANMNUSg6
         Jffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wrXmTvCwKnK0vEFJgBNg9u2DDb3H6wGmjhNYRxAS938=;
        b=8OoXc41UzuKn3pZtcvVmhBLuhiNIqgm/sHXOm9FHx4Fy7odEFe0jHd46snyv7NMOyK
         8T72VhgVEfzoxj9zsEO/Z4wda5n0ABGGkPprfdPZzsDWF4kuVJh//6tmBStrFIxRc+D5
         eiDc9QPz5UzykQQiOckA+3zLV3NS2a7Assow4wbmujalfHbRK7Mv5wYhrL6VQZDffSvp
         TJzBcRCVfj0v78+JfulNjtfamevSO4FHTL6bwU8Vr6OpFWsy7l/k7MZGiHAXHS0e5Zii
         wb5QPGudtcu+rdeoT5RWRDghL6Z9tbOXN4CAjfxdibLQoXgFy5+sh3MOke20GeWQ0RfX
         1UdQ==
X-Gm-Message-State: AOAM531ySnyvihSLA92F4Vs2/wbQhcX39xcvT7rVjB7BSzC5XeMibRoy
        VP8poPO5fV9c+FLLdtJOfvRowyGlN9lOxQ==
X-Google-Smtp-Source: ABdhPJy8PPjpgzrwy3xxvk+2kzmIc7SEOZGnK10p1m7zy7cPdp3kaj/aZvRMCfGtEHmEl2JDOKXYdQ==
X-Received: by 2002:a17:907:a41f:: with SMTP id sg31mr28246274ejc.231.1643856010502;
        Wed, 02 Feb 2022 18:40:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ee37sm3651004edb.106.2022.02.02.18.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 18:40:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFS2b-004qT6-EK;
        Thu, 03 Feb 2022 03:40:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: move core cmd_update() logic to C
Date:   Thu, 03 Feb 2022 03:26:28 +0100
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
 <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
 <patch-v5-9.9-e8e57606ee9-20220128T125206Z-avarab@gmail.com>
 <kl6l4k5g246p.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6l4k5g246p.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220203.865ypw7jw6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, Glen Choo wrote:

> - Junio pointed out that this conflicts with
>   es/superproject-aware-submodules [2]. I'm not sure which should be
>   based on which. If this does end up being based on
>   es/superproject-aware-submodules, it would probably be easier to
>   rebase as a series of smaller patches. Atharva noted that the
>   conflicts are mild though, so maybe it's not so bad.

I think it makes sense to get this series through first, i.e. the
(supposedly) no-behavior-changing one, and then one that introduces new
submodule behavior.

Particularly because for es/superproject-aware-submodules the main
selling point is a performance improvement, which as I noted in the
review for it I've been unable to observe once the C<->sh layer goes
away.

I'm not saying it's not there, just that I don't think it's been shown
so far, IIRC there was some reference to some Google-internal network FS
that might or might not be helped by it...

> - Besides making sure that the sh -> c is faithful, a thorough review
>   should hopefully catch unintentional mistakes. The size of this patch
>   makes such mistakes difficult to spot. For instance, here's something
>   I spotted only after trying to split the patch myself..
>
>   > +static int module_update(int argc, const char **argv, const char *prefix)
>   > +{
>   > +	const char *update = NULL;
>   > +	struct pathspec pathspec;
>   > +	struct update_data opt = UPDATE_DATA_INIT;
>   > +
>   > +	struct option module_update_clone_options[] = {
>   [...]
>   > +	};
>   > +
>   > +	const char *const git_submodule_helper_usage[] = {
>   > +		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
>   > +		NULL
>   > +	};
>   > +
>   > +	update_clone_config_from_gitmodules(&opt.max_jobs);
>   > +	git_config(git_update_clone_config, &opt.max_jobs);
>
>   Notice that we copy-pasted the option parsing from update-clone into
>   module_update() but forgot to update the names.
>
> My ideal patch organization would be something like:
>
> - wrap some existing command in "git submodule--helper update" (probably
>   run-update-procedure)
> - absorb the surrounding sh code into "git submodule--helper
>   update" one command at-a-time i.e. deprecating and removing the
>   commands one at a time - instead of deprecating and removing them all
>   at once (like this patch), or deprecating all at once and removing
>   them one at a time (like v1).

I do think atomic changes that don't leave dead code for removal later
are easier to read & reason about, whatever else is reorganized.

I.e. not to have something where we replace all the running code, and
then remove already-unused code later.

On that topic, I noticed this series could/should have [1] fixed up into
it.

> - If you think this alternative organization would be helpful for you
>   too, I will attempt it. This will take a while, but by the end you and
>   I will have effectively reviewed all of the code, so it should be easy
>   to finish up the review.

I think it might, but I really don't know. We'll just have to see, so if
you want to take a stab at it that would be great.

Maybe it's a good way forward. E.g. as af first small step we could turn:

    while read -r quickabort sha1 just_cloned sm_path
    [...]
    die_if_unmatched "$quickabort" "$sha1"

into version where we fold that die_if_unmatched() logic into the C
code, and then ensure-core-worktree etc.

> - Otherwise e.g. maybe this is a huge waste of time, or you're already
>   really confident in the correctness of the sh -> c when you reviewed
>   the original patch, etc, I'll just review this patch as-is. I'd
>   appreciate any tips and tricks that might help :)

I'm not really confident in it.

I've read it, tested it as well as I could manage etc. but it's still a
very large change.

1.

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index b93f39288ce..756c2a67c72 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -286,13 +286,6 @@ get_author_ident_from_commit () {
 	parse_ident_from_commit author AUTHOR
 }
 
-# Clear repo-local GIT_* environment variables. Useful when switching to
-# another repository (e.g. when entering a submodule). See also the env
-# list in git_connect()
-clear_local_git_env() {
-	unset $(git rev-parse --local-env-vars)
-}
-
 # Generate a virtual base file for a two-file merge. Uses git apply to
 # remove lines from $1 that are not in $2, leaving only common lines.
 create_virtual_base() {
diff --git a/git-submodule.sh b/git-submodule.sh
index bcd8b92aabd..6c91b9e2403 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -50,30 +50,11 @@ single_branch=
 jobs=
 recommend_shallow=
 
-die_if_unmatched ()
-{
-	if test "$1" = "#unmatched"
-	then
-		exit ${2:-1}
-	fi
-}
-
 isnumber()
 {
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
 }
 
-# Sanitize the local git environment for use within a submodule. We
-# can't simply use clear_local_git_env since we want to preserve some
-# of the settings from GIT_CONFIG_PARAMETERS.
-sanitize_submodule_env()
-{
-	save_config=$GIT_CONFIG_PARAMETERS
-	clear_local_git_env
-	GIT_CONFIG_PARAMETERS=$save_config
-	export GIT_CONFIG_PARAMETERS
-}
-
 #
 # Add a new submodule to the working tree, .gitmodules and the index
 #
