From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 01/12] t4150: am.messageid really adds the message id
Date: Tue,  7 Jul 2015 22:08:23 +0800
Message-ID: <1436278114-28057-2-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYN-0005SN-6n
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbbGGOIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:08:53 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32904 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962AbbGGOIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:08:51 -0400
Received: by pdbdz6 with SMTP id dz6so31797519pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KUnMXDvIBg4U9YOZZU7NUwdoe0pAODC4nsdE7RHTpF4=;
        b=QG+L4z/gMGkNAL8HOU7v4dhZAEbXxdTyoT1W2R0TayufgCgpgakeLaLcY+eeUBmgCu
         zec+oJi0NZvF/4KZHoNYhe/1juheud63VDT3CyAAtfAYw8zma9PAn4r0agrrEsdM1ieW
         aV3vklvgFukDhPKhDgPc6mxO1z5fA5CBKZ45/4LVJ/dLdNqZgwn/A36I3/+QqTfrFLtR
         +86+K/cF5L9RR5A7UFHdR9bcvSqGSHpYb64opCGIQRoYkoF0dFNU41EbNluc5HncRe0b
         4ouQra5SJICxbAGQirv7UeC5MBNe2rp7Aem57piB91uF+Gm4BgFRKt0ePsrlJk6yaJc1
         auQw==
X-Received: by 10.70.42.101 with SMTP id n5mr9427335pdl.93.1436278130700;
        Tue, 07 Jul 2015 07:08:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.08.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:08:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273506>

Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
the am.messageid setting determines whether the --message-id option is
set by default.

Add a test for this.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * don't use "git checkout -f" as it does not discard unmerged entries.
      Use "git reset --hard" instead.

 t/t4150-am.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index b822a39..264f53f 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -563,6 +563,18 @@ test_expect_success 'am --message-id really adds the message id' '
 	test_cmp expected actual
 '
 
+test_expect_success 'am.messageid really adds the message id' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout HEAD^ &&
+	test_config am.messageid true &&
+	git am patch1.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git cat-file commit HEAD | tail -n1 >actual &&
+	grep Message-Id patch1.eml >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'am --message-id -s signs off after the message id' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc1.76.gf60a929
