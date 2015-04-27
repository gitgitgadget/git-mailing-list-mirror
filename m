From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: prevent --chain-lint failure
Date: Mon, 27 Apr 2015 23:20:28 +0100
Message-ID: <1430173228-22004-2-git-send-email-luke@diamand.org>
References: <1430173228-22004-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 00:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmrOq-0002aJ-P9
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 00:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbbD0WVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 18:21:08 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33299 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312AbbD0WVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 18:21:06 -0400
Received: by wgin8 with SMTP id n8so131282774wgi.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhBI1Ob4gLhlGzQTt9ctmy1LgPR/pOut06TYTRrXVKw=;
        b=HnHM6evdnJr5kVKWPcGWLMaDaJI40tCTHRwqtZWc4PeHKU1yHSs7RHlFf/+ClMDHU9
         ziUg1Vytz4HKUXDXG0vlFeRO9iLm5PSGkZO+QAXWENMbAuXJyVYoyVR6g9WgXsjAs3yt
         CgtkvD8rAvAE1RKL0WvFdhliDONpdVQrIgaGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hhBI1Ob4gLhlGzQTt9ctmy1LgPR/pOut06TYTRrXVKw=;
        b=FHm9z0wCN5+mJ6ccjhP9i2v6aLytBR/3nv9HMxtQTxw4HxVyldUhvxg3f+NL4UsAvS
         UPDOMu5wqpG5vntHAeApGrFF7/SivjFe+G5DAT76pXSDoU4dGAe4KNeP1H3jx6rzvYAp
         w0pQaCIMZDDb31QTDbM+cEXHihaevJFwAmjsyjd6tFqN4WMfqPu9VoiqL4PRQgc7AjmV
         7irlcIQiscxXbFb06x/J2AzOxpb8wwC8babhZPlXHiDKnEqXU6+i4bC+2rd+cSmEncvi
         0KIlY8r+1UcHj/q11kj9q7NHUULNYa7wEeQf+TXqc2XG8Kpi7FTKFXEuiii6V2uv/otq
         +eWA==
X-Gm-Message-State: ALoCoQnyT6N5F6g95F88C04M2ivBIHUBkeKkX6xanxzb4zfcXRbOCe9+nFM3CGuDQvLkMSfO+Q0J
X-Received: by 10.181.13.144 with SMTP id ey16mr24612091wid.38.1430173265471;
        Mon, 27 Apr 2015 15:21:05 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id k2sm13477177wix.4.2015.04.27.15.21.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2015 15:21:04 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1430173228-22004-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267885>

t9814 has a test that simply sets up a pre-requisite for
another test, and as such, always succeeds. The way it was
written doesn't quite work with the test lint checks introduced
with the --chain-lint option.

Add an additional layer of {} to prevent the --chain-lint
code getting confused.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9814-git-p4-rename.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 99bb71b..14f9dc3 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -227,13 +227,15 @@ test_expect_success 'detect copies' '
 # See if configurables can be set, and in particular if the run.move.allow
 # variable exists, which allows admins to disable the "p4 move" command.
 test_expect_success 'p4 configure command and run.move.allow are available' '
-	p4 configure show run.move.allow >out ; retval=$? &&
-	test $retval = 0 &&
-	{
-		egrep ^run.move.allow: out &&
-		test_set_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW ||
-		true
-	} || true
+    {
+	    p4 configure show run.move.allow >out ; retval=$? &&
+	    test $retval = 0 &&
+	    {
+		    egrep ^run.move.allow: out &&
+		    test_set_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW ||
+		    true
+	    } || true
+    }
 '
 
 # If move can be disabled, turn it off and test p4 move handling
-- 
2.3.4.48.g223ab37
