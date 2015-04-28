From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4: t9814: prevent --chain-lint failure
Date: Tue, 28 Apr 2015 07:30:09 +0100
Message-ID: <1430202609-31841-2-git-send-email-luke@diamand.org>
References: <1430202609-31841-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 08:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymz2j-00059F-Ay
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 08:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbbD1Gat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 02:30:49 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38294 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbD1Gar (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 02:30:47 -0400
Received: by wiun10 with SMTP id n10so16278024wiu.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 23:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/ZZs9/dneo5Dq8+FU/ZC9T5Q3ldjKPgmd9AVXf1qnB0=;
        b=UntSfEjqGm2gPcoWLwgiq66myRoA3IVFS8Y+avnT2FxOHMsQ06qKhYosggHQeyFZgd
         yDGAe5Qfa+HYOrjGLILbBoALuyl0vaBKkMZjwmXPQulvLIk2DvKvhXKvZNQ40b5zkU0z
         ZUahzhXb9p8/xOWx2b59q2kZDsWPkqiKE+OXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/ZZs9/dneo5Dq8+FU/ZC9T5Q3ldjKPgmd9AVXf1qnB0=;
        b=TOnaRssRJpguCJgwqohFXz7jZjY4lofsqloXA1UaLGe8qyqLUQfdEfrnHK/bQVb3Fq
         hudFmiLjcN1bzAAolBClVdT6mCeycPB0N0xfh81E5ntk/yYdkZP7Bb95oMRzWCw6u1Ou
         abrFtMJ/VUWajIh6oEAFQpUfI0uxdaZJCvzgirBMohf5WgD08N3oPwugcKsJUUZcOQxE
         j04McMwo4Dp/6Rt+q47l585Ug1XdIkfOnrinILO8LxO+bBXBdg59wgsX2t2X8KGCfsCU
         WrUEd7Uug6ko9Q86G05NW/0R0mIAm6nh4zSkIEkMBr16sq2T3vEbuyKQpVdfPpZhR96K
         1Vyg==
X-Gm-Message-State: ALoCoQkclKsGwdtwwUHFvWdW6NiobdwrgjdMRs3E39WZOVFryTRSTOjkK+pjqJ73JwN4u/IsJVir
X-Received: by 10.181.13.198 with SMTP id fa6mr27289609wid.41.1430202646630;
        Mon, 27 Apr 2015 23:30:46 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id a18sm6543394wja.46.2015.04.27.23.30.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2015 23:30:45 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1430202609-31841-1-git-send-email-luke@diamand.org>
In-Reply-To: <20150427230223.GA22403@peff.net>
References: <20150427230223.GA22403@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267903>

Use test_lazy_prereq to setup prerequisites for the p4 move
test. This both makes the test simpler and clearer, and also
means they no longer fail the new --chain-lint tests.

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
