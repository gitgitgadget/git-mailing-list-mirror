From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/2] bash completion: only show 'log --merge' if merging
Date: Mon, 16 Feb 2009 17:34:57 +0100
Message-ID: <bc66ec312ad33c4a7c9580ba4ade75c5998443d7.1234801852.git.trast@student.ethz.ch>
References: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 17:37:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6Sb-0000Iq-EA
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZBPQfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbZBPQfN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:35:13 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:15235 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbZBPQfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:35:11 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 17:35:09 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 17:35:08 +0100
X-Mailer: git-send-email 1.6.2.rc0.328.g2c702
In-Reply-To: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
X-OriginalArrivalTime: 16 Feb 2009 16:35:08.0619 (UTC) FILETIME=[87C3F9B0:01C99054]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110201>

The gitk completion only shows --merge if MERGE_HEAD is present.
Do it the same way for git-log completion.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a5b3bf3..489951b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1003,6 +1003,11 @@ _git_log ()
 	__git_has_doubledash && return
 
 	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	local merge=""
+	if [ -f $g/MERGE_HEAD ]; then
+		merge="--merge"
+	fi
 	case "$cur" in
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
@@ -1030,7 +1035,7 @@ _git_log ()
 			--decorate
 			--walk-reflogs
 			--parents --children
-			--merge
+			$merge
 			$__git_diff_common_options
 			--pickaxe-all --pickaxe-regex
 			"
-- 
1.6.2.rc0.328.g2c702
