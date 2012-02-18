From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH] completion: remote set-* <name> and <branch>
Date: Sat, 18 Feb 2012 14:32:53 +0100
Message-ID: <1329571973-20796-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 18 14:34:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RykQj-0002Gb-SB
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 14:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab2BRNeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Feb 2012 08:34:20 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34756 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989Ab2BRNeU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2012 08:34:20 -0500
Received: by lagu2 with SMTP id u2so4788473lag.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 05:34:18 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.112.88.10 as permitted sender) client-ip=10.112.88.10;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.112.88.10 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.112.88.10])
        by 10.112.88.10 with SMTP id bc10mr4394491lbb.60.1329572058596 (num_hops = 1);
        Sat, 18 Feb 2012 05:34:18 -0800 (PST)
Received: by 10.112.88.10 with SMTP id bc10mr3659507lbb.60.1329572058521;
        Sat, 18 Feb 2012 05:34:18 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id il7sm11500200lbb.9.2012.02.18.05.34.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 05:34:17 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.245.g4cbe6
X-Gm-Message-State: ALoCoQkxUbFqCI4nPRrUKfucnJ1mtW4M0S3c/kR8rTZGimH5GT2v4370lrkgDMDh9p3Kl04ylBt5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191008>

Complete <name> only for set-url. For set-branches and
set-head, complete <name> and <branch> over the network,
like e.g. git pull already does.

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 contrib/completion/git-completion.bash |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 1505cff..8e7abb6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -738,6 +738,9 @@ __git_complete_remote_or_refspec ()
 {
 	local cur_=3D"$cur" cmd=3D"${words[1]}"
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
+	if [ "$cmd" =3D "remote" ]; then
+		c=3D$((++c))
+	fi
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
@@ -788,7 +791,7 @@ __git_complete_remote_or_refspec ()
 			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
 		fi
 		;;
-	pull)
+	pull|remote)
 		if [ $lhs =3D 1 ]; then
 			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
 		else
@@ -2289,7 +2292,7 @@ _git_config ()
=20
 _git_remote ()
 {
-	local subcommands=3D"add rename rm show prune update set-head"
+	local subcommands=3D"add rename rm set-head set-branches set-url show=
 prune update"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2297,9 +2300,12 @@ _git_remote ()
 	fi
=20
 	case "$subcommand" in
-	rename|rm|show|prune)
+	rename|rm|set-url|show|prune)
 		__gitcomp_nl "$(__git_remotes)"
 		;;
+	set-head|set-branches)
+		__git_complete_remote_or_refspec
+		;;
 	update)
 		local i c=3D'' IFS=3D$'\n'
 		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "remote=
s\..*" 2>/dev/null); do
--=20
1.7.9.1.245.g4cbe6
