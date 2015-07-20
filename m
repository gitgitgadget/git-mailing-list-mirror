From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 19:26:30 +0100
Message-ID: <1437416790-5792-5-git-send-email-philipoakley@iee.org>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:26:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFlr-0006rG-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288AbbGTS0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:26:31 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:33942 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753990AbbGTS03 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 14:26:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DFCABiPK1VPHMBFlxcgkFSVGmIKbVChXsEAgKBLk0BAQEBAQEHAQEBAUABP4QkAQEEViMQCEk5CgMRBhMbiBcJt3yQVwErj28RAVEHhCsFjDiIGoRviTuWfoEJgxo9MQEBAYEKgT4BAQE
X-IPAS-Result: A2DFCABiPK1VPHMBFlxcgkFSVGmIKbVChXsEAgKBLk0BAQEBAQEHAQEBAUABP4QkAQEEViMQCEk5CgMRBhMbiBcJt3yQVwErj28RAVEHhCsFjDiIGoRviTuWfoEJgxo9MQEBAYEKgT4BAQE
X-IronPort-AV: E=Sophos;i="5.15,509,1432594800"; 
   d="scan'208";a="614509317"
Received: from host-92-22-1-115.as13285.net (HELO localhost) ([92.22.1.115])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 20 Jul 2015 19:26:29 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274342>

Explain how the cc-cmd (and to-cmd) is invoked, along with two
simple examples (and a how-not-to example) to help in getting started.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
http://article.gmane.org/gmane.comp.version-control.git/274302
---
 Documentation/git-send-email.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ddc8a11..9f991cf 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -436,6 +436,42 @@ following commands:
 Note: the following perl modules are required
       Net::SMTP::SSL, MIME::Base64 and Authen::SASL
 
+Creating a cc-cmd (and to-cmd) action
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+git-send-email invokes the cc-cmd like this:
+
+	$cc-cmd $patchfilename
+
+Thus the patch itself can be processed to locate appropriate email address
+information if required.
+
+A simple solution for a basic address list is to create a 'cc-cmd' file
+(executable) which provides a list of addressees:
+
+	#!/bin/sh
+	echo <<\EOF
+	person1@example.com
+	person2@example.com
+	EOF
+
+Simply, using `cat cc-cmd` as the --cc-cmd (with cc-cmd as the text file
+of email addresses), does not work as expected as the invocation becomes:
+
+	$cat cc-cmd $patchfilename
+
+and since 'cat' copies the concatenation of its input files to its output,
+this adds the patch file to the address list resulting in an error
+"unable to extract a valid address from:".
+
+The quick-and-dirty work-around is to use '#' to effectively comment out
+the patch file name:
+
+    --cc-cmd='cat cc-cmd #'
+
+which works, but is very, very ugly.
+
+
 SEE ALSO
 --------
 linkgit:git-format-patch[1], linkgit:git-imap-send[1], mbox(5)
-- 
2.4.2.windows.1.5.gd32afb6
