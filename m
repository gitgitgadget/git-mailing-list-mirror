From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 5/8] t3901: avoid negation on right hand side of '|'
Date: Mon, 18 May 2009 18:44:42 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpPhpa6XnDlrUaNKPjrH6NYGZK9NzwH2STGreDnkCUEwiMxu0BD6uSgk@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpEj60b9ww0Dv2XSyNy2qLE-KEaaF8D8q9OHVC3tPAPSzNe1CJUXJDfA@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpGlk83sgTnCuuc7WdvYgBn_Ja9b0yZjdlJxTSSCaDWC05irzAQVk1uM@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CWm-0003iT-6I
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbZERXpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZERXpK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:45:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50117 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbZERXo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:58 -0400
Received: by mail.nrlssc.navy.mil id n4INitKS024906; Mon, 18 May 2009 18:44:58 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpGlk83sgTnCuuc7WdvYgBn_Ja9b0yZjdlJxTSSCaDWC05irzAQVk1uM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:55.0715 (UTC) FILETIME=[A5A9CF30:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119478>

Some shells do not properly handle constructs of the form:

   spew_something | ! process_input

So rewrite this to be:

   spew_something | process_input; test $? != 0

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t3901-i18n-patch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 7655da3..b04f74a 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -19,7 +19,7 @@ check_encoding () {
 		8859)
 			grep "^encoding ISO-8859-1" ;;
 		*)
-			! grep "^encoding ISO-8859-1" ;;
+			grep "^encoding ISO-8859-1"; test "$?" != 0 ;;
 		esac || {
 			bad=1
 			break
-- 
1.6.3.1.24.g152f4
