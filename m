From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH/RFC v2 2/4] rev-parse: Don't recognise --flags as an option if --no-flags has been specified.
Date: Sat, 25 Sep 2010 19:04:12 +1000
Message-ID: <1285405454-12521-4-git-send-email-jon.seymour@gmail.com>
References: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 11:02:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzQdr-0001ne-2p
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 11:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab0IYJBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 05:01:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49476 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab0IYJBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 05:01:51 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so815188pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UmoK/VBjbZGlHRhG+pll8yCbLdtwBV/GKmZGNr+V024=;
        b=eVQ4k52kdFSlZEsY5eh13a7T3V3pgtaHX7kvf3Tsj8//U+AYm0JAQleyZpPBMSaxcM
         /Wf8f+dqA5kLjs1t/+tVJdoLekkFOeYeyv0nrza0Quskd2gYlU5EVKqes37lRKouFtHc
         1HY6o9IK2BDUGn1lI7TqGTjoGb1dAF4KtNBbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uqjzbSlk/BsYL/T+pje+ip+IShHKxZdfHm0IaJ8UtVKEgb86jPtRrwuz+mthv7N7bh
         ZMzqg7hcbaA6d8bb1OXsCRMK1qr7x4EfJRsEj9HPvGidYHLn+kT/C4RifjkxRf0BRW/1
         WMUEdoCpdEE36GPEPqaIW8AJfuxBXOh6JVPtY=
Received: by 10.142.75.4 with SMTP id x4mr3825319wfa.184.1285405311619;
        Sat, 25 Sep 2010 02:01:51 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.90])
        by mx.google.com with ESMTPS id y36sm3574521wfd.6.2010.09.25.02.01.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 02:01:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.gc81ce.dirty
In-Reply-To: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157136>

Previously:
   $ git rev-parse --no-flags --flags -X
   -X

now:
   $ git rev-parse --no-flags --flags -X


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/rev-parse.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9e340c7..d403d29 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -520,6 +520,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--flags")) {
+				if (!(filter & DO_FLAGS)) {
+					// --preceding --no-flags means --flags is ignored
+					continue;
+				}
 				filter &= ~DO_NONFLAGS;
 				continue;
 			}
-- 
1.7.3.1.gc81ce.dirty
