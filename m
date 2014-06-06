From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 07/20] git-bisect.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:50 -0700
Message-ID: <1402066563-28519-8-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZf-00025K-I4
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaFFO4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:18 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:48882 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaFFO4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:15 -0400
Received: by mail-pd0-f178.google.com with SMTP id v10so2502867pde.23
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k5Ab2vsAeT1YncKUkjni/TWR0w2ElU28eC8MS0s5AV0=;
        b=fN4sNRnZT3XSNaTdvQSVAh+h00xEcbFb+uUsTU5/KqQQhN47QTsxdGrApKcZL0WLDp
         VJKdfCBgGxDwnve1fJN86OBIYlrXlR7AX2PgRL0rw/n3FHCdyok3POhuN2Am1V3DIoA3
         /jPSHq6DPAH0KegaYw7bZZaYg7Gokz+s4dbofHU70VLHLwUEbLmtO1fZQCREdlAMS8Pt
         uxkxIxe2OCHodKhYQOrpnEV15GvPMx+dwvwypayrdN1ZthAnjmSMN0aFIysCpoBBeUlG
         gJUswMzN9FsCOxSJSgJoYP7TVsx6x5eUdVOo0wGs8wPt758F7o6DAhBJOGGQv41BpKwB
         qrBA==
X-Received: by 10.68.232.67 with SMTP id tm3mr1682746pbc.51.1402066574327;
        Fri, 06 Jun 2014 07:56:14 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250935>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-bisect.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index af4d04c..1e0d602 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -408,7 +408,7 @@ bisect_replay () {
 	bisect_reset
 	while read git bisect command rev
 	do
-		test "$git $bisect" = "git bisect" -o "$git" = "git-bisect" || continue
+		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
 		if test "$git" = "git-bisect"
 		then
 			rev="$command"
-- 
1.7.10.4
