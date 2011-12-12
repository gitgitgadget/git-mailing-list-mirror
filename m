From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Update documentation for stripspace
Date: Sun, 11 Dec 2011 17:59:18 -0800
Message-ID: <1323655158-5075-1-git-send-email-conrad.irwin@gmail.com>
Cc: Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 02:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZvAy-0004mO-8A
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 02:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab1LLB71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 20:59:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52879 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab1LLB71 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 20:59:27 -0500
Received: by iaeh11 with SMTP id h11so2415065iae.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 17:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ytJzYyutN1/Rxmzd2zzF/nxTnV0CMsZg5he0cdUyhtw=;
        b=LurLcyaLqASwDN0ay0EonZ+NgY6RYR9QugyIstALWL9FCgE5FuvmJ1ksy9RahtRKPD
         uZWjNzaKT4SQ4MqNynwb9MmFfrgtis8TdD/bC6fKz5XSkBSYyRZVn21vP9yMUyijFxfn
         IIcB7Vo7beO90lL+y8XJHaAl3aDTqNBzekwvY=
Received: by 10.50.94.229 with SMTP id df5mr13510749igb.27.1323655166812;
        Sun, 11 Dec 2011 17:59:26 -0800 (PST)
Received: from monteverdi.hsd1.ca.comcast.net. (c-69-181-44-79.hsd1.ca.comcast.net. [69.181.44.79])
        by mx.google.com with ESMTPS id b31sm44747016ibh.9.2011.12.11.17.59.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Dec 2011 17:59:25 -0800 (PST)
X-Mailer: git-send-email 1.7.8.164.g00d7e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186822>

Tell the user what this command is intended for, and expand the
description of what it does.

Stop referring to the input as <stream>, as this command reads the
entire input into memory before processing it.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-stripspace.txt |   26 ++++++++++++++++++++------
 builtin/stripspace.c             |    2 +-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index b78f031..6667d25 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -3,26 +3,40 @@ git-stripspace(1)
 
 NAME
 ----
-git-stripspace - Filter out empty lines
+git-stripspace - Remove unnecessary whitespace
 
 
 SYNOPSIS
 --------
 [verse]
-'git stripspace' [-s | --strip-comments] < <stream>
+'git stripspace' [-s | --strip-comments] < input
 
 DESCRIPTION
 -----------
-Remove multiple empty lines, and empty lines at beginning and end.
+
+Normalizes input in the manner used by 'git' for user-provided metadata such
+as commit messages, notes, tags and branch descriptions.
+
+When run with no arguments this:
+
+- removes trailing whitespace from all lines
+- collapses multiple consecutive empty lines into one empty line
+- removes blank lines from the beginning and end of the input
+- ensures the last line ends with exactly one '\n'.
+
+In the case where the input consists entirely of whitespace characters, no
+output will be produced.
+
+*NOTE*: This is intended for cleaning metadata, prefer the `--whitespace=fix`
+mode of linkgit:git-apply[1] for correcting whitespace of patches or files in
+the repository.
 
 OPTIONS
 -------
 -s::
 --strip-comments::
-	In addition to empty lines, also strip lines starting with '#'.
+	Also remove all lines starting with '#'.
 
-<stream>::
-	Byte stream to act on.
 
 GIT
 ---
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1288ffc..f16986c 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -75,7 +75,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 				!strcmp(argv[1], "--strip-comments")))
 		strip_comments = 1;
 	else if (argc > 1)
-		usage("git stripspace [-s | --strip-comments] < <stream>");
+		usage("git stripspace [-s | --strip-comments] < input");
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
-- 
1.7.8.164.g00d7e
