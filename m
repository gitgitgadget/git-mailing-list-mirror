Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FFC20229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbcKAVE5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:04:57 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:33295 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbcKAVE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:04:56 -0400
Received: from localhost.localdomain ([92.22.77.238])
        by smtp.talktalk.net with SMTP
        id 1gEocza9Dg5ct1gEoclCkv; Tue, 01 Nov 2016 21:04:55 +0000
X-Originating-IP: [92.22.77.238]
X-Spam: 0
X-OAuthority: v=2.2 cv=bdMpa6HB c=1 sm=1 tr=0 a=x3tYpWevBceDNTPbB0rC5A==:117
 a=x3tYpWevBceDNTPbB0rC5A==:17 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8
 a=W_CWlIRNK7n7v_85qRIA:9 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
From:   Philip Oakley <philipoakley@iee.org>
To:     git@vger.kernel.org
Cc:     philipoakley@iee.org, fhalde@paypal.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH] doc: update-index --assume-unchanged
Date:   Tue,  1 Nov 2016 21:04:48 +0000
Message-Id: <20161101210448.4692-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <7CE3166CFD244DAABF554451E8B0800F@PhilipOakley>
References: <7CE3166CFD244DAABF554451E8B0800F@PhilipOakley>
X-CMAE-Envelope: MS4wfNiTrYfC5g/4dDIJCE6xGhDql4ltaI3n0CGVHm+SXbSQNJ6IwosIBAM6q1nldMUOS7Jh0pGulLRv1ynb1R143IYPMt79slYc/UB6o/6g7cWxphyFuIR1
 /wYwuxdSI7u34hM0vvJfe9PUrQlVP6cLt3xZMTry+DKyKfK4Z9ne3hNnKcQnQL9fpho3HB4qZmknnD/vwABRwheY2FtwZeP9jaLIIn1oz/FZ8FfmSfWAs2+a
 4obw12CGEijG0PIHt72PG1WEEYKinECaGS3wm7MW7Kvb6zxpLDKeuOyTl5se7PmZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Be more assertive about the User promise, and Git's defensiveness
of file changes.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Here is a full patch for 
https://public-inbox.org/git/7CE3166CFD244DAABF554451E8B0800F@PhilipOakley/

---
 Documentation/git-update-index.txt | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7386c93..4ec1711 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -85,10 +85,10 @@ OPTIONS
 
 --[no-]assume-unchanged::
 	When this flag is specified, the object names recorded
-	for the paths are not updated.  Instead, this option
+	for the paths are not updated.  This option
 	sets/unsets the "assume unchanged" bit for the
 	paths.  When the "assume unchanged" bit is on, the user
-	promises not to change the file and allows Git to assume
+	*promises* not to change the file and allows Git to assume
 	that the working tree file matches what is recorded in
 	the index.  If you want to change the working tree file,
 	you need to unset the bit to tell Git.  This is
@@ -301,17 +301,23 @@ $ git ls-files -s
 Using ``assume unchanged'' bit
 ------------------------------
 
-Many operations in Git depend on your filesystem to have an
+Many operations in Git depend on your filesystem having a fast and
 efficient `lstat(2)` implementation, so that `st_mtime`
 information for working tree files can be cheaply checked to see
 if the file contents have changed from the version recorded in
 the index file.  Unfortunately, some filesystems have
 inefficient `lstat(2)`.  If your filesystem is one of them, you
-can set "assume unchanged" bit to paths you have not changed to
-cause Git not to do this check.  Note that setting this bit on a
-path does not mean Git will check the contents of the file to
-see if it has changed -- it makes Git to omit any checking and
-assume it has *not* changed.  When you make changes to working
+can set "assume unchanged" bit to *paths you have not changed* to
+cause Git not to do this check.
+
+Note that setting this bit on a
+path does not mean Git will never check the contents of the file to
+see if it has changed. Though normally it makes Git to omit any checking to
+assume it has not changed.
+Commands which may overwrite local changes (pull/merge etc) are
+likely to check if the contents have changed
+
+If you make desired changes to working
 tree files, you have to explicitly tell Git about it by dropping
 "assume unchanged" bit, either before or after you modify them.
 
-- 
2.9.0.windows.1.323.g0305acf

