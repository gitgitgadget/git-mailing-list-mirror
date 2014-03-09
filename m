From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] rebase: new convenient option to edit/reword/delete a single commit
Date: Sun,  9 Mar 2014 09:49:14 +0700
Message-ID: <1394333354-16257-1-git-send-email-pclouds@gmail.com>
References: <53159601.8020702@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, philipoakley@iee.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 03:49:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMTnj-00051y-LI
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 03:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaCICsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2014 21:48:51 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63562 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaCICsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 21:48:50 -0500
Received: by mail-pb0-f43.google.com with SMTP id um1so5784242pbc.16
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 18:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+KfGB4AL6B/6TeC8EfJGY6adoxsD0/G/FT15cMCzF6c=;
        b=HaJx6m500hZIyZSdB2dfU5iPlTe2S2qYovIRd40N4LoOfEEMgC5gYmGZdhfCLCtbJd
         hKmVH6wK545hWCqYadFOv95LriZ+EIlXQH8elU0GCZjSl+xXR+++DzkwcnBd/1R4i9fk
         0AA8qLDyDPrbGtKZ+mYWqM+eI1SpBT+9Ux/z7JPyfJO/VmJoBVFC9TmAqH0XTKLUnsvW
         Hy1mbayLmqRGvOc5NhK8k3dPGGCsq5WPRWnOoECW182d9uClmkMz4G3n4BPjeb+SeSc8
         HJwDhpI5kwibvPnFVPXWtI4u6zPKKoyhlcHQF4kFBCDtz6NQFfGxwVz3PZJtSmmiFZIr
         qJog==
X-Received: by 10.66.27.48 with SMTP id q16mr31946525pag.9.1394333329828;
        Sat, 08 Mar 2014 18:48:49 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id db3sm51217193pbb.10.2014.03.08.18.48.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Mar 2014 18:48:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Mar 2014 09:49:22 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <53159601.8020702@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243687>

Prepare the todo list for you to edit/reword/delete the given commit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Allowing multiple actions is a bit too much for my shell skills. I
 don't really need it so I won't push it, but if somebody gives me a
 sketch, I'll try to polish it.

 --squash and --fixup would require two commits, making it a bit
 awkward in option handling. Or is the fixup/squash always HEAD?

 Documentation/git-rebase.txt | 11 +++++++++++
 git-rebase--interactive.sh   | 17 ++++++++++++++---
 git-rebase.sh                | 22 +++++++++++++++++++++-
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 2a93c64..becb749 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <ne=
wbase>]
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --edit-todo
+'git rebase' [--edit | -E | --reword | -R | --delete | -D ] <commit-is=
h>
=20
 DESCRIPTION
 -----------
@@ -356,6 +357,16 @@ unless the `--fork-point` option is specified.
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see SPLITTING COMMITS below).
=20
+-E=3D<commit>::
+--edit=3D<commit>::
+-R=3D<commit>::
+--reword=3D<commit>::
+-D=3D<commit>::
+--delete=3D<commit>::
+	Prepare the todo list to edit or reword or delete the
+	specified commit. Configuration variable `rebase.autostash` is
+	ignored.
+
 -p::
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a1adae8..3ded4c7 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1040,9 +1040,20 @@ fi
 has_action "$todo" ||
 	die_abort "Nothing to do"
=20
-cp "$todo" "$todo".backup
-git_sequence_editor "$todo" ||
-	die_abort "Could not execute editor"
+if test -n "$one_action"
+then
+	commit=3D"`git rev-parse --short $one_commit`"
+	sed "1s/pick $commit /$one_action $commit /" "$todo" > "$todo.new" ||
+		die_abort "failed to update todo list"
+	grep "^$one_action $commit " "$todo.new" >/dev/null ||
+		die_abort "expected to find '$one_action $commit' line but did not"
+	mv "$todo.new" "$todo" ||
+		die_abort "failed to update todo list"
+else
+	cp "$todo" "$todo".backup
+	git_sequence_editor "$todo" ||
+		die_abort "Could not execute editor"
+fi
=20
 has_action "$todo" ||
 	die_abort "Nothing to do"
diff --git a/git-rebase.sh b/git-rebase.sh
index 5f6732b..2acffb4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -32,6 +32,9 @@ verify             allow pre-rebase hook to run
 rerere-autoupdate  allow rerere to update index with resolved conflict=
s
 root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -=
i
+E,edit=3D!           generate todo list to edit this commit
+R,reword=3D!         generate todo list to reword this commit's messag=
e
+D,delete=3D!         generate todo list to delete this commit
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
 whitespace=3D!       passed to 'git apply'
@@ -228,6 +231,7 @@ then
 fi
 test -n "$type" && in_progress=3Dt
=20
+one_action=3D
 total_argc=3D$#
 while test $# !=3D 0
 do
@@ -290,6 +294,7 @@ do
 		;;
 	--autostash)
 		autostash=3Dtrue
+		explicit_autosquash=3Dt
 		;;
 	--verbose)
 		verbose=3Dt
@@ -335,6 +340,13 @@ do
 	--gpg-sign=3D*)
 		gpg_sign_opt=3D"-S${1#--gpg-sign=3D}"
 		;;
+	--edit=3D*|--reword=3D*|--delete=3D*)
+		test -n "$one_action" && die "$(gettext "--edit, --reword or --delet=
e cannot be used multiple times")"
+		interactive_rebase=3Dexplicit
+		one_action=3D"${1%=3D*}"
+		one_action=3D"${one_action#--}"
+		one_commit=3D"${1#--*=3D}"
+		;;
 	--)
 		shift
 		break
@@ -342,6 +354,7 @@ do
 	esac
 	shift
 done
+test -n "$one_action" && test $# -gt 0 && usage
 test $# -gt 2 && usage
=20
 if test -n "$cmd" &&
@@ -438,7 +451,14 @@ else
 	state_dir=3D"$apply_dir"
 fi
=20
-if test -z "$rebase_root"
+if test -n "$one_action"
+then
+	upstream_name=3D"$one_commit^"
+	upstream=3D$(peel_committish "${upstream_name}") ||
+	die "$(eval_gettext "invalid upstream \$upstream_name")"
+	upstream_arg=3D"$upstream_name"
+	test -n "$explicit_autosquash" || autosquash=3D
+elif test -z "$rebase_root"
 then
 	case "$#" in
 	0)
--=20
1.9.0.40.gaa8c3ea
