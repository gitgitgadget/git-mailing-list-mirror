From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v5 3/3] completion: add git status
Date: Fri, 10 Jun 2016 12:24:00 +0200
Message-ID: <20160610102400.9864-2-thomas.braun@virtuell-zuhause.de>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
 <20160610102400.9864-1-thomas.braun@virtuell-zuhause.de>
Cc: peff@peff.net, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 12:24:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBJc7-0004v1-9F
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 12:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbcFJKYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 06:24:23 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46413 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932586AbcFJKYS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 06:24:18 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=localhost.localdomain); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1bBJbr-0008QC-U9; Fri, 10 Jun 2016 12:24:16 +0200
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20160610102400.9864-1-thomas.braun@virtuell-zuhause.de>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465554258;46b1291a;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296963>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0bf67c9..ddda5e5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1826,6 +1826,56 @@ _git_stage ()
 	_git_add
 }
 
+_git_status ()
+{
+	local complete_opt
+	local untracked_state
+
+	case "$cur" in
+	--ignore-submodules=*)
+		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
+		return
+		;;
+	--untracked-files=*)
+		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
+		return
+		;;
+	--column=*)
+		__gitcomp "
+			always never auto column row plain dense nodense
+			" "" "${cur##--column=}"
+		return
+		;;
+	--*)
+		__gitcomp "
+			--short --branch --porcelain --long --verbose
+			--untracked-files= --ignore-submodules= --ignored
+			--column= --no-column
+			"
+		return
+		;;
+	esac
+
+	untracked_state="$(__git_get_option_value "-u" "--untracked-files=" \
+		"$__git_untracked_file_modes" "status.showUntrackedFiles")"
+
+	case "$untracked_state" in
+	no)
+		# --ignored option does not matter
+		complete_opt=
+		;;
+	all|normal|*)
+		complete_opt="--cached --directory --no-empty-directory --others"
+
+		if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then
+			complete_opt="$complete_opt --ignored --exclude=*"
+		fi
+		;;
+	esac
+
+	__git_complete_index_file "$complete_opt"
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
2.8.4.windows.1
