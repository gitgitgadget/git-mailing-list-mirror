From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 02/10] t/test-lib-functions.sh: allow to specify the tag name to test_commit
Date: Mon, 21 Jan 2013 00:40:19 -0800
Message-ID: <1358757627-16682-3-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwI-0002t2-Or
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab3AUIkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:46 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:50813 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab3AUIkp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:45 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so2614675dam.32
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GTHE76OMs7UAatj7AN0s1gh6OeLLgOf0+ptxJW06518=;
        b=nkzOU95zPvzP+yWJ4wO2Ub49I8FKYTl5ixVF+SnkwLwz0Iazteq/ud7TJhgPIPcBLc
         R7Y370rd4yNImS0C6eBnRz6Dl1WvPu+JyZGPU2ajsEMw2IAZ+sBCIoZDVlCz/ZOg+BLK
         p223X80FadKRh2Bdeispq4PjNBasgnfHnLC1nzV7sNemkuauBX7PF0KjwUW1E4fKraBk
         HbYT+a18y/lTesaPY/ZDJQvsnMDHD5cv5csIpYcQZAVG52XxCd96JPkZ3lLaXGpMFHBK
         1/FcHnNQTtxscUdIZ/Sh0CRMp/ULr8FLjU4c0z8J693D27/G3+fG5i4GsAeUapWWDqvM
         wGFQ==
X-Received: by 10.68.197.197 with SMTP id iw5mr27558426pbc.22.1358757644789;
        Mon, 21 Jan 2013 00:40:44 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.43
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:44 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214098>

The <message> part of test_commit() may not be appropriate for a tag name.
So let's allow test_commit to accept a fourth argument to specify the tag
name.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/test-lib-functions.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fa62d01..c601918 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -135,12 +135,13 @@ test_pause () {
 	fi
 }
 
-# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message.  It will also add a tag with <message> as name unless <tag> is
+# given.
 #
-# Both <file> and <contents> default to <message>.
+# <file>, <contents>, and <tag> all default to <message>.
 
 test_commit () {
 	notick= &&
@@ -168,7 +169,7 @@ test_commit () {
 		test_tick
 	fi &&
 	git commit $signoff -m "$1" &&
-	git tag "$1"
+	git tag "${4:-$1}"
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
1.8.1.1.252.gdb33759
