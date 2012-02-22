From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH 2/4] completion: normalize increment/decrement style
Date: Wed, 22 Feb 2012 09:58:11 +0100
Message-ID: <1329901093-24106-3-git-send-email-philip@foolip.org>
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
X-From: git-owner@vger.kernel.org Wed Feb 22 09:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S082O-0006Gb-Dc
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 09:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab2BVI6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 03:58:49 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54339 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754432Ab2BVI6s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 03:58:48 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so8716873lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 00:58:47 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.112.30.101 as permitted sender) client-ip=10.112.30.101;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.112.30.101 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.112.30.101])
        by 10.112.30.101 with SMTP id r5mr10984018lbh.90.1329901127479 (num_hops = 1);
        Wed, 22 Feb 2012 00:58:47 -0800 (PST)
Received: by 10.112.30.101 with SMTP id r5mr9107789lbh.90.1329901127400;
        Wed, 22 Feb 2012 00:58:47 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id ot2sm24473095lab.3.2012.02.22.00.58.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 00:58:46 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329901093-24106-1-git-send-email-philip@foolip.org>
X-Gm-Message-State: ALoCoQmkONOqFXHwSJvEQAA2MGmPQOZZHvgoFXaiuCMg4tuNanszNVXvprGzHGyivg522uxs6fJn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191239>

The style used for incrementing and decrementing variables was fairly
inconsistenty and was normalized to use x++, or ((x++)) in contexts
where the former would otherwise be interpreted as a command. This is a
bash-ism, but for obvious reasons this script is already bash-specific.

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 contrib/completion/git-completion.bash |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c63a408..1903bc9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -149,7 +149,7 @@ __git_ps1_show_upstream ()
 			svn_upstream=3D${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
 			svn_upstream=3D${svn_upstream%@*}
 			local n_stop=3D"${#svn_remote[@]}"
-			for ((n=3D1; n <=3D n_stop; ++n)); do
+			for ((n=3D1; n <=3D n_stop; n++)); do
 				svn_upstream=3D${svn_upstream#${svn_remote[$n]}}
 			done
=20
@@ -178,10 +178,8 @@ __git_ps1_show_upstream ()
 			for commit in $commits
 			do
 				case "$commit" in
-				"<"*) let ++behind
-					;;
-				*)    let ++ahead
-					;;
+				"<"*) ((behind++)) ;;
+				*)    ((ahead++))  ;;
 				esac
 			done
 			count=3D"$behind	$ahead"
@@ -739,7 +737,7 @@ __git_complete_remote_or_refspec ()
 	local cur_=3D"$cur" cmd=3D"${words[1]}"
 	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
 	if [ "$cmd" =3D "remote" ]; then
-		c=3D$((++c))
+		((c++))
 	fi
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
@@ -758,7 +756,7 @@ __git_complete_remote_or_refspec ()
 		-*) ;;
 		*) remote=3D"$i"; break ;;
 		esac
-		c=3D$((++c))
+		((c++))
 	done
 	if [ -z "$remote" ]; then
 		__gitcomp_nl "$(__git_remotes)"
@@ -998,7 +996,7 @@ __git_find_on_cmdline ()
 				return
 			fi
 		done
-		c=3D$((++c))
+		((c++))
 	done
 }
=20
@@ -1009,7 +1007,7 @@ __git_has_doubledash ()
 		if [ "--" =3D "${words[c]}" ]; then
 			return 0
 		fi
-		c=3D$((++c))
+		((c++))
 	done
 	return 1
 }
@@ -1132,7 +1130,7 @@ _git_branch ()
 		-d|-m)	only_local_ref=3D"y" ;;
 		-r)	has_r=3D"y" ;;
 		esac
-		c=3D$((++c))
+		((c++))
 	done
=20
 	case "$cur" in
@@ -2586,7 +2584,7 @@ _git_tag ()
 			f=3D1
 			;;
 		esac
-		c=3D$((++c))
+		((c++))
 	done
=20
 	case "$prev" in
@@ -2639,7 +2637,7 @@ _git ()
 		--help) command=3D"help"; break ;;
 		*) command=3D"$i"; break ;;
 		esac
-		c=3D$((++c))
+		((c++))
 	done
=20
 	if [ -z "$command" ]; then
--=20
1.7.5.4
