From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 11/20] t/lib-httpd.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:54 -0700
Message-ID: <1402066563-28519-12-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZA-0001nQ-OJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbaFFO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:19 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:44764 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaFFO4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:18 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so2584226pbc.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GM162k/PVfhPXg/Q3tJ3jSrKHfJTgIojO/17jDR+m0Y=;
        b=QhgRZ9X3CYClyT0193hIXtlPqJA8aoGNBN5Iba1u5WBe2JgfF5CpTdgo4okAydx8uc
         dxwyggIsImUaONVOiYHwZoANwQiBg1CO9noVYgV7s7vcZpi0By8pNuUg/xAQz7crmkTu
         p8pYoF9EdszjbwePknF1BFp8W7jEel8CT4IOX59Jv/SqTYCV3O9m8JvJBzkUGr+d3TQM
         r52AgpRNrNms/cIZIZU4KpMuY6IdH+K3Pt1ePJpTn4SmrZnDs9yxsiwWhAkoD2u4GYWb
         ZSXn53FnZyZaVVQlysSMda0K2erXLkZU+M3z7ZP6igVyglG7vNzE2x51eYoi6qbm6fDn
         IqIA==
X-Received: by 10.68.194.134 with SMTP id hw6mr1692459pbc.49.1402066578096;
        Fri, 06 Jun 2014 07:56:18 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250923>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/lib-httpd.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 252cbf1..38a47fe 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,7 +132,7 @@ prepare_httpd() {
 	HTTPD_URL_USER=$HTTPD_PROTO://user%40host@$HTTPD_DEST
 	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:pass%40host@$HTTPD_DEST
 
-	if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
+	if test -n "$LIB_HTTPD_DAV" || test -n "$LIB_HTTPD_SVN"
 	then
 		HTTPD_PARA="$HTTPD_PARA -DDAV"
 
-- 
1.7.10.4
