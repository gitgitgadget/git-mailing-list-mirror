From: Josh Micich <josh.micich@gmail.com>
Subject: Re: [PATCH 1/3] '--missing' option for mktree: updated usage message 
	and man page
Date: Thu, 14 May 2009 12:46:03 -0700
Message-ID: <a644352c0905141246v7948de25o2b22f3c6f1bcff41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh Micich <josh.micich@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 21:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4gt4-0004Pg-Vp
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 21:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbZENTqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 15:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbZENTqF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 15:46:05 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:49719 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbZENTqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 15:46:02 -0400
Received: by an-out-0708.google.com with SMTP id d40so3082781and.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=eGcr/aUKATR86+DLruKwQi0PSR/ZSGqu81VHWt/aFjc=;
        b=HQlE3J4kD+wicwmnGA6hcNN62poVjKXvyvOCnuRLr9hNY1BuFL8I1qydldRQBxzTjK
         GWJ/SXt7HZusweFJkDoA0wnfe097iAcXhhTIg5HVrhwwxpnvB2yUV76aujclvpMrkQKS
         I7g63LjgpjzEUtnynwywmnoPA2zGHNpBjw2Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=RQPamO8e+6tNIPchQPyxKtPq7vAdYL+1GNpJ0kAyBJvJ0D4u4HxSeSlyeeudGX7Zqm
         LwuD55XrK5bfFmXnQNBaPWv2g75exfknfyH3Io/bmb0iGg7OSAN6bsipqW+mC0csb90k
         408Ti4yg9yfqvlbe5vJg74UFHAu/sIn74995Y=
Received: by 10.100.144.14 with SMTP id r14mr3259488and.65.1242330363193; Thu, 
	14 May 2009 12:46:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119216>

Updated usage message in builtin-mktree.c to include '--missing'.
Updated man page to explain new '--missing' option. Also clarified
sorting behaviour.

Signed-off-by: Josh Micich <josh.micich@gmail.com>
---
 Documentation/git-mktree.txt |   13 ++++++++++---
 builtin-mktree.c             |    2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index af19f06..7336f48 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -8,12 +8,13 @@ git-mktree - Build a tree-object from ls-tree formatted text

 SYNOPSIS
 --------
-'git mktree' [-z]
+'git mktree' [-z] [--missing]

 DESCRIPTION
 -----------
-Reads standard input in non-recursive `ls-tree` output format,
-and creates a tree object.  The object name of the tree object
+Reads standard input in non-recursive `ls-tree` output format, and creates
+a tree object.  The order of the tree entries is normalised by mktree so
+pre-sorting the input is not required.  The object name of the tree object
 built is written to the standard output.

 OPTIONS
@@ -21,6 +22,12 @@ OPTIONS
 -z::
 	Read the NUL-terminated `ls-tree -z` output instead.

+--missing::
+	Allow missing objects.  The default behaviour (without this option)
+	is to verify that each tree entry's sha1 identifies an existing
+	object.  This option has no effect on the treatment of gitlink entries
+	(aka "submodules") which are always allowed to be missing.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/builtin-mktree.c b/builtin-mktree.c
index e1c9a27..5ff0475 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -63,7 +63,7 @@ static void write_tree(unsigned char *sha1)
 }

 static const char *mktree_usage[] = {
-	"git mktree [-z]",
+	"git mktree [-z] [--missing]",
 	NULL
 };

-- 
1.6.3.1.181.gfc9b3
