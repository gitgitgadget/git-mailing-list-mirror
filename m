From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] Makefile: add missing GIT-VERSION-FILE dependency
Date: Thu, 31 May 2012 16:10:44 +0200
Message-ID: <1338473444-8960-1-git-send-email-kusmabite@gmail.com>
Cc: nickh@reactrix.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 16:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa65a-0001gs-I2
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205Ab2EaOKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:10:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33926 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758091Ab2EaOKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:10:53 -0400
Received: by bkcji2 with SMTP id ji2so880258bkc.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wbDpS9+7ni0OBDizVYnmojU3czXrtRPluejWGAk3cYk=;
        b=nZr71ATVxKjRy0Sw8WCp7NOfPbUp+7MhhhC1e2BGbhBLMhjSH/MXfHqLgJYZAoMgn8
         94vUydMbaB/qOCPQgV1CJRJrBoJQIS+ZGkylLYPPPzxResRvVzA5U0Lv6QVKuq9+IJQc
         YVH9yqFatZxjZTh3/Rd8sGdflsmqzA1R/ZOX+iybQJo6q7Yt28XJN9u8GZd3/vlmpxQY
         NdaLLh8ixd+QqtgkQd0hJz1aXrxDoMAn1hp9yz/Az3pr4H2/U+UwgKnCbJy5NOpELfQs
         +wzSVNAamW/uTAfKziZZ+lUJO/kkkf2gbUNuZeixrSpYQrLJ8yEu5RRRvHRswRw/4WSP
         rD7g==
Received: by 10.204.152.22 with SMTP id e22mr12103534bkw.8.1338473451945;
        Thu, 31 May 2012 07:10:51 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 9sm3464749bku.9.2012.05.31.07.10.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:10:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.6836.gdf573d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198905>

In 20fc9bc (Set HTTP user agent to git/GIT_VERSION, 2006-04-04),
http.o started recording GIT_VERSION, but http.o wasn't added
to the list of files that depends on GIT-VERSION-FILE.

Fix this, so mofications to GIT-VERSION-FILE will result in an
updated user-agent string.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I stumbled over this while debugging something related. Perhaps this
fix is worth applying?

There's a similar issue with generation of assembly-listings, but I
figured that was intended for inspection of the generated code; the
version string probably doesn't matter in such cases.

Dunno...

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c09a679..59e2b25 100644
--- a/Makefile
+++ b/Makefile
@@ -2104,7 +2104,7 @@ configure: configure.ac
 	$(RM) $<+
 
 # These can record GIT_VERSION
-git.o git.spec \
+git.o git.spec http.o \
 	$(patsubst %.sh,%,$(SCRIPT_SH)) \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
-- 
1.7.11.rc0.6836.gdf573d9
