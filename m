From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/7] Add testcase showing how pathspecs are ignored with rev-list --objects
Date: Tue, 24 Aug 2010 20:53:09 -0600
Message-ID: <1282704795-29661-2-git-send-email-newren@gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo65q-0007sX-BI
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756413Ab0HYCvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:51:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33622 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab0HYCvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:51:46 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so180848vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=47RgC91/XYInPbLX1dHqEYeEaCl8As+PPxARk98CjJ4=;
        b=kfONjC3kk9pkszGTcFy4u0UdJ6PT05DFHS0o1O32mnrPDKGDiejqJ76XBTTy2M1n0T
         U8IvXeltGxG9bFEhpFVoJGZIWqpyLlZKOP80cmt/MUsnDwoWeZbkIhmnZc7wZyDNFAsM
         T0AffouoswD9ergTNoMTZqKtaAxkKjafSD6ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PqZHlBigifH2oHfKqfN7H9C8SLAJPAkFdtLp8q3/Iym4PB6FpznrD+a+XVaWwIr7ke
         H6QBAP9ceJmJjLznc83CvZxfbtKUFS1WbamXsWIKU4s0TAp+tjDMvVbbHYb70oSLy5g3
         6jWvPjNNUT6LA3odlQ1jNPVvCouEo/kC8NGSM=
Received: by 10.220.88.22 with SMTP id y22mr4771486vcl.12.1282704706419;
        Tue, 24 Aug 2010 19:51:46 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id v11sm577473vbb.3.2010.08.24.19.51.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:51:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.39.gf7e23
In-Reply-To: <1282704795-29661-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154394>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
It looks like the 19 rev-list testcases (t6000*-t6019*) are all fairly
specific, and I didn't see one where this testcase seemed to make sense;
or perhaps I just missed it.  I just created this 20th file to hold all
other miscellaneous rev-list testcases; if it does make more sense in
one of the other existing files, just let me know.

 t/t6000-rev-list-misc.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
new file mode 100755
index 0000000..2c403ac
--- /dev/null
+++ b/t/t6000-rev-list-misc.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='miscellaneous rev-list tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo content1 > wanted_file &&
+	echo content2 > unwanted_file &&
+	git add wanted_file unwanted_file &&
+	git commit -mone
+'
+
+test_expect_failure 'rev-list --objects heeds pathspecs' '
+
+	git rev-list --objects HEAD -- wanted_file >output &&
+	grep wanted_file output &&
+	! grep unwanted_file output
+
+'
+
+test_done
-- 
1.7.2.2.39.gf7e23
