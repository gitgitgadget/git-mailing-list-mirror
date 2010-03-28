From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] Makefile: Remove usage of deprecated Python "has_key" method
Date: Sat, 27 Mar 2010 17:45:12 -0700
Message-ID: <1269737112-21631-1-git-send-email-davvid@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 01:45:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvgdE-00006o-Im
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 01:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab0C1ApT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 20:45:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63118 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab0C1ApT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 20:45:19 -0400
Received: by gyg13 with SMTP id 13so768794gyg.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EDVfXEZUHVsgoCe6D2wOVdyH4OeAiShufIz9mOKysIc=;
        b=oNdB769j/S6as17ndEm1j/QAkLx54R5fHEj5qTeKOvWJ2ImO4b5+CrlUx04IRchGYs
         EU3KOeqp5FfpOP8SdgAOhsMR6GVHcxrxfIAQj2vEt1gsRBIwSbH2tVLQPMn1UjNuRW6N
         m5WSvQkl7MyyS6eh6YvLRivWy6bFr4G+CKx94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HNCmZ3NvaiO9k0HuRwa/BIPjICoo5HagTuipL74k7608lPN6kFZqWp3AtMKtOGHgpr
         vVYxLqvnEOevJvGuF08aAjP6c3sU0niZMhlTVPMJ8pR/qV3kGT5qXIfj8ZYAVh2LWqrm
         xd7CpQh1h4gog0Z0gPtTt5EayJSsB/eiXNksk=
Received: by 10.101.169.28 with SMTP id w28mr4965430ano.29.1269737117370;
        Sat, 27 Mar 2010 17:45:17 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm673882ywe.37.2010.03.27.17.45.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 17:45:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.291.g5e4f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143369>

"has_key" is a deprecated dictionary method in Python 2.6+.
Simplify the sys.path manipulation for installed scripts by
passing a default value to os.getenv().

SCRIPT_PYTHON is currently empty but this future-proofs us.
It also fixes things for users who maintain local git forks
with their own SCRIPT_PYTHON additions.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Makefile |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3a6c6ea..806ccdf 100644
--- a/Makefile
+++ b/Makefile
@@ -1609,9 +1609,8 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	    -e '}' \
 	    -e 's|^import sys.*|&; \\\
 	           import os; \\\
-	           sys.path[0] = os.environ.has_key("GITPYTHONLIB") and \\\
-	                         os.environ["GITPYTHONLIB"] or \\\
-	                         "@@INSTLIBDIR@@"|' \
+	           sys.path.insert(0, os.getenv("GITPYTHONLIB",\
+	                                        "@@INSTLIBDIR@@"));|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    $@.py >$@+ && \
 	chmod +x $@+ && \
-- 
1.7.0.3.291.g5e4f6
