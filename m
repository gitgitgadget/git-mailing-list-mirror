Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD6C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 10:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377575AbiDTKWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377574AbiDTKWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 06:22:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43172218C
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:19:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v4so1636668edl.7
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Yb3jDU1GAcmFCNlTBduPim5hTQzWed8jfAcyepRiEo4=;
        b=pQQ8RRe9eBQZvlOhHl9ZZQC2DoMjRSNKguHtc+olxTI4ThN0Gd97LPTcpXc5JQOoVz
         oPGDzRFR4XZhKi+8zgv7k87Q4eg0IehIjJrnYPq70jnehqByg2kqejPq+i2zBrCldc9J
         Ha/lzf/L3P/wN+5XVzY5pXEk9NrXNv+h8gs9rIOLzcA5vcVHIfiCgSX1PugUybD+FZ/F
         11p4H5RnDD8VrAMYPGPkmRp0qMZ8VrDPm7MhRQ7gLeiZTeftH0zfZu9i4IvuGU4RyKpI
         7nmcJ8m1EKw7CJOI+wFlAIfRYoi2Wp7dAJNYOhP4lNKe176E2RfwRb0MwHkEUjZK6HiX
         34SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Yb3jDU1GAcmFCNlTBduPim5hTQzWed8jfAcyepRiEo4=;
        b=PQxB7BoFGA3PdVY6alUo6vnJlgmJUJVZntAXlDV3C8vOfy9MtMAtKQkpcxZ2t/gMT8
         VJ46kUanSc7lUi6JIhYI0HPs435R+An3LFpLE0FTWukqcYoRRIJlje9bLYtymHinB7Pb
         Dacp2pQfIbA/KnVf6/9wCfQs2y36KrnHVQrx8lXIxItKxIhDCAzoOl83+9Wt7dwriqMx
         3qd25Sc9vsH/nxx2puTMotYTjv9IIMGjPuhqknh/UXOcVinK7uecjhZnT5OU8aodBrRU
         pkCsymQEwXSvlYGtW7l2s6/7OcXd/zQlP78pyK0k6lcU5L3OB7PhaOsYAHg6wyirjuxx
         wiNg==
X-Gm-Message-State: AOAM532GwjUXEWqAX1bnlqALWfCia6kodKlrGSIgJP4VeyPxUu8z2kFo
        ADrm+j4moTQWwe0sDFJJQQEQ3ThfvzA=
X-Google-Smtp-Source: ABdhPJwfaAcPak4Ale6NIxh0I1w9Sr+jrJhF+I08Gh95Kgnv/o1IgwioVTP1LAx59LF3eJMLo98wdA==
X-Received: by 2002:a05:6402:3690:b0:41d:79b5:5979 with SMTP id ej16-20020a056402369000b0041d79b55979mr22511377edb.309.1650449989339;
        Wed, 20 Apr 2022 03:19:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm6562317ejy.132.2022.04.20.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 03:19:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nh7R5-007FpS-Ve;
        Wed, 20 Apr 2022 12:19:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/8] rebase --apply: remove duplicated code
Date:   Wed, 20 Apr 2022 12:10:54 +0200
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
 <a4320f2fcf35f180e1c585be4105194f1555a874.1650448612.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <a4320f2fcf35f180e1c585be4105194f1555a874.1650448612.git.gitgitgadget@gmail.com>
Message-ID: <220420.86a6cg83b0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 20 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When we are reattaching HEAD after a fast-forward we can use
> move_to_original_branch() rather than open coding a copy of that
> code. The old code appears to handle the case where the rebase is
> started from a detached HEAD but in fact in that case there is nothing
> to do as we have already updated HEAD.
>
> Note that the removal of "strbuf_release(&msg)" is safe as there is an
> identical call just above this hunk which can be seen by viewing the
> diff with -U6.

Instead of assuring the reader that this is OK, perhaps just squash this
in:
	
	diff --git a/builtin/rebase.c b/builtin/rebase.c
	index 4a664964c30..5108679e816 100644
	--- a/builtin/rebase.c
	+++ b/builtin/rebase.c
	@@ -1029,7 +1029,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
	 	int ret, flags, total_argc, in_progress = 0;
	 	int keep_base = 0;
	 	int ok_to_skip_pre_rebase = 0;
	-	struct strbuf msg = STRBUF_INIT;
	 	struct strbuf revisions = STRBUF_INIT;
	 	struct strbuf buf = STRBUF_INIT;
	 	struct object_id merge_base;
	@@ -1769,17 +1768,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
	 		printf(_("First, rewinding head to replay your work on top of "
	 			 "it...\n"));
	 
	-	strbuf_addf(&msg, "%s: checkout %s",
	-		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
	-	ropts.oid = &options.onto->object.oid;
	-	ropts.orig_head = &options.orig_head,
	-	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
	+	{
	+		struct strbuf msg = STRBUF_INIT;
	+
	+		strbuf_addf(&msg, "%s: checkout %s",
	+			    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
	+			    options.onto_name);
	+		ropts.oid = &options.onto->object.oid;
	+		ropts.orig_head = &options.orig_head,
	+			ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
	 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
	-	ropts.head_msg = msg.buf;
	-	ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
	-	if (reset_head(the_repository, &ropts))
	-		die(_("Could not detach HEAD"));
	-	strbuf_release(&msg);
	+		ropts.head_msg = msg.buf;
	+		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
	+		if (reset_head(the_repository, &ropts))
	+			die(_("Could not detach HEAD"));
	+		strbuf_release(&msg);
	+	}
	 
	 	/*
	 	 * If the onto is a proper descendant of the tip of the branch, then

That's a 2-line change (aside from the scope addition) if viewed with
-w. I.e. before your change below we needed &msg in two places, now that
we only need it in one it seems better just to move the variable to be
scoped with its only user.

And maybe it's getting too much into unrelated cleanup, but this change
also leaves the loose end that the "ropts" variable no longer needs to
be shared. You added it in 6ae8086161d (reset_head(): take struct
rebase_head_opts, 2022-01-26) along whith the memset() removed here, but
(on top of the proposed squash) we could also do this:

	
	diff --git a/builtin/rebase.c b/builtin/rebase.c
	index 5108679e816..8e2dc74c834 100644
	--- a/builtin/rebase.c
	+++ b/builtin/rebase.c
	@@ -1043,7 +1043,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
	 	int reschedule_failed_exec = -1;
	 	int allow_preemptive_ff = 1;
	 	int preserve_merges_selected = 0;
	-	struct reset_head_opts ropts = { 0 };
	 	struct option builtin_rebase_options[] = {
	 		OPT_STRING(0, "onto", &options.onto_name,
	 			   N_("revision"),
	@@ -1275,7 +1274,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
	 	}
	 	case ACTION_SKIP: {
	 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
	-
	+		struct reset_head_opts ropts = { 0 };
	+	
	 		options.action = "skip";
	 		set_reflog_action(&options);
	 
	@@ -1291,6 +1291,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
	 	}
	 	case ACTION_ABORT: {
	 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
	+		struct reset_head_opts ropts = { 0 };
	+
	 		options.action = "abort";
	 		set_reflog_action(&options);
	 
	@@ -1770,6 +1772,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
	 
	 	{
	 		struct strbuf msg = STRBUF_INIT;
	+		struct reset_head_opts ropts = { 0 };
	 
	 		strbuf_addf(&msg, "%s: checkout %s",
	 			    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),

I.e. the "ropts" earlier in the function wasn't shared with the code
below, we'd "goto" past it...
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e942c300f8c..4832f16e675 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1782,19 +1782,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	 * If the onto is a proper descendant of the tip of the branch, then
>  	 * we just fast-forwarded.
>  	 */
> -	strbuf_reset(&msg);
>  	if (oideq(&merge_base, &options.orig_head)) {
>  		printf(_("Fast-forwarded %s to %s.\n"),
>  			branch_name, options.onto_name);
> -		strbuf_addf(&msg, "rebase finished: %s onto %s",
> -			options.head_name ? options.head_name : "detached HEAD",
> -			oid_to_hex(&options.onto->object.oid));
> -		memset(&ropts, 0, sizeof(ropts));
> -		ropts.branch = options.head_name;
> -		ropts.flags = RESET_HEAD_REFS_ONLY;
> -		ropts.head_msg = msg.buf;
> -		reset_head(the_repository, &ropts);
> -		strbuf_release(&msg);
> +		move_to_original_branch(&options);
>  		ret = finish_rebase(&options);
>  		goto cleanup;
>  	}

