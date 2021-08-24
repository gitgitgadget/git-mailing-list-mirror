Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B40C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C73961220
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhHXJnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhHXJnc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:43:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7ABC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:42:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e1so4950711plt.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:date:message-id
         :in-reply-to:mime-version:content-transfer-encoding;
        bh=znk81ZFe9H+2TNFwK5joLBpLLDbZN5GCXPxNpSaqJWs=;
        b=I5ckvm4im9wwY3hZQq/zcrb3dZxOF5WGhCrvtsQJz40CSvOdjaDS5sZZwrOJKSiyH1
         Qm/7nBySPvTQYQMA2e7NaU/FdypfyilVqjM66JJN/yvra55k1tpFkChdW7HopyU966zR
         cXUkE1LNAKM6hrUsHtOgVRmI/gwwl8b626T/YRqj1yxMIXBQRjX+IuYN+nEu1LkILit7
         s5dyjCMNT7vh1vU8sY0QpPlkjM6BGsV0wp01vr2ZF4gHAqV9ErG3fD/bZkXJKfZKjtfo
         0q9MxkchUqADKxAv3zrC0IUnqm3aP/kGrwQBmOFlFh0/KX8r8ve6yZrgWh72hZ0hmMpH
         FDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :message-id:in-reply-to:mime-version:content-transfer-encoding;
        bh=znk81ZFe9H+2TNFwK5joLBpLLDbZN5GCXPxNpSaqJWs=;
        b=OtCoU37gHtD6GUwouSQwNG+Fcbqs7dAdwkrU+mJDXMTTW2P/zYEYDPA97UzZalI6gA
         WHs9p2FoWqJ2HO9Y43rCWrXUmsoFIBXv5KAf/uVkV/Q9gRGNpCNF0CLW64rZI10yxwnn
         znVCIKGbt1An4ozlQ77Grlp0Mu+ly2pnLMQKjTLffHNJAdmKjSCHSTPCT3W0HHiWdJSG
         a2hQb30lrWuIOw2jp7re1FM7lIhYVJMEWZ9xpSZF/tGtNacYuBWP9PIhUwB07rZjomTy
         WUOKfcW4LR40LTozdPtt36FDBjHo4h/pUGWwkKVsi53Vw/OP2ffdjQlmcB+lLPHKgI2S
         3uYg==
X-Gm-Message-State: AOAM532Ji+9Xq5DxkYBaQHaCRTsy91q2FvedDM25uLHIZjra7y/uAisv
        tekjLoBS7+ptdih06oIGmAA=
X-Google-Smtp-Source: ABdhPJyrRHpkkEqafRCgivkofb7H2WdpmE7UZPi+Olf7eMqKr8BkCTrPsCfKma9u6FPXoASKR+7TUA==
X-Received: by 2002:a17:902:c406:b0:12d:d0ff:4aa with SMTP id k6-20020a170902c40600b0012dd0ff04aamr32531557plk.48.1629798168560;
        Tue, 24 Aug 2021 02:42:48 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id j12sm18061827pfj.54.2021.08.24.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:42:48 -0700 (PDT)
References: <20210802130627.36170-1-raykar.ath@gmail.com>
 <20210813075653.56817-1-raykar.ath@gmail.com> <xmqqim09w5yc.fsf@gitster.g>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [GSoC] [PATCH v3] submodule--helper: run update procedures from C
Date:   Tue, 24 Aug 2021 14:28:22 +0530
Message-ID: <m2r1ejdxb0.fsf@gmail.com>
In-reply-to: <xmqqim09w5yc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pardon my late response, I had been occupied with other things.

Junio C Hamano <gitster@pobox.com> writes:

> Atharva Raykar <raykar.ath@gmail.com> writes:
> [...]
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Shourya Shukla <periperidip@gmail.com>
>
> Keep trailer lines in chronological order.  The mentors mentored,
> the patch was written and finally you signed it off.

Okay.

>> +static int run_update_command(struct update_data *ud, int subforce)
>> +{
>> +	struct child_process cp =3D CHILD_PROCESS_INIT;
>> +	char *oid =3D oid_to_hex(&ud->oid);
>> +	int must_die_on_failure =3D 0;
>> +
>> +	cp.dir =3D xstrdup(ud->sm_path);
>> +	switch (ud->update_strategy.type) {
>> +	case SM_UPDATE_CHECKOUT:
>> +		cp.git_cmd =3D 1;
>> +		strvec_pushl(&cp.args, "checkout", "-q", NULL);
>> +		if (subforce)
>> +			strvec_push(&cp.args, "-f");
>> +		break;
>> +	case SM_UPDATE_REBASE:
>> +		cp.git_cmd =3D 1;
>> +		strvec_push(&cp.args, "rebase");
>> +		if (ud->quiet)
>> +			strvec_push(&cp.args, "--quiet");
>> +		must_die_on_failure =3D 1;
>> +		break;
>> +	case SM_UPDATE_MERGE:
>> +		cp.git_cmd =3D 1;
>> +		strvec_push(&cp.args, "merge");
>> +		if (ud->quiet)
>> +			strvec_push(&cp.args, "--quiet");
>> +		must_die_on_failure =3D 1;
>> +		break;
>> +	case SM_UPDATE_COMMAND:
>> +		/* NOTE: this does not handle quoted arguments */
>> +		strvec_split(&cp.args, ud->update_strategy.command);
>
> Indeed this doesn't.  I think cp.use_shell would be the right way to
> run this.
>
> Study what happens before run_command_v_opt_cd_env() with
> RUN_USING_SHELL calls run_command() and make something similar
> happen here, instead of doing a manual command line splitting.
>
> 	Side note: run_command_v_opt_cd_env() with RUN_USING_SHELL
> 	is used in places like diff.c::run_external_diff() to invoke
> 	an external diff command, ll-merge.c::ll_ext_merge() to
> 	invoke a user-defined low level merge driver,
> 	sequencer.c::do_exec() to invoke 'x cmd' you write in the
> 	todo list during an "rebase -i" session.

Thanks for the pointers, the details helped. I'll handle this more
correctly in the next version.

>> +		must_die_on_failure =3D 1;
>> +		break;
>> +	case SM_UPDATE_NONE:
>> +		BUG("this should have been handled before. How did we reach here?");
>> +		break;
>> +	case SM_UPDATE_UNSPECIFIED:
>> +		BUG("update strategy should have been specified");
>
> These two case arms are not a faithful conversion from the original,
> but because you do not carry around a random string from the caller
> and instead have parsed enums, it cannot be ;-)  But it makes me
> wonder why we want these two cases separate.  Isn't it a BUG() if
> anything other than what we handled (i.e. prepared cp.args for)
> already is in ud->update_strategy.type?  IOW, wouldn't it be more
> forward looking to do
>
> 	default:
> 		BUG("unexpected ud->update_strategy.type (%d)",
> 		    ud->update_strategy.type (%d)");
>
> or something?  That way, if we ever come up with a new update
> strategy and forget to update this part, we will catch such a bug
> fairly quickly.

The original intention for separating the cases was to differentiate the
cause for the invalid state, but your proposed suggestion is a lot
better. I'll address this.

>> +	}
>> +
>> +	strvec_push(&cp.args, oid);
>> +
>> +	prepare_submodule_repo_env(&cp.env_array);
>> +
>> +	if (run_command(&cp)) {
>> +		if (must_die_on_failure) {
>> +			switch (ud->update_strategy.type) {
>> +			case SM_UPDATE_CHECKOUT:
>> +				die(_("Unable to checkout '%s' in submodule path '%s'"),
>> +				      oid, ud->displaypath);
>> +				break;
>> +			case SM_UPDATE_REBASE:
>> +				die(_("Unable to rebase '%s' in submodule path '%s'"),
>> +				      oid, ud->displaypath);
>> +				break;
>> +			case SM_UPDATE_MERGE:
>> +				die(_("Unable to merge '%s' in submodule path '%s'"),
>> +				      oid, ud->displaypath);
>> +				break;
>> +			case SM_UPDATE_COMMAND:
>> +				die(_("Execution of '%s %s' failed in submodule path '%s'"),
>> +				      ud->update_strategy.command, oid, ud->displaypath);
>> +				break;
>
> The messages here correspond to what is assigned to $die_message in
> the original.  Note that they are emitted to the standard error
> stream.
>
> I suspect that these should be "printf()" followed by a call to
> exit() with some non-zero value (see below).

I also notice another major lapse in conversion. In the shell porcelain,
the "checkout" mode should not die out at all, instead it should print
out the error message.

My code tries to die() on the checkout mode (in a case arm that will
never be activated), and does not ever print the checkout failure
message at all. I will fix this in the re-roll.

(Will address more of this below...)

>> +			case SM_UPDATE_NONE:
>> +				BUG("this should have been handled before. How did we reach here?");
>> +				break;
>> +			case SM_UPDATE_UNSPECIFIED:
>> +				BUG("update strategy should have been specified");
>> +			}
>
> The same comment applies to the last two case arms of this switch
> statement and the next one, too.  I think we just should catch
> "everything else" with a simple "default:" label.
>
> Also, don't omit the "break;" from the last case arm in a switch
> statement.  It harms the long-term help of the code---the last case
> arm may not forever stay to be the last one.
>
>> +		}
>> +		/*
>> +		 * This signifies to the caller in shell that
>> +		 * the command failed without dying
>> +		 */
>> +		return 1;
>> +	}
>> +
>> +	switch (ud->update_strategy.type) {
>> +	case SM_UPDATE_CHECKOUT:
>> +		printf(_("Submodule path '%s': checked out '%s'\n"),
>> +		       ud->displaypath, oid);
>> +		break;
>> +	case SM_UPDATE_REBASE:
>> +		printf(_("Submodule path '%s': rebased into '%s'\n"),
>> +		       ud->displaypath, oid);
>> +		break;
>> +	case SM_UPDATE_MERGE:
>> +		printf(_("Submodule path '%s': merged in '%s'\n"),
>> +		       ud->displaypath, oid);
>> +		break;
>> +	case SM_UPDATE_COMMAND:
>> +		printf(_("Submodule path '%s': '%s %s'\n"),
>> +		       ud->displaypath, ud->update_strategy.command, oid);
>> +		break;
>> +	case SM_UPDATE_NONE:
>> +		BUG("this should have been handled before. How did we reach here?");
>> +		break;
>> +	case SM_UPDATE_UNSPECIFIED:
>> +		BUG("update strategy should have been specified");
>
> Likewise here.

Okay.

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int do_run_update_procedure(struct update_data *ud)
>> +{
>> +	int subforce =3D is_null_oid(&ud->suboid) || ud->force;
>> +
>> +	if (!ud->nofetch) {
>> +		/*
>> +		 * Run fetch only if `oid` isn't present or it
>> +		 * is not reachable from a ref.
>> +		 */
>> +		if (!is_tip_reachable(ud->sm_path, &ud->oid))
>> +			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
>> +			    !ud->quiet)
>> +				fprintf_ln(stderr,
>
> OK.  Combining these into a single statement like
>
> 		if (!is_tip_reachable(...) &&
> 		    fetch_in_submodule(...) &&
> 		    !ud->quiet)
> 			fprintf_ln(...
>
> would reduce the indentation level, but the way the conditional is
> structured may convey the flow of the thought better, i.e.
>
> 	if we need to fetch,
> 	    try to fetch and if that fails,
> 		report failure.
>
> On the other hand, if we take that line of thought to the extreme,
> the check for !ud->quiet should belong to another level of if
> statement so perhaps the more concise version I showed above might
> be an overall win.  I dunno.

Right. I agree with you, mainly because there are many other predicates
in my previous conversions that were done with short-circuited &&'s, so
might as well stick to what has been my convention.

>> +					   _("Unable to fetch in submodule path '%s'; "
>> +					     "trying to directly fetch %s:"),
>> +					   ud->displaypath, oid_to_hex(&ud->oid));
>> +		/*
>> +		 * Now we tried the usual fetch, but `oid` may
>> +		 * not be reachable from any of the refs.
>> +		 */
>> +		if (!is_tip_reachable(ud->sm_path, &ud->oid))
>> +			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
>> +				die(_("Fetched in submodule path '%s', but it did not "
>> +				      "contain %s. Direct fetching of that commit failed."),
>> +				    ud->displaypath, oid_to_hex(&ud->oid));
>
> Likewise.
>
>> +	}
>> [...]
>> +
>> +	if ((!is_null_oid(&update_data.oid) && !is_null_oid(&update_data.suboi=
d) &&
>> +	     !oideq(&update_data.oid, &update_data.suboid)) ||
>> +	    is_null_oid(&update_data.suboid) || update_data.force)
>> +		return do_run_update_procedure(&update_data);
>
> The original does the update procedure if $sha1 and $subsha1 are
> different or if $force option is given.  The rewritten seems to skip
> the update when .oid is NULL and .suboid is not NULL; intended?

Unintended. I initially implemented this with raw chars until I
discovered the object_id API. So this was the result of me
indiscriminately substituting NULL checks with the OID equivalents. I
realise this is not needed anymore, and we can simplify that to:

    if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)

> I understand that the division of labour between this function and
> do_run_update_procedure() is for the former to only exist to
> interface with the script side by populating the update_data
> structure, and the latter implements the logic to run update
> procedure.  I was a bit surprised that this conditional is
> here, not at the very beginning of the callee.

=C3=86var pointed out that since this function just had one caller, I could
move the whole 'if' outside it for now, which would save me one level of
indentation within that function, and make it easier to parse. With the
conditional being simplified to what I showed above, I think it can
still be justified?

Even in the series that will follow this, we would still have only one
caller for this function.

>> +	return 3;
>> +}
>> +
>>  static int resolve_relative_path(int argc, const char **argv, const cha=
r *prefix)
>>  {
>>  	struct strbuf sb =3D STRBUF_INIT;
>> @@ -2951,6 +3209,7 @@ static struct cmd_struct commands[] =3D {
>>  	{"add-clone", add_clone, 0},
>>  	{"update-module-mode", module_update_module_mode, 0},
>>  	{"update-clone", update_clone, 0},
>> +	{"run-update-procedure", run_update_procedure, 0},
>>  	{"ensure-core-worktree", ensure_core_worktree, 0},
>>  	{"relative-path", resolve_relative_path, 0},
>>  	{"resolve-relative-url", resolve_relative_url, 0},
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index dbd2ec2050..d8e30d1afa 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -519,14 +512,13 @@ cmd_update()
>>
>>  		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
>>
>> -		update_module=3D$(git submodule--helper update-module-mode $just_clon=
ed "$sm_path" $update)
>> -
>>  		displaypath=3D$(git submodule--helper relative-path "$prefix$sm_path"=
 "$wt_prefix")
>
> On the other side of the API boundary, update_data.displaypath is
> populated by value computed in C.  It is a bit unfortunate that we
> still need to compute it here and risk the two to drift apart.

Yes, and I had some trouble figuring out a clean separation boundary,
and this compromise felt like the best one. The best I can do is assure
you that the patch series following this change solves this issue
entirely, as it moves all of the shell code you see here into the C
helper, and thus we only compute this value once.

So there should be no worry about drift, as I will not give any chance
to introduce it at all :)

>>  		if test $just_cloned -eq 1
>>  		then
>>  			subsha1=3D
>>  		else
>> +			just_cloned=3D
>>  			subsha1=3D$(sanitize_submodule_env; cd "$sm_path" &&
>>  				git rev-parse --verify HEAD) ||
>>  			die "fatal: $(eval_gettext "Unable to find current revision in submo=
dule path '\$displaypath'")"
>> @@ -547,70 +539,38 @@ cmd_update()
>>  			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\=
${branch} revision in submodule path '\$sm_path'")"
>>  		fi
>>
>> -		if test "$subsha1" !=3D "$sha1" || test -n "$force"
>> -		then
>> -			subforce=3D$force
>> -			# If we don't already have a -f flag and the submodule has never bee=
n checked out
>> -			if test -z "$subsha1" && test -z "$force"
>> -			then
>> -				subforce=3D"-f"
>> -			fi
>> +		out=3D$(git submodule--helper run-update-procedure \
>> +			  ${wt_prefix:+--prefix "$wt_prefix"} \
>> +			  ${GIT_QUIET:+--quiet} \
>> +			  ${force:+--force} \
>> +			  ${just_cloned:+--just-cloned} \
>> +			  ${nofetch:+--no-fetch} \
>> +			  ${depth:+"$depth"} \
>> +			  ${update:+--update "$update"} \
>> +			  ${prefix:+--recursive-prefix "$prefix"} \
>> +			  ${sha1:+--oid "$sha1"} \
>> +			  ${subsha1:+--suboid "$subsha1"} \
>> +			  "--" \
>> +			  "$sm_path")
>
> We'd just show errors directly to the standard error stream from
> submodule--helper, but what comes from the printf in the switch
> statement at the end of run_update_command() is captured in $out
> variable.  Notably, the messages from die()s in the second switch
> statement in run_update_command() are not captured in $out here.
>
>> -			if test -z "$nofetch"
>> -			then
>> -				# Run fetch only if $sha1 isn't present or it
>> -				# is not reachable from a ref.
>> -				is_tip_reachable "$sm_path" "$sha1" ||
>> -				fetch_in_submodule "$sm_path" $depth ||
>> -				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypa=
th'; trying to directly fetch \$sha1:")"
>> -
>> -				# Now we tried the usual fetch, but $sha1 may
>> -				# not be reachable from any of the refs
>> -				is_tip_reachable "$sm_path" "$sha1" ||
>> -				fetch_in_submodule "$sm_path" "$depth" "$sha1" ||
>> -				die "fatal: $(eval_gettext "Fetched in submodule path '\$displaypat=
h', but it did not contain \$sha1. Direct fetching of that commit failed.")"
>> -			fi
>> -
>> -			must_die_on_failure=3D
>> -			case "$update_module" in
>> -			checkout)
>> -				command=3D"git checkout $subforce -q"
>> -				die_msg=3D"fatal: $(eval_gettext "Unable to checkout '\$sha1' in su=
bmodule path '\$displaypath'")"
>> -				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': checked =
out '\$sha1'")"
>> -				;;
>> -			rebase)
>> -				command=3D"git rebase ${GIT_QUIET:+--quiet}"
>> -				die_msg=3D"fatal: $(eval_gettext "Unable to rebase '\$sha1' in subm=
odule path '\$displaypath'")"
>> -				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': rebased =
into '\$sha1'")"
>> -				must_die_on_failure=3Dyes
>> -				;;
>> -			merge)
>> -				command=3D"git merge ${GIT_QUIET:+--quiet}"
>> -				die_msg=3D"fatal: $(eval_gettext "Unable to merge '\$sha1' in submo=
dule path '\$displaypath'")"
>> -				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': merged i=
n '\$sha1'")"
>> -				must_die_on_failure=3Dyes
>> -				;;
>> -			!*)
>> -				command=3D"${update_module#!}"
>> -				die_msg=3D"fatal: $(eval_gettext "Execution of '\$command \$sha1' f=
ailed in submodule path '\$displaypath'")"
>> -				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': '\$comma=
nd \$sha1'")"
>> -				must_die_on_failure=3Dyes
>> -				;;
>> -			*)
>> -				die "fatal: $(eval_gettext "Invalid update mode '$update_module' fo=
r submodule path '$path'")"
>> -			esac
>> -
>> -			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
>> -			then
>> -				say "$say_msg"
>> -			elif test -n "$must_die_on_failure"
>> -			then
>> -				die_with_status 2 "$die_msg"
>> -			else
>> -				err=3D"${err};$die_msg"
>> -				continue
>> -			fi
>> -		fi
>> +		# exit codes for run-update-procedure:
>> +		# 0: update was successful, say command output
>> +		# 128: subcommand died during execution
>> +		# 1: update procedure failed, but should not die
>> +		# 3: no update procedure was run
>> +		res=3D"$?"
>> +		case $res in
>> +		0)
>> +			say "$out"
>> +			;;
>
> And the case where there is no error is quite straight-forward.  We
> just emit what we saw in the standard output stream of the helper.
>
>> +		128)
>> +			exit $res
>> +			;;
>> +		1)
>> +			err=3D"${err};$out"
>
> This part is dubious.  In the original, $err accumulates what is in
> $die_msg, which are things like "fatal: Unable to rebase ...", but
> with this patch, what used to be the contents of $die_msg are given
> to die() after we see run_command() fail, and would have sent to the
> standard error stream, not captured in $out here, no?

Yes, this is bad. This error slipped past the test suite that I was too
reliant on. Even if it did work, it would not have printed the error
messages for the "checkout" mode. I will fix all of these issues.
Printing to stdout with error return ought to fix it, as you suggested.

>> +			continue
>> +			;;
>> +		esac
>>
>>  		if test -n "$recursive"
>>  		then
>
>
> Thanks.

Thanks for the thorough review.
