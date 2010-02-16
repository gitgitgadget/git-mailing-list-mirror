From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCHv2] grep documentation: clarify what files match
Date: Mon, 15 Feb 2010 19:25:40 -0500
Message-ID: <1266279940-13251-1-git-send-email-lodatom@gmail.com>
References: <7vvddz5l1z.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 01:23:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhBE4-0002Wn-J5
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 01:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378Ab0BPAXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 19:23:36 -0500
Received: from mail-qy0-f200.google.com ([209.85.221.200]:42923 "EHLO
	mail-qy0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359Ab0BPAXf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 19:23:35 -0500
Received: by qyk38 with SMTP id 38so809071qyk.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Wc/2Ilkm1WSj+mUodUahmm97X5WJEMGGpRm8hyvqIdo=;
        b=T1ocuZvMthrq10KRPW653WMBibjxlcnJT7WjZFJ2StGwbLhzhw7e8zsz4xFis1shbW
         EnERq3weBrnyVoGq6drCNSsfeMnax//5GJ+L7jDjojmBNqW0/8+Z9tGb2Mi5RYz+0Cb0
         4ZDrbNyQW0MQaWaLA+n4mEccqCRCHaf8O3RCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NS/ooOvq+XXeV/YozUyaEKWAtI/pPc3FstiDv3XXuQ3m1D5IQnqxpjMYj8x/xK5Q/K
         UOkmCypBCSW+x4i/9wgmrmyKgnRSM6Z0iSUlOCrAxsug1EvMBao/10uW+sSLMwg6wpLp
         4txYc9vIIJMC3Bo6kxcNyNRHAQSMgj7QBxXXU=
Received: by 10.224.18.139 with SMTP id w11mr513270qaa.160.1266279813381;
        Mon, 15 Feb 2010 16:23:33 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm4685512qyk.13.2010.02.15.16.23.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 16:23:32 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <7vvddz5l1z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140053>

Clarify that git-grep(1) searches only tracked files, and that each
<path> is a glob, as in git-add(1).  Add an example to show a simple use
case for searching all .c and .h files.

The meta-variable <path> should be changed to an official term for
a path glob, and the description for this should be in git(1), not
git-add(1).  However, we don't yet have such an official term, so just
use <path> and reference git-add(1) for now.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index e019e76..7f24032 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -26,8 +26,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Look for specified patterns in the working tree files, blobs
-registered in the index file, or given tree objects.
+Look for specified patterns in the tracked files in the working tree, blobs
+registered in the index file, or blobs in given tree objects.
 
 
 OPTIONS
@@ -49,7 +49,7 @@ OPTIONS
 	Don't match the pattern in binary files.
 
 --max-depth <depth>::
-	For each pathspec given on command line, descend at most <depth>
+	For each <path> given on command line, descend at most <depth>
 	levels of directories. A negative value means no limit.
 
 -w::
@@ -170,10 +170,17 @@ OPTIONS
 	Signals the end of options; the rest of the parameters
 	are <path> limiters.
 
+<path>...::
+	If given, limit the search to paths matching at least one pattern.
+	Each pattern is the same as <filepattern> of linkgit:git-add[1].
 
 Example
 -------
 
+git grep 'time_t' -- '*.[ch]'::
+	Looks for `time_t` in all tracked .c and .h files in the working
+	directory.
+
 git grep -e \'#define\' --and \( -e MAX_PATH -e PATH_MAX \)::
 	Looks for a line that has `#define` and either `MAX_PATH` or
 	`PATH_MAX`.
-- 
1.7.0
