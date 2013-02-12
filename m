From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 03/12] t/test-lib-functions.sh: allow to specify the tag name to test_commit
Date: Tue, 12 Feb 2013 02:17:30 -0800
Message-ID: <1360664260-11803-4-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cwe-00020V-JP
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814Ab3BLKSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:12 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40827 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3BLKSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:11 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so8272pab.22
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=knlR5/XQEU3Lx/6zSmIQ76Q50XTP/B1zJa2dioR61zk=;
        b=tcAkXky6oHivwTHiC0ZnYpZCbZUJtoTv4d0dz3/9dEI5mQKOJ+1v442F08SSvWgu0r
         OHuVWN7L2s1pv1MJhL8xSO6I1UBIOy+Dr6i4cm5KTHL5qqN2uIiiUObAdXmfZQUHhkw8
         iPnRRBzVZaNpTg2PsoxHnZPn8lD52cTOHOIyT41wBzyUEbOYXLH1Qr/y6evYRQzANp2N
         Z+evyQtvmaiBakbtOliPeTrY8A9Xvm1Bpe6878DD3TXeSkfxaium5H7cj3Tg+EtNIDLq
         iJ+GPMdvIOPYKaXk/gXDpYGGnUpKFMMULB8Evsbdxt4KES2elFt2kiqFnERjXSrnrWwq
         y4QA==
X-Received: by 10.66.81.199 with SMTP id c7mr50815403pay.39.1360664290509;
        Tue, 12 Feb 2013 02:18:10 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.08
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:09 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216132>

The <message> part of test_commit() may not be appropriate for a tag name.
So let's allow test_commit to accept a fourth argument to specify the tag
name.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fa62d01..61d0804 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -135,12 +135,12 @@ test_pause () {
 	fi
 }
 
-# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message, and tag the resulting commit with the given tag name.
 #
-# Both <file> and <contents> default to <message>.
+# <file>, <contents>, and <tag> all default to <message>.
 
 test_commit () {
 	notick= &&
@@ -168,7 +168,7 @@ test_commit () {
 		test_tick
 	fi &&
 	git commit $signoff -m "$1" &&
-	git tag "$1"
+	git tag "${4:-$1}"
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
1.8.1.3.579.gd9af3b6
