From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/5] completion: fix non-critical bugs in __gitcomp() tests
Date: Fri, 28 Sep 2012 12:09:31 +0200
Message-ID: <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
References: <20120928100530.GL10144@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 12:10:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THXWI-0005Tt-MN
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 12:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab2I1KJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 06:09:57 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:49552 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab2I1KJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 06:09:56 -0400
Received: from localhost6.localdomain6 (p5B130716.dip0.t-ipconnect.de [91.19.7.22])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lsz0c-1TT86z0iPi-011zkZ; Fri, 28 Sep 2012 12:09:55 +0200
X-Mailer: git-send-email 1.7.12.1.438.g7dfa67b
In-Reply-To: <20120928100530.GL10144@goldbirke>
X-Provags-ID: V02:K0:BQMMb4oTvcm5baEMqtFTlXWFhouFKijQama+J4+9ab+
 GcrsA4e9XF3orrrEkczeBAXPPrBCYgHrZVtbYBVMOYO0SghAQH
 GeSCFrMnhbeIUk/l+X47qgTW5qY+J3B4TWiImxE5iCSsiqtg7W
 qbNFFqBSDud2hjlQWxJETR6Qex1He2O9MliDFa33XuxrPz7SH8
 enLOZV5xW1bTRCALCEMeufIlDVHRFO9I6RoNNqZKtVPozwbLJo
 Cu53w0Xc544mWTeOMKOT90FA6sszXCk9OeIAwBUyBn3v6bDsbC
 JSH+ruINyx4DLB6qSJSJO2MNHN4CQGgEZIJTKJdHWCURSCMqbR
 EUdohO+Q/Oe5yfmtBfdfoJ6VCidvqnCYN/UJd6Mycsb4DfM502
 XxMYQWdXmAsvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206549>

When invoking __gitcomp() the $cur variable should hold the word to be
completed, but two tests (checking the handling of prefix and suffix)
set it to a bogus value.

Luckily the bogus values haven't influenced the tests' correctness,
because these two tests pass the word-to-be-matched as argument to
__gitcomp(), which overrides $cur anyway.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 92d7eb47..e7657537 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -121,7 +121,7 @@ test_expect_success '__gitcomp - prefix' '
 	EOF
 	(
 		local -a COMPREPLY &&
-		cur=3D"branch.me" &&
+		cur=3D"branch.maint.me" &&
 		__gitcomp "remote merge mergeoptions rebase
 			" "branch.maint." "me" &&
 		IFS=3D"$newline" &&
@@ -137,7 +137,7 @@ test_expect_success '__gitcomp - suffix' '
 	EOF
 	(
 		local -a COMPREPLY &&
-		cur=3D"branch.me" &&
+		cur=3D"branch.ma" &&
 		__gitcomp "master maint next pu
 			" "branch." "ma" "." &&
 		IFS=3D"$newline" &&
--=20
1.7.12.1.438.g7dfa67b
