From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/15] t1007 (hash-object): fix && chaining
Date: Thu,  8 Dec 2011 01:06:40 +0530
Message-ID: <1323286611-4806-5-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNJo-00013p-AP
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab1LGTiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:10 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48222 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:09 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so701321qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iTOmIgyl6j81b8+QZgq6U2Bde7yWau3rrzxFW7ZIs5s=;
        b=qUVf5pXxVzGxx8668UarZfFU9M1uJiSc8nme3pp5CGcOAyBNYw+gHIkvKGVLGduUmb
         CrikMHISpLIBJGn5Bzyokk0DcAiZ5HVtppSrWo1Ljul02RlDa8dWRlBSERdAGZtmk0+7
         s1UDXw1RiGiuiZIrsSG+JG/FrE7cAmNN2tHn4=
Received: by 10.50.202.65 with SMTP id kg1mr364730igc.1.1323286689262;
        Wed, 07 Dec 2011 11:38:09 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:08 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186485>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1007-hash-object.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 6d52b82..316c60a 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -154,13 +154,13 @@ test_expect_success 'check that --no-filters option works with --stdin-paths' '
 pop_repo
 
 for args in "-w --stdin" "--stdin -w"; do
-	push_repo
+	push_repo &&
 
 	test_expect_success "hash from stdin and write to database ($args)" '
 		test $example_sha1 = $(git hash-object $args < example)
-	'
+	' &&
 
-	test_blob_exists $example_sha1
+	test_blob_exists $example_sha1 &&
 
 	pop_repo
 done
@@ -176,20 +176,20 @@ test_expect_success "hash two files with names on stdin" '
 '
 
 for args in "-w --stdin-paths" "--stdin-paths -w"; do
-	push_repo
+	push_repo &&
 
 	test_expect_success "hash two files with names on stdin and write to database ($args)" '
 		test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object $args)"
-	'
+	' &&
 
-	test_blob_exists $hello_sha1
-	test_blob_exists $example_sha1
+	test_blob_exists $hello_sha1 &&
+	test_blob_exists $example_sha1 &&
 
 	pop_repo
 done
 
 test_expect_success 'corrupt tree' '
-	echo abc >malformed-tree
+	echo abc >malformed-tree &&
 	test_must_fail git hash-object -t tree malformed-tree
 '
 
-- 
1.7.7.3
