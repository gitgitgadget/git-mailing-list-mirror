Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8000C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53CC60F70
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhHBSvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHBSvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 14:51:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96EC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 11:50:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a1so6793509ioa.12
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l/cp0kaCP5hVtaD2bRdnXrspdsnMat/wMuIoGv+WEO8=;
        b=ikW76kwF9uGqrhBV1XPKhIa0pOoLigP3pZ+XXJG0a7jH8joWn0CSfEYNO+HPIiVzIE
         00P+Lqny+f6rdB/0wHFgxKeSkcW0iCgypyxaHgxK4icpKeMiZGmQVo7/FvJFSSVJe04I
         8ixqW1h3nwuzf92yL9/JPJGYfe2059jOwar9XI26J968MbLO+zM1haVEPrpF066cj0wc
         Sto4yRnzO/2j+LsYlPkt/20n61rW7nlprDtLQos4am6dzEB1usDWcat5+PdRwOKq2Fsl
         KSiC4XfuuGcbNJJ0kXENUI/K7FM8fwAfnyQYVOfOFEHPcA2usq1WgY4Kfmw9VW74Zu8I
         26vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l/cp0kaCP5hVtaD2bRdnXrspdsnMat/wMuIoGv+WEO8=;
        b=TSGmf/xa/Ag2tSWNgQQyI0x3a1HW8hQvp6HjLmulpJ1O/Qh47DwWWS0xVzCWNiUgUP
         9bqDC+3m7P+90URM0oPJOEAsR5m7EyAmRP9dPeOaK0yOehe1FiaJAg4aWpi825/BH/jn
         DSJ+iGmpOMTrimf7fCjkvw5PX0IAhKqg20NtfbFeadhZ90utx9bg5bZSV+p5tNGfi34Z
         GNEtk+acsNW9b5DnMe9e8M5udP2ymJnoxN2Nc/d5tg6AenpDF9LGf6y1T3WY/i/l8G6j
         gk42Nx0t8EWxJjb1cb3F5vo2EJ9mIcu5CQNxPomhvIScdV6jN1/wkbbNTWkJIUmR+XgJ
         qKTA==
X-Gm-Message-State: AOAM5329WD/B7Ga12CUyW5jBTGhSDXKt1K/8rVIQsJUB2tVNCr7DdbgM
        KbkKUT2ZFeMirJ4wt8gHerj1bM/uQs5qKROEvmE=
X-Google-Smtp-Source: ABdhPJzIzOf3mBXQqS62gOUT8l5rq/627iukBImHvxWS95NHLhM1mt6gS3nidjJmZAft+qFdFeDY3gxP355i1tWqxPE=
X-Received: by 2002:a05:6638:44f:: with SMTP id r15mr16112192jap.55.1627930250358;
 Mon, 02 Aug 2021 11:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210722134012.99457-1-raykar.ath@gmail.com> <20210802130627.36170-1-raykar.ath@gmail.com>
In-Reply-To: <20210802130627.36170-1-raykar.ath@gmail.com>
From:   Shourya Shukla <periperidip@gmail.com>
Date:   Tue, 3 Aug 2021 00:20:39 +0530
Message-ID: <CACdWUYXhckBkHLPnRDxxb=raAD0=7236jAzvneBLhw8fXvGTMw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v2] submodule--helper: run update procedures from C
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le lun. 2 ao=C3=BBt 2021 =C3=A0 18:36, Atharva Raykar <raykar.ath@gmail.com=
> a =C3=A9crit :
>
> Add a new submodule--helper subcommand `run-update-procedure` that runs
> the update procedure if the SHA1 of the submodule does not match what
> the superproject expects.
>
> This is an intermediate change that works towards total conversion of
> `submodule update` from shell to C.
>
> Specific error codes are returned so that the shell script calling the
> subcommand can take a decision on the control flow, and preserve the
> error messages across subsequent recursive calls of `cmd_update`.
>
> This patch could have been approached differently, by first changing the
> `is_tip_reachable` and `fetch_in_submodule` shell functions to be
> `submodule--helper` subcommands, and then following up with a patch that
> introduces the `run-update-procedure` subcommand. We have not done it
> like that because those functions are trivial enough to convert directly
> along with these other changes. This lets us avoid the boilerplate and
> the cleanup patches that will need to be introduced in following that
> approach.

I feel that this part is more suitable for a cover letter rather than the c=
ommit
message itself. It is a useful piece of info though.

> This change is more focused on doing a faithful conversion, so for now we
> are not too concerned with trying to reduce subprocess spawns.
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> ---
>
> Notable changes since v1:
>
> * Modified the code structure in
>   submodule--helper.c:run_update_command(), while fixing problems with
>   the translation marks.
>
> * Renamed '--sha1' and '--subsha1' options to '--oid' and '--suboid' to
>   since the argument is parsed into an object_id struct, not plain sha1
>   data.
>
> * Used option callbacks to parse the SHA1 arguments directly.
>
> * Moved the conditional out of 'do_run_update_procedure()'.
>
> Feedback required:
>
> =C3=86var felt that it would be clearer to populate the 'fatal' messages
> after the run_command() operation in 'run_update_command()', to make it
> more readable [1]. I have attempted something like that here, and it has =
led
> to a lot more duplicated 'switch' statements, which feels suboptimal.
> I'd appreciate suggestions to make it more legible.
>
> [1] https://lore.kernel.org/git/87r1fps63r.fsf@evledraar.gmail.com/
>
> Fetch-it-Via:
> git fetch https://github.com/tfidfwastaken/git submodule-run-update-proc-=
list-2
>
>  builtin/submodule--helper.c | 253 ++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 106 +++++----------
>  2 files changed, 286 insertions(+), 73 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..b9c40324d0 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2029,6 +2029,20 @@ struct submodule_update_clone {
>         .max_jobs =3D 1, \
>  }
>
> +struct update_data {
> +       const char *recursive_prefix;
> +       const char *sm_path;
> +       const char *displaypath;
> +       struct object_id oid;
> +       struct object_id suboid;
> +       struct submodule_update_strategy update_strategy;
> +       int depth;
> +       unsigned int force: 1;
> +       unsigned int quiet: 1;
> +       unsigned int nofetch: 1;
> +       unsigned int just_cloned: 1;
> +};
> +#define UPDATE_DATA_INIT { .update_strategy =3D SUBMODULE_UPDATE_STRATEG=
Y_INIT }
>
>  static void next_submodule_warn_missing(struct submodule_update_clone *s=
uc,
>                 struct strbuf *out, const char *displaypath)
> @@ -2282,6 +2296,175 @@ static int git_update_clone_config(const char *va=
r, const char *value,
>         return 0;
>  }
> +
> +static int run_update_command(struct update_data *ud, int subforce)
> +{
> +       struct child_process cp =3D CHILD_PROCESS_INIT;
> +       char *oid =3D oid_to_hex(&ud->oid);
> +       int must_die_on_failure =3D 0;
> +
> +       cp.dir =3D xstrdup(ud->sm_path);
> +       switch (ud->update_strategy.type) {
> +       case SM_UPDATE_CHECKOUT:
> +               cp.git_cmd =3D 1;
> +               strvec_pushl(&cp.args, "checkout", "-q", NULL);

Would it be possible to add the 'if' statement above just before the
'switch' (or after,
whichever seems okay) since this is common amongst (almost) all the cases?

> +               if (subforce)
> +                       strvec_push(&cp.args, "-f");
> +               break;
> +       case SM_UPDATE_REBASE:
> +               cp.git_cmd =3D 1;
> +               strvec_push(&cp.args, "rebase");
> +               if (ud->quiet)
> +                       strvec_push(&cp.args, "--quiet");
> +               must_die_on_failure =3D 1;
> +               break;
> +       case SM_UPDATE_MERGE:
> +               cp.git_cmd =3D 1;
> +               strvec_push(&cp.args, "merge");
> +               if (ud->quiet)
> +                       strvec_push(&cp.args, "--quiet");
> +               must_die_on_failure =3D 1;
> +               break;
> +       case SM_UPDATE_COMMAND:
> +               /* NOTE: this does not handle quoted arguments */
> +               strvec_split(&cp.args, ud->update_strategy.command);
> +               must_die_on_failure =3D 1;
> +               break;
> +       case SM_UPDATE_UNSPECIFIED:
> +       case SM_UPDATE_NONE:
> +               BUG("update strategy should have been specified");
> +       }

If the original did not bug out, do we need to? The documentation does
not mention
this as well:
https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-none

> +
> +       strvec_push(&cp.args, oid);
> +
> +       prepare_submodule_repo_env(&cp.env_array);
> +
> +       if (run_command(&cp)) {
> +               if (must_die_on_failure) {
> +                       switch (ud->update_strategy.type) {
> +                       case SM_UPDATE_CHECKOUT:
> +                               die(_("Unable to checkout '%s' in submodu=
le path '%s'"),
> +                                     oid, ud->displaypath);
> +                               break;
> +                       case SM_UPDATE_REBASE:
> +                               die(_("Unable to rebase '%s' in submodule=
 path '%s'"),
> +                                     oid, ud->displaypath);
> +                               break;
> +                       case SM_UPDATE_MERGE:
> +                               die(_("Unable to merge '%s' in submodule =
path '%s'"),
> +                                     oid, ud->displaypath);
> +                               break;
> +                       case SM_UPDATE_COMMAND:
> +                               die(_("Execution of '%s %s' failed in sub=
module path '%s'"),
> +                                     ud->update_strategy.command, oid, u=
d->displaypath);
> +                               break;
> +                       case SM_UPDATE_UNSPECIFIED:
> +                       case SM_UPDATE_NONE:
> +                               BUG("update strategy should have been spe=
cified");
> +                       }
> +               }
> +               /*
> +                * This signifies to the caller in shell that
> +                * the command failed without dying
> +                */
> +               return 1;
> +       }
> +
> +       switch (ud->update_strategy.type) {
> +       case SM_UPDATE_CHECKOUT:
> +               printf(_("Submodule path '%s': checked out '%s'\n"),
> +                      ud->displaypath, oid);
> +               break;
> +       case SM_UPDATE_REBASE:
> +               printf(_("Submodule path '%s': rebased into '%s'\n"),
> +                      ud->displaypath, oid);
> +               break;
> +       case SM_UPDATE_MERGE:
> +               printf(_("Submodule path '%s': merged in '%s'\n"),
> +                      ud->displaypath, oid);
> +               break;
> +       case SM_UPDATE_COMMAND:
> +               printf(_("Submodule path '%s': '%s %s'\n"),
> +                      ud->displaypath, ud->update_strategy.command, oid)=
;
> +               break;
> +       case SM_UPDATE_UNSPECIFIED:
> +       case SM_UPDATE_NONE:
> +               BUG("update strategy should have been specified");
> +       }
> +
> +       return 0;
> +}
> +
> +static int do_run_update_procedure(struct update_data *ud)
> +{
> +       int subforce =3D is_null_oid(&ud->suboid) || ud->force;
> +
> +       if (!ud->nofetch) {
> +               /*
> +                * Run fetch only if `oid` isn't present or it
> +                * is not reachable from a ref.
> +                */
> +               if (!is_tip_reachable(ud->sm_path, &ud->oid))
> +                       if (fetch_in_submodule(ud->sm_path, ud->depth, ud=
->quiet, NULL) &&
> +                           !ud->quiet)
> +                               fprintf_ln(stderr,
> +                                          _("Unable to fetch in submodul=
e path '%s'; "
> +                                            "trying to directly fetch %s=
:"),
> +                                          ud->displaypath, oid_to_hex(&u=
d->oid));

I was wondering if an OID is invalid, will it be counted as
unreachable and vice-versa?
If that is the case then that would simplify the work.
