From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 14/19] bash prompt: use bash builtins to find out current
	branch during rebase
Date: Wed,  9 May 2012 02:44:45 +0200
Message-ID: <1336524290-30023-15-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv3q-0005NI-H5
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab2EIArR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:47:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52058 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab2EIArQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:47:16 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MbF3n-1SheWO2Tn9-00Kt3U; Wed, 09 May 2012 02:47:07 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:U99KKZ+XPpWKxELC2CmINl/asUzSH5Py3x7PYZElk7l
 w+ecqP/XNRJ6tllZMUg2lzUxcG7GEOU53DhT7dyJ4NqfqsivfI
 EDd8D5QvgjvEuPjjTqAYPpiP7gvWu5KnT6unzfLyfZ8xhLZS+i
 2J308R7WbpbJjVWxQ1z2S8fa16IW1uT9VNNyXbgTo7GE3xSToQ
 8Wa9AW4b/0de8Z8v4AXHWAAx73CHGZt9CDPYETkRRTMNlWoWaV
 C7EarWa+Q7i68dkcpFs2bth2kVYIa5xDJeGkM9zomFL1hrHv+b
 SHUGFWmtUK0EIcvwM2XobHPvXOz+Y/r7BRMvtUue2UoTiKPOCr
 0qbBQ18Rv5rETgUJSl6Ki88whaF+nGUNZW/iRpABgt8CcdtAva
 qqfMteA62tQ7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197447>

During an ongoing interactive rebase __git_ps1() finds out the name of
the rebased branch by executing the '$(cat .git/rebase-merge/head-name)=
'
command substitution.  That is not quite the most efficient way to
read a single line single word file, because it imposes the overhead
of fork()ing a subshell and fork()+exec()ing 'cat'.

Use the 'read' bash builtin instead to avoid that overhead.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 64b96f13..671032bf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -272,10 +272,10 @@ __git_ps1 ()
 	local b=3D""
 	if [ -f "$__git_dir/rebase-merge/interactive" ]; then
 		r=3D"|REBASE-i"
-		b=3D"$(cat "$__git_dir/rebase-merge/head-name")"
+		read b <"$__git_dir/rebase-merge/head-name"
 	elif [ -d "$__git_dir/rebase-merge" ]; then
 		r=3D"|REBASE-m"
-		b=3D"$(cat "$__git_dir/rebase-merge/head-name")"
+		read b <"$__git_dir/rebase-merge/head-name"
 	else
 		if [ -d "$__git_dir/rebase-apply" ]; then
 			if [ -f "$__git_dir/rebase-apply/rebasing" ]; then
--=20
1.7.10.1.541.gb1be298
