Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC4CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 20:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhLNUIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhLNUIx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 15:08:53 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B5C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:08:51 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id l10-20020a17090a4d4a00b001a6f817f57eso12317787pjh.3
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/q2LVndDJSuNA9VHqTen3RqTDZlsWdpFojbfZEzqzbw=;
        b=HinzExX595wCUsXYuYLS5/IIefZETiKQXOKF3JKgvhq/dSs8Tf5D6uRTBdCjqBNqPp
         TagFxAak+ssurrz+qgSZF6UMZOt1tYJtVDYcXe+40fkp2X9Km3Iy//2ZD+YuYMBg2iBS
         rvcv47JfrB2wCPfoIqeWqpxoJsXowIH5H5Zhgf6LxBdlDv7kc6mlBzu5BvlT4nCCesRO
         6BQMOWVQH7CyrbL8wrKeHL/PKex1/4UCzwEIxLTtXeDLZ7I2c3l3gWuHtSk95N2xRbzw
         Mf1T/5ZAn8zx/B7h8vYwD0mi+zwOb7ppCcmbhichzbmmkIPGfWOG79yGRinG57IMNsw/
         htBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/q2LVndDJSuNA9VHqTen3RqTDZlsWdpFojbfZEzqzbw=;
        b=ZTaHDaVPmbJ/mASlFoLeH2qNBohzfkQ1HYnwbcO2y9A7flkh1XXLSnmP7rAVPgodNU
         sUVwFsQpxZttCAwvJ3x9bSRgj8r9+/hX9Rz2t7HtGsdCDqRHf2EQSGAGZx7pBkr/N91h
         HnRKbv2SuImEkuzEf0pEzBmbizlb+v9RCbNaE/F8DTrCD+iDt+Mz3UC+Pd5CCi6IzCXF
         HCih67/dWG+bU23Y8ROTARoonLPR/HBL51N6W/THrw/yztWhoqqZCfUOnoXVatqC9Bzy
         aj0q70WK2P/OKj9eTUwjkrlDgArmlftztsa9nfOAzs3FY8LuPh2PeG/u9YxUH5NgSx9d
         0xqg==
X-Gm-Message-State: AOAM531DFzRuzVTP1cAPFgVXZL/12HxfxzgFQtO5lA4R0JYlUhE8UZMQ
        WHnXx5ZkHaQRcakPXj0RCDAfUKNOJsCVww==
X-Google-Smtp-Source: ABdhPJxMSr5fCTVVgpLnbU9jhRWru0Z6DcscDIVPnDW+z9xBSMcoTWrPedbcObqCaRsuJO2arOtoQRnH6BRHBw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7682:b0:148:a2f7:9d7e with SMTP
 id m2-20020a170902768200b00148a2f79d7emr1050852pll.157.1639512530565; Tue, 14
 Dec 2021 12:08:50 -0800 (PST)
Date:   Tue, 14 Dec 2021 12:08:47 -0800
In-Reply-To: <a54c6015-6afb-b25f-d2d2-392bf77e93f0@gmail.com>
Message-Id: <kl6l7dc7uey8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211206215528.97050-1-chooglen@google.com> <20211209184928.71413-1-chooglen@google.com>
 <20211209184928.71413-5-chooglen@google.com> <a54c6015-6afb-b25f-d2d2-392bf77e93f0@gmail.com>
Subject: Re: [PATCH v3 4/5] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Glen,
>
> Le 2021-12-09 =C3=A0 13:49, Glen Choo a =C3=A9crit=C2=A0:
>>   Documentation/config/advice.txt    |   3 +
>>   Documentation/config/submodule.txt |   8 +
>
> Same comment as I remarked in v1 [1]:
>
> We would need to add the new flag to Documentation/git-branch.txt,
> and also probably update the documentation of 'submodule.recurse'
> in 'Documentation/config/submodule.txt'.
>
> [1] https://lore.kernel.org/git/3ad3941c-de18-41bf-2e44-4238ae868d79@gmai=
l.com/

Ah, I missed Documentation/git-branch.txt. Thanks.

I avoided updating 'submodule.recurse' because it seemed a bit redundant
when 'submodule.propagateBranches' is in the next paragraph. But I can
imagine that this helps users with tunnel vision (like me...), so I'll
do the update.

>> diff --git a/Documentation/config/advice.txt b/Documentation/config/advi=
ce.txt
>> index 063eec2511..e52262dc69 100644
>> --- a/Documentation/config/advice.txt
>> +++ b/Documentation/config/advice.txt
>> @@ -116,6 +116,9 @@ advice.*::
>>   	submoduleAlternateErrorStrategyDie::
>>   		Advice shown when a submodule.alternateErrorStrategy option
>>   		configured to "die" causes a fatal error.
>> +	submodulesNotUpdated::
>> +		Advice shown when a user runs a submodule command that fails
>> +		because `git submodule update` was not run.
>
> I see you added '--init' in the actual message below, but maybe it would =
be more accurate
> to also add it here ?

Sounds good.

>> +	/*
>> +	 * Before creating any branches, first check that the branch can
>> +	 * be created in every submodule.
>> +	 */
>> +	for (i =3D 0; i < submodule_entry_list.entry_nr; i++) {
>> +		if (submodule_entry_list.entries[i].repo =3D=3D NULL) {
>> +			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
>> +				advise(_("You may try updating the submodules using 'git checkout %=
s && git submodule update --init'"),
>> +				       start_name);
>> +			die(_("submodule '%s': unable to find submodule"),
>
> small nit, maybe write: "unable to find submodule repository" ?

I don't think that adding the word 'repository' makes the problem
clearer to the user. It might even be misleading e.g. a hypotethical
user might think "Unable to find the repository? The remote repository
is giving a 404 Not Found?".

>> +			    submodule_entry_list.entries[i].submodule->name);
>> +		}
>> +
>> +		if (submodule_create_branch(
>> +			    submodule_entry_list.entries[i].repo,
>> +			    submodule_entry_list.entries[i].submodule, name,
>> +			    oid_to_hex(&submodule_entry_list.entries[i]
>> +						.name_entry->oid),
>> +			    tracking_name, force, reflog, quiet, track, 1))
>
> Here, we do not actually use the dry_run argument, since we *always* want=
 to
> do a dry run for the submodules...
>
>> +			die(_("submodule '%s': cannot create branch '%s'"),
>> +			    submodule_entry_list.entries[i].submodule->name,
>> +			    name);
>> +	}
>> +
>> +	create_branch(the_repository, name, start_name, force, 0, reflog, quie=
t,
>> +		      BRANCH_TRACK_NEVER, dry_run);
>
> ... whereas for the superproject branch, we use the given dry_run argumen=
t...
>
>> +	if (dry_run)
>> +		return;
>> +	/*
>> +	 * NEEDSWORK If tracking was set up in the superproject but not the
>> +	 * submodule, users might expect "git branch --recurse-submodules" to
>> +	 * fail or give a warning, but this is not yet implemented because it =
is
>> +	 * tedious to determine whether or not tracking was set up in the
>> +	 * superproject.
>> +	 */
>> +	setup_tracking(name, tracking_name, track, quiet, 0);
>> +
>> +	for (i =3D 0; i < submodule_entry_list.entry_nr; i++) {
>> +		if (submodule_create_branch(
>> +			    submodule_entry_list.entries[i].repo,
>> +			    submodule_entry_list.entries[i].submodule, name,
>> +			    oid_to_hex(&submodule_entry_list.entries[i]
>> +						.name_entry->oid),
>> +			    tracking_name, force, reflog, quiet, track, 0))
>
> ... and if !dry_run, then we do create the branches in the submodules.
>
> That is a little bit hard to follow if you are not careful. Maybe it's ju=
st me,
> but as I was first reading it I wondered why '0' and '1' were hard-coded =
as the dry-run
> arguments to submodule_create_branch... It would maybe be clearer to use =
a named
> variable ?

This is valid feedback, but I'm not sure how to make this clearer
(besides adding comments). In every case, we really do want the
hard-coded value, i.e. we'd always want dry_run =3D 1 (validation) at the
beginning, and always dry_run =3D 0 (actually create branches) at the end.

As such, a named variable like the following:

  int dry_run_off =3D 0;
  setup_tracking(name, tracking_name, track, quiet, dry_run_off);

seems rather artificial. Perhaps you had something like an enum in mind,
like:

  enum dry_run {
    DRY_RUN_OFF,
    DRY_RUN_ON
  };
  setup_tracking(name, tracking_name, track, quiet, DRY_RUN_OFF);

which is better, but still feels artificial for a single function with
an boolean parameter.

Passing literal 0s and 1s don't seem to contradict
Documentation/CodingGuidelines or the style of code I have touched, e.g.

>> -		create_branch(the_repository,
>> -			      argv[0], (argc =3D=3D 2) ? argv[1] : head,
>> -			      force, 0, reflog, quiet, track);

hard-codes 0 to clobber_head_ok.

Perhaps you had something else in mind?

>> @@ -851,6 +874,9 @@ int cmd_branch(int argc, const char **argv, const ch=
ar *prefix)
>>   		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPL=
ACE);
>>   		strbuf_release(&buf);
>>   	} else if (!noncreate_actions && argc > 0 && argc <=3D 2) {
>> +		const char *branch_name =3D argv[0];
>> +		const char *start_name =3D argc =3D=3D 2 ? argv[1] : head;
>> +
>>   		if (filter.kind !=3D FILTER_REFS_BRANCHES)
>>   			die(_("The -a, and -r, options to 'git branch' do not take a branch=
 name.\n"
>>   				  "Did you mean to use: -a|-r --list <pattern>?"));
>> @@ -858,10 +884,14 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
>>   		if (track =3D=3D BRANCH_TRACK_OVERRIDE)
>>   			die(_("the '--set-upstream' option is no longer supported. Please u=
se '--track' or '--set-upstream-to' instead."));
>>  =20
>> -		create_branch(the_repository,
>> -			      argv[0], (argc =3D=3D 2) ? argv[1] : head,
>> -			      force, 0, reflog, quiet, track);
>> -
>> +		if (recurse_submodules) {
>> +			create_branches_recursively(the_repository, branch_name,
>> +						    start_name, NULL, force,
>> +						    reflog, quiet, track, 0);
>
> Here again, maybe it would be clearer to use a named variable instead of =
hard-coding '0' ?
>
>> +			return 0;
>> +		}
>> +		create_branch(the_repository, branch_name, start_name, force, 0,
>> +			      reflog, quiet, track, 0);
>
> Same here.

I agree that the previous example of create_branches_recursively() is
hard to follow, but for cmd_branch() I think there is very little reason
to name a variable for dry_run when cmd_branch() only uses 0.

>>   	} else
>>   		usage_with_options(builtin_branch_usage, options);
>>  =20
>
>> diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
>> new file mode 100755
>> index 0000000000..2dd0e2b01f
>> --- /dev/null
>> +++ b/t/t3207-branch-submodule.sh
>
> The tests look pretty thourough.

Thanks!

>> +
>> +test_expect_success 'should create branch when submodule is not in HEAD=
 .gitmodules' '
>
> micro-nit: maybe write: HEAD:.gitmodules as this is revision synatx.

Sounds good.
