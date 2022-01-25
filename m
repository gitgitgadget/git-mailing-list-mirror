Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F55DC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 20:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiAYUwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 15:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiAYUwO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 15:52:14 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF72C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 12:52:13 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 33F3B19F522;
        Tue, 25 Jan 2022 21:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1643143930;
        bh=xJYt0hsjVkVW1ZAoyhbIAUvTGJLO2fu27De+3VGywLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2QkGC9VogzqRlw61fe91dOP44VyuADVGgJ461bGChIQEyvexY7hv4n6dauVDLS1Y
         s3bavSY1eeFfVzery4lVm1o1EsYdBLPmPEaCBrXB5wKAI3A8OqXyVqRzE+Kz27sAn9
         qEfE4PMbfFLFmUBSDHTgkVEN0vDqva8FYr6455AInPNiVJ+NVnZEIK6WLo12+x1IYE
         mVNfxmg8jIufiq6nUyMtI1ZnbowyV9biORe76/El4Q5Ff2xHfwXT5Lya3XnBKW6sDS
         E3qKgwY44vOOdTgxX3LqT6KgobE0RJRVQp2dXunw4nbvOhG1iuciV0vhpUBprIJqfS
         3IK9D7KA4jZrQ==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Johannes Sixt <j6t@kdbg.org>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/4] i18n: factorize more 'incompatible options' messages
Date:   Tue, 25 Jan 2022 21:52:06 +0100
Message-ID: <2894278.sRLLl5rxgE@cayenne>
In-Reply-To: <80593381-2ecc-5de5-76b7-0e6c6452559f@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com> <ba203623-87b1-f3eb-9498-52c4ea4ba07e@kdbg.org> <80593381-2ecc-5de5-76b7-0e6c6452559f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le lundi 24 janvier 2022, 12:06:19 CET Phillip Wood a =E9crit :
> On 24/01/2022 07:14, Johannes Sixt wrote:
> > Am 22.01.22 um 19:35 schrieb Jean-No=EBl Avila via GitGitGadget:
> >> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >>
> >> When more than two options are mutually exclusive, print the ones
> >> which are actually on the command line.
> >=20
> > Reading this, I expect that all mutually exclusive options are listed in
> > the error messages. But the updated code lists only the first and second
> > option even if more are on the command line. What is the justification
> > for that? Just "make the work for translators easier"? I am not 100%
> > sure that this is the right balance. Wouldn't it be helpful for users to
> > get to know which set of options is incompatible, or is an error message
> > not the right place for this kind of education? Don't know...
>=20
> That was my feeling as well when reading this patch, I think the loss of=
=20
> information in the error messages is a shame.

The enhancement aims at being more precise as to which options actually=20
present on=20
the command line are mutually exclusive, instead of letting the user sort o=
ut=20
where the clash comes from. Personal taste, but the "--foo/--bar" is poor u=
ser=20
interaction: better a partial but precise message than a (hopefully) comple=
te=20
but generic one.



> >> @@ -1268,19 +1269,19 @@ static int parse_and_validate_options(int argc=
,=20
const char *argv[],
> >>   			die(_("You are in the middle of a rebase --=20
cannot amend."));
> >>   	}
> >>   	if (fixup_message && squash_message)
> >> -		die(_("Options --squash and --fixup cannot be used=20
together"));
> >> -	if (use_message)
> >> -		f++;
> >> -	if (edit_message)
> >> -		f++;
> >> -	if (fixup_message)
> >> -		f++;
> >> -	if (logfile)
> >> -		f++;
> >> +		die(_("options '%s' and '%s' cannot be used together"),=20
"--squash", "--fixup");
> >> +	f_options[f] =3D "-C";
> >> +	f+=3D	!!use_message;
> >> +	f_options[f] =3D "-c";
> >> +	f+=3D!!edit_message;
> >> +	f_options[f] =3D "-F";
> >> +	f+=3D!!logfile;
> >> +	f_options[f] =3D "--fixup";
> >> +	f+=3D!!fixup_message;
>=20
> This feels like an out of bounds access waiting to happen when someone=20
> adds a new option but forgets to increase the size of f_options above

That's one of the advantages of C99: declaring the variables near their use=
=20
site so that you can keep them in you brain while reading the code.

>=20
> Best Wishes
>=20
> Phillip
>=20
> >=20
> > I prefer this if-cascade over the "f +=3D truth_value" style, because I
> > find it is easier to understand. If you write it as
> >=20
> > 	if (extcmd)
> > 		f_options[f++] =3D "--extcmd";
> >=20
> > you get each branch down to two lines. (But then others may disagree
> > with the easy-to-understand argument due to the f++ buried in the
> > expression. Unsure...)




> >=20
> >>  =20
> >>   	if (use_gui_tool)
> >>   		setenv("GIT_MERGETOOL_GUI", "true", 1);
> >> diff --git a/builtin/grep.c b/builtin/grep.c
> >> index 9e34a820ad4..b199781cb27 100644
> >> --- a/builtin/grep.c
> >> +++ b/builtin/grep.c
> >> @@ -1168,10 +1168,10 @@ int cmd_grep(int argc, const char **argv, cons=
t=20
char *prefix)
> >>   		setup_pager();
> >>  =20
> >>   	if (!use_index && (untracked || cached))
> >> -		die(_("--cached or --untracked cannot be used with --
no-index"));
> >> +		die(_("options '%s' and '%s' cannot be used=20
together"),"--cached/--untracked", "--no-index");
> >=20
> > Huh? "--cached/--untracked"? Which one was used on the command line?=20
But...
> >=20
> >>  =20
> >>   	if (untracked && cached)
> >> -		die(_("--untracked cannot be used with --cached"));
> >> +		die(_("options '%s' and '%s' cannot be used together"),=20
"--untracked", "--cached");
> >>  =20
> >>   	if (!use_index || untracked) {
> >>   		int use_exclude =3D (opt_exclude < 0) ? use_index : !!
opt_exclude;
> >=20
> > ... doesn't this logic imply that --cached, --untracked, and --no-index
> > are three mutually exclusive options?
> >=20
> >> diff --git a/builtin/log.c b/builtin/log.c
> >> index 4b493408cc5..59b4a2fd380 100644
> >> --- a/builtin/log.c
> >> +++ b/builtin/log.c
> >> @@ -1759,6 +1759,9 @@ int cmd_format_patch(int argc, const char **argv=
,=20
const char *prefix)
> >>   	struct strbuf rdiff_title =3D STRBUF_INIT;
> >>   	int creation_factor =3D -1;
> >>  =20
> >> +	int f =3D 0;
> >> +	char * f_options[4];
> >> +
> >=20
> > Style: char *f_options[4]; don't needlessly separate these new variables
> > from the others by an empty line.
> >=20
> >>   	const struct option builtin_format_patch_options[] =3D {
> >>   		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> >>   			    N_("use [PATCH n/m] even with a single=20
patch"),
> >> @@ -1978,8 +1981,21 @@ int cmd_format_patch(int argc, const char **arg=
v,=20
const char *prefix)
> >>   	if (rev.show_notes)
> >>   		load_display_notes(&rev.notes_opt);
> >>  =20
> >> -	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
> >> -		die(_("options '%s', '%s', and '%s' cannot be used=20
together"), "--stdout", "--output", "--output-directory");
> >> +	if (use_stdout) {
> >> +		f_options[f] =3D "--stdout";
> >> +		f++;
> >> +	}
> >> +	if (rev.diffopt.close_file) {
> >> +		f_options[f] =3D "--output";
> >> +		f++;
> >> +	}
> >> +	if (output_directory) {
> >> +		f_options[f] =3D "--output-directory";
> >> +		f++;
> >> +	}
> >> +
> >> +	if (f > 1)
> >> +		die(_("options '%s'and '%s' cannot be used together"),=20
f_options[0], f_options[1]);
> >>  =20
> >>   	if (use_stdout) {
> >>   		setup_pager();
> >> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> >> index 6719ac198dc..1447f1c493a 100644
> >> --- a/builtin/merge-base.c
> >> +++ b/builtin/merge-base.c
> >> @@ -159,12 +159,12 @@ int cmd_merge_base(int argc, const char **argv,=
=20
const char *prefix)
> >>   		if (argc < 2)
> >>   			usage_with_options(merge_base_usage,=20
options);
> >>   		if (show_all)
> >> -			die("--is-ancestor cannot be used with --
all");
> >> +			die(_("options '%s' and '%s' cannot be used=20
together"),"--is-ancestor", "--all");
> >>   		return handle_is_ancestor(argc, argv);
> >>   	}
> >>  =20
> >>   	if (cmdmode =3D=3D 'r' && show_all)
> >> -		die("--independent cannot be used with --all");
> >> +		die(_("options '%s' and '%s' cannot be used=20
together"),"--independent", "--all");
> >>  =20
> >>   	if (cmdmode =3D=3D 'o')
> >>   		return handle_octopus(argc, argv, show_all);
> >> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commi=
t-
template-squash-signoff.sh
> >> index 91964653a0b..5fcaa0b4f2a 100755
> >> --- a/t/t7500-commit-template-squash-signoff.sh
> >> +++ b/t/t7500-commit-template-squash-signoff.sh
> >> @@ -442,7 +442,7 @@ test_expect_success '--fixup=3Dreword: give error =
with=20
pathsec' '
> >>   '
> >>  =20
> >>   test_expect_success '--fixup=3Dreword: -F give error message' '
> >> -	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
> >> +	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used=20
together" >expect &&
> >>   	test_must_fail git commit --fixup=3Dreword:HEAD~ -F msg  2>actual &&
> >>   	test_cmp expect actual
> >>   '
> >=20
> > A general comment: To me, it looks like you didn't want to change the
> > variable name 'f' in the first hunk above, and then just named the array
> > 'f_options' to go with 'f'. Perhaps `exclusive_opt` (not plural!) for
> > the array. Now, renaming 'f' to something longer makes the code a bit
> > unwieldy. Therefore, let me suggest yet another approach: factor out
> > functions check_exclusive_opts3(), check_exclusive_opts4(), to be used=
=20
like
> >=20
> > 	check_exclusive_opts3(use_stdout, "--stdout",
> > 		rev.diffopt.close_file, "--output",
> > 		output_directory, "--output-directory");
> >=20
> > I am not yet proposing check_exclusive_opts2(), but others may think it
> > is an improvement, too, (if they think that such functions are an
> > improvement in the first place).
> >=20
> > -- Hannes
>=20

Will factorize away such exclusive options, but I'm not sure where. Should =
it=20
be in git-compat-util.h?


