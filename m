From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/3] Support config-based names
Date: Mon, 11 Jun 2007 23:10:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706112244210.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 05:11:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxwmf-0005uE-Ka
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 05:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbXFLDKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 23:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbXFLDKl
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 23:10:41 -0400
Received: from iabervon.org ([66.92.72.58]:3092 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbXFLDKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 23:10:40 -0400
Received: (qmail 1946 invoked by uid 1000); 12 Jun 2007 03:10:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 03:10:39 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49912>

It can be useful to refer to commits in remotes based on their configured 
relationship to local branches. For example, "git log HEAD^[push]..HEAD" 
would, when pushing is set up, show what hasn't been pushed yet.

I picked base^[word] as the format for sha1 names which are some arbitrary 
function of base. I think this format isn't used for anything yet, isn't 
valid as ref names, and is structureally suitable for having a variety of 
extensions. I added {branch}^[merge] for the default head to merge into 
{branch} and {branch}^[push] for the tracking ref for the remote branch to 
push {branch} to. The push one could be extended to include the branch to 
push to by default at other remotes as {branch}^[push:{remote}]. I'm not 
too picky about the format for this, if there's something better for the 
space of sha1 names that don't have to be super compact and may have lots 
of options.

(In order to prepare this email, I set up a push default of my branch to 
next, and did: "git log --reverse HEAD^[push]..HEAD" and "git diff --stat 
HEAD^[push]...HEAD")

Patch 1 is likely to be independantly useful for things like a 
builtin-fetch, which needs to get configuration for branches along with 
remotes.

 Patch 1: Parse and report branch config
 Patch 2: Search for matching push refspec in configuration
 Patch 3: Add sha1 names using the preceding functions

 remote.c    |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 remote.h    |   22 +++++++++++-
 sha1_name.c |   50 +++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 15 deletions(-)

	-Daniel
*This .sig left intentionally blank*
