From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/3] fixup!  doc: generate a list of valid merge tools
Date: Wed, 30 Jan 2013 19:55:45 +0000
Message-ID: <ab68c2d04aa2177a303c53517219cff8a82d8db5.1359575447.git.john@keeping.me.uk>
References: <cover.1359575447.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 21:03:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dsl-00018W-2F
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879Ab3A3UDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:03:17 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56278 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab3A3UDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:03:13 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2013 15:03:13 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B79A58660D7;
	Wed, 30 Jan 2013 19:56:25 +0000 (GMT)
X-Quarantine-ID: <gfm69P9GCqmi>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfm69P9GCqmi; Wed, 30 Jan 2013 19:56:25 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 3B2368660DF;
	Wed, 30 Jan 2013 19:56:25 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 31C40161E563;
	Wed, 30 Jan 2013 19:56:25 +0000 (GMT)
X-Quarantine-ID: <4uSl8HQYywsq>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uSl8HQYywsq; Wed, 30 Jan 2013 19:56:25 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id AF8A9161E02E;
	Wed, 30 Jan 2013 19:56:18 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <cover.1359575447.git.john@keeping.me.uk>
In-Reply-To: <cover.1359575447.git.john@keeping.me.uk>
References: <cover.1359575447.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215067>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index b6ed2fa..b44a2c8 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -22,6 +22,7 @@ is_available () {
 
 show_tool_names () {
 	condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}
+	not_found_msg=${4:-}
 
 	shown_any=
 	( cd "$MERGE_TOOLS_DIR" && ls ) | {
@@ -32,13 +33,19 @@ show_tool_names () {
 			then
 				if test -n "$preamble"
 				then
-					echo "$preamble"
+					printf "%s\n" "$preamble"
 					preamble=
 				fi
 				shown_any=yes
 				printf "%s%s\n" "$per_line_prefix" "$toolname"
 			fi
 		done
+
+		if test -n "$preamble" && test -n "$not_found_msg"
+		then
+			printf "%s\n" "$not_found_msg"
+		fi
+
 		test -n "$shown_any"
 	}
 }
@@ -242,30 +249,27 @@ list_merge_tool_candidates () {
 show_tool_help () {
 	tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
 
-	tab='	' av_shown= unav_shown=
+	tab='	'
+	LF='
+'
+	any_shown=no
 
 	cmd_name=${TOOL_MODE}tool
-	if show_tool_names 'mode_ok && is_available' "$tab$tab" \
-		"$tool_opt may be set to one of the following:"
-	then
-		av_shown=yes
-	else
-		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
-		av_shown=no
-	fi
+	show_tool_names 'mode_ok && is_available' "$tab$tab" \
+		"$tool_opt may be set to one of the following:" \
+		"No suitable tool for 'git $cmd_name --tool=<tool>' found." &&
+		any_shown=yes
 
-	if show_tool_names 'mode_ok && ! is_available' "$tab$tab" \
-		"The following tools are valid, but not currently available:"
-	then
-		unav_shown=yes
-	fi
+	show_tool_names 'mode_ok && ! is_available' "$tab$tab" \
+		"${LF}The following tools are valid, but not currently available:" &&
+		any_shown=yes
 
-	case ",$av_shown,$unav_shown," in
-	*,yes,*)
+	if test "$any_shown" = yes
+	then
 		echo
 		echo "Some of the tools listed above only work in a windowed"
 		echo "environment. If run in a terminal-only session, they will fail."
-	esac
+	fi
 	exit 0
 }
 
-- 
1.8.1.1
