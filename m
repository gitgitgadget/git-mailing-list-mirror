From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] rebase-i: work around Windows CRLF line endings
Date: Tue, 27 Oct 2015 10:47:21 +0100 (CET)
Message-ID: <adcab7dcf9d802b3703b9ec9291132259a092a04.1445939154.git.johannes.schindelin@gmx.de>
References: <cover.1445782122.git.johannes.schindelin@gmx.de> <cover.1445939154.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0rP-00016A-IG
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbbJ0Jrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:47:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:60866 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615AbbJ0Jrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:47:43 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0Lm6IP-1aQ4gS3kn3-00Zd0Q;
 Tue, 27 Oct 2015 10:47:21 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445939154.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Ix+5vx3ZaLuEFcMjufGNoxSmLZV+rblv5Krc795VY7FomZQtZp1
 9z0zt3maKNUIJ4GPZDpVcZ426rlRjONId2BfSIq7zCBcjE3SSIx49zLlTixq5wzQEBdIFBl
 rRbwU+hbzDkvMvjwvP36/ZHDATbFqvFJ8e0On7fsa22BoOWxfww77TwXOhoOMQq4zXKBgs0
 udsloHZxDjnr8WrPz8sqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5vMv6Nwkpjw=:Y9hkWqAREP7SvJfqdqZyVF
 H0WmRpMLnxI8pwC8oUHUic0DGjv3QA/Yuhpl0gcKtb7ToeG6fY6FyYeCufswm6Byo/tYie/Vn
 DeR67ooS4fWhnDpCF3o5Ub4WThtzgUIaHohIY3GLB08fp8Mp51DrCMM/lGG51nWbxWI10xWT0
 JrdYCdhyajIdRY3cFa9O7QIzM7SNlnl9bqTABYcZjSSdAQ32njDF6dQvI2HZhUWFiPGjw84QS
 sZ2dbp+G2k2kFh+NMA/P0Q3jboW8BlxBV5VsJextoOGvrqoChfSBJH/ZSmKswe3aqCJysdbur
 35qO8kK1uWkFFU6koq7jA2vDwitMDJE4cGy8Uh6n9o63ljdGme5cp/8drpdoZFE2Dcn3YrsGa
 YzJPxrjWL+SrGSPaRnyBPpj9yLlRo5r8LyQo+le8cBRddMCx2uDHCvBgz/SEvL+UCi/yua6HG
 YDLqUSEvQ/hhkwfSSwc6gTIKeSLq0AW/CPSEV0wwZGRWcO6t+sPsC7rj4eOjrju7bvVzb4CY6
 3yF5M/3fTGs+BCq0AT2wwo1hy3ZAi7gG737ARKwTbV2Wn+8RbMtcDv1rGByNWhbF/Do5FSVkb
 U2fZp86zzNTqGcsifhdej9ezYn82mj3jb6vSAphX0Jz/mIkaj55hhaiwP+KF4YfughCST29SR
 EgcscD0dSLROsQLtyCdaBf0ryoUJtBgQiFspq/VQKO/9KGj34XWlR4ueCLsEfpnHGUmTQHP0/
 lhoxjriC7pv5uvCiTsk6UiuGYo0swVUCtuQ5Z7TzZF3u/0qcjVRXTLOdZEczFnUKxpiZPgOa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280255>

From: Junio C Hamano <gitster@pobox.com>

Editors on Windows can and do save text files with CRLF line
endings, which is the convention on the platform.  We are seeing
reports that the "read" command in a port of bash to the environment
however does not strip the CRLF at the end, not adjusting for the
same convention on the platform.

This breaks the recently added sanity checks for the insn sheet fed
to "rebase -i"; instead of an empty line (hence nothing in $command),
the script was getting a lone CR in there.

Special case a lone CR and treat it the same way as an empty line to
work this around.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    | 13 +++++++++++++
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d65c06e..daadf2d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,6 +77,10 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
+# Work around a Windows port of shell that does not strip
+# the newline at the end of a line correctly.
+cr=$(printf "\015")
+
 strategy_args=
 if test -n "$do_merge"
 then
@@ -518,6 +522,11 @@ do_next () {
 	"$comment_char"*|''|noop|drop|d)
 		mark_action_done
 		;;
+	"$cr")
+		# Windows port of shell not stripping the newline
+		# at the end of an empty line correctly.
+		mark_action_done
+		;;
 	pick|p)
 		comment_for_reflog pick
 
@@ -896,6 +905,10 @@ check_bad_cmd_and_sha () {
 		"$comment_char"*|''|noop|x|exec)
 			# Doesn't expect a SHA-1
 			;;
+		"$cr")
+			# Windows port of shell not stripping the newline
+			# at the end of an empty line correctly.
+			;;
 		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
 			then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5dfa16a..98eb49a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1261,7 +1261,7 @@ test_expect_success 'static check of bad SHA-1' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-test_expect_failure 'editor saves as CR/LF' '
+test_expect_success 'editor saves as CR/LF' '
 	git checkout -b with-crlf &&
 	write_script add-crs.sh <<-\EOF &&
 	sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&
-- 
2.1.4
