From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/2] git-p4: add failing test for P4EDITOR handling
Date: Wed, 13 May 2015 08:36:14 +0100
Message-ID: <1431502575-2176-2-git-send-email-luke@diamand.org>
References: <1431502575-2176-1-git-send-email-luke@diamand.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>,
	Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 09:37:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsRE4-0001sF-K1
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 09:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933064AbbEMHhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 03:37:03 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36360 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034AbbEMHg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 03:36:58 -0400
Received: by wizk4 with SMTP id k4so186032166wiz.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDdL8ouHyRuBHLEsFMpSXYIOJ1Ecz46Eq9BdpHhqUCo=;
        b=XsUYPpO46JPKY0KJIA1nVbAkHJYlL+MPGNXWoFXRLnVsxowmk8I2iV4im5vLuErxmF
         mpT2FPsaT9Sj4oznIm+72Iir5Gr0pnITdbuRRcq3F1hbQErw2iqBHAep+Bcl9d4J6bkJ
         irwCRCv+IM+KbkeLAfP8/0Rjk1PDK1xier8VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GDdL8ouHyRuBHLEsFMpSXYIOJ1Ecz46Eq9BdpHhqUCo=;
        b=J0hsSdqvcRQS2LrxUBT5xjMTvQNSumB12bD/yaJZCac0SiWevoZDE9eBTzr58KeX9S
         T8qRo+7DiB6Fcpm2MwXiCi0XqNk3tcC8b0xLLS1t8fOrDgNkf53hv7d5/UXPvY1NBh/m
         ywkWM4EgiHNAlDoIBh/7Vcsv59suAtvLIod0Fw7n5LG6KmpFM1HmSQ7gwa4VrkRv5WZj
         bKXTaQmuyEd4OXQA5TJveUV+xssieIDjthaFjK3hbpAItyMKfgSzEZjZ2tBKvaosdAVc
         2MpJo+fgtZA2f7HlZPdn9hvNDDWiqPQvxqlVJrtfXH4i0aosfhRWPuuhrNg1kN0xRaJL
         X9Fw==
X-Gm-Message-State: ALoCoQkMYsEP+NJ2eRDbI9wRLE0hmlwUlxBdm1e42BWjViv5GL6L5HrRZs0bbt/vaMozWWsswyJk
X-Received: by 10.180.10.102 with SMTP id h6mr2405601wib.37.1431502616837;
        Wed, 13 May 2015 00:36:56 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id nb9sm6579871wic.10.2015.05.13.00.36.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 00:36:56 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
In-Reply-To: <1431502575-2176-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268942>

Add test case that git-p4 handles a setting of P4EDITOR
that takes arguments, e.g. "gvim -f"

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9820-git-p4-editor-handling.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 t/t9820-git-p4-editor-handling.sh

diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
new file mode 100755
index 0000000..e0a3c52
--- /dev/null
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -0,0 +1,38 @@
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
+	git p4 clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		echo change >file1 &&
+		git commit -m "change" file1 &&
+		P4EDITOR="touch \"$git/touched\"" git p4 submit &&
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
2.4.0.rc3.380.g8e2ddc7
