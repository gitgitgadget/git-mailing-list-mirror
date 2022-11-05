Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216E0C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 14:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKEO3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKEO3A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 10:29:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515EE6571
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 07:28:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f27so20010051eje.1
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NfvChiDozIx3Hg69w/YiraEzBU3/KZkvApnaPbmWu2I=;
        b=CwmIsRoygA4WFTbvmj1mLg4d/74IQwsSb6xSK+0JBCsN2lxLgwAoskZAZQ+GE5BYIv
         /OHSM7owVH74hwYhHqYGk2J7HLgDF26GEWI7NnY0q//VdEK3dXmjey9W7kRwHWI2Cgcg
         k3kzujwY32C4DL2HperOQTl1N9A83T0clf9xFzPUrVLJamHzaMY+L4r28E5rWxCKjzvW
         8q6xH2fluk/BQgQz5vHXk5w86bO/HH07LOAu8QTSxxyAfmlmebt73l6H7NPLGrPb8Eln
         SNVc8FsqQ3EB8VYcihvZbJeCrR5DZN0V4YJnXuXCmKonywe7gSkfaL5s0OlNeT0PP6CF
         MvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfvChiDozIx3Hg69w/YiraEzBU3/KZkvApnaPbmWu2I=;
        b=fUio52JnfW6ySQwcwDHXYxcx0JbCY0UKwbMpqbv/cmgpkCcx29M5ad0mDXU6ECsMkZ
         iE2srY+7+DBNWgJYS/SCWbs5/O58uwA4Ha9Sv5MFge2ixv3ovmPIvjR7C3as1QRriOAX
         PX3td4OA2NBLyd/YrY7DGacsWFQ6MI3k0c5SCob9VLjydMSr/KwlBDM4aThKAAHQm3mH
         PU9YoamOLkDi1rYhA+QN8Z7hl1BzSPHTepxC+lOaPsOmDkPGTJTOInLzTOKTACF6bZ2O
         W4rdY7PE5Rs6OMbCGy88syo2BwUOVGnXTLH7kU2al3ohG+P4hCTyo5z/1ZfV5t1XlfX0
         sIGg==
X-Gm-Message-State: ACrzQf2Dnv7dojhaoFNmYZeZ8h+rLZyLvDnqzJzbO7xZvlB94Gi7Q9xI
        X7vaqwLKvgKEeEWXM2JMzRYYidPrqLjf9A==
X-Google-Smtp-Source: AMsMyM4SPhu1NREhTalkEvzcY7oj9h/M4VZnoXKoZzNNYeOEzQ/5zE4clVAhHjeYUS/d1A8qY4Y/iw==
X-Received: by 2002:a17:906:fe45:b0:791:9624:9ea5 with SMTP id wz5-20020a170906fe4500b0079196249ea5mr40413104ejb.282.1667658530283;
        Sat, 05 Nov 2022 07:28:50 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id nc30-20020a1709071c1e00b0073d81b0882asm1002149ejc.7.2022.11.05.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:28:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orKAD-000QvK-0g;
        Sat, 05 Nov 2022 15:28:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 8/8] submodule--helper: use OPT_SUBCOMMAND() API
Date:   Sat, 05 Nov 2022 15:23:24 +0100
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <patch-8.8-105853cd358-20221102T074148Z-avarab@gmail.com>
 <kl6l7d0bobt0.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221104.86wn8bzeus.gmgdl@evledraar.gmail.com>
 <kl6l8rkqy7no.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6l8rkqy7no.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221105.86wn89wk4e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Nov 03 2022, Glen Choo wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> [...]
>>>> +	struct option options[] =3D {
>>>> +		OPT_SUBCOMMAND("clone", &fn, module_clone),
>>>> +		OPT_SUBCOMMAND("add", &fn, module_add),
>>>> +		OPT_SUBCOMMAND("update", &fn, module_update),
>>>> +		OPT_SUBCOMMAND("foreach", &fn, module_foreach),
>>>> +		OPT_SUBCOMMAND("init", &fn, module_init),
>>>> +		OPT_SUBCOMMAND("status", &fn, module_status),
>>>> +		OPT_SUBCOMMAND("sync", &fn, module_sync),
>>>> +		OPT_SUBCOMMAND("deinit", &fn, module_deinit),
>>>> +		OPT_SUBCOMMAND("summary", &fn, module_summary),
>>>> +		OPT_SUBCOMMAND("push-check", &fn, push_check),
>>>> +		OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
>>>> +		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
>>>> +		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
>>>> +		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
>>>> +		OPT_END()
>>>> +	};
>>>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>>>> +	subcmd =3D argv[0];
>>>> +
>>>> +	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
>>>> +	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
>>>> +	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
>>>> +	    get_super_prefix())
>>>> +		/*
>>>> +		 * xstrfmt() rather than "%s %s" to keep the translated
>>>> +		 * string identical to git.c's.
>>>> +		 */
>>>> +		die(_("%s doesn't support --super-prefix"),
>>>> +		    xstrfmt("'%s %s'", cmd, subcmd));
>>>
>>> FYI I'm preparing a series to get rid of the SUPPORT_SUPER_PREFIX checks
>>> in both the top level and in submodule--helper (i.e. revisiting my
>>> complaints from [1]), but I haven't sent it out yet because I haven't
>>> found the right way to motivate that change. Feel free to chime in on
>>> that series when it comes out.
>>>
>>> [1] https://lore.kernel.org/git/20220630221147.45689-5-chooglen@google.=
com/
>>
>> Maybe you have different plans, but keep at the WIP re-roll of what I
>> have after this, I've also removed all of that.
>>
>> Basically, ending up with:
>>=20=09
>> 	--- a/builtin.h
>> 	+++ b/builtin.h
>> 	@@ -224,7 +224,14 @@ int cmd_sparse_checkout(int argc, const char **arg=
v, const char *prefix);
>> 	 int cmd_status(int argc, const char **argv, const char *prefix);
>> 	 int cmd_stash(int argc, const char **argv, const char *prefix);
>> 	 int cmd_stripspace(int argc, const char **argv, const char *prefix);
>> 	+int cmd_submodule(int argc, const char **argv, const char *prefix);
>> 	 int cmd_submodule__helper(int argc, const char **argv, const char *pre=
fix);
>> 	+int cmd_submodule__helper_clone(int argc, const char **argv, const cha=
r *prefix);
>> 	+int cmd_submodule_absorbgitdirs(int argc, const char **argv, const cha=
r *prefix);
>> 	+int cmd_submodule_foreach(int argc, const char **argv, const char *pre=
fix);
>> 	+int cmd_submodule_status(int argc, const char **argv, const char *pref=
ix);
>> 	+int cmd_submodule_sync(int argc, const char **argv, const char *prefix=
);
>> 	+int cmd_submodule_update(int argc, const char **argv, const char *pref=
ix);
>> 	 int cmd_switch(int argc, const char **argv, const char *prefix);
>> 	 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
>> 	 int cmd_tag(int argc, const char **argv, const char *prefix);
>>
>> And changes like:
>>=20=09
>> 	@@ -366,7 +365,7 @@ static void runcommand_in_submodule_cb(const struct=
 cache_entry *list_item,
>>=20=09=20
>> 	                strvec_pushl(&cpr.args, "--super-prefix", NULL);
>> 	                strvec_pushf(&cpr.args, "%s/", displaypath);
>> 	-               strvec_pushl(&cpr.args, "submodule--helper", "foreach",=
 "--recursive",
>> 	+               strvec_pushl(&cpr.args, "submodule--helper-foreach", "-=
-recursive",
>> 	                             NULL);
>>=20=09=20
>> 	                if (info->quiet)
>>
>> I.e. when we call "foreach" we dispatch to cmd_submodule_foreach(), but
>> when "foreach" needs to recurse it doesn't invoke a "git submodule
>> foreach", instead it invokes "git submodule--helper-foreach".
>>
>> The reason for doing that is that we can't promote the helper to a
>> built-in without also leaking implementation detail that we support the
>> now internal-only --super-prefix in the command itself.
>>
>> So this code becomes:
>>=20=09
>> 	@@ -3352,43 +3304,17 @@ static int module_add(int argc, const char **ar=
gv, const char *prefix)
>>=20=09=20
>> 	 int cmd_submodule__helper(int argc, const char **argv, const char *pre=
fix)
>> 	 {
>> 	-       const char *cmd =3D argv[0];
>> 	-       const char *subcmd;
>> 	        parse_opt_subcommand_fn *fn =3D NULL;
>> 	        const char *const usage[] =3D {
>> 	                N_("git submodule--helper <command>"),
>> 	                NULL
>> 	        };
>> 	        struct option options[] =3D {
>> 	-               OPT_SUBCOMMAND("clone", &fn, module_clone),
>> 	-               OPT_SUBCOMMAND("add", &fn, module_add),
>> 	-               OPT_SUBCOMMAND("update", &fn, module_update),
>> 	-               OPT_SUBCOMMAND("foreach", &fn, module_foreach),
>> 	-               OPT_SUBCOMMAND("init", &fn, module_init),
>> 	-               OPT_SUBCOMMAND("status", &fn, module_status),
>> 	-               OPT_SUBCOMMAND("sync", &fn, module_sync),
>> 	-               OPT_SUBCOMMAND("deinit", &fn, module_deinit),
>> 	-               OPT_SUBCOMMAND("summary", &fn, module_summary),
>> 	-               OPT_SUBCOMMAND("push-check", &fn, push_check),
>> 	-               OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
>> 	-               OPT_SUBCOMMAND("set-url", &fn, module_set_url),
>> 	-               OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
>> 	-               OPT_SUBCOMMAND("create-branch", &fn, module_create_bran=
ch),
>> 	+               OPT_SUBCOMMAND("push-check", &fn, cmd_submodule_push_ch=
eck),
>> 	+               OPT_SUBCOMMAND("create-branch", &fn, cmd_submodule_crea=
te_branch),
>> 	                OPT_END()
>> 	        };
>> 	        argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>> 	-       subcmd =3D argv[0];
>> 	-
>> 	-       if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
>> 	-           strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
>> 	-           strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
>> 	-           get_super_prefix())
>> 	-               /*
>> 	-                * xstrfmt() rather than "%s %s" to keep the translated
>> 	-                * string identical to git.c's.
>> 	-                */
>> 	-               die(_("%s doesn't support --super-prefix"),
>> 	-                   xstrfmt("'%s %s'", cmd, subcmd));
>>=20=09=20
>> 	        return fn(argc, argv, prefix);
>> 	 }
>>
>> I.e. for all the "super-prefix" ones we dispatch directly (and maybe I
>> should just do that too for those two stragglers).
>>
>> It's ugly, but it's only ugly on the inside, but if you can think of a
>> better way to do it...
>
> If we _really_ wanted to keep the check, an alternative might be to
> teach the subcommand parser about SUPPORT_SUPER_PREFIX. But frankly, I
> think this SUPPORT_SUPER_PREFIX check is far more trouble than it's
> worth, and I wouldn't want you to spend your time trying to find ways to
> keep it only for it to be dropped altogether.
>
> Here's a snippet from the cover letter I'm working on, which will
> hopefully convince you that we don't need to worry about this any more.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
>   When we introduced the internal-only "--super-prefix" in 74866d7579 (gi=
t: make
>   super-prefix option, 2016-10-07), we specified that commands must prefi=
x paths
>   by it, and pathspecs must be parsed relative to it. That commit also in=
cludes
>   safeguards to ensure that "--super-prefix" is used correctly, namely:
>
>   - Only commands marked SUPPORT_SUPER_PREFIX can be invoked with "--supe=
r-prefix".
>   - The super prefix is propagated via the GIT_INTERNAL_SUPER_PREFIX env =
var, so a
>     non-SUPPORT_SUPER_PREFIX command cannot be invoked by a SUPPORT_SUPER=
_PREFIX
>     one.
>
>   However, its use is inconsistent, which is a strong reason to consider =
using
>   better-scoped flags instead. For example..
>
>     - Of the 4 commands that are SUPPORT_SUPER_PREFIX, only "read-tree" a=
nd
>       "submodule--helper" do anything useful with it. "fsmonitor--daemon"=
 has it
>       to avoid the SUPPORT_SUPER_PREFIX warning [1]. "checkout--worker" d=
oesn't have
>       a documented reason, but since it can be invoked by "read-tree", it=
's
>       presumably also a workaround.
>     - "read-tree" and "submodule--helper" use different values for the su=
per prefix;
>       "read-tree" passes the path from the root of the superproject's tre=
e to the
>       submodule's gitlink, while "submodule--helper" passes the relative =
path of the
>       original CWD to the submodule.
>     - "submodule--helper" doesn't use "--super-prefix" to parse pathspecs=
, only to
>       display paths.
>
>   This series fixes replaces "--super-prefix" with such better-scoped fla=
gs, and
>   fixes some bugs resulting from the SUPPORT_SUPER_PREFIX check.
>
> [1] 53fcfbc84f (fsmonitor--daemon: allow --super-prefix argument, 2022-05=
-26)
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
> I figured out all the details, but it would look something like:
>
> - Add an internal-only "--tree-super-prefix" flag to "git read-tree",
>   which sets a global variable that is read from unpack-trees.c.
> - Add an internal-only "--wt-super-prefix" flag to "git
>   submodule--helper", which sets a global variable that is read from
>   submodule.c. Unlike "--super-prefix", this won't be gated behind a
>   SUPPORT_SUPER_PREFIX for each subcommand, since AFAICT, every
>   subcommand is using this "--wt-super-prefix" correctly, so we can just
>   make sure that new subcommands do too.
> - Remove the global "--super-prefix", the corresponding env var and
>   SUPPORT_SUPER_PREFIX.

Yes, I'm very much on the same page with removing it eventully. But as
you note above that'll take some doing.

So for the "submodule as a built-in" I didn't want to take it hostage to
that, but just to ensure that I:

 * Got it working
 * Did not implicitly leak "this needs a --super-prefix" from the
   current set of commands to any other commands, or to e.g. public
   "submodule foreach" just because we need it for the internal-only
   helper.

Are you proposing that you'll submit another clean-up topic that the
submodule-as-a-builtin will need to be queued on top of, in addition to
this topic?

If so I'd really prefer we defer those cleanups, which should also be
much easier once submodule's fully in C, unless they're much more
trivial than I'm currently suspecting they are...
