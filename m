From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH] make: Remove -pthread on Darwin (it is included by cstdlib).
Date: Mon, 26 Jan 2009 14:03:59 -0500
Message-ID: <1232996639-12450-1-git-send-email-ted@tedpavlic.com>
References: <497E079C.7090303@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 20:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWmZ-0004wX-3W
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZAZTEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbZAZTEI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:04:08 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:41157 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218AbZAZTEH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 14:04:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 72CE180D803F;
	Mon, 26 Jan 2009 13:58:02 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9wUHSQGAoKt7; Mon, 26 Jan 2009 13:58:02 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 5535F80D8021;
	Mon, 26 Jan 2009 13:58:02 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
In-Reply-To: <497E079C.7090303@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107249>

As discussed in

http://lists.apple.com/archives/Unix-porting/2005/Mar/msg00019.html

the Mac OS X C standard library is always thread safe and always
includes the pthread library. So explicitly using -pthread causes an
'unrecognized option' compiler warning.

This patch clears PTHREAD_LIBS if Darwin is detected.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---

Rather than simply clearing PTHREAD_LIBS, would it be better to filter
PTHREAD_LIBS to remove "-pthread" if detected?

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b4d9cb4..9d451cf 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,7 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	PTHREAD_LIBS =
 endif
 
 ifndef CC_LD_DYNPATH
-- 
1.6.1.213.g28da8
