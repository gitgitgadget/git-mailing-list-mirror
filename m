From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Mon, 11 May 2009 05:28:13 +0200
Message-ID: <20090511032813.GA15540@gmx.de>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de> <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 05:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3MBw-00024z-CN
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 05:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZEKD22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 23:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZEKD22
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 23:28:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:52662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751888AbZEKD21 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2009 23:28:27 -0400
Received: (qmail invoked by alias); 11 May 2009 03:28:25 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp049) with SMTP; 11 May 2009 05:28:25 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/vAoNmzFnv7hqN+n5edMMSowrghXclB9nJMGQhgo
	Vs8KrRnYdeoBPy
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 11 May 2009 05:28:13 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090509190910.GA9655@gmx.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118770>

=46eedback to Berts reply:

  > tg-push first. And where is the --dry-run option?
  fixed: added -h|--help option

  >This phrase needs rewording, what about: "its deps, both their tgish
  >and non-tgish ones."
  fixed, used Uwes text.

  It looks like this now:

          $tg push remote
          to push the current branch, its deps and, both their tgish
          and non-tgish ones.  You may add --no-deps and or --tgish-onl=
y
          to change this default behaviour. Use these only if you know =
what you
          are doing. They are only present for the sake of completeness=
=2E


  >now i see why you have the Usage: in the README. common practice is =
to
  >print the usage if an unknown option was given. see all the other
  >tg-*.sh scripts.
  fixed: see -h|--help above. tg export lists the Usage as well in the =
README. (-> other topic)



  >How effetcts the tg -r REMOTE option this command. Or more exactly w=
hy
  >doesn't have this option an effect here?
  laziness. I thought about that myself. Its fixed now. Usage looks lik=
e this:

    Usage: tg push [(--dry-run | --no-deps | --tgish-only)] [-r "remote=
 remote2"]* branch*


  > the common error message is: "not a TopGit-controlled branch".
  :-) The point about this is: You can use
    $tg push -r "remote1 remote2" non-tgish-branch1 non-tgish-branch2.
  tg push will note that it can't find remotes but it'll push those bra=
nches.
  So you can "abuse" tg push to push normal branches to multiple remote
  locations.

  > why not pass the --dry-run option to git remote?
  git remote -> git push:
  I added --dry-run so that I can see the list of branches which would =
be pushed
  if I had not used --dry-run. It isn't that important that's why I mis=
sed adding
  it to Usage as well.

 =20
=46eedback to Uwe Klein Koenigs mail:

  > I'd like to have a bit more prose.  Something like:
  fixed/misus


  > maybe extend the comment to something like:

  >         # if a remote is used ('topgit.remote' configuration variab=
le or
  >         # tg -r $remote, a tg-base implicitly depends on
  >         # refs/remotes/$remote/top-bases/$_dep.  Don't push these.

  > You could even test if this is a dependency as described in this
  > comment.  Didn't test it, but something like

  >         test "x$_dep" =3D "xrefs/remotes/$base_remote/top-bases/$_n=
ame"

  > could do the trick.

  I've extended the recurse_deps function reading from the global var
  no_remotes now. It's still ugly but less verbose and more intuitive t=
han
  adding long comments



  > > + =C2=A0 =C2=A0 =C2=A0 [ -z "$tgish_deps_only" ] || [ -n "$_dep_i=
s_tgish" ] || return 0
  >I've always problems to understand these constructs.  Are these any
  >better than
  ... :-) *lol* You proposed using them :-)
  I do have a vary hard time reading writing them as well.
  I have to use boolean algebra to wrap my head around those constructs=
=2E


  > > + =C2=A0 =C2=A0 =C2=A0 echo "$_dep"
  > > + =C2=A0 =C2=A0 =C2=A0 local base=3D"top-bases/$_dep"
  > > + =C2=A0 =C2=A0 =C2=A0 if ref_exists "$base"; then
  > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "top-base=
s/$_dep"
  > > + =C2=A0 =C2=A0 =C2=A0 else
  > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "warning,=
 no base found $base" 1>&2
  > > + =C2=A0 =C2=A0 =C2=A0 fi
  >mmh, I wonder why you need to do the top-bases explicitly.  recurse_=
deps
  >doesn't that for you?
  Have a closer look at that function, please:
    "
      has_remote "top-bases/$_name" && [ -z "$no_remotes" ] &&
              echo "refs/remotes/$base_remote/top-bases/$_name" >>"$_de=
psfile"
      [..]
      ref_exists "refs/top-bases/$_dep"  ||
    "
  are all occurrences of top-bases. And both only do checks (or push re=
motes)



=46eedback to Berts 2nd reply:

  >I also like the true/false style, its also useable with the current =
'scheme':
  >    $tgish_deps_only && ... =20
  great idea. true/false are sh builtins. adopted. I still prefer
  [ foo -a bar ]; or [ foo -o bar ]; for readability.

Sincerly
Marc Weber

commit cdab940eefc0a56e0daa8b270bace1aba00a3b57
Author: Marc Weber <marco-oweber@gmx.de>
Date:   Mon May 11 05:25:40 2009 +0200

    t/tg-push
   =20
    add tg-push  pushing the branch, its deps and their bases
   =20
    Signed-off-by: Marc Weber <marco-oweber@gmx.de>

diff --git a/.gitignore b/.gitignore
index eb56446..2f6d991 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,6 +21,8 @@
 /tg-import.txt
 /tg-remote
 /tg-remote.txt
+/tg-push
+/tg-push.txt
 /tg
 .*.swp
=20
diff --git a/README b/README
index d2f095d..495c70b 100644
--- a/README
+++ b/README
@@ -480,6 +480,12 @@ tg update
=20
 	TODO: tg update -a for updating all topic branches
=20
+tg push
+~~~~~~~
+	pushes a TopGit-controlled topic branch to a remote
+	repository.  By default the remote gets all dependencies
+	(both tgish and non-tgish) and bases pushed to.
+
 TODO: tg rename
=20
=20
diff --git a/tg-push.sh b/tg-push.sh
new file mode 100644
index 0000000..0fa7854
--- /dev/null
+++ b/tg-push.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# GPLv2
+
+remotes=3D
+
+## Parse options see README
+
+recurse_deps=3Dtrue
+tgish_deps_only=3Dfalse
+dry_run=3Dfalse
+
+while [ -n "$1" ]; do
+	arg=3D"$1"; shift
+	case "$arg" in
+	--no-deps)
+		recurse_deps=3Dfalse;;
+	--dry-run)
+		dry_run=3Dtrue;;
+	--tgish-only)
+		tgish_deps_only=3Dtrue;;
+	-h|--help)
+		echo "Usage: tg push [(--dry-run | --no-deps | --tgish-only)] [-r "r=
emote remote2"]* branch*"
+		exit 1;;
+	-r)
+		remotes=3D"$remotes $1"
+		shift
+		;;
+	*)
+		branches=3D"$branches $arg";;
+	esac
+done
+
+if [ -z "$remotes" ]; then
+	remotes=3D"$(git config topgit.remote 2>/dev/null)"
+fi
+
+if [ -z "$remotes" ]; then
+	die "no remote location given. Either use -r remote argument or set t=
opgit.remote"
+fi
+
+if [ -z "$branches" ]; then
+	branches=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+fi
+
+for name in $branches; do
+	ref_exists "$name" || die "detached HEAD? Can't push that"
+done
+
+push_branch(){
+	# if so desired omit non tgish deps
+	 $tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
+
+	echo "$_dep"
+	local base=3D"top-bases/$_dep"
+	if ref_exists "$base"; then
+		echo "top-bases/$_dep"
+	else
+		echo "warning, no base found $base" 1>&2
+	fi
+}
+
+for remote in $remotes; do
+	for name in $branches; do
+		list=3D"$(
+			# deps
+			if $recurse_deps; then
+				no_remotes=3D1 recurse_deps push_branch "$name"
+			fi
+			# current branch
+			_dep=3D"$name"
+			_dep_is_tgish=3D1
+			push_branch "$name"
+		)"
+		echo "pushing:"; echo $list
+		if $dry_run; then
+			echo git push $remote $list
+		else
+			git push $remote $list
+		fi
+	done
+done
diff --git a/tg.sh b/tg.sh
index 0804f73..94f38f4 100644
--- a/tg.sh
+++ b/tg.sh
@@ -136,6 +136,7 @@ branch_annihilated()
 # of the whole function.
 # If recurse_deps() hits missing dependencies, it will append
 # them to space-separated $missing_deps list and skip them.
+# set no_remotes to any value to omit remote dependencies (-> tg push)
 recurse_deps()
 {
 	_cmd=3D"$1"; shift
@@ -145,9 +146,8 @@ recurse_deps()
 	_depsfile=3D"$(mktemp -t tg-depsfile.XXXXXX)"
 	# Check also our base against remote base. Checking our head
 	# against remote head has to be done in the helper.
-	if has_remote "top-bases/$_name"; then
+	has_remote "top-bases/$_name" && [ -z "$no_remotes" ] &&
 		echo "refs/remotes/$base_remote/top-bases/$_name" >>"$_depsfile"
-	fi
=20
 	# if the branch was annihilated, there exists no .topdeps file
 	if ! branch_annihilated "$_name"; then
