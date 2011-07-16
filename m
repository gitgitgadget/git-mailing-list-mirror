From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 02/23] t5800: factor out some ref tests
Date: Sat, 16 Jul 2011 15:03:22 +0200
Message-ID: <1310821424-4750-3-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:04:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Xu-00056J-73
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab1GPNE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab1GPNEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:25 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996059ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EHuq5OQM6e1GirtOi3Oz2cb4Uju/wO7o1mRB/O5DOg0=;
        b=l5rOZVa+tsPRanhFcrkEmKYl12LJ9SEMWle3omlma9du5yd9O1aruwyZuY5PZBkXYj
         vDPA2Hug3guMND1K5yLmmfuVTyykNXClN49sLZbTA9XmbW0hu31bs3anXSXIiCtWwYXE
         QE1m5ckWqo8P99pg0xzuhoNG70vTRnxdy6BO0=
Received: by 10.14.50.15 with SMTP id y15mr1621300eeb.149.1310821464772;
        Sat, 16 Jul 2011 06:04:24 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177256>

From: Jeff King <peff@peff.net>

These are a little hard to read, and I'm about to add more
just like them. Plus the failure output is nicer if we use
test_cmp than a comparison with "test".

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged

 t/t5800-remote-helpers.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1fb6380..3a37ad0 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -17,6 +17,12 @@ then
 	test_set_prereq PYTHON_24
 fi
 
+compare_refs() {
+	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
+	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success PYTHON_24 'setup repository' '
 	git init --bare server/.git &&
 	git clone server public &&
@@ -59,8 +65,7 @@ test_expect_success PYTHON_24 'pushing to local repo' '
 	echo content >>file &&
 	git commit -a -m three &&
 	git push) &&
-	HEAD=$(git --git-dir=localclone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs localclone HEAD server HEAD
 '
 
 test_expect_success PYTHON_24 'synch with changes from localclone' '
@@ -73,8 +78,7 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	echo content >>file &&
 	git commit -a -m four &&
 	git push) &&
-	HEAD=$(git --git-dir=clone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs clone HEAD server HEAD
 '
 
 test_done
-- 
1.7.5.1.292.g728120
