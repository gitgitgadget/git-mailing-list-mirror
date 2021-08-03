Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3462FC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 08:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CA560F93
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 08:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhHCIrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhHCIrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 04:47:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4CC06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 01:46:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e5so22830455pld.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=Ek4SUG4iX/MqP3M6zBmK3nNtR5wjDXieaxaVBulEOE4=;
        b=LxoHxieuU8PeIfpUvk5I8So6euj41RkItKm3nm5C479eI+T9DhJqnbAXRqtw0yfO3m
         s9MD61xKlZlnPbqsUkEaGRyiL4c1n8KCPBxcDmRtny4zPMn7Am8bS5xvaO4O4X7d68by
         3yJLtjyT0hMWxQ91GB/N92r7yid1jW2KCmy/1cb3Cj0j8FpkXTfHzwbVFuca7ELQueSj
         wAyRNPmgN6hXh8EuC+ODQopcriqoHUxl4htsOr2qHBHM6/km63j3wdAJl4ulOTeZt+DQ
         FxLvIxVcILPh+Y2KjAHLUOjQGE1RVzgy5XUWJxH5HpHZ6YqrvxMtibRPakjpu1wXSFrx
         NF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=Ek4SUG4iX/MqP3M6zBmK3nNtR5wjDXieaxaVBulEOE4=;
        b=uYY3DxHia76rHhUGfq+21qVTfUID5O2VSRKsFQLImH2tRWDk+5RjtiGEEa+IMSpR8t
         3nC/IryftSZRRoSi9gjHhN8F9jQXLq9SviC325BgL5cOU14uiSRgBQx9OcdqABqfxhVQ
         NMOkO8b44lFTgKl1dtf/wFzVACmN6PMYfLIxRoC/5L0d273KQUqwHTbZv2AD9Jd8eIOC
         NEOPZh7tMdaALC/rlHxc2fltcUntftit3vWKY+QCmqb9BlAINmZRkY+M73aJfYIjgs9o
         RjBq/90xS5z/05izoSkQPvoNylYZE7DmhVJryLRqm2tKT1XLBAN/iMBTsCrysINBjuPt
         wGAw==
X-Gm-Message-State: AOAM531t5f1kNvcckWNiayaKHNVieljizKFovV3fnqwyN/WwPKIeKVcO
        vr3difhT54ueO2YrTr3UHvk=
X-Google-Smtp-Source: ABdhPJzrKTITDdHoo27ZZ92+RCXpvj7bUIpzlkDymgtydtZysDEhn8g8vSQFl0NrZA2011Ctrd/bnA==
X-Received: by 2002:aa7:96fc:0:b029:3ab:8eff:ca39 with SMTP id i28-20020aa796fc0000b02903ab8effca39mr21429358pfq.62.1627980409105;
        Tue, 03 Aug 2021 01:46:49 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id q14sm14466646pff.209.2021.08.03.01.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 01:46:48 -0700 (PDT)
References: <20210722134012.99457-1-raykar.ath@gmail.com>
 <20210802130627.36170-1-raykar.ath@gmail.com>
 <CACdWUYXhckBkHLPnRDxxb=raAD0=7236jAzvneBLhw8fXvGTMw@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [GSoC] [PATCH v2] submodule--helper: run update procedures from C
In-reply-to: <CACdWUYXhckBkHLPnRDxxb=raAD0=7236jAzvneBLhw8fXvGTMw@mail.gmail.com>
Message-ID: <m2czquc3v0.fsf@gmail.com>
Date:   Tue, 03 Aug 2021 14:16:43 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Shourya Shukla <periperidip@gmail.com> writes:

> Le lun. 2 ao=C3=BBt 2021 =C3=A0 18:36, Atharva Raykar=20
> <raykar.ath@gmail.com> a =C3=A9crit :
>>
>> Add a new submodule--helper subcommand `run-update-procedure`=20
>> that runs
>> the update procedure if the SHA1 of the submodule does not=20
>> match what
>> the superproject expects.
>>
>> This is an intermediate change that works towards total=20
>> conversion of
>> `submodule update` from shell to C.
>>
>> Specific error codes are returned so that the shell script=20
>> calling the
>> subcommand can take a decision on the control flow, and=20
>> preserve the
>> error messages across subsequent recursive calls of=20
>> `cmd_update`.
>>
>> This patch could have been approached differently, by first=20
>> changing the
>> `is_tip_reachable` and `fetch_in_submodule` shell functions to=20
>> be
>> `submodule--helper` subcommands, and then following up with a=20
>> patch that
>> introduces the `run-update-procedure` subcommand. We have not=20
>> done it
>> like that because those functions are trivial enough to convert=20
>> directly
>> along with these other changes. This lets us avoid the=20
>> boilerplate and
>> the cleanup patches that will need to be introduced in=20
>> following that
>> approach.
>
> I feel that this part is more suitable for a cover letter rather=20
> than the commit
> message itself. It is a useful piece of info though.

Okay, that seems right, the message does seem a bit too
context-sensitive.

>> This change is more focused on doing a faithful conversion, so=20
>> for now we
>> are not too concerned with trying to reduce subprocess spawns.
>>
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Shourya Shukla <periperidip@gmail.com>
>> ---
>>
>> Notable changes since v1:
>>
>> * Modified the code structure in
>>   submodule--helper.c:run_update_command(), while fixing=20
>>   problems with
>>   the translation marks.
>>
>> * Renamed '--sha1' and '--subsha1' options to '--oid' and=20
>> '--suboid' to
>>   since the argument is parsed into an object_id struct, not=20
>>   plain sha1
>>   data.
>>
>> * Used option callbacks to parse the SHA1 arguments directly.
>>
>> * Moved the conditional out of 'do_run_update_procedure()'.
>>
>> Feedback required:
>>
>> =C3=86var felt that it would be clearer to populate the 'fatal'=20
>> messages
>> after the run_command() operation in 'run_update_command()', to=20
>> make it
>> more readable [1]. I have attempted something like that here,=20
>> and it has led
>> to a lot more duplicated 'switch' statements, which feels=20
>> suboptimal.
>> I'd appreciate suggestions to make it more legible.
>>
>> [1]=20
>> https://lore.kernel.org/git/87r1fps63r.fsf@evledraar.gmail.com/
>>
>> Fetch-it-Via:
>> git fetch https://github.com/tfidfwastaken/git=20
>> submodule-run-update-proc-list-2
>>
>>  builtin/submodule--helper.c | 253=20
>>  ++++++++++++++++++++++++++++++++++++
>>  git-submodule.sh            | 106 +++++----------
>>  2 files changed, 286 insertions(+), 73 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c=20
>> b/builtin/submodule--helper.c
>> index d55f6262e9..b9c40324d0 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2029,6 +2029,20 @@ struct submodule_update_clone {
>>         .max_jobs =3D 1, \
>>  }
>>
>> +struct update_data {
>> +       const char *recursive_prefix;
>> +       const char *sm_path;
>> +       const char *displaypath;
>> +       struct object_id oid;
>> +       struct object_id suboid;
>> +       struct submodule_update_strategy update_strategy;
>> +       int depth;
>> +       unsigned int force: 1;
>> +       unsigned int quiet: 1;
>> +       unsigned int nofetch: 1;
>> +       unsigned int just_cloned: 1;
>> +};
>> +#define UPDATE_DATA_INIT { .update_strategy =3D=20
>> SUBMODULE_UPDATE_STRATEGY_INIT }
>>
>>  static void next_submodule_warn_missing(struct=20
>>  submodule_update_clone *suc,
>>                 struct strbuf *out, const char *displaypath)
>> @@ -2282,6 +2296,175 @@ static int=20
>> git_update_clone_config(const char *var, const char *value,
>>         return 0;
>>  }
>> +
>> +static int run_update_command(struct update_data *ud, int=20
>> subforce)
>> +{
>> +       struct child_process cp =3D CHILD_PROCESS_INIT;
>> +       char *oid =3D oid_to_hex(&ud->oid);
>> +       int must_die_on_failure =3D 0;
>> +
>> +       cp.dir =3D xstrdup(ud->sm_path);
>> +       switch (ud->update_strategy.type) {
>> +       case SM_UPDATE_CHECKOUT:
>> +               cp.git_cmd =3D 1;
>> +               strvec_pushl(&cp.args, "checkout", "-q", NULL);
>
> Would it be possible to add the 'if' statement above just before=20
> the
> 'switch' (or after,
> whichever seems okay) since this is common amongst (almost) all=20
> the cases?

I'll try it on once, if it makes the code more readable, I'll=20
include it
in the reroll.

>> +               if (subforce)
>> +                       strvec_push(&cp.args, "-f");
>> +               break;
>> +       case SM_UPDATE_REBASE:
>> +               cp.git_cmd =3D 1;
>> +               strvec_push(&cp.args, "rebase");
>> +               if (ud->quiet)
>> +                       strvec_push(&cp.args, "--quiet");
>> +               must_die_on_failure =3D 1;
>> +               break;
>> +       case SM_UPDATE_MERGE:
>> +               cp.git_cmd =3D 1;
>> +               strvec_push(&cp.args, "merge");
>> +               if (ud->quiet)
>> +                       strvec_push(&cp.args, "--quiet");
>> +               must_die_on_failure =3D 1;
>> +               break;
>> +       case SM_UPDATE_COMMAND:
>> +               /* NOTE: this does not handle quoted arguments=20
>> */
>> +               strvec_split(&cp.args,=20
>> ud->update_strategy.command);
>> +               must_die_on_failure =3D 1;
>> +               break;
>> +       case SM_UPDATE_UNSPECIFIED:
>> +       case SM_UPDATE_NONE:
>> +               BUG("update strategy should have been=20
>> specified");
>> +       }
>
> If the original did not bug out, do we need to? The=20
> documentation does
> not mention
> this as well:
> https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-no=
ne

This was how the original shell porcelain did it:
case "$update_module" in
checkout)
	command=3D"git checkout $subforce -q"
	die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in=20
	submodule path '\$displaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath':=20
	checked out '\$sha1'")"
	;;
rebase)
	command=3D"git rebase ${GIT_QUIET:+--quiet}"
	die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in=20
	submodule path '\$displaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath':=20
	rebased into '\$sha1'")"
	must_die_on_failure=3Dyes
	;;
merge)
	command=3D"git merge ${GIT_QUIET:+--quiet}"
	die_msg=3D"$(eval_gettext "Unable to merge '\$sha1' in submodule=20
	path '\$displaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath':=20
	merged in '\$sha1'")"
	must_die_on_failure=3Dyes
	;;
!*)
	command=3D"${update_module#!}"
	die_msg=3D"$(eval_gettext "Execution of '\$command \$sha1'=20
	failed in submodule path '\$displaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath':=20
	'\$command \$sha1'")"
	must_die_on_failure=3Dyes
	;;
*)
	die "$(eval_gettext "Invalid update mode '$update_module' for=20
	submodule path '$path'")"
esac

The fallthrough case used to die, but I noticed that this branch=20
will
never get activated. This is because the 'update-clone' helper=20
will not
output any entry that has the update mode set to 'none', and thus=20
the
`while` loop that contains this code would never run.

Which is why I decided to BUG out on that case, because that state
should never be reached. But I see the source of confusion, and=20
maybe I
should have different BUG messages for SM_UPDATE_UNSPECIFIED and
SM_UPDATE_NONE. The latter should probably say "should have been=20
handled
by update-clone".

>> +
>> +       strvec_push(&cp.args, oid);
>> +
>> +       prepare_submodule_repo_env(&cp.env_array);
>> +
>> +       if (run_command(&cp)) {
>> +               if (must_die_on_failure) {
>> +                       switch (ud->update_strategy.type) {
>> +                       case SM_UPDATE_CHECKOUT:
>> +                               die(_("Unable to checkout '%s'=20
>> in submodule path '%s'"),
>> +                                     oid, ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_REBASE:
>> +                               die(_("Unable to rebase '%s' in=20
>> submodule path '%s'"),
>> +                                     oid, ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_MERGE:
>> +                               die(_("Unable to merge '%s' in=20
>> submodule path '%s'"),
>> +                                     oid, ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_COMMAND:
>> +                               die(_("Execution of '%s %s'=20
>> failed in submodule path '%s'"),
>> +=20
>> ud->update_strategy.command, oid, ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_UNSPECIFIED:
>> +                       case SM_UPDATE_NONE:
>> +                               BUG("update strategy should=20
>> have been specified");
>> +                       }
>> +               }
>> +               /*
>> +                * This signifies to the caller in shell that
>> +                * the command failed without dying
>> +                */
>> +               return 1;
>> +       }
>> +
>> +       switch (ud->update_strategy.type) {
>> +       case SM_UPDATE_CHECKOUT:
>> +               printf(_("Submodule path '%s': checked out=20
>> '%s'\n"),
>> +                      ud->displaypath, oid);
>> +               break;
>> +       case SM_UPDATE_REBASE:
>> +               printf(_("Submodule path '%s': rebased into=20
>> '%s'\n"),
>> +                      ud->displaypath, oid);
>> +               break;
>> +       case SM_UPDATE_MERGE:
>> +               printf(_("Submodule path '%s': merged in=20
>> '%s'\n"),
>> +                      ud->displaypath, oid);
>> +               break;
>> +       case SM_UPDATE_COMMAND:
>> +               printf(_("Submodule path '%s': '%s %s'\n"),
>> +                      ud->displaypath,=20
>> ud->update_strategy.command, oid);
>> +               break;
>> +       case SM_UPDATE_UNSPECIFIED:
>> +       case SM_UPDATE_NONE:
>> +               BUG("update strategy should have been=20
>> specified");
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int do_run_update_procedure(struct update_data *ud)
>> +{
>> +       int subforce =3D is_null_oid(&ud->suboid) || ud->force;
>> +
>> +       if (!ud->nofetch) {
>> +               /*
>> +                * Run fetch only if `oid` isn't present or it
>> +                * is not reachable from a ref.
>> +                */
>> +               if (!is_tip_reachable(ud->sm_path, &ud->oid))
>> +                       if (fetch_in_submodule(ud->sm_path,=20
>> ud->depth, ud->quiet, NULL) &&
>> +                           !ud->quiet)
>> +                               fprintf_ln(stderr,
>> +                                          _("Unable to fetch=20
>> in submodule path '%s'; "
>> +                                            "trying to=20
>> directly fetch %s:"),
>> +                                          ud->displaypath,=20
>> oid_to_hex(&ud->oid));
>
> I was wondering if an OID is invalid, will it be counted as
> unreachable and vice-versa?
> If that is the case then that would simplify the work.

Could you elaborate? I'm not sure what you mean by 'invalid' in=20
this
context. I don't think this code will receive any kind of=20
malformed
oid--they come from 'update-clone' which handles it correctly.

As far as I can tell, the only way to check if a particular OID is
unreachable is when we check if all the refs cannot find it.
