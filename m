From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] mailinfo: better parse email adresses containg parentheses
Date: Mon, 21 Jul 2008 15:34:29 +0200
Message-ID: <1216647269-12287-1-git-send-email-book@cpan.org>
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 16:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKwBW-0006yj-2n
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 16:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYGUOPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbYGUOPS
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 10:15:18 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:48082 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbYGUOPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 10:15:17 -0400
X-Greylist: delayed 2440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jul 2008 10:15:17 EDT
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1KKvWU-000143-CD; Mon, 21 Jul 2008 15:33:54 +0200
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1KKvX3-0003Ca-D9; Mon, 21 Jul 2008 15:34:29 +0200
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89360>

    When using git-rebase, author fields containing a ')' at the last
    position had the close-parens character incorrectly removed
    because the From: parser incorrectly matched it as

        user@host (User Name)

    (removing parentheses), instead of

        User Name (me) <user@host>

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 builtin-mailinfo.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b99a5b6..5581c9f 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -115,10 +115,10 @@ static void handle_from(const struct strbuf *from)
 	 * the () pair at the end.
 	 */
 	strbuf_trim(&f);
-	if (f.buf[0] == '(')
+	if (f.buf[0] == '(' && f.len && f.buf[f.len - 1] == ')') {
 		strbuf_remove(&name, 0, 1);
-	if (f.len && f.buf[f.len - 1] == ')')
 		strbuf_setlen(&f, f.len - 1);
+	}
 
 	get_sane_name(&name, &f, &email);
 	strbuf_release(&f);
-- 
1.5.4.3
