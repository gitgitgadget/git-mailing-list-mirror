From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: add 'git svn' options
Date: Wed,  5 Mar 2008 20:28:06 +0100
Message-ID: <cba299961b895ea1b20a4a3f7f4add86618891ed.1204745177.git.szeder@ira.uka.de>
References: <>
 <ad6d56c74f4e5ae29dc8176eba6e7381c12a3351.1204745177.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, spearce@spearce.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWzIF-0002mG-CL
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 20:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187AbYCET2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 14:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088AbYCET2K
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 14:28:10 -0500
Received: from francis.fzi.de ([141.21.7.5]:19310 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754513AbYCET2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 14:28:08 -0500
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Mar 2008 20:28:05 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <ad6d56c74f4e5ae29dc8176eba6e7381c12a3351.1204745177.git.szeder@ira.uka.de>
In-Reply-To: <ad6d56c74f4e5ae29dc8176eba6e7381c12a3351.1204745177.git.szeder@ira.uka.de>
References: <ad6d56c74f4e5ae29dc8176eba6e7381c12a3351.1204745177.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 05 Mar 2008 19:28:05.0213 (UTC) FILETIME=[08F190D0:01C87EF7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76253>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   65 ++++++++++++++++++++++++=
++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8f56641..797ac1b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1186,6 +1186,71 @@ _git_svn ()
 			set-tree commit-diff info create-ignore propget
 			proplist show-ignore show-externals
 			"
+	else
+		local remote_opts=3D"--username=3D --config-dir=3D --no-auth-cache"
+		local fc_opts=3D"
+			--follow-parent --authors-file=3D --repack=3D
+			--no-metadata --use-svm-props --use-svnsync-props
+			--log-window-size=3D --no-checkout --quiet
+			--repack-flags --user-log-author $remote_opts
+			"
+		local init_opts=3D"
+			--template=3D --shared=3D --trunk=3D --tags=3D
+			--branches=3D --stdlayout --minimize-url
+			--no-metadata --use-svm-props --use-svnsync-props
+			--rewrite-root=3D $remote_opts
+			"
+		local cmt_opts=3D"
+			--edit --rmdir --find-copies-harder --copy-similarity=3D
+			"
+
+		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+		case "$command,$cur" in
+		fetch,--*)
+			__gitcomp "--revision=3D --fetch-all $fc_opts"
+			;;
+		clone,--*)
+			__gitcomp "--revision=3D $fc_opts $init_opts"
+			;;
+		init,--*)
+			__gitcomp "$init_opts"
+			;;
+		dcommit,--*)
+			__gitcomp "
+				--merge --strategy=3D --verbose --dry-run
+				--fetch-all --no-rebase $cmt_opts $fc_opts
+				"
+			;;
+		set-tree,--*)
+			__gitcomp "--stdin $cmt_opts $fc_opts"
+			;;
+		create-ignore,--*|propget,--*|proplist,--*|show-ignore,--*|\
+		show-externals,--*)
+			__gitcomp "--revision=3D"
+			;;
+		log,--*)
+			__gitcomp "
+				--limit=3D --revision=3D --verbose --incremental
+				--oneline --show-commit --non-recursive
+				--authors-file=3D
+				"
+			;;
+		rebase,--*)
+			__gitcomp "
+				--merge --verbose --strategy=3D --local
+				--fetch-all $fc_opts
+				"
+			;;
+		commit-diff,--*)
+			__gitcomp "--message=3D --file=3D --revision=3D $cmt_opts"
+			;;
+		info,--*)
+			__gitcomp "--url"
+			;;
+		*)
+			COMPREPLY=3D()
+			;;
+		esac
 	fi
 }
=20
--=20
1.5.4.3

