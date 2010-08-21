From: Eric Wong <normalperson@yhbt.net>
Subject: Re: using git-svn with --no-metadata
Date: Sat, 21 Aug 2010 19:07:11 +0000
Message-ID: <20100821190711.GA19129@dcvr.yhbt.net>
References: <E1OmnCj-0001Z7-2U@smtp.tt-solutions.com> <20100821183711.GA14986@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 21:07:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmtPT-0005Gx-Qh
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 21:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955Ab0HUTHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 15:07:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34232 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866Ab0HUTHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 15:07:12 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38D81F514;
	Sat, 21 Aug 2010 19:07:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100821183711.GA14986@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154152>

Eric Wong <normalperson@yhbt.net> wrote:
> Vadim Zeitlin <vz-git@zeitlins.org> wrote:
> > The documentation (for my 1.7.1 version) did say that:
> >
> > 	If you lose your .git/svn/git-svn/.rev_db file, git svn will not be
> > 	able to rebuild it and you won't be able to fetch again, either.
> >
> > but I understood it as meaning that I wouldn't be able to fetch again if
> > the file was lost (the file name appears to be wrong BTW, since the switch
> > to rev_map from rev_db some time ago)

> I'll update the docs accordingly.

Hopefully the following patch makes sense, let me know what you think,
thanks.

>From 4c169c696bee06472ca3511a0f58c1c1b52b9fe9 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 21 Aug 2010 18:52:14 +0000
Subject: [PATCH] Documentation/git-svn: discourage "noMetadata"

"noMetadata" is a limited and sometimes harmful option.
Recommend git-filter-branch instead (if at all) for one-shot
imports instead.

This also fixes an out-of-date reference to "rev_db" format,
noticed by Vadim Zeitlin.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4b84d08..8abbcdc 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -56,6 +56,8 @@ COMMANDS
 	as well, they take precedence.
 --no-metadata;;
 	Set the 'noMetadata' option in the [svn-remote] config.
+	This option is not recommended, please read the 'svn.noMetadata'
+	section of this manpage before using this option.
 --use-svm-props;;
 	Set the 'useSvmProps' option in the [svn-remote] config.
 --use-svnsync-props;;
@@ -597,13 +599,21 @@ svn.noMetadata::
 svn-remote.<name>.noMetadata::
 	This gets rid of the 'git-svn-id:' lines at the end of every commit.
 +
-If you lose your .git/svn/git-svn/.rev_db file, 'git svn' will not
+If you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
 be able to rebuild it and you won't be able to fetch again,
-either.  This is fine for one-shot imports.
+either.  This is sometimes useful for one-shot imports.
 +
 The 'git svn log' command will not work on repositories using
 this, either.  Using this conflicts with the 'useSvmProps'
 option for (hopefully) obvious reasons.
++
+This option is NOT recommended as it makes it difficult to track down
+old references to SVN revision numbers in existing documentation, bug
+reports and archives.  If you plan to eventually migrate from SVN to git
+and are certain about dropping SVN history, consider
+linkgit:git-filter-branch[1] instead.  filter-branch also allows
+reformating of metadata for ease-of-reading and rewriting authorship
+info for non-"svn.authorsFile" users.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
-- 
Eric Wong
