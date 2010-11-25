From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 2/9] t5550-http-fetch: add test for http-fetch
Date: Thu, 25 Nov 2010 16:21:03 +0800
Message-ID: <1290673270-4284-3-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX6C-0008IX-Hs
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab0KYIWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:22:31 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab0KYIWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:22:31 -0500
Received: by iwn5 with SMTP id 5so389iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZszKKaeTIa/WLTNJcG9vuoq+m/E8bI5PNyG/+y59NcE=;
        b=J9r94nKl/DwfA1SPRtw+5EvQnKz7HiB9HUITDUfhkXwPsbqu0vdAr7i8EFB/GkGOWI
         2B/92SHEcWryrDFrOSHwSwbxz1GTS2jadlp5th2rbwGlpw3/0EILFD3WfAYepWGm4Cdq
         ra9Kilq0p5sT3QsJKXK++OTnIxMWIr5dlv1RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gq42UrqOoHQLfhXE9MUUzK+BSf6QLC637P09T8N9b2kN3IqhZ8vvJ0vmR3ciecCbzv
         1kdEZd76sfGTjds+KtcKmg9YB3Ai/O7G2ffjOw8HKQ0TuDj7zcbtvPhjSi+iWETTumCK
         iMUxBmaWwqFk/PPTpL3BQZeqljUL3xBGsUc30=
Received: by 10.42.229.136 with SMTP id ji8mr162016icb.383.1290673350473;
        Thu, 25 Nov 2010 00:22:30 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.22.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:22:29 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162107>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

New in v3.

 t/t5550-http-fetch.sh |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 39f7b7c..d3bf5ce 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -30,7 +30,8 @@ test_expect_success 'create http-accessible bare repository' '
 '
 
 test_expect_success 'clone http repository' '
-	git clone $HTTPD_URL/dumb/repo.git clone &&
+	git clone $HTTPD_URL/dumb/repo.git clone-tmpl &&
+	cp -R clone-tmpl clone &&
 	test_cmp file clone/file
 '
 
@@ -42,6 +43,17 @@ test_expect_success 'fetch changes via http' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'fetch changes via manual http-fetch' '
+	cp -R clone-tmpl clone2 &&
+
+	HEAD=$(git rev-parse --verify HEAD) &&
+	(cd clone2 &&
+	 git http-fetch -a -w heads/master-new $HEAD $(git config remote.origin.url) &&
+	 git checkout master-new &&
+	 test $HEAD = $(git rev-parse --verify HEAD)) &&
+	test_cmp file clone2/file
+'
+
 test_expect_success 'http remote detects correct HEAD' '
 	git push public master:other &&
 	(cd clone &&
-- 
1.7.3.2.495.gc7b3f
