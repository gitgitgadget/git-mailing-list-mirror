From: newren@gmail.com
Subject: [PATCH 2/7] Modify fast-export testcase to check that we correctly omit tags of trees
Date: Fri, 19 Jun 2009 22:36:58 -0600
Message-ID: <1245472623-28103-3-git-send-email-newren@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:46:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsTA-0005tJ-W0
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbZFTEqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbZFTEqI
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:46:08 -0400
Received: from mail-pz0-f195.google.com ([209.85.222.195]:47763 "EHLO
	mail-pz0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZFTEqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:46:07 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2009 00:46:00 EDT
Received: by mail-pz0-f195.google.com with SMTP id 33so119885pzk.33
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=f3vftXBegy7cTdX2DVPBnYu3TlUJes/DAtDe5oHlyMo=;
        b=QOU6xa0EUrYjRqv0qO403iw9Os1RUxs39EWl6p6lYaMdO3mmdl2z4GyskvD+LR13N7
         Bs5C44uEzB33tsJZ+53YRd7jV4E0VjKP6lc4Em2xOGF3wiSsuO9Eb2FrbA4CMro/+9ni
         tfd/KxgBw+vZ7Ff22892wuNVUakCbg+LcXfUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Xg67vkf7UiWF0g0TAtpS2oeuVAx3CtM86/Q8SpRxSe0nTJGZugIgsrUXAwWZXgWmGx
         1w1LNpPiWloNfTy7LuZTtT4+q60VAozk1SiOcTbV+vvKbr7wx0N3Mp7SevXCZFfChzYI
         Np4BqdMGQS/L3uhyOO+Dpz4yMUaX0PswwT8XE=
Received: by 10.143.5.20 with SMTP id h20mr1627498wfi.167.1245472768993;
        Fri, 19 Jun 2009 21:39:28 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245472623-28103-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121929>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
Should I have just squashed this with the previous patch?  Or with the
other testcase patch?

 t/t9301-fast-export.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 8c8a9e6..d17f0e4 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -272,7 +272,13 @@ test_expect_success 'set-up a few more tags for tag export tests' '
 '
 
 # NEEDSWORK: not just check return status, but validate the output
-test_expect_success 'tree_tag'        'git fast-export tree_tag'
+test_expect_success 'tree_tag'        '
+	mkdir result &&
+	cd result &&
+	git init &&
+	cd ..
+	git fast-export tree_tag | (cd result && git fast-import)
+'
 test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
-- 
1.6.3.2.323.gfb84f
