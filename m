From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Add backslash to list of 'crud' characters in real name
Date: Mon, 1 Dec 2008 08:41:50 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812010836280.3256@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:45:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7BtH-0007gB-5s
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbYLAQmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYLAQmh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:42:37 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34950 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754068AbYLAQmg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 11:42:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB1GfoMn029096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Dec 2008 08:41:51 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB1GfouU017535;
	Mon, 1 Dec 2008 08:41:50 -0800
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102060>


We remove crud characters at the beginning and end of real-names so that 
when we see email addresses like

	From: "David S. Miller" <davem@davemloft.net>

we drop the quotes around the name when we parse that and split it up into 
name and email.

However, the list of crud characters was basically just a random list of 
common things that are found around names, and it didn't contain the 
backslash character that some insane scripts seem to use when quoting 
things. So now the kernel has a number of authors listed like

	Author: \"Rafael J. Wysocki\ <rjw@sisk.pl>

because the author name had started out as

	From: \"Rafael J. Wysocki\" <rjw@sisk.pl>

and the only "crud" character we noticed and removed was the final 
double-quote at the end.

We should probably do better quote removal from names anyway, but this is 
the minimal obvious patch.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 ident.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ident.c b/ident.c
index 09cf0c9..99f1c85 100644
--- a/ident.c
+++ b/ident.c
@@ -121,6 +121,7 @@ static int crud(unsigned char c)
 		c == '<' ||
 		c == '>' ||
 		c == '"' ||
+		c == '\\' ||
 		c == '\'';
 }
 
