Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF5C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 08:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBGIxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 03:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBGIxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 03:53:20 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB21738
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 00:53:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw12so41350770ejc.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 00:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEjcBCuDE4NBmF+bLn7jhjs5dQuufQk4WpUXjIydR+I=;
        b=IKEDeaUYQtfKTlUoeEatgmdTMiBaJj68JRXJJALzQkOgrou9E5EOgN6xjRVQuJ+5zd
         fqpNDvZzung6hIKrcIoqQCBMqFukyNQoq4lWM7GwjNiAqFYBtMpVUDnCOEOUoXsHFtEa
         FUUmsBxJcRuX7sl1PFN2DL6k7e1iVPWUyUB5Z/5HKsTfMcjVx7neUDC/IlIve9K35+yv
         Qox8qQxPer2zci5mpsLiK3U1bygdr5CTlek1iHGSFlMRaDvY2ifd+DnYXXOCyiDv5kB1
         U6XZRkhjmNselNvFIVOKq087v4gAXwRQRlmaAwCxibbWE1EwlzXfBU/THXrJyXccOz8r
         o3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEjcBCuDE4NBmF+bLn7jhjs5dQuufQk4WpUXjIydR+I=;
        b=4lJVmRDWtdXVoAb4kIg5B6a547Hgh2IpXZFhXAeawQrFTUe76WBYEMYv4jN/wSGHE6
         onG4tMMfV9hLnH5YJ6WAJT4OEpOxUwqFpARDXEualCrsHMbLJCQoEeah2GLxbBHcC4gS
         EgCVoFUTY0cF6oEhLOiO1a7jTlPd4wOXUq7Lg0xMGHP/OJNhWLIuz3qNchly3zhzkedj
         ib5WvbIO5vKrUlGNfHYSdYrJR8EGJwwgdem/dWLhT6pHrf+HOWgHpAtxeg0sz9juOAyf
         2k7IY3yV/YWojoevff2uKog9KDzDWozaqPrOZnfo3vYytcMt2JjkjrKf1u8uKD+QN6g6
         FaCw==
X-Gm-Message-State: AO0yUKUBtQtXOFG4pCp5iNEabGqX8mYr3iO4HEAe3+4Jv14mj/cp88sG
        4RNUTBxlR6MWzbQhzoJEUOU=
X-Google-Smtp-Source: AK7set86EHuyc0q0zP05ScyFwWuOsmRweh3PRT2khnsAP4IlGLO3dAvUGdP7irLTP2bbgysrQpFHRw==
X-Received: by 2002:a17:906:164a:b0:86b:9216:2ddb with SMTP id n10-20020a170906164a00b0086b92162ddbmr2642539ejd.52.1675759997223;
        Tue, 07 Feb 2023 00:53:17 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709066d9400b0088c224bf5adsm6654614ejt.147.2023.02.07.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:53:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPJj2-000dzV-0U;
        Tue, 07 Feb 2023 09:53:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] branch: operations on orphan branches
Date:   Tue, 07 Feb 2023 09:33:39 +0100
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Message-ID: <230207.86cz6l501v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Rub=C3=A9n Justo wrote:

> Avoid some confusing errors operating with orphan branches when
> working with worktrees.
>
> Changes from v2:
>
>  - Renamed "ishead_and_reject_rebase_or_bisect_branch()" to
>    "die_if_branch_is_being_rebased_or_bisected()"

Looking this over holistically, I think this is a great example of where
factoring something out into a function is just making readbility
worse. This function is only used in copy_or_rename_branch(), and the
overloaded name & semantics are making things quite confusing.

Whereas if we just start by pulling it into its only caller I think this
gets much better, at the end of this message is a diff-on-top these
three patches where I do that (I kept the "target" variable to minimize
the diff with the move detection, but we probalby want the strbuf
directly instead).

>    A proposed name "die_if_branch_is_is_use()" has not been used because
>    it could lead to confusion.  We don't yet support copying or renaming
>    a branch being rebased or bisected, but we do under other uses.

Another thing that I think could be improved in this series is if you
skip the refactoring-while-at-it of changing the existing
"if/if/die/die" into a "if/die/?:".

In the below diff I have that proposed change on top, but this snippet
here shows the diff to "origin/master":
=09
	@@ -806,7 +806,7 @@ int cmd_branch(int argc, const char **argv, const char=
 *prefix)
=09=20
	 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
	 		if (!ref_exists(branch_ref.buf))
	-			error((!argc || !strcmp(head, branch_name))
	+			error((!argc || branch_checked_out(branch_ref.buf))
	 			      ? _("No commit on branch '%s' yet.")
	 			      : _("No branch named '%s'."),
	 			      branch_name);
	@@ -851,10 +851,11 @@ int cmd_branch(int argc, const char **argv, const ch=
ar *prefix)
	 		}
=09=20
	 		if (!ref_exists(branch->refname)) {
	-			if (!argc || !strcmp(head, branch->name))
	+			if (!argc || branch_checked_out(branch->refname))
	 				die(_("No commit on branch '%s' yet."), branch->name);
	 			die(_("branch '%s' does not exist"), branch->name);
	 		}

I.e. your refactoring of this in 2/3 turns out to in the end have just
been inflating the code change, for no functional benefit.

I wouldn't mind if this were in some pre-cleanup, or if it actually made
the code easier to read, but IMO this pattern of using a ternary to
select the format to "error" or "die" makes things worse for
readability. It's a few bytes less code, but makes things harder to follow =
overall.

And even if you disagree with that as far as the end state is concerned,
I think it's unarguable that it makes the 2/3 harder to follow, since
it's sticking a refactoring that's not neede dfor the end-goal here into
an otherwise functional change.

I'm aware that some of the code in the context uses this pattern, and
you probably changed the "if" block you modified to be consistent with
the code above, but I think in this case it's better not to follow the
existing style (which is used in that function, but is a rare exception
overall in this codebase).

The diff-on-top, mentioned above:

=3D=3D BEGIN
=09
diff --git a/builtin/branch.c b/builtin/branch.c
index 7efda622241..dc7a3e3dde1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -486,45 +486,16 @@ static void print_current_branch_name(void)
 		die(_("HEAD (%s) points outside of refs/heads/"), refname);
 }
=20
-/*
- * Dies if the specified branch is being rebased or bisected.  Otherwise r=
eturns
- * 0 or, if the branch is HEAD in any worktree, returns 1. If the branch i=
s HEAD
- * and also orphan, returns 2.
- */
-static int die_if_branch_is_being_rebased_or_bisected(const char *target)
-{
-	struct worktree **worktrees =3D get_worktrees();
-	int i, ret =3D 0;
-
-	for (i =3D 0; worktrees[i]; i++) {
-		struct worktree *wt =3D worktrees[i];
-
-		if (wt->head_ref && !strcmp(target, wt->head_ref))
-			ret =3D is_null_oid(&wt->head_oid) ? 2 : 1;
-
-		if (!wt->is_detached)
-			continue;
-
-		if (is_worktree_being_rebased(wt, target))
-			die(_("Branch %s is being rebased at %s"),
-			    target, wt->path);
-
-		if (is_worktree_being_bisected(wt, target))
-			die(_("Branch %s is being bisected at %s"),
-			    target, wt->path);
-	}
-
-	free_worktrees(worktrees);
-	return ret;
-}
-
 static void copy_or_rename_branch(const char *oldname, const char *newname=
, int copy, int force)
 {
 	struct strbuf oldref =3D STRBUF_INIT, newref =3D STRBUF_INIT, logmsg =3D =
STRBUF_INIT;
 	struct strbuf oldsection =3D STRBUF_INIT, newsection =3D STRBUF_INIT;
 	const char *interpreted_oldname =3D NULL;
 	const char *interpreted_newname =3D NULL;
-	int recovery =3D 0, oldref_is_head, oldref_is_orphan;
+	int recovery =3D 0, oldref_is_head =3D 0, oldref_is_orphan =3D 0;
+	struct worktree **worktrees;
+	int i;
+	const char *target;
=20
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -537,8 +508,29 @@ static void copy_or_rename_branch(const char *oldname,=
 const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
=20
-	oldref_is_head =3D die_if_branch_is_being_rebased_or_bisected(oldref.buf);
-	oldref_is_orphan =3D (oldref_is_head > 1);
+	worktrees =3D get_worktrees();
+	target =3D oldref.buf;
+	for (i =3D 0; worktrees[i]; i++) {
+		struct worktree *wt =3D worktrees[i];
+
+		if (wt->head_ref && !strcmp(target, wt->head_ref)) {
+			oldref_is_head =3D 1;
+			if (is_null_oid(&wt->head_oid))
+				oldref_is_orphan =3D 1;
+		}
+
+		if (!wt->is_detached)
+			continue;
+
+		if (is_worktree_being_rebased(wt, target))
+			die(_("Branch %s is being rebased at %s"),
+			    target, wt->path);
+
+		if (is_worktree_being_bisected(wt, target))
+			die(_("Branch %s is being bisected at %s"),
+			    target, wt->path);
+	}
+	free_worktrees(worktrees);
=20
 	if ((copy || !oldref_is_head) &&
 	    (oldref_is_orphan || !ref_exists(oldref.buf)))
@@ -858,10 +850,12 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
=20
-		if (!ref_exists(branch->refname))
-			die((!argc || branch_checked_out(branch->refname))
-			    ? _("No commit on branch '%s' yet.")
-			    : _("branch '%s' does not exist"), branch->name);
+		if (!ref_exists(branch->refname)) {
+			if (!argc || branch_checked_out(branch->refname))
+				die(_("No commit on branch '%s' yet."), branch->name);
+			die(_("branch '%s' does not exist"), branch->name);
+		}
+=09=09
=20
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,

=3D=3D END

P.S. if I were refactoring those ?: for style in that function I'd
probably go for this on-top. The N_() followed by _() pattern is
probably overdoing it, but included to show that one way out of this
sort of thing with i18n is that you can pre-mark the string with N_(),
then use it with _() to emit the message (right now the code uses
"copy?" over "copy ?" instead to align them):

diff --git a/builtin/branch.c b/builtin/branch.c
index dc7a3e3dde1..e42f9bc4900 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -805,31 +805,35 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 		}
=20
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
-		if (!ref_exists(branch_ref.buf))
-			error((!argc || branch_checked_out(branch_ref.buf))
-			      ? _("No commit on branch '%s' yet.")
-			      : _("No branch named '%s'."),
-			      branch_name);
-		else if (!edit_branch_description(branch_name))
+		if (!ref_exists(branch_ref.buf)) {
+			if (!argc || branch_checked_out(branch_ref.buf))
+				error(_("No commit on branch '%s' yet."),
+				      branch_name);
+			else
+				error(_("No branch named '%s'."), branch_name);
+		} else if (!edit_branch_description(branch_name)) {
 			ret =3D 0; /* happy */
+		}
=20
 		strbuf_release(&branch_ref);
 		strbuf_release(&buf);
=20
 		return ret;
 	} else if (copy || rename) {
+		static const char *cannot_copy =3D N_("cannot copy the current branch wh=
ile not on any.");
+		static const char *cannot_rename =3D N_("cannot rename the current branc=
h while not on any.");
 		if (!argc)
 			die(_("branch name required"));
 		else if ((argc =3D=3D 1) && filter.detached)
-			die(copy? _("cannot copy the current branch while not on any.")
-				: _("cannot rename the current branch while not on any."));
+			die("%s", copy ? _(cannot_copy) : _(cannot_rename));
 		else if (argc =3D=3D 1)
 			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
 		else if (argc =3D=3D 2)
 			copy_or_rename_branch(argv[0], argv[1], copy, copy + rename > 1);
+		else if (copy)
+			die(_("too many branches for a copy operation"));
 		else
-			die(copy? _("too many branches for a copy operation")
-				: _("too many arguments for a rename operation"));
+			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch;
 		struct strbuf buf =3D STRBUF_INIT;
=20
