From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git log --grep=foo".
Date: Mon, 26 Jul 2010 20:14:37 +0200
Message-ID: <1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 20:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSCX-0005tX-PO
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab0GZSOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:14:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36342 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab0GZSOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:14:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6QID2Md008915
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Jul 2010 20:13:02 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdSCI-0002HX-MR; Mon, 26 Jul 2010 20:14:42 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdSCI-000871-LA; Mon, 26 Jul 2010 20:14:42 +0200
X-Mailer: git-send-email 1.7.2.23.g58c3b.dirty
In-Reply-To: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Jul 2010 20:13:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6QID2Md008915
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280772785.25989@n1cMsgViNVu7GqSdhprERA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151867>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 7e82efd..e93bbd9 100644
--- a/revision.c
+++ b/revision.c
@@ -1148,6 +1148,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			       int *unkc, const char **unkv)
 {
 	const char *arg = argv[0];
+	const char *optarg = argv[1];
 
 	/* pseudo revision arguments */
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
@@ -1374,6 +1375,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		add_header_grep(revs, GREP_HEADER_COMMITTER, arg+12);
 	} else if (!prefixcmp(arg, "--grep=")) {
 		add_message_grep(revs, arg+7);
+	} else if (!strcmp(arg, "--grep")) {
+		add_message_grep(revs, optarg);
+		return 2;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
-- 
1.7.2.23.g58c3b.dirty
