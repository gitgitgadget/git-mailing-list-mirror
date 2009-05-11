From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Mon, 11 May 2009 21:55:32 +0200
Message-ID: <20090511195532.GA28340@pengutronix.de>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de> <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bba-0004dS-Ie
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbZEKTzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbZEKTzd
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:55:33 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56840 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbZEKTzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:55:32 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3bb3-0002sU-3u; Mon, 11 May 2009 21:55:33 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M3bb2-0003sm-Rh; Mon, 11 May 2009 21:55:32 +0200
Content-Disposition: inline
In-Reply-To: <20090511032813.GA15540@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118837>

Hi Marc,

just some random nitpicks on top of your patch:

diff --git a/tg-push.sh b/tg-push.sh
index 0fa7854..8897a18 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -8,7 +8,7 @@ remotes=3D
=20
 recurse_deps=3Dtrue
 tgish_deps_only=3Dfalse
-dry_run=3Dfalse
+dry_run=3D
=20
 while [ -n "$1" ]; do
 	arg=3D"$1"; shift
@@ -16,11 +16,11 @@ while [ -n "$1" ]; do
 	--no-deps)
 		recurse_deps=3Dfalse;;
 	--dry-run)
-		dry_run=3Dtrue;;
+		dry_run=3D"--dry-run";;
 	--tgish-only)
 		tgish_deps_only=3Dtrue;;
 	-h|--help)
-		echo "Usage: tg push [(--dry-run | --no-deps | --tgish-only)] [-r "r=
emote remote2"]* branch*"
+		echo "Usage: tg push [--dry-run] [--no-deps] [--tgish-only] [-r "rem=
ote remote2"]* branch*"
 		exit 1;;
 	-r)
 		remotes=3D"$remotes $1"
@@ -44,12 +44,12 @@ if [ -z "$branches" ]; then
 fi
=20
 for name in $branches; do
-	ref_exists "$name" || die "detached HEAD? Can't push that"
+	ref_exists "$name" || die "detached HEAD? Can't push $name"
 done
=20
 push_branch(){
 	# if so desired omit non tgish deps
-	 $tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
+	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
=20
 	echo "$_dep"
 	local base=3D"top-bases/$_dep"
@@ -73,10 +73,6 @@ for remote in $remotes; do
 			push_branch "$name"
 		)"
 		echo "pushing:"; echo $list
-		if $dry_run; then
-			echo git push $remote $list
-		else
-			git push $remote $list
-		fi
+		git push $dry_run "$remote" $list
 	done
 done
--=20
1.6.2.4

It's untested, but I think it should be enough if it is eyeballed by
someone else.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
