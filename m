From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 1/2] test-lib: add a function to compare an expection with stdout from a command
Date: Sat, 16 Apr 2016 12:13:49 -0400
Message-ID: <1460823230-45692-2-git-send-email-rappazzo@gmail.com>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	szeder@ira.uka.de, peff@peff.net,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:14:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arSrH-0003qV-K5
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 18:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbcDPQOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 12:14:01 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:36105 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcDPQOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 12:14:00 -0400
Received: by mail-qg0-f68.google.com with SMTP id f105so12855682qge.3
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mlD+opnmditqwcfXHZzAlvqCc4Ndbn5vRyfSw5gBgLI=;
        b=WpBmpZU1vN3XDlMoEOmUlw3RO6Wi7VlzGJ6zCc6FXRBWe/eogBTXcwL+TRcxZoiHuL
         8LkJ/sNfoTXgmzPhMeakLd5nMvqox/9ai5/D2jKcGumzvQXdxKepFKQ+oWiV6lPagPI3
         XiuHipKcFeOyPTRbbluzhhFQwaKL9l1k3P8C2PCR65NynUiwfxXqzvhc5tUh20kIIRbM
         7D1Q8xVpgiXf/ylPki7ZPPha2EnIqT6U0iF7knxZGXP6skEe7xUev+tQiDuWFhzK2b5V
         9Yw10zr+HiTawM3e641sVdn6Oy8x6eodNpTHVt4/f7VmpV0ftpf/cWBH0xpuI96HrTkF
         5qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mlD+opnmditqwcfXHZzAlvqCc4Ndbn5vRyfSw5gBgLI=;
        b=QUZYSpB7IXpP76M0BmDrUgMop707Akl8LQ8VnsveQ+kotBoG/crSPAab0MRMqMhiT6
         9msq6RJ0d9mdIoOHY2hAuh0T8C29UIthcbfCAXQKHxrf0HW3klIhzWagiiiINV4nrzat
         PP2yHJcRtt3M4mFeFNIcz5T9TRLBSNKkvPhXJkqYys1Pr6x7vODx1HceSwyDAhFp8XRm
         aJDe8SW3fcp774/fJqMaqrpe/EXJpsj+7DknE4W0SzIFbXejZ+5mpX4k30Ech8g2inpN
         7tdN06hgRCqeNxt55i3rZzfDJ+lqTZTlvtvmjoYR+0AmoPYundDTahviaVfyODtop0ip
         Fn2w==
X-Gm-Message-State: AOPr4FU8I4l8L9vVO7Cpk5ciw6Q0TDyWDDwJqF3tv7t5ktzKkuWE8M2uSeNGO3DE9jJEow==
X-Received: by 10.141.46.71 with SMTP id x68mr34681633qhe.70.1460823239123;
        Sat, 16 Apr 2016 09:13:59 -0700 (PDT)
Received: from MRappazzo-8.local.info (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id w69sm22643384qhw.3.2016.04.16.09.13.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 16 Apr 2016 09:13:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291730>

test_stdout accepts an expection and a command to execute.  It will execute
the command and then compare the stdout from that command to an expectation.
If the expectation is not met, a mock diff output is written to stderr.

Based-on-a-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/test-lib-functions.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d99eb3..95e54b2 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -941,3 +941,37 @@ mingw_read_file_strip_cr_ () {
 		eval "$1=\$$1\$line"
 	done
 }
+
+#	test_stdout is a helper function to compare expected output with
+#	the standard output of a command execution
+#
+#	Args:
+#		1: The expected output
+#		2: The command to run
+#
+#	You can use it like:
+#
+#	test_expect_success 'foo works' '
+#		test_cmp "This is expected" cmd_to_run arg1 arg2 ... argN
+#	'
+#
+#	The output when there is a mismatch mimics diff output, but this
+#	can break down for a multi-line result
+test_stdout () {
+	expect=$1
+	shift
+	if ! actual=$("$@")
+	then
+		echo "test_stdout: command failed: '$*'" >&2
+		return 1
+	fi
+	if test "$expect" != "$actual"
+	then
+		echo "test_stdout: unexpected output for '$*'" >&2
+		echo "@@ -N +N @@" >&2
+		echo "-$expect" >&2
+		echo "+$actual" >&2
+		return 1
+	fi
+	return 0
+}
-- 
2.8.0
