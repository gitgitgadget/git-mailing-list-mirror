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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600C3C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 10:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAC860E09
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 10:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhHCKIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbhHCKIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 06:08:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD046C061799
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 03:07:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so3118766pjr.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=+ExQDSzaJht3MChr7f++TLdhzYNNsJYsMXJQQfEo7Vg=;
        b=t03kHx1dst21LixtwEgdZTqYgXMDYErc2zuZ/MFFyQfHv40RaEfpaC33i7Vh7RHACz
         6oomHK0zPZ4v4EwsmP5OGLZWFl5VQExvRWe1YfAQwE3Wl87exYgofHfC3AXxL8/HwrZG
         niWbZK4DazVFti6wPi/DIow9j7hzcXfWWsNMTku2EqniYkKVj/yBU1KwRU9UIQnHXYqB
         +scO/eqp3d5KhyhEZrjSDDbPQ2psvZGrZ5XgCtl67dS0O19nUzP0YLe5htE9v2k1/YSZ
         vb1KR7MGvNmL9MK6AV/o0VDrcGNkCZq2m1JJjGIbDBejYdk/Zw8VeK1Sy5Q+9h9+AvQk
         dYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=+ExQDSzaJht3MChr7f++TLdhzYNNsJYsMXJQQfEo7Vg=;
        b=M3NFwUMKW0rdGY/dUdIYxf/m2W8d7ZFcpEVG7orO0rRz8oNv6k9EbLUJC6lyHWKJLh
         u+38dsoC01bJcCMxGG0kHZZ2orDbo4cPIwTBWL3NVyFZKhruBprw+MFKoNxS09tnVob6
         e0G+uI22DBrvEmAm38mK7mYXQ5Ku7WMe0/MsAuc6uYo1Pz6k2FMKMyzVKaJSPO+kk6Lk
         vf6/684W6FlV+RuXsCl6UQMMdgJ+Re7/WDZoRyj9OuSp0Mq88JVJeYx4p4d+0HDmbRrc
         Q20EwS+wleggpsctZBAXD/a0LWm5Rko1i3xzYJgpRDZSJKz708Ly2uz08RL/ikTpBovq
         qiHQ==
X-Gm-Message-State: AOAM5321yK770o/4nBUmz31liX1BhKKBES8Yo8hm2WmhlDI0/j0TxSCz
        EgYHkapbwM/XWzqWCVriGow=
X-Google-Smtp-Source: ABdhPJzpzgIL1/IxlHuTpMoTAAvvT3izlHH2xnVMmoXbdi2JgIGAugqO9ACD1oof6F1FZoEC/WwiLg==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr3851802pjb.4.1627985271293;
        Tue, 03 Aug 2021 03:07:51 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id w9sm3176971pfg.151.2021.08.03.03.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:07:50 -0700 (PDT)
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
Message-ID: <m2zgtyaljh.fsf@gmail.com>
Date:   Tue, 03 Aug 2021 15:37:46 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


(I am resending this email, because my client mangled the whitespaces
due to a misconfiguration. Please ignore the my previous message.)

Shourya Shukla <periperidip@gmail.com> writes:

> Le lun. 2 ao=C3=BBt 2021 =C3=A0 18:36, Atharva Raykar <raykar.ath@gmail.c=
om> a =C3=A9crit :
>>
>> Add a new submodule--helper subcommand `run-update-procedure` that runs
>> the update procedure if the SHA1 of the submodule does not match what
>> the superproject expects.
>>
>> This is an intermediate change that works towards total conversion of
>> `submodule update` from shell to C.
>>
>> Specific error codes are returned so that the shell script calling the
>> subcommand can take a decision on the control flow, and preserve the
>> error messages across subsequent recursive calls of `cmd_update`.
>>
>> This patch could have been approached differently, by first changing the
>> `is_tip_reachable` and `fetch_in_submodule` shell functions to be
>> `submodule--helper` subcommands, and then following up with a patch that
>> introduces the `run-update-procedure` subcommand. We have not done it
>> like that because those functions are trivial enough to convert directly
>> along with these other changes. This lets us avoid the boilerplate and
>> the cleanup patches that will need to be introduced in following that
>> approach.
>
> I feel that this part is more suitable for a cover letter rather than the=
 commit
> message itself. It is a useful piece of info though.

Okay, that seems right, the message does seem a bit too context-sensitive.

>> This change is more focused on doing a faithful conversion, so for now we
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
>>   submodule--helper.c:run_update_command(), while fixing problems with
>>   the translation marks.
>>
>> * Renamed '--sha1' and '--subsha1' options to '--oid' and '--suboid' to
>>   since the argument is parsed into an object_id struct, not plain sha1
>>   data.
>>
>> * Used option callbacks to parse the SHA1 arguments directly.
>>
>> * Moved the conditional out of 'do_run_update_procedure()'.
>>
>> Feedback required:
>>
>> =C3=86var felt that it would be clearer to populate the 'fatal' messages
>> after the run_command() operation in 'run_update_command()', to make it
>> more readable [1]. I have attempted something like that here, and it has=
 led
>> to a lot more duplicated 'switch' statements, which feels suboptimal.
>> I'd appreciate suggestions to make it more legible.
>>
>> [1] https://lore.kernel.org/git/87r1fps63r.fsf@evledraar.gmail.com/
>>
>> Fetch-it-Via:
>> git fetch https://github.com/tfidfwastaken/git submodule-run-update-proc=
-list-2
>>
>>  builtin/submodule--helper.c | 253 ++++++++++++++++++++++++++++++++++++
>>  git-submodule.sh            | 106 +++++----------
>>  2 files changed, 286 insertions(+), 73 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
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
>> +#define UPDATE_DATA_INIT { .update_strategy =3D SUBMODULE_UPDATE_STRATE=
GY_INIT }
>>
>>  static void next_submodule_warn_missing(struct submodule_update_clone *=
suc,
>>                 struct strbuf *out, const char *displaypath)
>> @@ -2282,6 +2296,175 @@ static int git_update_clone_config(const char *v=
ar, const char *value,
>>         return 0;
>>  }
>> +
>> +static int run_update_command(struct update_data *ud, int subforce)
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
> Would it be possible to add the 'if' statement above just before the
> 'switch' (or after,
> whichever seems okay) since this is common amongst (almost) all the cases?

I'll try it on once, if it makes the code more readable, I'll include it in=
 the
reroll.

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
>> +               /* NOTE: this does not handle quoted arguments */
>> +               strvec_split(&cp.args, ud->update_strategy.command);
>> +               must_die_on_failure =3D 1;
>> +               break;
>> +       case SM_UPDATE_UNSPECIFIED:
>> +       case SM_UPDATE_NONE:
>> +               BUG("update strategy should have been specified");
>> +       }
>
> If the original did not bug out, do we need to? The documentation does
> not mention
> this as well:
> https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-no=
ne

This was how the original shell porcelain did it:

case "$update_module" in
checkout)
	command=3D"git checkout $subforce -q"
	die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in submodule path '=
\$displaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': checked out '\$=
sha1'")"
	;;
rebase)
	command=3D"git rebase ${GIT_QUIET:+--quiet}"
	die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$=
displaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': rebased into '\=
$sha1'")"
	must_die_on_failure=3Dyes
	;;
merge)
	command=3D"git merge ${GIT_QUIET:+--quiet}"
	die_msg=3D"$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$d=
isplaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': merged in '\$sh=
a1'")"
	must_die_on_failure=3Dyes
	;;
!*)
	command=3D"${update_module#!}"
	die_msg=3D"$(eval_gettext "Execution of '\$command \$sha1' failed in submo=
dule path '\$displaypath'")"
	say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': '\$command \$sh=
a1'")"
	must_die_on_failure=3Dyes
	;;
*)
	die "$(eval_gettext "Invalid update mode '$update_module' for submodule pa=
th '$path'")"
esac

The fallthrough case used to die, but I noticed that this branch will never=
 get
activated. This is because the 'update-clone' helper will not output any en=
try
that has the update mode set to 'none', and thus the `while` loop that cont=
ains
this code would never run.

Which is why I decided to BUG out on that case, because that state should n=
ever
be reached. But I see the source of confusion, and maybe I should have diff=
erent
BUG messages for SM_UPDATE_UNSPECIFIED and SM_UPDATE_NONE. The latter should
probably say "should have been handled by update-clone".

>> +
>> +       strvec_push(&cp.args, oid);
>> +
>> +       prepare_submodule_repo_env(&cp.env_array);
>> +
>> +       if (run_command(&cp)) {
>> +               if (must_die_on_failure) {
>> +                       switch (ud->update_strategy.type) {
>> +                       case SM_UPDATE_CHECKOUT:
>> +                               die(_("Unable to checkout '%s' in submod=
ule path '%s'"),
>> +                                     oid, ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_REBASE:
>> +                               die(_("Unable to rebase '%s' in submodul=
e path '%s'"),
>> +                                     oid, ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_MERGE:
>> +                               die(_("Unable to merge '%s' in submodule=
 path '%s'"),
>> +                                     oid, ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_COMMAND:
>> +                               die(_("Execution of '%s %s' failed in su=
bmodule path '%s'"),
>> +                                     ud->update_strategy.command, oid, =
ud->displaypath);
>> +                               break;
>> +                       case SM_UPDATE_UNSPECIFIED:
>> +                       case SM_UPDATE_NONE:
>> +                               BUG("update strategy should have been sp=
ecified");
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
>> +               printf(_("Submodule path '%s': checked out '%s'\n"),
>> +                      ud->displaypath, oid);
>> +               break;
>> +       case SM_UPDATE_REBASE:
>> +               printf(_("Submodule path '%s': rebased into '%s'\n"),
>> +                      ud->displaypath, oid);
>> +               break;
>> +       case SM_UPDATE_MERGE:
>> +               printf(_("Submodule path '%s': merged in '%s'\n"),
>> +                      ud->displaypath, oid);
>> +               break;
>> +       case SM_UPDATE_COMMAND:
>> +               printf(_("Submodule path '%s': '%s %s'\n"),
>> +                      ud->displaypath, ud->update_strategy.command, oid=
);
>> +               break;
>> +       case SM_UPDATE_UNSPECIFIED:
>> +       case SM_UPDATE_NONE:
>> +               BUG("update strategy should have been specified");
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
>> +                       if (fetch_in_submodule(ud->sm_path, ud->depth, u=
d->quiet, NULL) &&
>> +                           !ud->quiet)
>> +                               fprintf_ln(stderr,
>> +                                          _("Unable to fetch in submodu=
le path '%s'; "
>> +                                            "trying to directly fetch %=
s:"),
>> +                                          ud->displaypath, oid_to_hex(&=
ud->oid));
>
> I was wondering if an OID is invalid, will it be counted as
> unreachable and vice-versa?
> If that is the case then that would simplify the work.

Could you elaborate? I'm not sure what you mean by 'invalid' in this contex=
t. I
don't think this code will receive any kind of malformed oid--they come from
'update-clone' which handles it correctly.

As far as I can tell, the only way to check if a particular OID is unreacha=
ble
is when we check if all the refs cannot find it.
