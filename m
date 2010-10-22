From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH] userdiff.c: Improve builtin csharp regex patterns.
Date: Fri, 22 Oct 2010 18:31:43 +0200
Message-ID: <1287765103-3778-1-git-send-email-torarvid@gmail.com>
Cc: Petr Onderka <gsvick@gmail.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:04:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9L2D-0000DS-1B
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989Ab0JVRDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:03:50 -0400
Received: from smtp3.powertech.no ([195.159.0.178]:60269 "EHLO
	smtp3.powertech.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757971Ab0JVRDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:03:50 -0400
X-Greylist: delayed 1909 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2010 13:03:50 EDT
Received: from exchange.qsystems.no (unknown [77.40.144.122])
	by smtp3.powertech.no (Postfix) with ESMTP id 7F3A6CD294;
	Fri, 22 Oct 2010 18:31:58 +0200 (CEST)
Received: from pingvin1 ([192.168.223.6]) by exchange.qsystems.no with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 22 Oct 2010 18:31:58 +0200
Received: by pingvin1 (Postfix, from userid 1000)
	id 474D94B892; Fri, 22 Oct 2010 18:31:58 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.1.68.g06779.dirty
X-OriginalArrivalTime: 22 Oct 2010 16:31:58.0423 (UTC) FILETIME=[A59F1E70:01CB7206]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159712>

This fixes the case where you have a c# method on the form:

public Dictionary<int, string> GetSomeMap()

The previous regex did not support generic syntax with more than one
type parameter. This patch basically copies the regex used for methods, and
adds the requirement that it has a MethodName<.*> pattern where the .* can
contain Comma, Space and Tab.

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---
Maybe someone can optimize this, or merge it with the "Methods and
constructors" pattern in a nice way. It seemed to solve my itch, at least...

 userdiff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index f9e05b5..06d8077 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -103,6 +103,8 @@ PATTERNS("csharp",
 	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
 	 /* Methods and constructors */
 	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 /* Generic methods */
+	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][@._[:alnum:]]+<[<>@., \t[:alnum:]]+>[ \t]+[@._[:alnum:]]+(<[<>@., \t[:alnum:]]+>)?[ \t]*\\(.*\\))[ \t]*$\n"
 	 /* Properties */
 	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
 	 /* Type definitions */
-- 
1.7.3.GIT
