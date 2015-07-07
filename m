From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 36/44] builtin-am: invoke post-applypatch hook
Date: Tue,  7 Jul 2015 22:20:54 +0800
Message-ID: <1436278862-2638-37-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTms-0005PY-KW
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbbGGOXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:50 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33795 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699AbbGGOW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:22:58 -0400
Received: by pabvl15 with SMTP id vl15so114119266pab.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oXBue1V/KQharMDfl6XVYeVsGXm85bO4xffew/OV2TI=;
        b=D79sObiTJdGVB8zB7Phcl8ii5rADAQ4+dU/SGtOHeSaZ2O8HHddfwcGgW77yjf/Pxt
         GoakBjCzoVJ4ZIhgiAxtpvBMo6twhuwPD41UFbcrHi1O4RmRn9ISm5dsgBw53d5ueeY2
         5yI4I9SXd4xotb91RCY02oyYxQojZhGez+BoMb/Sb5OivlwMvqGxrS/04JfVaTmcuKpE
         px463kUSJUWCcmKK6EtX+vc3IYARuG9kHz7Mdb/DAixLI27P/Ee9QztSOHt/FiX0CwtX
         dH4lLTe9wcPtEdLWJFcfxaLWJg4QSdqB5b9e8kgUAwtthluX+CC5k8vlDOtOEhTN46il
         p/aA==
X-Received: by 10.70.43.136 with SMTP id w8mr9425255pdl.157.1436278977446;
        Tue, 07 Jul 2015 07:22:57 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:22:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273555>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the post-applypatch hook after the patch is
applied and a commit is made. The exit code of the hook is ignored.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 407775c..fdaf0a7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1418,6 +1418,8 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
+	run_hook_le(NULL, "post-applypatch", NULL);
+
 	strbuf_release(&sb);
 }
 
-- 
2.5.0.rc1.76.gf60a929
