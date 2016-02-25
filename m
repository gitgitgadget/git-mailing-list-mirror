From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 14/21] completion: don't offer commands when 'git --opt' needs an argument
Date: Thu, 25 Feb 2016 23:50:43 +0100
Message-ID: <1456440650-32623-15-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:53:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4n0-0006n0-1t
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbcBYWxi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:53:38 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35837 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWxi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:53:38 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4mr-0007uU-Uf; Thu, 25 Feb 2016 23:53:35 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440815.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287463>

The main git options '--git-dir', '-c', '-C', '--worktree' and
'--namespace' require an argument, but attempting completion right
after them lists git commands.

Don't offer anything right after these options, thus let Bash fall
back to filename completion, because

  - the three options '--git-dir', '-C' and '--worktree' do actually
    require a path argument, and

  - we don't complete the required argument of '-c' and '--namespace',
    and in that case the "standard" behavior of completion scripts in
    general is to not offer anything, but fall back to filename
    completion.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6932d2a276eb..6027733a4b46 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2666,6 +2666,14 @@ __git_main ()
 	done
=20
 	if [ -z "$command" ]; then
+		case "$prev" in
+		--git-dir|-C|--work-tree)
+			return
+			;;
+		-c|--namespace)
+			return
+			;;
+		esac
 		case "$cur" in
 		--*)   __gitcomp "
 			--paginate
--=20
2.7.2.410.g92cb358
