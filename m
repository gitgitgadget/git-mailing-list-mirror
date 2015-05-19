From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 1/3] git-p4: add failing test for P4EDITOR handling
Date: Tue, 19 May 2015 23:23:16 +0100
Message-ID: <1432074198-13806-2-git-send-email-luke@diamand.org>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
 <1432074198-13806-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 00:24:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupvu-0005dQ-5a
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbbESWYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:24:05 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36624 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbESWYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:24:02 -0400
Received: by wgbgq6 with SMTP id gq6so33518018wgb.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iTDxCN34J2iL8R7F0I/pQ6daQl2VSDfA/1MVdzYkzHw=;
        b=ebae4ynKatom+spAp+wCZaqX/r3XplBI41I1tRflkBYZQwVOPFx6NEaxWkZISodLam
         N9V1NzYzuI46bSCQ4SsJMM1pC2VdmjkCFSTG17APGl2lg1R+4tbM4IQ8Jei77xvWN0rJ
         PLYjOO8Mxo2fZTz11TbpBO8PHw+QeAwK5zcwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iTDxCN34J2iL8R7F0I/pQ6daQl2VSDfA/1MVdzYkzHw=;
        b=BfuQiT8psxhNJKXp2PCtlbGlbPnnBQGv62bc8GQzFiTtOGZWMYeueX1LBaPIgFhAMj
         EYKyAKatJyK2+kPxyVyzvq98yoa5Ie7uEgUIZDQLAOK2h6lz8/hA26nxp2VkQTnTTcf0
         VRy2cNWCwThUu79l44Wwt7vbAv2DXtsbHrE9pJ+LzWECqWZ46mxXicS8YeKqo4pYeuCR
         GHV1yWKAINVKUbKAn+UfbzuxUf2+gT+aOB0khKrb5IHN8UGbfvtHI9fE5vZH50UNH00Y
         FEk2VIMjXI+RcPq7h3tvT3vg46wHCWg7+fLc7z00jeEuZFFUS983MQrF/KwRtlCkuKQ/
         wTEQ==
X-Gm-Message-State: ALoCoQk9OdPuwiRLT7twAVUyJByPDITsqwiVGfSJPe1cbVuWYBeeOioe5kktupHymuxNjRtl+abA
X-Received: by 10.180.188.170 with SMTP id gb10mr36163101wic.39.1432074241411;
        Tue, 19 May 2015 15:24:01 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id x10sm23711568wjf.45.2015.05.19.15.24.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 15:24:00 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1432074198-13806-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269424>

Add test case that git-p4 handles a setting of P4EDITOR
that takes arguments, e.g. "gvim -f". This currently fails.

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9820-git-p4-editor-handling.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100755 t/t9820-git-p4-editor-handling.sh

diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
new file mode 100755
index 0000000..af924bb
--- /dev/null
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='git p4 handling of EDITOR'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "file1"
+	)
+'
+
+test_expect_failure 'EDITOR has options' '
+# Check that the P4EDITOR argument can be given command-line
+# options, which git-p4 will then pass through to the shell.
+test_expect_success 'EDITOR has options' '
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		echo change >file1 &&
+		git commit -m "change" file1 &&
+		P4EDITOR=": >\"$git/touched\" && test-chmtime +5" git p4 submit &&
+		test_path_is_file "$git/touched"
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.4.1.502.gb11c5ab
