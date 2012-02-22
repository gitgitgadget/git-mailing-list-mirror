From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH 1/4] completion: remote set-* <name> and <branch>
Date: Wed, 22 Feb 2012 09:58:10 +0100
Message-ID: <1329901093-24106-2-git-send-email-philip@foolip.org>
References: <20120222001737.GB2228@goldbirke>
 <1329901093-24106-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 09:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S082N-0006Gb-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 09:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab2BVI6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 03:58:43 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54339 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753759Ab2BVI6l (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 03:58:41 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so8716873lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 00:58:40 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.152.123.68 as permitted sender) client-ip=10.152.123.68;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.152.123.68 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.152.123.68])
        by 10.152.123.68 with SMTP id ly4mr21821912lab.13.1329901120306 (num_hops = 1);
        Wed, 22 Feb 2012 00:58:40 -0800 (PST)
Received: by 10.152.123.68 with SMTP id ly4mr18308937lab.13.1329901120228;
        Wed, 22 Feb 2012 00:58:40 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id ot2sm24473095lab.3.2012.02.22.00.58.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 00:58:39 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329901093-24106-1-git-send-email-philip@foolip.org>
X-Gm-Message-State: ALoCoQmSNopktuM9StSOJ9ti4mdhj/IBMQOs33Tbyuw3/Swz+fMEPBBfl9DbvRWTfec/fvThNIPK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191238>

Complete <name> only for set-url. For set-branches and
set-head, complete <name> and <branch> over the network,
like e.g. git pull already does.

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 contrib/completion/git-completion.bash |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ab24310..c63a408 100755
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
1.7.5.4
