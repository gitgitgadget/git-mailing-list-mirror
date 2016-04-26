From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/3] git-p4 tests: cd to / before running python
Date: Tue, 26 Apr 2016 08:50:59 +0100
Message-ID: <1461657061-7984-2-git-send-email-luke@diamand.org>
References: <1461657061-7984-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 09:48:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxjO-0006Lm-6J
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbcDZHsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:48:22 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35918 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbcDZHsV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:48:21 -0400
Received: by mail-wm0-f53.google.com with SMTP id v188so115509076wme.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e91cTSqotVrjJCAz1ZpCBnL1daGkDXBbKoVQ0vWVgyY=;
        b=cFpIImaF52cQU+HOdWTh0SxQqZbxCRasGmLSSEqSoCmA5emiiiAxIQZEuxDiDDyAKP
         0S+P8/MniZH5sR2kh/j7fYM5xO54CZl2CcG22di688qQ7w8gv/tUroeIh9pm4Wkwl87s
         4j0L+WYgSnmcwYADES7g+VqV5c3+15y+gy2KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e91cTSqotVrjJCAz1ZpCBnL1daGkDXBbKoVQ0vWVgyY=;
        b=fAairIGLVjAJgNVN0lcj0w1BbvbMbC30UEZY45WGi30cIeg945adB/MbYm/qNBvHfK
         iGJkvwz/Cq0onbGNRNQRLWuGFctfSxGW7l1ueY4WoR6IBAzCieeinGH+Opq07op+7ikE
         uNxgpbkt9KSA/wsQJ8a9S45Gky2HIyV+shA2g46EtcbBo1SpMJz+dnWdGZI+pXB2wqUc
         yiItUKhCePHI5hNsQ6EHzjhgTbOiQF6gr7TQMYrPuhKGhwUtJlGPbEwCDL2URXB1n17k
         de3bhAH7ThhHs+vv2xVBMeREKsoYtXGMTfpxqz2w7OwyqaWiAKmXbp/va4p5Ak/Y9ije
         UC+Q==
X-Gm-Message-State: AOPr4FXNPLbT9DbSdzEl9ZSA+URzak0MzpJX7awTSXBYAFIfBRHX6PuHXTxcA4ZtE5khNg==
X-Received: by 10.194.58.138 with SMTP id r10mr1289985wjq.153.1461656899969;
        Tue, 26 Apr 2016 00:48:19 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id h8sm1734520wmd.2.2016.04.26.00.48.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 00:48:19 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
In-Reply-To: <1461657061-7984-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292588>

The python one-liner for getting the current time prints out
error messages if the current directory is deleted while it is
running if using python3.

Avoid these messages by switching to "/" before running it.

This problem does not arise if using python2.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index f9ae1d7..724bc43 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -50,7 +50,7 @@ native_path() {
 # at runtime (e.g. via NTP). The 'clock_gettime(CLOCK_MONOTONIC)'
 # function could fix that but it is not in Python until 3.3.
 time_in_seconds() {
-	python -c 'import time; print int(time.time())'
+	(cd / && python -c 'import time; print(int(time.time()))')
 }
 
 # Try to pick a unique port: guess a large number, then hope
-- 
2.8.1.218.gd2cea43.dirty
