From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] git-svn: clarify explanation of --destination argument
Date: Mon, 19 Dec 2011 19:24:30 -0600
Message-ID: <20111220012430.GD20979@elie.hsd1.il.comcast.net>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
 <20111217100521.GA12610@elie.hsd1.il.comcast.net>
 <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
 <20111220012236.GB20979@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 02:24:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcoRg-0004eF-6U
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 02:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab1LTBYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 20:24:40 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49207 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab1LTBYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 20:24:38 -0500
Received: by yhr47 with SMTP id 47so4420375yhr.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 17:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=miGWYr+A76OkDGhi60t8eCUuXpAfM2R8lzanBsG4orA=;
        b=pUWJG9m6OAUhOOvgsdAEmmqXAcvwLBai2d4RuIYKe85mUkFR06QI6UxJNd+7SWPqwR
         /dlsdpt+1CbFjepUmxE3Wm0rSYUAIXKNvgMm63QKgab5ynLg2bVMMqfpt33LomH3aq3J
         sLPV3B9KcTehywCBo/KWUo9JlEe5+P+/xagSo=
Received: by 10.236.201.194 with SMTP id b42mr96802yho.32.1324344278410;
        Mon, 19 Dec 2011 17:24:38 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f47sm96225yhh.8.2011.12.19.17.24.37
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 17:24:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111220012236.GB20979@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187491>

The existing documentation for "-d" does not make it obvious whether
its argument is supposed to be a full svn path, a partial svn path,
the glob from the config file, or what.  Clarify the text and add an
example to get the reader started.

Reported-by: Nathan Gray <n8gray@n8gray.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-svn.txt |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 66fd60a4..a343c261 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -254,13 +254,15 @@ first have already been pushed into SVN.
 	Create a tag by using the tags_subdir instead of the branches_subdir
 	specified during git svn init.
 
--d;;
---destination;;
+-d<path>;;
+--destination=<path>;;
+
 	If more than one --branches (or --tags) option was given to the 'init'
 	or 'clone' command, you must provide the location of the branch (or
-	tag) you wish to create in the SVN repository.  The value of this
-	option must match one of the paths specified by a --branches (or
-	--tags) option.  You can see these paths with the commands
+	tag) you wish to create in the SVN repository.  <path> specifies which
+	path to use to create the branch or tag and should match the pattern
+	on the left-hand side of one of the configured branches or tags
+	refspecs.  You can see these refspecs with the commands
 +
 	git config --get-all svn-remote.<name>.branches
 	git config --get-all svn-remote.<name>.tags
@@ -935,6 +937,13 @@ Multiple fetch, branches, and tags keys are supported:
 	tags = tags/server/*:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
 
+Creating a branch in such a configuration requires disambiguating which
+location to use using the -d or --destination flag:
+
+------------------------------------------------------------------------
+$ git svn branch -d branches/server release-2-3-0
+------------------------------------------------------------------------
+
 Note that git-svn keeps track of the highest revision in which a branch
 or tag has appeared. If the subset of branches or tags is changed after
 fetching, then .git/svn/.metadata must be manually edited to remove (or
-- 
1.7.8
