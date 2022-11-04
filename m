Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A3C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKDB3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKDB3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:29:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC4E9
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:29:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z18so5600174edb.9
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 18:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x3Xb29AeAgz0hIolMZCbH7aCiKFlxgHcUBkfcLRF1Rc=;
        b=ckeF+E1VJYTHYHwm3N22D5D52Xn5soAZu/znbRAHA6EKmE1VkO69Vb/nOPl2gOXppf
         EM0KIwsPVndoO65ERG1G3oZszlhdClAjzUOosfqSWGoi2Zdb9dbfwBl+UEuDIA765Vom
         ftaAhhm30Eb78hcdX7zF+2g3lakAjmbAY16d7DAnjHhmIYXiyynQWa3TvvyLx5eE2DO4
         HF+mb+gT+KsOroFUE2VaE9dLREnslnH/X1U0rN6l3EF4dE6fq5TTF9db6eKzx00gFd8R
         aNVILk/CZ2zzQqOBJgU4SEXDsd2UoYbDTpLxR+QkstxD333SnVbXUTxzERegr/HN/7tG
         DzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3Xb29AeAgz0hIolMZCbH7aCiKFlxgHcUBkfcLRF1Rc=;
        b=o4jzUlaOUfKzmfaciFe3JDY57ibQ+PBxlgdWu6bn8gBcy//ysbvL+mY2TbmuJ/kdjC
         51gc+jPqCeyZuhEFNOKTwZ896/bTm7PzGhLuUzPuQRhjXrQAl7S9Z9aLFTbRoqnVycoA
         0aqjRfuPB8S2gPH2CRcmZNUoIRIf+gzw+k/c8gBK4yIS/eZSrxqZh28+/lRIKl3Bm5dK
         GnFPl4CnbUHEbaAxOfJN+cG28SyE0yv3MF/C9FfAdk02FkHBeF1HIPM0KX4y8MDgv0pN
         lBawYYNCfkVQrKn7Echfh9a0v8reWC3wKn4nB3sLdZOv4QxdVIdqwjGlyCS1fICf79ZY
         pobA==
X-Gm-Message-State: ACrzQf2tOHRyBLQ2b9dBtga3afKTkeIYndTNHXQ7ukFuhmc6PWQGJ/Ma
        lraCgYhLRt3zPouvHRzny2jlD/CKq1E0JA==
X-Google-Smtp-Source: AMsMyM6PkDSL65To/gPJ5BVXTbSstQ9PrYD9806PI5CQqIslHZdb8X7Kn0OUs5Ae6MYOMumrGgEHBw==
X-Received: by 2002:a05:6402:348b:b0:45c:b22b:c4a9 with SMTP id v11-20020a056402348b00b0045cb22bc4a9mr34123422edc.65.1667525389024;
        Thu, 03 Nov 2022 18:29:49 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b00782e3cf7277sm177510ejc.120.2022.11.03.18.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:29:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqlWl-00D1U5-33;
        Fri, 04 Nov 2022 02:29:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 8/8] submodule--helper: use OPT_SUBCOMMAND() API
Date:   Fri, 04 Nov 2022 02:22:54 +0100
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <patch-8.8-105853cd358-20221102T074148Z-avarab@gmail.com>
 <kl6l7d0bobt0.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6l7d0bobt0.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221104.86wn8bzeus.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
>> +	struct option options[] =3D {
>> +		OPT_SUBCOMMAND("clone", &fn, module_clone),
>> +		OPT_SUBCOMMAND("add", &fn, module_add),
>> +		OPT_SUBCOMMAND("update", &fn, module_update),
>> +		OPT_SUBCOMMAND("foreach", &fn, module_foreach),
>> +		OPT_SUBCOMMAND("init", &fn, module_init),
>> +		OPT_SUBCOMMAND("status", &fn, module_status),
>> +		OPT_SUBCOMMAND("sync", &fn, module_sync),
>> +		OPT_SUBCOMMAND("deinit", &fn, module_deinit),
>> +		OPT_SUBCOMMAND("summary", &fn, module_summary),
>> +		OPT_SUBCOMMAND("push-check", &fn, push_check),
>> +		OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
>> +		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
>> +		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
>> +		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
>> +		OPT_END()
>> +	};
>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>> +	subcmd =3D argv[0];
>> +
>> +	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
>> +	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
>> +	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
>> +	    get_super_prefix())
>> +		/*
>> +		 * xstrfmt() rather than "%s %s" to keep the translated
>> +		 * string identical to git.c's.
>> +		 */
>> +		die(_("%s doesn't support --super-prefix"),
>> +		    xstrfmt("'%s %s'", cmd, subcmd));
>
> FYI I'm preparing a series to get rid of the SUPPORT_SUPER_PREFIX checks
> in both the top level and in submodule--helper (i.e. revisiting my
> complaints from [1]), but I haven't sent it out yet because I haven't
> found the right way to motivate that change. Feel free to chime in on
> that series when it comes out.
>
> [1] https://lore.kernel.org/git/20220630221147.45689-5-chooglen@google.co=
m/

Maybe you have different plans, but keep at the WIP re-roll of what I
have after this, I've also removed all of that.

Basically, ending up with:
=09
	--- a/builtin.h
	+++ b/builtin.h
	@@ -224,7 +224,14 @@ int cmd_sparse_checkout(int argc, const char **argv, =
const char *prefix);
	 int cmd_status(int argc, const char **argv, const char *prefix);
	 int cmd_stash(int argc, const char **argv, const char *prefix);
	 int cmd_stripspace(int argc, const char **argv, const char *prefix);
	+int cmd_submodule(int argc, const char **argv, const char *prefix);
	 int cmd_submodule__helper(int argc, const char **argv, const char *prefix=
);
	+int cmd_submodule__helper_clone(int argc, const char **argv, const char *=
prefix);
	+int cmd_submodule_absorbgitdirs(int argc, const char **argv, const char *=
prefix);
	+int cmd_submodule_foreach(int argc, const char **argv, const char *prefix=
);
	+int cmd_submodule_status(int argc, const char **argv, const char *prefix);
	+int cmd_submodule_sync(int argc, const char **argv, const char *prefix);
	+int cmd_submodule_update(int argc, const char **argv, const char *prefix);
	 int cmd_switch(int argc, const char **argv, const char *prefix);
	 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
	 int cmd_tag(int argc, const char **argv, const char *prefix);

And changes like:
=09
	@@ -366,7 +365,7 @@ static void runcommand_in_submodule_cb(const struct ca=
che_entry *list_item,
=09=20
	                strvec_pushl(&cpr.args, "--super-prefix", NULL);
	                strvec_pushf(&cpr.args, "%s/", displaypath);
	-               strvec_pushl(&cpr.args, "submodule--helper", "foreach", "-=
-recursive",
	+               strvec_pushl(&cpr.args, "submodule--helper-foreach", "--re=
cursive",
	                             NULL);
=09=20
	                if (info->quiet)

I.e. when we call "foreach" we dispatch to cmd_submodule_foreach(), but
when "foreach" needs to recurse it doesn't invoke a "git submodule
foreach", instead it invokes "git submodule--helper-foreach".

The reason for doing that is that we can't promote the helper to a
built-in without also leaking implementation detail that we support the
now internal-only --super-prefix in the command itself.

So this code becomes:
=09
	@@ -3352,43 +3304,17 @@ static int module_add(int argc, const char **argv,=
 const char *prefix)
=09=20
	 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
	 {
	-       const char *cmd =3D argv[0];
	-       const char *subcmd;
	        parse_opt_subcommand_fn *fn =3D NULL;
	        const char *const usage[] =3D {
	                N_("git submodule--helper <command>"),
	                NULL
	        };
	        struct option options[] =3D {
	-               OPT_SUBCOMMAND("clone", &fn, module_clone),
	-               OPT_SUBCOMMAND("add", &fn, module_add),
	-               OPT_SUBCOMMAND("update", &fn, module_update),
	-               OPT_SUBCOMMAND("foreach", &fn, module_foreach),
	-               OPT_SUBCOMMAND("init", &fn, module_init),
	-               OPT_SUBCOMMAND("status", &fn, module_status),
	-               OPT_SUBCOMMAND("sync", &fn, module_sync),
	-               OPT_SUBCOMMAND("deinit", &fn, module_deinit),
	-               OPT_SUBCOMMAND("summary", &fn, module_summary),
	-               OPT_SUBCOMMAND("push-check", &fn, push_check),
	-               OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
	-               OPT_SUBCOMMAND("set-url", &fn, module_set_url),
	-               OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
	-               OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
	+               OPT_SUBCOMMAND("push-check", &fn, cmd_submodule_push_check=
),
	+               OPT_SUBCOMMAND("create-branch", &fn, cmd_submodule_create_=
branch),
	                OPT_END()
	        };
	        argc =3D parse_options(argc, argv, prefix, options, usage, 0);
	-       subcmd =3D argv[0];
	-
	-       if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
	-           strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
	-           strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
	-           get_super_prefix())
	-               /*
	-                * xstrfmt() rather than "%s %s" to keep the translated
	-                * string identical to git.c's.
	-                */
	-               die(_("%s doesn't support --super-prefix"),
	-                   xstrfmt("'%s %s'", cmd, subcmd));
=09=20
	        return fn(argc, argv, prefix);
	 }

I.e. for all the "super-prefix" ones we dispatch directly (and maybe I
should just do that too for those two stragglers).

It's ugly, but it's only ugly on the inside, but if you can think of a
better way to do it...
