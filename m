From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH svn-dump-fast-export] Reference documentation
Date: Sat, 29 May 2010 01:16:21 -0500
Message-ID: <20100529061621.GA6513@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat May 29 08:16:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIFLD-0007Td-MQ
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 08:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab0E2GQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 02:16:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60602 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab0E2GQB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 02:16:01 -0400
Received: by gyg13 with SMTP id 13so1587090gyg.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 23:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=pDTwMzHFOqlOziBiTEAJphxBffF1l1iXcRKwbB+h1as=;
        b=oiMtngKVGO89VF7V3NcfOdsvPbfxhmDrGuk48mDsNrT0Q0rNstaSIZnI79WKHsBc11
         I8GaDj9nJR+fvllOrnQJyjKIW+Im94hylShkSpwQtYtF3Ryx5GtH7pTHLBgwpKcRjP3c
         bu0NOo49vyu7lyl76tA7YWvaLM/B1YdtSfFgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=qRxjUD57lUuDch3KTvbEOQEn+d3NvqMoj+pROHiZzOIxbfuWF1XEtH7VhiFhUb6tTr
         XwEJuqSjisJzr8PG0frV4vhNK4MCpyH++rTrYqRiK5fCcSVvlSPGHRT0ZBxze6XimRw8
         1Gm6raVuSs/xM4TqUYWKzgpnn3eh5ZT3+YLfo=
Received: by 10.231.178.162 with SMTP id bm34mr1670257ibb.86.1275113760326;
        Fri, 28 May 2010 23:16:00 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm14525353ibg.6.2010.05.28.23.15.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 23:15:59 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147956>

Add a simple manual page (in asciidoc format) to document
the svn-fe command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Patch is against git://github.com/barrbrain/svn-dump-fast-export.git master

Thoughts?

 svn-fe.txt |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 svn-fe.txt

diff --git a/svn-fe.txt b/svn-fe.txt
new file mode 100644
index 0000000..bfd3a68
--- /dev/null
+++ b/svn-fe.txt
@@ -0,0 +1,56 @@
+svn-fe(1)
+=========
+
+NAME
+----
+svn-fe - convert an SVN "dumpfile" to a fast-import stream
+
+SYNOPSIS
+--------
+svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
+
+DESCRIPTION
+-----------
+Converts a textual representation of a Subversion repository into
+input suitable for git-fast-import(1) and similar importers.
+
+INPUT FORMAT
+------------
+Subversion's repository dump format is documented in full in
+`notes/dump-load-format.txt` from the Subversion source tree.
+Files in this format can be generated using the 'svnadmin dump' or
+'svk admin dump' command.
+
+OUTPUT FORMAT
+-------------
+The fast-import format is documented by the git-fast-import(1)
+manual page.
+
+NOTES
+-----
+Subversion dumps do not record a separate author and committer for
+each revision, nor a separate display name and email address for
+each author.  Like git-svn(1), 'svn-fe' will use the name
+
+---------
+user <user@UUID>
+---------
+
+as committer, where 'user' is the value of the `svn:author` property
+and 'UUID' the repository's identifier.
+
+To support incremental imports, 'svn-fe' will put a `git-svn-id`
+line at the end of each commit log message if passed an url on the
+command line.  This line has the form `git-svn-id: URL@REVNO UUID`.
+
+Empty directories and unknown properties are silently discarded.
+
+The resulting repository will generally require further processing
+to put each project in its own repository and to separate the history
+of each branch.  The 'git filter-branch --subdirectory-filter' command
+may be useful for this purpose.
+
+SEE ALSO
+--------
+git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
+https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
-- 
1.7.1
