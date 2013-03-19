From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/6] t2200: check that "add -u" limits itself to subdirectory
Date: Tue, 19 Mar 2013 15:44:51 -0700
Message-ID: <20130319224451.GB19014@google.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:45:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI5HX-0008NQ-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934421Ab3CSWo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:44:56 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34390 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab3CSWoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:44:55 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so810362pbc.36
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=h6JjZWllQe0AL/EAqxNm45h+FFcndEaO9MZa//gvsko=;
        b=W8VR/onp7xRcCB17d6cDoUBOeeZprOg1LvFHssbYH0Q2fLBC4ZQnut7B0aUk2uPb8o
         CXAqbH164xel+VZ7nWQdJvAPFbodD3b5z9GIHMKj+tMEh5tFCrS7dmbX7A6PTOLw9moi
         RG7QWdJcES5FuaB/zGXF97EnI3tehEMG5dXG9qdYun05ktB8Hj5FedclFpQ9Zw/t9dgo
         xk8Q7pElaO2IQYQLW57pJXCynId9cALEjzPpPwFhdxXJtkypTUwlevu+gInoqDW/Yls7
         jEd8YHFP0EFGxsmpmK0H8SnpTsVP12w+JdXRkMcmv3tmGJ00k7wnoeYjBibU+3ynRQDv
         ypdA==
X-Received: by 10.66.234.33 with SMTP id ub1mr200012pac.29.1363733095381;
        Tue, 19 Mar 2013 15:44:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id y13sm25795718pbv.0.2013.03.19.15.44.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 15:44:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319224400.GA19014@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218561>

From: Jeff King <peff@peff.net>
Date: Thu, 14 Mar 2013 02:44:04 -0400

This behavior is due to change in the future, but let's test
it anyway. That helps make sure we do not accidentally
switch the behavior too soon while we are working in the
area, and it means that we can easily verify the change when
we do make it.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged, only included for reference.

 t/t2200-add-update.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 4cdebda..c317254 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,6 +80,22 @@ test_expect_success 'change gets noticed' '
 
 '
 
+# Note that this is scheduled to change in Git 2.0, when
+# "git add -u" will become full-tree by default.
+test_expect_success 'non-limited update in subdir leaves root alone' '
+	(
+		cd dir1 &&
+		echo even more >>sub2 &&
+		git add -u
+	) &&
+	cat >expect <<-\EOF &&
+	check
+	top
+	EOF
+	git diff-files --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success SYMLINKS 'replace a file with a symlink' '
 
 	rm foo &&
-- 
1.8.2.rc3
