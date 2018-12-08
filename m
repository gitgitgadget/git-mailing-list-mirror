Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A57B20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 04:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLHEVt (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 23:21:49 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:52311 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeLHEVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 23:21:49 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gVU7d-0005VI-6K
        for git@vger.kernel.org; Fri, 07 Dec 2018 23:21:45 -0500
Date:   Fri, 7 Dec 2018 23:21:39 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181208042139.GA4827@hopa.kiewit.dartmouth.edu>
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
 <20181206212459.GN4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com>
 <20181207012256.GR4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kbeAd1C-ySnJye-QU5FFf2jygksUsWtEmbvPZ_dQy_3uA@mail.gmail.com>
 <20181208021531.GB4633@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20181208021531.GB4633@hopa.kiewit.dartmouth.edu>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [wishlist] git submodule update --reset-hard
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


On Fri, 07 Dec 2018, Yaroslav Halchenko wrote:


> On Fri, 07 Dec 2018, Stefan Beller wrote:
> > > the initial "git submodule update --reset-hard" is pretty much a
> > > crude workaround for some of those cases, so I would just go earlier in
> > > the history, and redo some things, whenever I could just drop or revert
> > > some selected set of commits.

> > That makes sense.
> > Do you want to give the implementation a try for the --reset-hard switch?

> ok, will do, thanks for the blessing ;-)

The patch is attached (please advise if should be done
differently) and also submitted as PR
https://github.com/git/git/pull/563

I guess it would need more tests.  Took me some time to figure out
why I was getting

	fatal: bad value for update parameter

after all my changes to the git-submodule.sh script after looking at an
example commit 42b491786260eb17d97ea9fb1c4b70075bca9523 which introduced
--merge to the update ;-)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        

--ffoCPvUAPMgSXi6H
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-submodule-Add-reset-hard-option-for-git-submodule-up.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 170296dc661b4bc3d942917ce27288df52ff650d Mon Sep 17 00:00:00 2001
=46rom: Yaroslav Halchenko <debian@onerussian.com>
Date: Fri, 7 Dec 2018 21:28:29 -0500
Subject: [PATCH] submodule: Add --reset-hard option for git submodule update

This patch adds a --reset-hard option for the update command to hard
reset submodule(s) to the gitlink for the corresponding submodule in
the superproject.  This feature is desired e.g. to be able to discard
recent changes in the entire hierarchy of the submodules after running

   git reset --hard PREVIOUS_STATE

in the superproject which leaves submodules in their original state,
and

   git reset --hard --recurse-submodules PREVIOUS_STATE

would result in the submodules being checked into detached HEADs.

As in the original  git reset --hard  no checks or any kind of
safe-guards against jumping into some state which was never on the
current branch is done.

must_die_on_failure is not set to  yes to mimic behavior of a update
--checkout strategy, which would leave user with a non-clean state
immediately apparent via  git status  so an informed decision/actions
could be done manually.

Signed-off-by: Yaroslav Halchenko <debian@onerussian.com>
---
 Documentation/git-submodule.txt | 12 +++++++++++-
 Documentation/gitmodules.txt    |  4 ++--
 builtin/submodule--helper.c     |  3 ++-
 git-submodule.sh                | 10 +++++++++-
 submodule.c                     |  4 ++++
 submodule.h                     |  1 +
 t/t7406-submodule-update.sh     | 17 ++++++++++++++++-
 7 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.=
txt
index ba3c4df550..f90a42d265 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -124,7 +124,7 @@ If you really want to remove a submodule from the repos=
itory and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for remov=
al
 options.
=20
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|=
--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth =
<depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|=
--force] [--checkout|--rebase|--merge|--reset-hard] [--reference <repositor=
y>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -358,6 +358,16 @@ the submodule itself.
 	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.
=20
+--reset-hard::
+	This option is only valid for the update command.
+	Hard reset current state to the commit recorded in the	superproject.
+    If this option is given, the submodule's HEAD will not get detached
+    if it was not detached before. Note that, like with a regular
+    git reset --hard  no safe-guards are in place to prevent jumping
+    to a commit which was never part of the current branch.
+	If the key `submodule.$name.update` is set to `reset-hard`, this
+	option is implicit.
+
 --init::
 	This option is only valid for the update command.
 	Initialize all submodules for which "git submodule init" has not been
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 312b6f9259..e085dbc01f 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -43,8 +43,8 @@ submodule.<name>.update::
 	command in the superproject. This is only used by `git
 	submodule init` to initialize the configuration variable of
 	the same name. Allowed values here are 'checkout', 'rebase',
-	'merge' or 'none'. See description of 'update' command in
-	linkgit:git-submodule[1] for their meaning. Note that the
+	'merge', 'reset-hard' or 'none'. See description of 'update' command
+	in linkgit:git-submodule[1] for their meaning. Note that the
 	'!command' form is intentionally ignored here for security
 	reasons.
=20
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..31d95c3cd6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1481,6 +1481,7 @@ static void determine_submodule_update_strategy(struc=
t repository *r,
 	if (just_cloned &&
 	    (out->type =3D=3D SM_UPDATE_MERGE ||
 	     out->type =3D=3D SM_UPDATE_REBASE ||
+	     out->type =3D=3D SM_UPDATE_RESET_HARD ||
 	     out->type =3D=3D SM_UPDATE_NONE))
 		out->type =3D SM_UPDATE_CHECKOUT;
=20
@@ -1851,7 +1852,7 @@ static int update_clone(int argc, const char **argv, =
const char *prefix)
 			      "submodule boundaries")),
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
+			   N_("rebase, merge, checkout, reset-hard or none")),
 		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &suc.dissociate,
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..b5d6fad983 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--name <=
name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|=
--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--refere=
nce <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|=
--force] [--checkout|--merge|--rebase|--reset-hard] [--[no-]recommend-shall=
ow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>=
] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
@@ -483,6 +483,9 @@ cmd_update()
 		-m|--merge)
 			update=3D"merge"
 			;;
+		--reset-hard)
+			update=3D"reset-hard"
+			;;
 		--recursive)
 			recursive=3D1
 			;;
@@ -621,6 +624,11 @@ cmd_update()
 				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': merged in '=
\$sha1'")"
 				must_die_on_failure=3Dyes
 				;;
+			reset-hard)
+				command=3D"git reset --hard"
+				die_msg=3D"$(eval_gettext "Unable to reset --hard to '\$sha1' in submo=
dule path '\$displaypath'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': was reset -=
-hard to '\$sha1'")"
+				;;
 			!*)
 				command=3D"${update_module#!}"
 				die_msg=3D"$(eval_gettext "Execution of '\$command \$sha1' failed in s=
ubmodule path '\$displaypath'")"
diff --git a/submodule.c b/submodule.c
index 6415cc5580..4580cf0944 100644
--- a/submodule.c
+++ b/submodule.c
@@ -373,6 +373,8 @@ enum submodule_update_type parse_submodule_update_type(=
const char *value)
 		return SM_UPDATE_REBASE;
 	else if (!strcmp(value, "merge"))
 		return SM_UPDATE_MERGE;
+	else if (!strcmp(value, "reset-hard"))
+		return SM_UPDATE_RESET_HARD;
 	else if (*value =3D=3D '!')
 		return SM_UPDATE_COMMAND;
 	else
@@ -406,6 +408,8 @@ const char *submodule_strategy_to_string(const struct s=
ubmodule_update_strategy
 		return "checkout";
 	case SM_UPDATE_MERGE:
 		return "merge";
+	case SM_UPDATE_RESET_HARD:
+		return "reset-hard";
 	case SM_UPDATE_REBASE:
 		return "rebase";
 	case SM_UPDATE_NONE:
diff --git a/submodule.h b/submodule.h
index a680214c01..f23ac4630e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,6 +29,7 @@ enum submodule_update_type {
 	SM_UPDATE_CHECKOUT,
 	SM_UPDATE_REBASE,
 	SM_UPDATE_MERGE,
+	SM_UPDATE_RESET_HARD,
 	SM_UPDATE_NONE,
 	SM_UPDATE_COMMAND
 };
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e87164aa8f..2e08e0047c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -6,7 +6,8 @@
 test_description=3D'Test updating submodules
=20
 This test verifies that "git submodule update" detaches the HEAD of the
-submodule and "git submodule update --rebase/--merge" does not detach the =
HEAD.
+submodule and "git submodule update --rebase/--merge/--reset-hard" does
+not detach the HEAD.
 '
=20
 . ./test-lib.sh
@@ -305,6 +306,20 @@ test_expect_success 'submodule update --merge staying =
on master' '
 	)
 '
=20
+test_expect_success 'submodule update --reset-hard staying on master' '
+	(cd super/submodule &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	 (cd submodule &&
+	  compare_head
+	 ) &&
+	 git submodule update --reset-hard submodule &&
+	 cd submodule &&
+	 compare_head
+	)
+'
+
 test_expect_success 'submodule update - rebase in .git/config' '
 	(cd super &&
 	 git config submodule.submodule.update rebase
--=20
2.20.0.rc2.8.g0a3bec4a1c.dirty


--ffoCPvUAPMgSXi6H--
