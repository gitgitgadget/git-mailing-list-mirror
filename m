Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FC5C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87DE60EB6
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhGWJTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhGWJTA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 05:19:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90699C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:59:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gt31so2688836ejc.12
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9xIUYlTYrhPHpjHjfJlLDBElDIN7ZLrshs+pFNYdQk8=;
        b=EmZH8wS+qLZy7zbjy1IlK9JmBCql3/q9S5xLst1nJ+k+SgX97FOnf7Yu/biA6JPrcq
         bUCdDGw5ZPRoRYmB302HEWdauy8o4Z2dXDkY7RiV3BAqy9HRNonmweyf6EN/f2nWrWbz
         o3rRCq+ul04sssrLCEglEh+JguugmFAhLRUInuNXtWYp5c62vxnb7cEFiUka4kCjKR/u
         +Kehh/KWmhxgtYHqjBnEk/cG8+xhwANRnMvj+JLE53ap1f7vcGPZ9XYbM1QOuyHXxjIE
         NcmfdncCw+H8CKTLTFyNqAfHdUfjY98Pc3Xh3YEp+5WBm/rtbafPoDSnZ9V4aP9gaCeN
         LPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9xIUYlTYrhPHpjHjfJlLDBElDIN7ZLrshs+pFNYdQk8=;
        b=RmD0qIGYZCE24uBpjnKLB142XU9mWYhwji+ip26mnCsKES2nN3Yxa2164X/WYsdX3i
         J5d4Ixas73+ELQX9Hjr5c1I9nqpdMhTtBZlJfOgQs/sltGKkU2BPgd7DAzFuhVDpA2Gl
         ZvCZRWESsniTivdEsgVdf/w5CJvB2ccIh9owEmCOciRObrZN2dI8qcHoULWrXPjGX0Pq
         3RpegDfMdVvbUBmI+LOK0t7nYq9rZW7qucmG0DaJvzZ7pKaLDtG+u4QpUAJ76uhaE1Vc
         0ZHuQkaJHX0342Rm+Uf3xVIigVg/NyId/8eIwB/HT5NrkN70yfvsuqo1T+CQcDZzyTjr
         hBZQ==
X-Gm-Message-State: AOAM532wu5GwekHeMEti0f5ffSFSbtyRhBHOqFfAojwJosfvdYdqTwke
        GvDH4QpU71GR/GW2OSRNMSw5huxWz+BieA==
X-Google-Smtp-Source: ABdhPJzXyL9eQI1Q4Hj6PjNWbddWSc733NQ5FH5ybUH60ei5O3L3iWCz+a2tallaeGhR7rE1gKGKvw==
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr3833018ejc.384.1627034371750;
        Fri, 23 Jul 2021 02:59:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l20sm13418032edb.47.2021.07.23.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:59:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [GSoC] [PATCH] submodule--helper: run update procedures from C
Date:   Fri, 23 Jul 2021 11:37:46 +0200
References: <20210722134012.99457-1-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210722134012.99457-1-raykar.ath@gmail.com>
Message-ID: <87r1fps63r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Atharva Raykar wrote:

> +/* NEEDSWORK: try to do this without creating a new process */
> +static int is_tip_reachable(const char *path, struct object_id *sha1)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf rev = STRBUF_INIT;
> +	char *sha1_hex = oid_to_hex(sha1);
> +
> +	cp.git_cmd = 1;
> +	cp.dir = xstrdup(path);
> +	cp.no_stderr = 1;
> +	strvec_pushl(&cp.args, "rev-list", "-n", "1", sha1_hex, "--not", "--all", NULL);
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +
> +	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
> +		return 0;
> +
> +	return 1;
> +}

I think it's fine to do this & leave out the NEEDSWORK commit, just
briefly noting in the commit-message that we're not bothering with
trying to reduce sub-command invocations. It can be done later if anyone
cares.

> [...]
> +		strbuf_addf(&die_msg, "fatal: Unable to checkout '%s' in submodule path '%s'\n",
> +			    sha1, ud->displaypath);
> +		strbuf_addf(&say_msg, "Submodule path '%s': checked out '%s'\n",
> +			    ud->displaypath, sha1);

For all of these you're removing the translation from a message like:

    die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"

Which is easy enough to fix, just use _(), i.e.:

    strbuf_addf(&die_msg, _("Unable to checkout '%s' in submodule path '%s'\n"), [...]

I removed the "fatal: " per a comment below...

> +		break;
> +	case SM_UPDATE_REBASE:
> +		cp.git_cmd = 1;
> +		strvec_push(&cp.args, "rebase");
> +		if (ud->quiet)
> +			strvec_push(&cp.args, "--quiet");
> +		strbuf_addf(&die_msg, "fatal: Unable to rebase '%s' in submodule path '%s'\n",
> +			    sha1, ud->displaypath);
> +		strbuf_addf(&say_msg, "Submodule path '%s': rebased into '%s'\n",
> +			    ud->displaypath, sha1);
> +		must_die_on_failure = 1;
> +		break;
> +	case SM_UPDATE_MERGE:
> +		cp.git_cmd = 1;
> +		strvec_push(&cp.args, "merge");
> +		if (ud->quiet)
> +			strvec_push(&cp.args, "--quiet");
> +		strbuf_addf(&die_msg, "fatal: Unable to merge '%s' in submodule path '%s'\n",
> +			    sha1, ud->displaypath);
> +		strbuf_addf(&say_msg, "Submodule path '%s': merged in '%s'\n",
> +			    ud->displaypath, sha1);
> +		must_die_on_failure = 1;
> +		break;
> +	case SM_UPDATE_COMMAND:
> +		/* NOTE: this does not handle quoted arguments */
> +		strvec_split(&cp.args, ud->update_strategy.command);
> +		strbuf_addf(&die_msg, "fatal: Execution of '%s %s' failed in submodule path '%s'\n",
> +			    ud->update_strategy.command, sha1, ud->displaypath);
> +		strbuf_addf(&say_msg, "Submodule path '%s': '%s %s'\n",
> +			    ud->displaypath, ud->update_strategy.command, sha1);
> +		must_die_on_failure = 1;
> +		break;
> +	case SM_UPDATE_UNSPECIFIED:
> +	case SM_UPDATE_NONE:
> +		BUG("update strategy should have been specified");
> +	}
> +
> +	strvec_push(&cp.args, sha1);
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +
> +	if (run_command(&cp)) {
> +		if (must_die_on_failure) {
> +			retval = 2;
> +			fputs(_(die_msg.buf), stderr);
> +			goto cleanup;

FWIW I'd find this clearer if we just kept track of what operation we
ran above, and just in this run_command() && must_die_on_failure case
started populating these die messages.

But even if not the reason I dropped the "fatal: " is shouldn't we just
call die() here directly? Why clean up when we're dying anyway?

Also since I see you used _() here that won't work, i.e. with gettet if
you happen to need to declare things earlier, you need to use N_() to
mark the message for translation.

The _() here won't find any message translated (unless the string
happened to exactly match a thing in the *.po file for other reasons,
not the case here).

But in this case we can just die(msg) here and have used the _() above,
or just call die() directly here not having made a die_msg we usually
won't use...

> +static int do_run_update_procedure(struct update_data *ud)
> +{
> +	if ((!is_null_oid(&ud->sha1) && !is_null_oid(&ud->subsha1) && !oideq(&ud->sha1, &ud->subsha1)) ||
> +	    is_null_oid(&ud->subsha1) || ud->force) {
> +		int subforce = is_null_oid(&ud->subsha1) || ud->force;
> +
> +		if (!ud->nofetch) {
> +			/*
> +			 * Run fetch only if `sha1` isn't present or it
> +			 * is not reachable from a ref.
> +			 */
> +			if (!is_tip_reachable(ud->sm_path, &ud->sha1))
> +				if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
> +				    !ud->quiet)
> +					fprintf_ln(stderr,
> +						   _("Unable to fetch in submodule path '%s'; "
> +						     "trying to directly fetch %s:"),
> +						   ud->displaypath, oid_to_hex(&ud->sha1));
> +			/*
> +			 * Now we tried the usual fetch, but `sha1` may
> +			 * not be reachable from any of the refs.
> +			 */
> +			if (!is_tip_reachable(ud->sm_path, &ud->sha1))
> +				if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->sha1))
> +					die(_("Fetched in submodule path '%s', but it did not "
> +					      "contain %s. Direct fetching of that commit failed."),
> +					    ud->displaypath, oid_to_hex(&ud->sha1));
> +		}
> +
> +		return run_update_command(ud, subforce);
> +	}
> +
> +	return 3;
> +}

Since this has excatly one caller I think it's better for readability
(less indentation) and flow to just remove that "return 3" condition and
do the big "if" you have at the end, i.e. have this function start with
"int subforce =" and...

>  static void update_submodule(struct update_clone_data *ucd)
>  {
>  	fprintf(stdout, "dummy %s %d\t%s\n",
> @@ -2379,6 +2552,79 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	return update_submodules(&suc);
>  }
>  
> +static int run_update_procedure(int argc, const char **argv, const char *prefix)
> +{
> +	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
> +	char *prefixed_path, *update = NULL;
> +	char *sha1 = NULL, *subsha1 = NULL;
> +	struct update_data update_data = UPDATE_DATA_INIT;
> +
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
> +		OPT__FORCE(&force, N_("force checkout updates"), 0),
> +		OPT_BOOL('N', "no-fetch", &nofetch,
> +			 N_("don't fetch new objects from the remote site")),
> +		OPT_BOOL(0, "just-cloned", &just_cloned,
> +			 N_("overrides update mode in case the repository is a fresh clone")),
> +		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
> +		OPT_STRING(0, "prefix", &prefix,
> +			   N_("path"),
> +			   N_("path into the working tree")),
> +		OPT_STRING(0, "update", &update,
> +			   N_("string"),
> +			   N_("rebase, merge, checkout or none")),
> +		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
> +			   N_("path into the working tree, across nested "
> +			      "submodule boundaries")),
> +		OPT_STRING(0, "sha1", &sha1, N_("string"),
> +			   N_("SHA1 expected by superproject")),
> +		OPT_STRING(0, "subsha1", &subsha1, N_("string"),
> +			   N_("SHA1 of submodule's HEAD")),
> +		OPT_END()
> +	};
> +
> +	const char *const usage[] = {
> +		N_("git submodule--helper run-update-procedure [<options>] <path>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if (argc != 1)
> +		usage_with_options(usage, options);
> +	update_data.force = !!force;
> +	update_data.quiet = !!quiet;
> +	update_data.nofetch = !!nofetch;
> +	update_data.just_cloned = !!just_cloned;

For all of these just pass the reference to the update_data variable
directly in the OPT_*(). No need to set an "int force", only to copy it
over to update_data.force. Let's just use the latter only.

> +
> +	if (sha1)
> +		get_oid_hex(sha1, &update_data.sha1);
> +	else
> +		oidcpy(&update_data.sha1, null_oid());

Nit: Even if a historical option forces us to support --sha1, let's use
"oid" for the variable etc. But in this case the --sha1 is new, no?
Let's use --object-id or --oid (whatever is more common, I didn't
check)>

> +
> +	if (subsha1)
> +		get_oid_hex(subsha1, &update_data.subsha1);
> +	else
> +		oidcpy(&update_data.subsha1, null_oid());

Ditto. Also I think for both of these you can re-use
parse_opt_object_id. See "squash-onto" and "upstream" in
builtin/rebase.c.

Then you just supply an oid variable directly and let that helper do all
the get_oid etc.

> +	if (update_data.recursive_prefix)
> +		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
> +	else
> +		prefixed_path = xstrdup(update_data.sm_path);
> +
> +	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
> +
> +	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
> +					    update_data.sm_path, update,
> +					    &update_data.update_strategy);
> +
> +	free(prefixed_path);
> +
> +	return do_run_update_procedure(&update_data);

....(continued from above) ...here just do:

    if (that big if condition)
        return do_run_update_procedure(&update_data);
    else
        return 3;
