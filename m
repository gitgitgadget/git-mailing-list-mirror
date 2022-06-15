Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F7C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbiFOKMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbiFOKMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:12:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B0CDEC5
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:12:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h23so22177976ejj.12
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EX3isTNEzYfQG1AoXobZoa9Qms4Y5JRLHPIjyEL2DZw=;
        b=H4SfOks36nzn8XMJ3/Y1GYVPn+6Mgh3FX6c0I0RCLUEpHsltrG2FYSApaIDOD5ieqI
         5ZXmkXz445YeI8HrQ2V/Oag8OOX4S9bIODCbu1WRaC6X40td5XRiSWxBQkyUG+J4VYzL
         0ZSOqZBAfNus3GGFBj1zZkfs7eJE7YZcAs1FHSo3sc3lWSWy3+omSXUbNAXWQF3qSuZg
         QIM20Bsvw7eIpyePPI9zwCLg/xeejHBFW8j0IsNjOUs3zGI/bfsqS5q1QQY0PUd8I11O
         6p/h6j413R9WuYoE7KSrfvqxC+sKjjwWgVB6+PY4ATn2CMyHUmYzwRjUUScf4tdWW45B
         Bcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EX3isTNEzYfQG1AoXobZoa9Qms4Y5JRLHPIjyEL2DZw=;
        b=1mMHdBaSUtKEbV2zw6gQSGwPlw5IStTG73koUKjjSkt1LLr1idu9BIoold/qUSaKng
         k2yFQSSjiJWis+qwgEiZ3uwVuWuS85eZtQGGMPrSijfWF2l5D0DTCpaNwpXxtNPNok/B
         I5nz6nlkf5c3PJKlvp4Y3YfNXIDoXpgHx0Q28DJSmyNmTVJrHxVH5ovbAmvhcMev5CNU
         E8GmyZLBq6aDeEml7jANjsk9tSq1pViQ8egELIJ4CqJzfxYA0sD5exP5ksndZQ3aM6IX
         4gKMFbzWqrbZs4H5d3+2+bLlcpMAdfHBylAf/RT5uOT+cCIbR42dMciAiuC471jiqi5e
         IrFg==
X-Gm-Message-State: AOAM533iwu5j2zbou6IC9t1hHPg2iBfMQjJu8C9DJqayvzdMaY6DY6XW
        o5g24ll/xjqe8D6Bm1e8OYk=
X-Google-Smtp-Source: ABdhPJxG66g732vo00+9sWzt2iOMEbWI6L0NwHpciHdEFbVKIcH8ehU5dBQSRpDHYSdA/ReS0V1dTQ==
X-Received: by 2002:a17:906:7394:b0:712:3c15:ba52 with SMTP id f20-20020a170906739400b007123c15ba52mr8027627ejl.169.1655287955653;
        Wed, 15 Jun 2022 03:12:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7db9a000000b004314bb65e7fsm8994191edt.41.2022.06.15.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:12:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1Q0o-000moN-9i;
        Wed, 15 Jun 2022 12:12:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: [PATCH v2 08/12] submodule--helper: report "submodule" as our
 name in "-h" output
Date:   Wed, 15 Jun 2022 11:42:09 +0200
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <patch-v2-08.12-99ac52d810f-20220613T220150Z-avarab@gmail.com>
 <kl6lczfa60d3.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lczfa60d3.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220615.86r13qxmjx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 574d6e0a79b..c2f55779cb1 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -286,7 +286,7 @@ static int module_list(int argc, const char **argv, =
const char *prefix)
>>  	};
>>=20=20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper list [--prefix=3D<path>] [<path>...]"),
>> +		N_("git submodule list [--prefix=3D<path>] [<path>...]"),
>>  		NULL
>>  	};
>> @@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **arg=
v, const char *prefix)
>>  	};
>>=20=20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <comma=
nd>"),
>> +		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, =
const char *prefix)
>>  	};
>>=20=20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper init [<options>] [<path>]"),
>> +		N_("git submodule init [<options>] [<path>]"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -786,7 +786,7 @@ static int module_name(int argc, const char **argv, =
const char *prefix)
>>  	const struct submodule *sub;
>>=20=20
>>  	if (argc !=3D 2)
>> -		usage(_("git submodule--helper name <path>"));
>> +		usage(_("git submodule name <path>"));
>>=20=20
>>  	sub =3D submodule_from_path(the_repository, null_oid(), argv[1]);
>>=20=20
>> @@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **a=
rgv, const char *prefix)
>>  	};
>>=20=20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>=
]"),
>> +		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv=
, const char *prefix)
>>  	};
>>=20=20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
>> +		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -1789,7 +1789,7 @@ static int module_clone(int argc, const char **arg=
v, const char *prefix)
>>  	};
>>=20=20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper clone [--prefix=3D<path>] [--quiet] "
>> +		N_("git submodule clone [--prefix=3D<path>] [--quiet] "
>>  		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
>>  		   "[--single-branch] [--filter <filter-spec>] "
>>  		   "--url <url> --path <path>"),
>> @@ -2787,7 +2787,7 @@ static int absorb_git_dirs(int argc, const char **=
argv, const char *prefix)
>>  	};
>>=20=20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
>> +		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -2851,9 +2851,9 @@ static int module_config(int argc, const char **ar=
gv, const char *prefix)
>>  		OPT_END()
>>  	};
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper config <name> [<value>]"),
>> -		N_("git submodule--helper config --unset <name>"),
>> -		"git submodule--helper config --check-writeable",
>> +		N_("git submodule config <name> [<value>]"),
>> +		N_("git submodule config --unset <name>"),
>> +		"git submodule config --check-writeable",
>>  		NULL
>>  	};
>>=20=20
>> @@ -2892,7 +2892,7 @@ static int module_set_url(int argc, const char **a=
rgv, const char *prefix)
>>  		OPT_END()
>>  	};
>>  	const char *const usage[] =3D {
>> -		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
>> +		N_("git submodule set-url [--quiet] <path> <newurl>"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -2931,8 +2931,8 @@ static int module_set_branch(int argc, const char =
**argv, const char *prefix)
>>  		OPT_END()
>>  	};
>>  	const char *const usage[] =3D {
>> -		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <pat=
h>"),
>> -		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <bran=
ch> <path>"),
>> +		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
>> +		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <pat=
h>"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -2973,7 +2973,7 @@ static int module_create_branch(int argc, const ch=
ar **argv, const char *prefix)
>>  		OPT_END()
>>  	};
>>  	const char *const usage[] =3D {
>> -		N_("git submodule--helper create-branch [-f|--force] [--create-reflog=
] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"=
),
>> +		N_("git submodule create-branch [-f|--force] [--create-reflog] [-q|--=
quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
>>  		NULL
>>  	};
>>=20=20
>> @@ -3276,7 +3276,7 @@ static int module_add(int argc, const char **argv,=
 const char *prefix)
>>  	};
>>=20=20
>>  	const char *const usage[] =3D {
>> -		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"=
),
>> +		N_("git submodule add [<options>] [--] <repository> [<path>]"),
>>  		NULL
>>  	};

First, I think this patch is premature, so let's just drop it in a
re-roll. We don't *need* to fix this particular edge case or bug now,
and can just do it as we do the final migration.

> I don't feel positive about pretending to be "git submodule" when the
> subcommand is internal-only. Such commands are only invoked as "git
> submodule--helper foo" and we will probably never turn them into
> external-facing "git submodule foo" [1]. Even if it is internal-only,
> there is a debugging benefit to emitting a usage string with the
> correct, non-user facing command name.

I think we should really be most concerned about the end users here,
nobody except git developers are going to want to invoke
"submodule--helper" directly, so its help messages should be aimed at
helping users.

As you mention in another E-Mail it's currently not a big deal, I
*think* that "absorbgitdirs" is the only case where we'll implicitly
suggest to a user that they might invoke "git submodule--helper" as we
emit the usage info.

But I think for the patches that come after this we should definitely
change this, i.e. we don't want an in-between state where we have both
of builtin/submodule{,--helper}.c because we haven't merged the two yet,
but are now telling users about the inernal-only helper.

> I admit it might be a bit confusing to have a mix of usage strings with
> "submodule--helper" vs "submodule", but as long as we clearly label
> which commands are user-facing and which aren't, it shouldn't be too
> hard to maintain, e.g. this might just be a matter of adding comments to
> the array of commands like:
>
>   static struct cmd_struct commands[] =3D {
>     /* User facing commands - pretend to be "git submodule" */
>     {"name", module_name},
>     {"add", module_add},
>     [...]
>     /* Internal-only commands */
>     {"clone", module_clone},
>     {"resolve-relative-url-test", resolve_relative_url_test},
>     [...]
>   };
>
> Notably, even with this patch we still _kind of_ have 'pseudo usage
> strings' that reference "git submodule--helper". These are just
> internal-only commands that don't use the parse_options() API, e.g.
>
> 	if (argc < 3)
> 		die("submodule--helper push-check requires at least 2 arguments");
>
> I think it's ok to leave them as-is, provided we also leave the other
> internal-only commands as-is.

Yes let's leave them, we'll be converting these to not invoke
sub-processes sooner than later anyway.

> [1] For convenience, here is a list of all of the subcommands changed in
> this patch and whether they are user-facing/internal-only:
>
> User-facing                 Internal-only
>
> - foreach                   - list
> - init                      - name
> - summary                   - clone
> - sync                      - config
> - absorbgitdirs             - create-branch
> - set-url
> - set-branch
> - add

But yeah, if/when we change the public-facing usage strings we should be
leaving out the "internal-only" commands, thanks. I just did a dumb
search/replace.
