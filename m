From: larsxschneider@gmail.com
Subject: [PATCH v2] convert: legitimately disable clean/smudge filter with an empty override
Date: Fri, 29 Jan 2016 09:21:37 +0100
Message-ID: <1454055697-6742-2-git-send-email-larsxschneider@gmail.com>
References: <1454055697-6742-1-git-send-email-larsxschneider@gmail.com>
Cc: tboegi@web.de, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 09:22:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP4JP-0008BC-3h
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 09:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbcA2IVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 03:21:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34794 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbcA2IVm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 03:21:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id p63so8374382wmp.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 00:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5MpPCNBkUx0ZyU0UJ0J9PWwAkP146eGUR7y5maC2J/w=;
        b=v35TTIqchr/TcesNVRaeT2awEN5K58g5i5FY0658t7h2hHQ30l8S78wOdYNRV8iYUj
         zog6Jfhhi7NCdqPduLBwa2+8Odf2hJ0pOznkjxu4q8ohUdXjc0fDs4wzPVcg03MP1nkh
         KueDeZe3baEE/oHxbUtH6phU1dqqp79A/zbgFfN4x4YfAdrd8ffJJNksnxI3i5BWTC20
         vlenbrddCEJo+JNDxO5MaDwFIjmdANxqtJOQTMJN+Kiz3QWtSalYxK/4vyzt0Iy94NCB
         7D57FoAhZndqHYIDFp/vbWEABUmVVTwBWPJhqwaBlbEfELTG84HTHJS36ClaJTYpSEYx
         24Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5MpPCNBkUx0ZyU0UJ0J9PWwAkP146eGUR7y5maC2J/w=;
        b=CLwMTDf9ROJzglVgvtVKLn7qgr5z4J1jPLHSSmpki24Yp8z8WXwOJ2DOg5xYUart0f
         LywTpxQ6ESN1N7trwj7MjizhIZTUM/0hbL3cwx80rAq2VTfUl0kvswxGuV3PYahG4c36
         dO/PdHlIRGYXkZ4UUW2MPcQzTwwnhS/0mNdoKLDiaTR6LP/+KG62FAX3zPsM735qjBYP
         4+7GeiwIBOXkesFNUkEIx8et2rmTcbD6V2xdStTqytldouNmNIqvEQsyC0rfTOb7WxNY
         CVUwu0blLPW97rJzcdb01YrwGo4udl47Nnzwzzj8I3uEBrkCuk8kPNOFrI/ir2yNbvxg
         U1xw==
X-Gm-Message-State: AG10YOQqJsyjFeZuEOPGIOQ41kOzVK56tVpH10PV6SPUd+YbJfc/Z0AMSUCAv1oMXi0KjQ==
X-Received: by 10.194.71.135 with SMTP id v7mr7258329wju.106.1454055700966;
        Fri, 29 Jan 2016 00:21:40 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA916.dip0.t-ipconnect.de. [80.139.169.22])
        by smtp.gmail.com with ESMTPSA id i5sm14457681wja.23.2016.01.29.00.21.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jan 2016 00:21:40 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1454055697-6742-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285072>

From: Lars Schneider <larsxschneider@gmail.com>

If the clean/smudge command of a Git filter driver (filter.<driver>.smudge and
filter.<driver>.clean) is set to an empty string ("") and the filter driver is
not required (filter.<driver>.required=false) then Git will run successfully.
However, Git will print an error for every file that is affected by the filter.

Teach Git to consider an empty clean/smudge filter as legitimately disabled
and do not print an error message if the filter is not required.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c             |  2 +-
 t/t0021-conversion.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 814e814..02d5f1e 100644
--- a/convert.c
+++ b/convert.c
@@ -395,7 +395,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	struct async async;
 	struct filter_params params;
 
-	if (!cmd)
+	if (!cmd || !*cmd)
 		return 0;
 
 	if (!dst)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 718efa0..7bac2bc 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -252,4 +252,20 @@ test_expect_success "filter: smudge empty file" '
 	test_cmp expected filtered-empty-in-repo
 '
 
+test_expect_success 'disable filter with empty override' '
+	test_config_global filter.disable.smudge false &&
+	test_config_global filter.disable.clean false &&
+	test_config filter.disable.smudge false &&
+	test_config filter.disable.clean false &&
+
+	echo "*.disable filter=disable" >.gitattributes &&
+
+	echo test >test.disable &&
+	git -c filter.disable.clean= add test.disable 2>err &&
+	test_must_be_empty err &&
+	rm -f test.disable &&
+	git -c filter.disable.smudge= checkout -- test.disable 2>err &&
+	test_must_be_empty err
+'
+
 test_done
-- 
2.5.1
