From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 22/24] t1600: add index v5 specific tests
Date: Wed, 27 Nov 2013 13:00:57 +0100
Message-ID: <1385553659-9928-23-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldpO-0002HU-T4
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab3K0MCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:42 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:37074 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab3K0MCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:40 -0500
Received: by mail-lb0-f178.google.com with SMTP id c11so5480608lbj.9
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jliM1mq3uQCaCrREkfpRpN+MUWbUnU3k3aLOW0zpZvY=;
        b=whJ4bD5Z4NPwTzYc4UIkYgRGkhpnIhE/NPVufEkIuwTP3wAFONJHGdFLUODT2ydvih
         9WZ4W3dh3gge+HAdqhv5f0n6METb96qVILJjCnxjWOiSodrKuunOFEx8cXG/jp0u+StB
         1TZIfJDz1CnCXgupZU2UYkLSIw1is3WYLhmpUVooMdf5c+DNkoY3Q3Ip/XSFUaY/VqKR
         BoAsLUlBqJIAb8FlMT8lSkTahlnBB3SPqGBy2487p4pl1TfVphbXtQok3sK9lVV95fmY
         1M1cz4o/yWVff+x91L1tI8fgQqdcEf/KDq34JNw7NEGysHtY6yeXtYb8weZR9k7RYrpd
         en4A==
X-Received: by 10.112.205.6 with SMTP id lc6mr15513lbc.45.1385553758662;
        Wed, 27 Nov 2013 04:02:38 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id l10sm45481475lbh.13.2013.11.27.04.02.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:37 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238435>

Add a test that tests only index v5 specific corner cases, to protect
against breaking them in the future.

Currently there is only one known case where the sorting is broken if
the index is read filtered with two different length pathspecs.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t1600-index-v5.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 t/t1600-index-v5.sh

diff --git a/t/t1600-index-v5.sh b/t/t1600-index-v5.sh
new file mode 100755
index 0000000..fe68976
--- /dev/null
+++ b/t/t1600-index-v5.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description="Test index-v5 specific corner cases"
+
+. ./test-lib.sh
+
+test_set_index_version 5
+
+test_expect_success 'setup' '
+	mkdir -p abc/def def &&
+	touch abc/def/xyz def/xyz &&
+	git add . &&
+	git commit -m "test commit"
+'
+
+test_expect_success 'ls-files ordering correct' '
+	cat <<-\EOF >expected &&
+	abc/def/xyz
+	def/xyz
+	EOF
+	git ls-files abc/def/xyz def/xyz >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4.2
