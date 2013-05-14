From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/47] remote-hg: test: simplify previous branch checkout
Date: Mon, 13 May 2013 23:36:38 -0500
Message-ID: <1368506230-19614-16-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc71c-0004Aq-La
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab3ENEje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:34 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:49220 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ENEj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:28 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so103825oag.18
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=M1tFwoUd25U8eyBYN3fWzOVu6aQCLtTrs2FM0L/2B0c=;
        b=QE4QxrvkuNUcGgl1qnGb1fPJ8b02UV/kkEiyKE1tFlCH+jd5kQohW4J/QaZ5qY7z9F
         rwLuBX7WjnadHIphpR1thWYtulTQIS/a/To6J/pMUWf3pM1I3DNo0bqGVzGLxF0ptDHP
         SR/YQeqBpdFGwHhPFw+45GVWnokkpzIIQVG2YV6/9HC9Wt/L29mBY1pWxdyHOgRGA8MI
         ipYGeeI3/Po6MG3ZinrCQQcITz5tSZ0gHwAKirBC+QjjmtIQG0N6h+zgeT+6T1w815h7
         9101vjm9y8G/KbpYcnzhLE2lmlaULa25u2V7fKrXQgSHpGuGnVc9Bzk6DO2KSJsFKjpF
         SPtg==
X-Received: by 10.60.92.230 with SMTP id cp6mr15508460oeb.91.1368506368203;
        Mon, 13 May 2013 21:39:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20485115oes.6.2013.05.13.21.39.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224253>

@{-1} does the same thing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-bidi.sh   | 3 +--
 contrib/remote-helpers/test-hg-hg-git.sh | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index 4bfbda2..88a33e6 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -41,10 +41,9 @@ hg_clone () {
 hg_push () {
 	(
 	cd $2
-	old=$(git symbolic-ref --short HEAD)
 	git checkout -q -b tmp &&
 	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*' &&
-	git checkout -q $old &&
+	git checkout -q @{-1} &&
 	git branch -q -D tmp 2> /dev/null || true
 	)
 }
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 274a8d5..e503293 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -61,10 +61,9 @@ hg_clone_hg () {
 hg_push_git () {
 	(
 	cd $2
-	old=$(git symbolic-ref --short HEAD)
 	git checkout -q -b tmp &&
 	git fetch -q "hg::../$1" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*' &&
-	git checkout -q $old &&
+	git checkout -q @{-1} &&
 	git branch -q -D tmp 2> /dev/null || true
 	)
 }
-- 
1.8.3.rc1.579.g184e698
