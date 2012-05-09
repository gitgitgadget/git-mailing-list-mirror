From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 03/19] completion: use __gitdir() in _git_log()
Date: Wed,  9 May 2012 02:44:34 +0200
Message-ID: <1336524290-30023-4-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv2J-0004qr-Gq
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab2EIApm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:45:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:64275 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223Ab2EIApl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:45:41 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MBo1b-1SKSEq0yHP-00AxIY; Wed, 09 May 2012 02:45:35 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:LPHJnKNNYVI8AZf9EtFox0JT5HTCJ1BB56FB6VDWz1U
 jWxNTsv5qMG/tSu85oroBPae/m1Mc+btkQpPTwGHb4ouQpkW3n
 eXFR8iip9okbNpYLfLJbh8Cf2h9ebYIKoJNwXx8vNi09iiLIRU
 ll9t9MkXsUy+gFV7FEfPpQ/+CaBz+qf6Sgh2xD/zMFlqKLePBo
 43BQe4B5awbQdEQB1fz51TR4CPap1D9iXty9fKh8c0+CciNkJm
 eySHiqUQ/RmBMWkARLI4AvCeUjkjFVeFHhD4lnLnyGMDTXLwRh
 O2ngu64ce9VqOCoYzo9yvl7qrKigAV412If0/cLQeVHTmAleQ+
 vPfgTPzZer/1lAVxCEeidvu8/Fjl/KtptqXKwZSkmZSjLwLyvz
 9cC9YuDlkfnIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197434>

The standard way to find out the path to the repository in the
completion script is the __gitdir() helper function, because that
handles the repository path given on the command line (i.e. git
--git-dir=3D/path/to/repo log --<TAB>).  However, there is one
exception: the completion function for 'git log' still uses 'git
rev-parse --git-dir' directly, and could offer (or not) the '--merge'
option erroneously when the repository is specified on the command
line.

Use __gitdir() there, too.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 9f56ec7a..f17abccb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1551,7 +1551,7 @@ _git_log ()
 {
 	__git_has_doubledash && return
=20
-	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
+	local g=3D"$(__gitdir)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge=3D"--merge"
--=20
1.7.10.1.541.gb1be298
