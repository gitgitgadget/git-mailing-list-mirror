From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: support pretty format aliases
Date: Sun, 10 Oct 2010 23:34:21 +0200
Message-ID: <1286746461-7338-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:35:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53Xr-0000tL-SO
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab0JJVea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:34:30 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:50988 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0JJVea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:34:30 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0M6RLT-1OlBJA0Ipv-00yBju; Sun, 10 Oct 2010 23:34:27 +0200
X-Mailer: git-send-email 1.7.3.1.148.g2fffa
X-Provags-ID: V02:K0:H8/gsOKJ7eBRFgugG5901wOpinFtB8Mj0E0TJwndrfS
 JVwrXi5gLOsBa9VoWb9D7wgC6QKApVNmf+Hg02cfAsX4bu4rgQ
 M2vnB6/u2KaHxcMAgUjpMd3ocykKBdb9RbkEDNjXVjfm/Yb14z
 ERNkX4WgSs4Sn71Z4a5MBnE+n5GcA18NnMAxHHMU/Q7Ug3JG2A
 SA1wLKhysyuSRL+Xvz+hA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158713>

Users can have their own pretty format aliases since 8028184 (pretty:
add aliases for pretty formats, 2010-05-02), so let's offer those
after '--pretty=3D', too.

Similar to the completion of aliases, this will invoke 'git config'
each time pretty aliases needs to be completed, so changes in pretty.*
configuration will be reflected immediately.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6756990..3022213 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1368,7 +1368,16 @@ _git_log ()
 	fi
 	case "$cur" in
 	--pretty=3D*)
-		__gitcomp "$__git_log_pretty_formats
+		local pretty_aliases
+		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "pretty=
\..*" 2>/dev/null); do
+			case "$i" in
+			pretty.*)
+				i=3D"${i#pretty.}"
+				pretty_aliases=3D"$pretty_aliases ${i/ */}"
+				;;
+			esac
+		done
+		__gitcomp "$__git_log_pretty_formats $pretty_aliases
 			" "" "${cur##--pretty=3D}"
 		return
 		;;
--=20
1.7.3.1.148.g2fffa
