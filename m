Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1987DC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 21:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiCaV35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiCaV3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 17:29:54 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915DF23F392
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:28:02 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=F1iPfP6e6TuTOmpVLmMPlEThesXrgKpMIbWpF97lhYF2BmTsJDZoDKekaOxWWXw0ElHchYURP69AIubsYjJveuMysMvURXwE4aZoduwuDxhK01UfgmY0MUcilsDIFxw8WdJPZBlgdrQGch73AAmMsELwiNm3QwKKqeuoG1WaOgSZguZJefSCUmbOF4l1PZMKhqIc+uCRIDZ6zTtek4OLj9Q7uMGTbezGRq3JLTTY6cPlmvQnCVNoCXX9gCryClFDk9Gs+Br433A87ygZd8ySKG1qsQ4Z0RHGYJlp/Lq0VvxaqWNk7xf2HWYA4fqQn50ncoRp96i8HHBjEf0OMZ9m4g==; s=purelymail1; d=slashdev.space; v=1; bh=yj82khhUOH142BUYF3JMt4Nn+ZRT3h0NCuTYesWQ95c=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=E1wEEjFILQtlnVL1LvBRdbIjutsXvB59LXoHufb8tI85sf2e6m/ampBHNRu5wGQid9EzeJBJzvvwUHrwCCR5semkFmdDIMDQPq5UTBZiRhtV4MEpwB0MJBBMLWMFTVS0Lv24pWyAPxzTQ8apPvyWbYwD0rxFsj91Nk1/PkG1o1LFS57t/Ra9eFCE9VYAq3ctU/gkmkEqw3x2TIighQmtPyXrrzCzrsMKYQjFXrxfHBcrLUWpeuPY92t/FRctL+EeRlYSwLiEOufM8lNJfVfGh0j+ePS7ayuGGOLTwlxq/LoyvHmh8JXvXsG4nd/4uKVssEvkklGo4wnjkbSMnOlTcw==; s=purelymail1; d=purelymail.com; v=1; bh=yj82khhUOH142BUYF3JMt4Nn+ZRT3h0NCuTYesWQ95c=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2089722214;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Thu, 31 Mar 2022 21:27:54 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     git@vger.kernel.org
Cc:     Garrit Franke <garrit@slashdev.space>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] cli: add -v and -h shorthands
Date:   Thu, 31 Mar 2022 23:27:09 +0200
Message-Id: <20220331212709.36036-1-garrit@slashdev.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330190956.21447-1-garrit@slashdev.space>
References: <20220330190956.21447-1-garrit@slashdev.space>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=ANSI_X3.4-1968
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of "git -v" to be synonymous with "--version" /
"version", and "git -h" to be synonymous with "--help", but not "help".

These shorthands both display the "unknown option" message. Following
this change, "-v" displays the version, and "-h" displays the help text
of the "git" command.

It should be noted that the "-v" shorthand could be misinterpreted by
the user to mean "verbose" instead of "version", since some sub-commands
make use of it in this context. The top-level "git" command does not
have a "verbose" flag, so it's safe to introduce this shorthand
unambiguously.

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---
On 31.03.22 22:07, Junio C Hamano wrote:
>> Not that I'm a fan of this clutter, but it's a possible path to go
>> down if we actually needed a second shorthand using this letter.
>=20
> Do you mean you want to use "-V" for version, instead of the "-v"
> used in the patch, so that "-v" can be left for "--verbose"?
>=20
> I am not sure consistency with whom we are aiming for anymore with
> that mixed to the proposal X-<.

I think I put this in a wrong way. I don't advocate for curls UI and
don't think we should mimic it here. It's just a thing to consider if we
ever find ourselves in this situation. Using the lowercase "-v" for
"version" as proposed by this patch makes the most sense IMO. If we ever
need a shorthand for "verbose", "-V" could be the way to go.

>      (Side note) A tip for reviewers.  Be suspicious of any change
>      that adds new things _in front_ of existing sequence.  Question
>      if there is a good justification for it.  If there isn't, see if
>      it makes it better if you instead append the new stuff to
>      existing sequence.  If neither results in satisfying code,
>      perhaps it is good time to totally rewrite it to make both
>      existing and new stuff fit in the flow.

This is great advice, not just for reviewers. Thanks for taking the time
to write this.

> We may want to be a bit more explicit and readable, by spelling out
> the expectation, i.e.
>=20
> =09=09if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
> =09=09=09argv[0] =3D "version";
> =09=09else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
> =09=09=09argv[0] =3D "help";
>=20
> This makes it clear that these two pseudo-commands, spelled with a
> dash in front and stand for other commands, are the only thing we
> care about and what their accepted spelling are.

Nice and precise. I incorporated this into v3.

 Documentation/git.txt |  4 +++-
 git.c                 | 11 +++++++----
 t/t0012-help.sh       |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 13f83a2a3a..302607a496 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-C <path>] [-c <name>=3D<value>]
+'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
@@ -39,6 +39,7 @@ or https://git-scm.com/docs.
=20
 OPTIONS
 -------
+-v::
 --version::
 =09Prints the Git suite version that the 'git' program came from.
 +
@@ -46,6 +47,7 @@ This option is internally converted to `git version ...` =
and accepts
 the same options as the linkgit:git-version[1] command. If `--help` is
 also given, it takes precedence over `--version`.
=20
+-h::
 --help::
 =09Prints the synopsis and a list of the most commonly used
 =09commands. If the option `--all` or `-a` is given then all
diff --git a/git.c b/git.c
index a25940d72e..e2aeb57a35 100644
--- a/git.c
+++ b/git.c
@@ -25,7 +25,7 @@ struct cmd_struct {
 };
=20
 const char git_usage_string[] =3D
-=09N_("git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+=09N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>=
]\n"
 =09   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--i=
nfo-path]\n"
 =09   "           [-p | --paginate | -P | --no-pager] [--no-replace-object=
s] [--bare]\n"
 =09   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
@@ -146,7 +146,8 @@ static int handle_options(const char ***argv, int *argc=
, int *envchanged)
 =09=09 * commands can be written with "--" prepended
 =09=09 * to make them look like flags.
 =09=09 */
-=09=09if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
+=09=09if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version") ||
+=09=09    !strcmp(cmd, "-h") || !strcmp(cmd, "-v"))
 =09=09=09break;
=20
 =09=09/*
@@ -892,8 +893,10 @@ int cmd_main(int argc, const char **argv)
 =09argc--;
 =09handle_options(&argv, &argc, NULL);
 =09if (argc > 0) {
-=09=09/* translate --help and --version into commands */
-=09=09skip_prefix(argv[0], "--", &argv[0]);
+=09=09if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
+=09=09=09argv[0] =3D "version";
+=09=09else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
+=09=09=09argv[0] =3D "help";=20
 =09} else {
 =09=09/* The user didn't specify a command; give them help */
 =09=09commit_pager_choice();
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6c3e1f7159..6c33a43690 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -181,7 +181,7 @@ for cmd in git "git help"
 do
 =09test_expect_success "'$cmd' section spacing" '
 =09=09test_section_spacing_trailer git help <<-\EOF &&
-=09=09usage: git [--version] [--help] [-C <path>] [-c <name>=3D<value>]
+=09=09usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<=
value>]
=20
 =09=09These are common Git commands used in various situations:
=20
--=20
2.35.1

