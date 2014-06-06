From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 01/20] check_bindir: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:44 -0700
Message-ID: <1402066563-28519-2-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZ1-0001jT-Nu
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbaFFO4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:10 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:58130 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaFFO4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:09 -0400
Received: by mail-pd0-f178.google.com with SMTP id v10so2502741pde.23
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xM433wjONjzoo3uOfYDdKovzRjYO5Ex5TLojg1sLExY=;
        b=bTpMPM9OGlqYBGmH8/ynA1aANDZKL5OnZWiAJfXOuplvrWE9rcE447QKF9b1PEA+bq
         yXPD9eBFk2nEfLbqJNxqSBL6YPH3wx9I2sV1bWIMmDidQFYg/7olElqddITstuBu8yAs
         2aFXFKqqiYslZcis5A1DfHUdgdGxxhtJE2KqJhfgBIOroESXxNukdhHQZXNM9cVWDaZ5
         NNlF3vcEp7RelcY8yb6Hn6AFH0g5gHhzVG3Cg7XJo6uZ8lsonyljjNGeA49IyclgdmHd
         ggETaIF2wJ9AbNeroj9HyG7BRSnbywhvIvcwtP50Fl04bMfHbYbq2QnSsbHWO8hAxzgp
         er0w==
X-Received: by 10.69.19.140 with SMTP id gu12mr1619710pbd.111.1402066568620;
        Fri, 06 Jun 2014 07:56:08 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250919>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 check_bindir |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check_bindir b/check_bindir
index a1c4c3e..623eadc 100755
--- a/check_bindir
+++ b/check_bindir
@@ -2,7 +2,7 @@
 bindir="$1"
 gitexecdir="$2"
 gitcmd="$3"
-if test "$bindir" != "$gitexecdir" -a -x "$gitcmd"
+if test "$bindir" != "$gitexecdir" && test -x "$gitcmd"
 then
 	echo
 	echo "!! You have installed git-* commands to new gitexecdir."
-- 
1.7.10.4
