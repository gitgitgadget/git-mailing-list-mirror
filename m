From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: remove redundant __git_compute_all_commands() call
Date: Fri,  1 May 2015 17:48:56 +0200
Message-ID: <1430495336-8456-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 17:49:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoDBX-0002Zq-Sr
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbbEAPs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 11:48:59 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39001 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754101AbbEAPs6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 11:48:58 -0400
Received: from x590c27d8.dyn.telefonica.de ([89.12.39.216] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YoDBO-0007qE-Ov; Fri, 01 May 2015 17:48:56 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1430495336.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268149>

During lazy-initialization of the lists of all commands and porcelain
commands the function __git_compute_all_commands() is called twice.  Th=
e
relevant part of the call sequence looks like this:

  __git_compute_porcelain_commands()
     __git_compute_all_commands()
        <finds list of all commands uninitialized>
        __git_list_all_commands()
        <initializes list of all commands>
     __git_list_porcelain_commands()
        __git_compute_all_commands()
           <finds list of all commands already initialized, does nothin=
g>
        <filters porcelains from list of all commands>

Either one of the two calls could be removed and the initialization of
both command lists would still work as a whole, but let's remove the ca=
ll
from __git_compute_porcelain_commands(), because this way
__git_list_porcelain_commands() will keep working in itself.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5944c82..8b0d2b4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -735,7 +735,6 @@ __git_list_porcelain_commands ()
 __git_porcelain_commands=3D
 __git_compute_porcelain_commands ()
 {
-	__git_compute_all_commands
 	test -n "$__git_porcelain_commands" ||
 	__git_porcelain_commands=3D$(__git_list_porcelain_commands)
 }
--=20
1.9.5.msysgit.0
