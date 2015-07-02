From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 01/12] t4150: am.messageid really adds the message id
Date: Fri,  3 Jul 2015 02:16:29 +0800
Message-ID: <1435861000-25278-2-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj31-0006Fw-Un
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbbGBSRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:15 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34913 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbbGBSRL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:11 -0400
Received: by pactm7 with SMTP id tm7so44103834pac.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eB6ujrTKZzWwOfyAASziTzmWHTQ1oGZqnRhXPIYrvD0=;
        b=HoDDte+XkiJlyAPE9UMYw6vvPArdcRNOOcjPFxpcqhlS5CfDhuw+WJQaajK+f59VG1
         udgRTAJpDI/8Jag2Msal16ZamAb5ik2S1IGEtzmU6gWGaHKzgognNdH417fOhUytffqP
         0m8NooeaafK45xVziUDv2cIq1qm2q0gJiz67NJZrpYcJ3dgy4XsXB5dDYlMkdxa8t2WS
         zkePBBpEbmcogErSOORtk8Dh9TsyZwO4mpMl3IXq8LqXR4sh44D4JCIO5RPXw3yibmPK
         /fJkRJ6pNBFxI8gxmEf0b4yNlPN9fk/XoPyqT7KaXGsTQpnNCo+i++zqTzIW48CZeRux
         44Vg==
X-Received: by 10.68.192.74 with SMTP id he10mr10672554pbc.64.1435861030592;
        Thu, 02 Jul 2015 11:17:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273255>

Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
the am.messageid setting determines whether the --message-id option is
set by default.

Add a test for this.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index b822a39..3f54bdf 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -563,6 +563,17 @@ test_expect_success 'am --message-id really adds the message id' '
 	test_cmp expected actual
 '
 
+test_expect_success 'am.messageid really adds the message id' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f HEAD^ &&
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
2.5.0.rc1.81.gfe77482
