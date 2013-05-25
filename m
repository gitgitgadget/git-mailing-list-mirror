From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/48] remote-hg: test: simplify previous branch checkout
Date: Fri, 24 May 2013 21:29:23 -0500
Message-ID: <1369449004-17981-8-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4HD-0001Wx-G2
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab3EYCcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:06 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:35654 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3EYCcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:04 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so7037190oag.9
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V9R2O4VRQ1pxJahlNFGIi/SsiFWXDQ7190kU8srU0fM=;
        b=sOynWl8B9UFocO632TlCX52Kf53rRAIH0gwPZrwo5Q3HA9hhybmVgahgGQtyLnWsuc
         SHl7J2FbukYelxXWVCbTG+peXpJkqr7AMiHt/UdB52yKPjcxCIt3pZFcyvg7rGPsmW4Q
         6LZ2+3+Hl90v8iM5C8rjkrX098Q448ntCLAJk/ZOn8cIlY+1lBI45w7FQqfRPGjaxHns
         LjvsBNZgF7i4VOzjBD8ZgZfOaxFJrP0CPIoraK1kqtervcElu6zGZbPhyuObw9GaXEDi
         Sck6pI8Rhe6eoE+wAfgxo+yULtLEIj2gRMG+F3jFffXNSeSajpAD4AyRHQThe8udgQo0
         bA4w==
X-Received: by 10.182.129.101 with SMTP id nv5mr13238119obb.56.1369449123621;
        Fri, 24 May 2013 19:32:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm20059559obi.8.2013.05.24.19.32.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225421>

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
1.8.3.rc3.312.g47657de
