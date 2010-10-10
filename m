From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: not all 'git bisect' subcommands make sense when
	not bisecting
Date: Sun, 10 Oct 2010 23:39:34 +0200
Message-ID: <1286746774-7877-2-git-send-email-szeder@ira.uka.de>
References: <1286746774-7877-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:39:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53cb-0002vY-H2
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab0JJVjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:39:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52642 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab0JJVjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:39:48 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MPKs8-1P0dlT2FG4-0053O7; Sun, 10 Oct 2010 23:39:39 +0200
X-Mailer: git-send-email 1.7.3.1.148.g2fffa
In-Reply-To: <1286746774-7877-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:hZqrBNck8h3HzLexskg2TOT8z4aTwAg+RPEN2L7btAc
 Nb/YcGMtC2u6SKba2HrLxQP6OemMNH07E+uRXC06t177wg2MwW
 1M9TN9F83JCOVbEbPYEHP9OCNwuHdHrwcWyXR15PbwHczS0+xn
 JsEdLW7PxEbgNOi/y33hYZMOTjAWXPeq5mY7gJ2EG4NXYi+m/1
 izhJQf8XputG0Zfb1zGuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158715>

=2E.. but only 'start' and 'replay'.  The other commands will either
error out or offer to start bisecting for the user.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index eb8ef47..1262f72 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -907,7 +907,11 @@ _git_bisect ()
 	local subcommands=3D"start bad good skip reset visualize replay log r=
un"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
+		if [ -f "$(__gitdir)"/BISECT_START ]; then
+			__gitcomp "$subcommands"
+		else
+			__gitcomp "replay start"
+		fi
 		return
 	fi
=20
--=20
1.7.3.1.148.g2fffa
