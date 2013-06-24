From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 06/16] bash prompt: return early from __git_ps1() when not
 in a git repository
Date: Mon, 24 Jun 2013 18:39:16 +0200
Message-ID: <1372091966-19315-7-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:43:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9rr-0003DY-Ly
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab3FXQnr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:43:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51358 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab3FXQnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:43:46 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Ljxmg-1UGSGW10N0-00c6OS; Mon, 24 Jun 2013 18:43:38 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:jLO3W7wh8+WFzss91MrDq5uNiwhwuwrz95Y7zbsnvz/
 sHc3BsvQl5kkUJZ0tG+Dnn2UGVtXdeZKXB784r5dkD4wQZakX6
 mKL0kh8EB17rI5V4SS6+fmVtLNWOFZRsV8D3m0aX2jd62egTzG
 CQCMNCJpnqxnnEkn5sokcyCAmt+ASlnUzsjnS71z9GT/rjztlq
 yJWDD/1hllMtVEViFmTDEROkPuNd4yCgYBy1SFY0yjEh2SfMIH
 rh3tyjZR4d539ygFj3Maz3PeeMQLujresRClWADWlK7uEvMNds
 UTm1cm8Xrq2MeKn9/wn5vhjCvXGOK8uSNYmwvZimP4czsA6Baq
 aX33O50nUVuW4p9Bmnl2KBIOv1HHYEBUpfdMNObFKEsYcSp6Xh
 PSEKj9XF0egwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228857>

=2E.. to gain one level of indentation for the bulk of the function.

(The patch looks quite unreadable, you'd better check it with 'git
diff -w'.)

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 201 ++++++++++++++++++++-----------=
--------
 1 file changed, 101 insertions(+), 100 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 3c5e62bb..a915b04c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -341,121 +341,122 @@ __git_ps1 ()
 			#In PC mode PS1 always needs to be set
 			PS1=3D"$ps1pc_start$ps1pc_end"
 		fi
+		return
+	fi
+
+	local r=3D""
+	local b=3D""
+	local step=3D""
+	local total=3D""
+	if [ -d "$g/rebase-merge" ]; then
+		b=3D"$(cat "$g/rebase-merge/head-name" 2>/dev/null)"
+		step=3D$(cat "$g/rebase-merge/msgnum" 2>/dev/null)
+		total=3D$(cat "$g/rebase-merge/end" 2>/dev/null)
+		if [ -f "$g/rebase-merge/interactive" ]; then
+			r=3D"|REBASE-i"
+		else
+			r=3D"|REBASE-m"
+		fi
 	else
-		local r=3D""
-		local b=3D""
-		local step=3D""
-		local total=3D""
-		if [ -d "$g/rebase-merge" ]; then
-			b=3D"$(cat "$g/rebase-merge/head-name" 2>/dev/null)"
-			step=3D$(cat "$g/rebase-merge/msgnum" 2>/dev/null)
-			total=3D$(cat "$g/rebase-merge/end" 2>/dev/null)
-			if [ -f "$g/rebase-merge/interactive" ]; then
-				r=3D"|REBASE-i"
+		if [ -d "$g/rebase-apply" ]; then
+			step=3D$(cat "$g/rebase-apply/next" 2>/dev/null)
+			total=3D$(cat "$g/rebase-apply/last" 2>/dev/null)
+			if [ -f "$g/rebase-apply/rebasing" ]; then
+				b=3D"$(cat "$g/rebase-apply/head-name" 2>/dev/null)"
+				r=3D"|REBASE"
+			elif [ -f "$g/rebase-apply/applying" ]; then
+				r=3D"|AM"
 			else
-				r=3D"|REBASE-m"
-			fi
-		else
-			if [ -d "$g/rebase-apply" ]; then
-				step=3D$(cat "$g/rebase-apply/next" 2>/dev/null)
-				total=3D$(cat "$g/rebase-apply/last" 2>/dev/null)
-				if [ -f "$g/rebase-apply/rebasing" ]; then
-					b=3D"$(cat "$g/rebase-apply/head-name" 2>/dev/null)"
-					r=3D"|REBASE"
-				elif [ -f "$g/rebase-apply/applying" ]; then
-					r=3D"|AM"
-				else
-					r=3D"|AM/REBASE"
-				fi
-			elif [ -f "$g/MERGE_HEAD" ]; then
-				r=3D"|MERGING"
-			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
-				r=3D"|CHERRY-PICKING"
-			elif [ -f "$g/REVERT_HEAD" ]; then
-				r=3D"|REVERTING"
-			elif [ -f "$g/BISECT_LOG" ]; then
-				r=3D"|BISECTING"
+				r=3D"|AM/REBASE"
 			fi
+		elif [ -f "$g/MERGE_HEAD" ]; then
+			r=3D"|MERGING"
+		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
+			r=3D"|CHERRY-PICKING"
+		elif [ -f "$g/REVERT_HEAD" ]; then
+			r=3D"|REVERTING"
+		elif [ -f "$g/BISECT_LOG" ]; then
+			r=3D"|BISECTING"
+		fi
=20
-			test -n "$b" ||
-			b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
-				detached=3Dyes
-				b=3D"$(
-				case "${GIT_PS1_DESCRIBE_STYLE-}" in
-				(contains)
-					git describe --contains HEAD ;;
-				(branch)
-					git describe --contains --all HEAD ;;
-				(describe)
-					git describe HEAD ;;
-				(* | default)
-					git describe --tags --exact-match HEAD ;;
-				esac 2>/dev/null)" ||
+		test -n "$b" ||
+		b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
+			detached=3Dyes
+			b=3D"$(
+			case "${GIT_PS1_DESCRIBE_STYLE-}" in
+			(contains)
+				git describe --contains HEAD ;;
+			(branch)
+				git describe --contains --all HEAD ;;
+			(describe)
+				git describe HEAD ;;
+			(* | default)
+				git describe --tags --exact-match HEAD ;;
+			esac 2>/dev/null)" ||
=20
-				b=3D"$(git rev-parse --short HEAD 2>/dev/null)..." ||
-				b=3D"unknown"
-				b=3D"($b)"
-			}
-		fi
+			b=3D"$(git rev-parse --short HEAD 2>/dev/null)..." ||
+			b=3D"unknown"
+			b=3D"($b)"
+		}
+	fi
=20
-		if [ -n "$step" ] && [ -n "$total" ]; then
-			r=3D"$r $step/$total"
-		fi
+	if [ -n "$step" ] && [ -n "$total" ]; then
+		r=3D"$r $step/$total"
+	fi
=20
-		local w=3D""
-		local i=3D""
-		local s=3D""
-		local u=3D""
-		local c=3D""
-		local p=3D""
+	local w=3D""
+	local i=3D""
+	local s=3D""
+	local u=3D""
+	local c=3D""
+	local p=3D""
=20
-		if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]=
; then
-			if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)"=
 ]; then
-				c=3D"BARE:"
+	if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ];=
 then
+		if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)" =
]; then
+			c=3D"BARE:"
+		else
+			b=3D"GIT_DIR!"
+		fi
+	elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null)=
" ]; then
+		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
+		   [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]
+		then
+			git diff --no-ext-diff --quiet --exit-code || w=3D"*"
+			if git rev-parse --quiet --verify HEAD >/dev/null; then
+				git diff-index --cached --quiet HEAD -- || i=3D"+"
 			else
-				b=3D"GIT_DIR!"
-			fi
-		elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null=
)" ]; then
-			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
-			   [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]
-			then
-				git diff --no-ext-diff --quiet --exit-code || w=3D"*"
-				if git rev-parse --quiet --verify HEAD >/dev/null; then
-					git diff-index --cached --quiet HEAD -- || i=3D"+"
-				else
-					i=3D"#"
-				fi
-			fi
-			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-				git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+				i=3D"#"
 			fi
+		fi
+		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
+			git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+		fi
=20
-			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
-			   [ "$(git config --bool bash.showUntrackedFiles)" !=3D "false" ] =
&&
-			   [ -n "$(git ls-files --others --exclude-standard)" ]
-			then
-				u=3D"%${ZSH_VERSION+%}"
-			fi
+		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
+		   [ "$(git config --bool bash.showUntrackedFiles)" !=3D "false" ] &=
&
+		   [ -n "$(git ls-files --others --exclude-standard)" ]
+		then
+			u=3D"%${ZSH_VERSION+%}"
+		fi
=20
-			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-				__git_ps1_show_upstream
-			fi
+		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+			__git_ps1_show_upstream
 		fi
+	fi
=20
-		local z=3D"${GIT_PS1_STATESEPARATOR-" "}"
-		local f=3D"$w$i$s$u"
-		if [ $pcmode =3D yes ]; then
-			local gitstring=3D
-			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-				__git_ps1_colorize_gitstring
-			else
-				gitstring=3D"$c${b##refs/heads/}${f:+$z$f}$r$p"
-			fi
-			gitstring=3D$(printf -- "$printf_format" "$gitstring")
-			PS1=3D"$ps1pc_start$gitstring$ps1pc_end"
+	local z=3D"${GIT_PS1_STATESEPARATOR-" "}"
+	local f=3D"$w$i$s$u"
+	if [ $pcmode =3D yes ]; then
+		local gitstring=3D
+		if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+			__git_ps1_colorize_gitstring
 		else
-			# NO color option unless in PROMPT_COMMAND mode
-			printf -- "$printf_format" "$c${b##refs/heads/}${f:+$z$f}$r$p"
+			gitstring=3D"$c${b##refs/heads/}${f:+$z$f}$r$p"
 		fi
+		gitstring=3D$(printf -- "$printf_format" "$gitstring")
+		PS1=3D"$ps1pc_start$gitstring$ps1pc_end"
+	else
+		# NO color option unless in PROMPT_COMMAND mode
+		printf -- "$printf_format" "$c${b##refs/heads/}${f:+$z$f}$r$p"
 	fi
 }
--=20
1.8.3.1.599.g4459181
