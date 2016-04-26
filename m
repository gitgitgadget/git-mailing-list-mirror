From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 3/3] git-p4 tests: time_in_seconds should use $PYTHON_PATH
Date: Tue, 26 Apr 2016 08:51:01 +0100
Message-ID: <1461657061-7984-4-git-send-email-luke@diamand.org>
References: <1461657061-7984-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 09:48:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxjU-0006Lm-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbcDZHs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:48:27 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37625 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbcDZHsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:48:23 -0400
Received: by mail-wm0-f41.google.com with SMTP id n3so20841172wmn.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aM0okGSnrueH9SSCEaEk2VuJFq1bAElBb3WVajzRuLA=;
        b=V3fIdgzIaZbN+x/Kpp8T6Mw2NGLLKCoA0tmwW7A0rHcRxGmsAQMKn8ItDHml0u8sPQ
         pRWo0OPF47Qfu2VRd0GoM91PmFR+yBB663wLTowGh8Fv4EinpWHPJIrKKBydLospAYJV
         w15mW26UAYYf0Jr5TNpDwAKIP36mB0CfxA09Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aM0okGSnrueH9SSCEaEk2VuJFq1bAElBb3WVajzRuLA=;
        b=FN6MCP4trPyKShRDTUxuw/Ln/qryEkJhl7hh3lF4hmmqnBtioVxCklpE7J25Sqpv/P
         2dcY7ZAnNP68SnakkGK6+lMzFCyetph5Si7hnrYVcGGoJsF+VAYq0ZFf7WdkPskuk5Pv
         EsvcAGzjZaEFVElsatSnE+MzFFSvAms+4t1tIaPEN+N1ek/2vhq2oie5ZpzWdqeWG3TP
         G9Bsber2xziCfGQt+4OqpgSXe7rYZ0oW7uPLFF5KYLPNdwja5pXDrtcxHbzXfT/xV157
         VIejKZvS/kixybL762AHqrd/Ts5aYPvQhnvtjYTkq+a2fUB/dIvrmNEnzZvuwY074TB1
         /H5w==
X-Gm-Message-State: AOPr4FUa3fIDWnCYNDOkj3hpjToyxUv9RsFr20w/cjU3+Soca5REPpowNKs0/5MQ5SxoKQ==
X-Received: by 10.28.0.87 with SMTP id 84mr15540581wma.68.1461656902046;
        Tue, 26 Apr 2016 00:48:22 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id h8sm1734520wmd.2.2016.04.26.00.48.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 00:48:21 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
In-Reply-To: <1461657061-7984-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292590>

The time_in_seconds script should use $PYTHON_PATH, rather than
just hard-coded python, so that users can override which version
gets used, as is done for other python invocations.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 7393ee2..012d40e 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -50,7 +50,7 @@ native_path() {
 # at runtime (e.g. via NTP). The 'clock_gettime(CLOCK_MONOTONIC)'
 # function could fix that but it is not in Python until 3.3.
 time_in_seconds() {
-	(cd / && python -c 'import time; print(int(time.time()))')
+	(cd / && "$PYTHON_PATH" -c 'import time; print(int(time.time()))')
 }
 
 # Try to pick a unique port: guess a large number, then hope
-- 
2.8.1.218.gd2cea43.dirty
