From: Neil Schemenauer <nas@arctrix.com>
Subject: New converstion tool: svn2git.py
Date: Wed, 19 Nov 2008 13:13:21 -0600
Message-ID: <20081119191320.GA20870@arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 20:21:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2scC-0005h1-Mj
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 20:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYKSTUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 14:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbYKSTUE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 14:20:04 -0500
Received: from vapor.arctrix.com ([66.220.1.99]:35786 "HELO vapor.arctrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752884AbYKSTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 14:20:04 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Nov 2008 14:20:03 EST
Received: (qmail 20950 invoked by uid 1000); 19 Nov 2008 19:13:21 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101370>

Hi,

I'm working on a tool to do conversions from SVN to git using a SVN
dump.  It's in early development but perhaps some people would be
interested in it:

    http://python.ca/nas/python/svn2git.py

I would like to improve it so that it intelligently converts SVN
branches and tags into git branches (when possible).  The basic idea
is to map SVN paths into git branches, e.g. trunk -> master,
branches/foo -> branch-foo, tags/bar -> tags-bar.  Next, specific
SVN dump actions like:

    Node-path: branches/foo
    Node-kind: dir
    Node-action: add
    Node-copyfrom-rev: 3
    Node-copyfrom-path: trunk

need to be detected and the commit needs to performed with the
correct parent.  One complication is that SVN can create a branch or
tag from anywhere, for example, the action

    Node-path: tags/bar
    Node-kind: dir
    Node-action: add
    Node-copyfrom-rev: 3
    Node-copyfrom-path: trunk/subdir

would create tags/bar based on revision 3 of trunk/subdir.  There
doesn't seem to be a good way to convert that into git.  I was
thinking that the tags-bar branch in that case would have no parent.
Would git still efficently pack that or would you end up with extra
blobs?

  Neil
