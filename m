From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] git-rebase--interactive.sh: use printf instead of echo to print commit message
Date: Fri, 13 Aug 2010 15:47:35 -0500
Message-ID: <vFgTzGXLhalxcMpLoOFhqi1W6sU5I3lJ9CWjrrJjoRmkMjHSswmpLXU2vVL8PS5JJNEO727l9q8@cipher.nrlssc.navy.mil>
References: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com>
Cc: avarab@gmail.com, Matthieu.Moy@imag.fr, gitster@pobox.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: benji@silverinsanity.com
X-From: git-owner@vger.kernel.org Fri Aug 13 22:49:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1BY-0003Gm-9Y
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab0HMUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 16:48:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40063 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0HMUsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:48:53 -0400
Received: by mail.nrlssc.navy.mil id o7DKmFMG032333; Fri, 13 Aug 2010 15:48:15 -0500
In-Reply-To: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com>
X-OriginalArrivalTime: 13 Aug 2010 20:48:15.0027 (UTC) FILETIME=[D9E03030:01CB3B28]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153505>

From: Brandon Casey <drafnel@gmail.com>

Replace the echo statements that operate on $rest with printf's to restore
what was lost from 938791cd.  This avoids any mangling that XSI-conformant
echo's may introduce.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio,

Feel free to squash this into 1/2 if desired.

-Brandon


 git-rebase--interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2e5bed0..3419247 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -625,7 +625,7 @@ skip_unnecessary_picks () {
 		case "$fd,$command" in
 		3,pick|3,p)
 			# pick a commit whose parent is current $ONTO -> skip
-			sha1=$(echo "$rest" | cut -d ' ' -f 1)
+			sha1=$(printf '%s' "$rest" | cut -d ' ' -f 1)
 			case "$(git rev-parse --verify --quiet "$sha1"^)" in
 			"$ONTO"*)
 				ONTO=$sha1
@@ -642,7 +642,7 @@ skip_unnecessary_picks () {
 			fd=1
 			;;
 		esac
-		echo "$command${rest:+ }$rest" >&$fd
+		printf '%s\n' "$command${rest:+ }$rest" >&$fd
 	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
 	mv -f "$TODO".new "$TODO" &&
 	case "$(peek_next_command)" in
-- 
1.7.2.1
