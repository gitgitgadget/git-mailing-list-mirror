From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: remove ancient "ensure colon in COMP_WORDBREAKS"
 workaround
Date: Mon, 10 Jun 2013 01:59:21 +0200
Message-ID: <1370822361-15637-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 01:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlpWM-0003PP-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab3FIX7e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 19:59:34 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:51560 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3FIX7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:59:33 -0400
Received: from localhost6.localdomain6 (f051160074.adsl.alicedsl.de [78.51.160.74])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MTJZq-1UuAxG1tIs-00RWbU; Mon, 10 Jun 2013 01:59:32 +0200
X-Mailer: git-send-email 1.8.0.269.g97125f4
X-Provags-ID: V02:K0:yzz1LiTHXiyC/wqDUCeWS3X8T+L6OA21Y7Q0VAjRao6
 F9vcVRidUuuw+b8fZyYfUYUKAZQGbt8veYaSZIZ48USii+J4Vx
 Xjko5qYqGPX6WuM4e2gJRg0FtBmTjkBYv5m4g7zjl6AJRd56lo
 LrhEU6bq5DCVQx7wfSdk6aFDw2VIPdutdMcGVAnm9ADhGbhmc0
 rDhBc1nFVy9u+d3GaKVqNgZPwmHVNIjqjz9KhdFj9Bgb95euY6
 GMhTAtWKg0Boi+4s5kAv61xs5HTIdaSaAo3PyJmW4ToJXpiPip
 7VYgjcGdm5SFbcD2HjKajHZX2N3ixz6GfRylAAf1wUKdOhJu1s
 oOVHaBpjUMjQCVhFJDhFOJMYf2SqswujfcVAI/5UzqxhnK4W2h
 iDClHeew8lPJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227218>

=46edore 9 shipped the gvfs package with a buggy Bash completion script=
:
it removed the ':' character from COMP_WORDBREAKS, thereby breaking
certain features of git's completion script.  We worked this around in
db8a9ff0 (bash completion: Resolve git show ref:path<tab> losing ref:
portion, 2008-07-15).

The bug was fixed in Fedora 10 and Fedora 9 reached its EOL on
2009-07-10, almost four years ago.  It's about time to remove our
workaround.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 91234d47..2f78dcfa 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -24,11 +24,6 @@
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
=20
-case "$COMP_WORDBREAKS" in
-*:*) : great ;;
-*)   COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"
-esac
-
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
@@ -458,11 +453,6 @@ __git_complete_revlist_file ()
 			;;
 		esac
=20
-		case "$COMP_WORDBREAKS" in
-		*:*) : great ;;
-		*)   pfx=3D"$ref:$pfx" ;;
-		esac
-
 		__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" ls-tree "$ls" 2>/dev/n=
ull \
 				| sed '/^100... blob /{
 				           s,^.*	,,
@@ -560,10 +550,6 @@ __git_complete_remote_or_refspec ()
 	[ "$remote" =3D "." ] && remote=3D
 	case "$cur_" in
 	*:*)
-		case "$COMP_WORDBREAKS" in
-		*:*) : great ;;
-		*)   pfx=3D"${cur_%%:*}:" ;;
-		esac
 		cur_=3D"${cur_#*:}"
 		lhs=3D0
 		;;
--=20
1.8.0.269.g97125f4
