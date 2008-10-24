From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC] Introduce a built-in attribute "text"
Date: Fri, 24 Oct 2008 15:55:47 +0200
Message-ID: <1224856547-30533-1-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 15:57:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtNA5-0004cE-5x
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 15:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbYJXNz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 09:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYJXNz4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 09:55:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59212 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751500AbYJXNz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 09:55:56 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1EC6718268A
	for <git@vger.kernel.org>; Fri, 24 Oct 2008 09:55:55 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Oct 2008 09:55:55 -0400
X-Sasl-enc: yNWDm5jAwpIP0c7W7gMWTbw+EIrf01kT6yjOYnFAg5sF 1224856554
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5961224808;
	Fri, 24 Oct 2008 09:55:54 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.514.g2f91b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99038>

"text is the opposite of "binary": It sets the attributes "crlf" and
"diff". It is needed because attribute macros can't be negated,
and some users may want to force git into treating certain files as
text which are not recognized by the internal logic.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This gives the user the chance to mess up completely (given an
"appropriate" setting of autocrlf), but I still think it's a good idea
to have that "-binary" built-in. attributes aren't used by noobs anyways.
In many cases, "diff" might be preferred over "text". Should I add a warning
to the doc?

Michael

 Documentation/gitattributes.txt |    4 +++-
 attr.c                          |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2694559..2a00f8c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -510,7 +510,9 @@ the same time.  The system knows a built-in attribute macro, `binary`:
 which is equivalent to the above.  Note that the attribute macros can only
 be "Set" (see the above example that sets "binary" macro as if it were an
 ordinary attribute --- setting it in turn unsets "crlf" and "diff").
-
+Therefore, there is also a built-in attribute macro `text` which allows
+you to mark certain files as text which git does not recognize automatically.
+It is equivalent to setting `crlf diff`.
 
 DEFINING ATTRIBUTE MACROS
 -------------------------
diff --git a/attr.c b/attr.c
index 17f6a4d..63e2837 100644
--- a/attr.c
+++ b/attr.c
@@ -283,6 +283,7 @@ static void free_attr_elem(struct attr_stack *e)
 
 static const char *builtin_attr[] = {
 	"[attr]binary -diff -crlf",
+	"[attr]text diff crlf",
 	NULL,
 };
 
-- 
1.6.0.3.514.g2f91b
