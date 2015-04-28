From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3] git-p4: t9814: prevent --chain-lint failure
Date: Tue, 28 Apr 2015 08:21:22 +0100
Message-ID: <1430205682-4309-2-git-send-email-luke@diamand.org>
References: <1430205682-4309-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 09:22:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmzqJ-0004jR-0C
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbbD1HWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 03:22:01 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38906 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbbD1HV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 03:21:58 -0400
Received: by wiun10 with SMTP id n10so17600410wiu.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yb7dHsBDzFpuFWgL+p9CllqFJ0Web0N17jPacgSOPCs=;
        b=KWZ7Ss58TrpRVYFW/3UfmrUqlWsONtT2FTWQwzHqaVvdQgQQ+Ppd1KzhD1396aAteY
         8JCBai55uPv9iFJrgs99CxYegQdbPktCXwxPkXuwEveHRDvgyxtHLJLm7JTxza8PGM9M
         gYP+Q1/3xs4I5vi1T+3lUGSMY/WmYnhG68jMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yb7dHsBDzFpuFWgL+p9CllqFJ0Web0N17jPacgSOPCs=;
        b=KSMpM86B9vond2eR3961InaDtpjkOtPUS5j4bRw2eziqsXqqSvCTxJq/11m2ipHI3+
         uYI34oFO5gVemcqAppDG3PVQU2VDyPsnF3lh9xRGvNkXE10e3ltZ1dvmhaK7u7BljPyY
         51kj9kOcBLXGHS1i2fXW5qgSF22qHAz4poaUvY/uvny+o4jM/o3MaxUj81MgZViEsf/a
         TH6oRBhN5ngpI9DGqYgUC5O2Cx83tJ2x+oiPpZahbjepuvLA+GdrFPuFgqPnJ8EegRe6
         T+ynuxfbZbPGJzyg0WnX7+oLn+2ebwYv8eyVZwtC5HjTckHJklmieGHSwNokRgJI+SDb
         qL0A==
X-Gm-Message-State: ALoCoQnSHYUD/aWDjwZbgctYvHG4zN+XnZFQgbpn0HDqx+bVLFPOGXf+wk+Mqt76RCs5JeL+PPBt
X-Received: by 10.180.94.39 with SMTP id cz7mr26626782wib.66.1430205717467;
        Tue, 28 Apr 2015 00:21:57 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id gj7sm14954864wib.4.2015.04.28.00.21.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 00:21:56 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1430205682-4309-1-git-send-email-luke@diamand.org>
In-Reply-To: <1430202609-31841-1-git-send-email-luke@diamand.org>
References: <1430202609-31841-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267910>

Use test_lazy_prereq to setup prerequisites for the p4 move
test. This both makes the test simpler and clearer, and also
means it no longer fails the new --chain-lint tests.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9814-git-p4-rename.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 99bb71b..c89992c 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -226,14 +226,9 @@ test_expect_success 'detect copies' '
 
 # See if configurables can be set, and in particular if the run.move.allow
 # variable exists, which allows admins to disable the "p4 move" command.
-test_expect_success 'p4 configure command and run.move.allow are available' '
-	p4 configure show run.move.allow >out ; retval=$? &&
-	test $retval = 0 &&
-	{
-		egrep ^run.move.allow: out &&
-		test_set_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW ||
-		true
-	} || true
+test_lazy_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW '
+	p4 configure show run.move.allow >out &&
+	egrep ^run.move.allow: out
 '
 
 # If move can be disabled, turn it off and test p4 move handling
-- 
2.3.4.48.g223ab37
