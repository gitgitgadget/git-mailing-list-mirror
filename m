From: "Britton Kerin" <bkerin@fastmail.fm>
Subject: confusing GIT_DIR behavior case
Date: Mon, 17 Mar 2008 14:43:49 -0800
Message-ID: <1205793829.5984.1242927563@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 23:44:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbO4G-0006os-8V
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 23:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbYCQWnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYCQWnu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 18:43:50 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37722 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753114AbYCQWnt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2008 18:43:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 3B4DBD7193
	for <git@vger.kernel.org>; Mon, 17 Mar 2008 18:43:49 -0400 (EDT)
Received: from web6.messagingengine.com ([10.202.2.215])
  by compute2.internal (MEProxy); Mon, 17 Mar 2008 18:43:49 -0400
Received: by web6.messagingengine.com (Postfix, from userid 99)
	id 1BEFA6081C; Mon, 17 Mar 2008 18:43:49 -0400 (EDT)
X-Sasl-Enc: fTazEGZJ2dQLbv3Y44Nd85tnq5cCwuoEDNJc9oqavezF 1205793829
Content-Disposition: inline
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77467>


I'm noob so wanted to see 'git_repo' instead of invisible '.git'.
I tried GIT_DIR=git_repo after looking at 

       GIT_DIR
              If the GIT_DIR environment variable is set then it
              specifies a
              path to use instead of the default .git for the base of
              the
              repository.

in the man page plus the usual mantra of 
 
       git init 
       git add .
       git commit

in many git noob docs.

But it fails like this:

       rhino$ mkdir test
       rhino$ cd test
       rhino$ export GIT_DIR=git_repo
       rhino$ git init
       Initialized empty Git repository in git_repo/
       rhino$ git add .
       fatal: This operation must be run in a work tree

I had to irc to hear that git_repo must be added to info/exclude (even
though '.git' isnt in there :).

Confusingly I was able to grope up a GIT_WORK_TREE setting (I forget
exactly
what) that made 'git add .' work but then 'git commit' failed.

It seems to me that at least one of these options should be useful (I
doubt I
know enought to know which):

   1.  GIT_DIR (and --git-dir) should make git behave exactly as if git
   was 
       wired to look for $GIT_DIR rather than '.git'.  The occurence of
       the
       GIT_DIR description in the top-level man page (for 'man git')
       seems to
       suggest that this is how things work.

   2.  The above man page section should be changed, and --git-dir
   option
       description should be expanded a bit, or referred to the section
       describing GIT_DIR.

   3.  The above diagnostic should be changed.  It looks to me like its
   running
       some test to determine that its in the repo directory and then
       giving
       up, presumably because it believes it was erroneously invoked
       there.  The
       error is the first thing that shows up in the above case probably
       because
       the git_repo is the first directory in a recursive traversal
       where there is
       a problem.  If this is the case it would be a nice clue if it
       would spit out
       the name of the offending directory.

   4.  The noob docs should make some mention of this issue.

Cheers,
Britton
