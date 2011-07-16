From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RDD/PATCH v3 23/23] t5800: point out that deleting branches does not work
Date: Sat, 16 Jul 2011 15:03:43 +0200
Message-ID: <1310821424-4750-24-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Yq-0005cV-HP
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab1GPNFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:05:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57335 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab1GPNFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:05:09 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996062ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6Fa/kpbQXH0bhk9Bz5SAfl0I1CPNUJ4Wf9/32F/bxgs=;
        b=fosv4HchxFBpVYkgbNc5S0cz96C7tGFM7gu2d4Tip4HJdsu23SBExdA3vzMt9Gk9t3
         THtA3EosD1ecznfbOdlJVm+dDGurPnymdrYRLJR7sUCq93IAUaxVP/guZ2IgR1m4Bjmr
         iTGwPYOhFo2BtaLavs516XOM4cAClEi1HIfnY=
Received: by 10.213.29.197 with SMTP id r5mr576903ebc.123.1310821509216;
        Sat, 16 Jul 2011 06:05:09 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.05.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:05:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177270>

This test actually breaks the repositories involved somehow, so it is
not enabled by default.
---

  Not meant for inclusion.

 t/t5800-remote-helpers.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 68f8418..ad85888 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -133,6 +133,17 @@ test_expect_failure 'push new branch with old content' '
 	compare_refs clone refs/heads/existing server refs/heads/existing
 '
 
+test_expect_failure BROKEN 'delete branch' '
+	(cd clone &&
+	 git checkout -b delete-me &&
+	 echo content >>file &&
+	 git commit -a -m eight &&
+	 git push origin delete-me
+	 git push origin :delete-me) &&
+	test_must_fail git --git-dir="server/.git" rev-parse --verify delete-me
+'
+
+
 test_expect_failure 'push new branch with old:new refspec' '
 	(cd clone &&
 	 git push origin new-name:new-refspec
-- 
1.7.5.1.292.g728120
