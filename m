From: larsxschneider@gmail.com
Subject: [PATCH v1 1/3] travis-ci: move "after_failure" code to dedicated file in /ci
Date: Sun, 22 May 2016 13:00:54 +0200
Message-ID: <1463914856-64745-2-git-send-email-larsxschneider@gmail.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 13:01:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4R8K-0001yu-1d
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbcEVLBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 07:01:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33846 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbcEVLBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:01:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so7685068wmn.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fNfiBVkzmF0yT++CypTEKXcJSI+ydghblOH+9VEeZy0=;
        b=SFXVb4UtYJCORdppl6OIQigvrjkLeOqPFcz3kZj2Ov5AUtdo3LLsu8RmWCdVGRS9W8
         tQsvPKSmNNxa+DlU+n7q9WyLpCSwIlmDMD53o1g/S+F+NROM1z0Fbj/pfbEABidosmxM
         o+WJ4yQU+Z2Lk4QuSOLRC3Z69/qECiCOLFPlGAo/ocyf/olJh6mn/puq4OFMMu7b08KK
         qmT6O46Gb8NtNu1JDQ3uRqdZHSFYZwabtP1/LmO+orlZYrS7wD0veKIbX3FDd1R3fRoB
         6w8FZf2RSUNxfE+wsjiHmyHmWDV7MT/p4mrStCOreoT9l+RDLtAv4oQENWSwvH+wcwCP
         jQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fNfiBVkzmF0yT++CypTEKXcJSI+ydghblOH+9VEeZy0=;
        b=WgfsfdsqNYENoxGVdduA/zFVAF7NC2qu9saa7TQlxjmJOIjsTMfEIhXuLpL6uQ0Fsb
         UKkQvZyJVizOE2q9N51e0sN63xirrXuE09D4hL8OFO4U7NNouFH4eNTAXPOqNWDrioHY
         tvtUYMv9MPx7gqYnfug9EwdEkVjKm7Q36wdnqrl2eazi8hbPjLSijts+AXVE8KB8CiW5
         fBWnBIcPNP9YaQEXyyCl56bhpUPVSQW+HjRXM3eeCO8Z9oM6Em++YhJ4fHM4pnedvvJO
         4O3xyG/CG1WOcS9YJ7UVlioPLrtiIppn3wh0If3ikeXL0KWb0+IJFpGkq2nmLW4CcMl+
         0JzA==
X-Gm-Message-State: AOPr4FWl+Qm/kc3CcLO4CP4jsanDQAEv/Ipfo3T/UDwpz/yLZtTEkJQyLzAQ3WEQvgrHRw==
X-Received: by 10.28.46.209 with SMTP id u200mr11423934wmu.97.1463914859491;
        Sun, 22 May 2016 04:00:59 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB5ECD.dip0.t-ipconnect.de. [93.219.94.205])
        by smtp.gmail.com with ESMTPSA id u4sm29343478wjz.4.2016.05.22.04.00.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 May 2016 04:00:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295278>

From: Lars Schneider <larsxschneider@gmail.com>

Move the code and adjust it to the Git shell script coding guidelines.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml       | 12 +-----------
 ci/test-report.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)
 create mode 100755 ci/test-report.sh

diff --git a/.travis.yml b/.travis.yml
index adab5b8..a93ecb3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -101,17 +101,7 @@ script: make --quiet test
 after_failure:
   - >
     : '<-- Click here to see detailed test output!                                                        ';
-    for TEST_EXIT in t/test-results/*.exit;
-    do
-      if [ "$(cat "$TEST_EXIT")" != "0" ];
-      then
-        TEST_OUT="${TEST_EXIT%exit}out";
-        echo "------------------------------------------------------------------------";
-        echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)";
-        echo "------------------------------------------------------------------------";
-        cat "${TEST_OUT}";
-      fi;
-    done;
+    ./ci/test-report.sh
 
 notifications:
   email: false
diff --git a/ci/test-report.sh b/ci/test-report.sh
new file mode 100755
index 0000000..d08a999
--- /dev/null
+++ b/ci/test-report.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+#
+# Print test results
+#
+for TEST_EXIT in t/test-results/*.exit
+do
+	if test "$(cat "$TEST_EXIT")" != "0"
+	then
+		TEST="${TEST_EXIT%.exit}"
+		TEST_OUT="${TEST}.out"
+		echo "------------------------------------------------------------------------"
+		echo "  $(tput setaf 1)${TEST} Output$(tput sgr0)"
+		echo "------------------------------------------------------------------------"
+		cat "$TEST_OUT"
+		echo ""
+		echo ""
+	fi
+done
+
-- 
2.5.1
