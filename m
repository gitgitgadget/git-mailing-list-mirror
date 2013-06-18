From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] fixup! bash prompt: use bash builtins to find out current
 branch
Date: Tue, 18 Jun 2013 12:01:38 +0200
Message-ID: <1371549698-16826-1-git-send-email-szeder@ira.uka.de>
References: <20130618094931.GB2204@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 12:02:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uosjs-00058B-KD
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab3FRKCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:02:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54192 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab3FRKCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:02:05 -0400
Received: from localhost6.localdomain6 (g230129165.adsl.alicedsl.de [92.230.129.165])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MFn1t-1V3PTC3e2n-00FCcW; Tue, 18 Jun 2013 12:02:04 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <20130618094931.GB2204@goldbirke>
X-Provags-ID: V02:K0:YUHbSw2sVdNjmokj6Pg4w9BKE5jUOYxacZpC+du1/h/
 7i+su8e0+6zSs+Fy+Qs3qzDhDUhPP7GU1IApZA2Xo4DNbD5x35
 t+FcL3lsOqkeHEyeVvEnUbWRWcJ+NnjfdwSNIjqGTdVbuJg8rs
 rVlyNC186QasUb1mEIQ1Xg9/Py0ZVjPgsjP5t/1VnSB70oMV5F
 YGJOzo8Tqv10RTHHXEiRS5uf6qzt1X3JNfAhvC4rOO2TpJfB2h
 ydFcKvUi3NfI39D4W8V2zYzCfikbzNkkLcFemskiG3vmJJeufO
 bvVqXsJmkJbGmqRLekDlQWyoyYsjsi4HJtmR4qzLtBDT03eWok
 hSu9z7tV89fuaCQuVldUeAvYNsd4cJUj1XuarxrcFG8xM6koKj
 KV9tuqJ+7n3xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228183>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

---
On Tue, Jun 18, 2013 at 11:49:31AM +0200, SZEDER G=C3=A1bor wrote:
> (Hmm, speaking of which, the
> patch reading HEAD might break setups using $PROMPT_COMMAND, because
> it might do a simple return without updating $PS1...)

Indeed.  Here's the fixup.

 contrib/completion/git-prompt.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 4e5c8efa..3c8c7b0d 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -362,7 +362,12 @@ __git_ps1 ()
 			b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
 		else
 			local head=3D""
-			read head 2>/dev/null <"$g/HEAD" || return
+			if ! read head 2>/dev/null <"$g/HEAD"; then
+				if [ $pcmode =3D yes ]; then
+					PS1=3D"$ps1pc_start$ps1pc_end"
+				fi
+				return
+			fi
 			# is it a symbolic ref?
 			b=3D"${head#ref: }"
 			if [ "$head" =3D "$b" ]; then
--=20
1.8.3.1.487.g8f4672d
