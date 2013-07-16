From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/2] diff: Remove -q to stay silent on missing files.
Date: Tue, 16 Jul 2013 12:28:07 +0200
Message-ID: <1373970487-32595-3-git-send-email-stefanbeller@googlemail.com>
References: <20130714220739.GC13444@google.com>
 <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, jrnieder@gmail.com, trast@student.ethz.ch,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 16 12:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz2Ur-0005mM-8n
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 12:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab3GPK2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 06:28:25 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:33317 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab3GPK2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 06:28:19 -0400
Received: by mail-we0-f178.google.com with SMTP id u53so439213wes.37
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tRDDVyjbKSSvDh9+IlPVuq51/0p8PGFBSFfbGwyJGwg=;
        b=ioKlKB7kOvezkWgkaANFKVUsRNnoxMPXJzlCKfM3RsQPvgNMsUOIqmwFMyTuwriR9i
         2Q6t+YSQv223p1SodICWM6Tx6+7hzQTLRawXs2z26mUucVMdn8weyALZb6UZhUTjrwhv
         oolGNcBu9dZogA2Uly+iKd1u9Hh9V35lrNuEOcDguvb/kEfJdAQx23d78U6RVQ0+Gjas
         mHQvwStwiKPdSWiAZrK1C9kxCM2kqczdoGJTivxlknS1XzSdz+v1nHgebwsBJC7c2yQS
         wWcI23pVMJT0Hx162JwzzCYDlnRNE/aYY57bmENDQswk1ltZbhiSHAZwPC4JLaaXyWTW
         B2OA==
X-Received: by 10.180.96.227 with SMTP id dv3mr576236wib.59.1373970497737;
        Tue, 16 Jul 2013 03:28:17 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fb9sm26789236wid.2.2013.07.16.03.28.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 03:28:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3.10.g2733812
In-Reply-To: <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230562>

This feature was not tested in the test suite, hence we'd remove it for
now. It doesn't seem to be often used anyway.
A google search for "git diff -q" (match string exactly) only returned
http://stackoverflow.com/questions/11021287/git-detect-if-there-are-untracked-files-quickly
where "git diff -q" was quoted for its exit code behavior regarding files
being found or not.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Proposed-by: <Jonathan Nieder> <jrnieder@gmail.com>
---
 Documentation/git-diff-files.txt | 6 +-----
 diff-no-index.c                  | 2 --
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 906774f..d118cfb 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the working tree and the index
 SYNOPSIS
 --------
 [verse]
-'git diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
+'git diff-files' [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -41,10 +41,6 @@ omit diff output for unmerged entries and just show "Unmerged".
 	diff, similar to the way 'diff-tree' shows a merge
 	commit with these flags.
 
--q::
-	Remain silent even on nonexistent files
-
-
 include::diff-format.txt[]
 
 GIT
diff --git a/diff-no-index.c b/diff-no-index.c
index 419cd78..98a9cf1 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -223,8 +223,6 @@ void diff_no_index(struct rev_info *revs,
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
-		else if (!strcmp(argv[i], "-q"))
-			i++;
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
-- 
1.8.2.3.10.g2733812
