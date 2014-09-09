From: Marat Radchenko <marat@slonopotamus.org>
Subject: [ANNOUNCE] git-as-svn: subversion frontend server for git repository
Date: Tue, 9 Sep 2014 15:19:04 +0400
Message-ID: <20140909111903.GA13137@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: marat@slonopotamus.org, bozaro@yandex.ru
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 13:45:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRJra-0006R3-OE
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 13:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278AbaIILpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 07:45:31 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:54826 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbaIILpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 07:45:30 -0400
X-Greylist: delayed 1581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Sep 2014 07:45:30 EDT
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XRJRw-0003Rx-88; Tue, 09 Sep 2014 15:19:04 +0400
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256689>

Some time ago I complained [1] about troubles using Git
on a project with high ratio of non-programmers.

Since then, a conclusion was made: Git is too complex.
While Git provides many nice advanced stuff, its simplest
workflow isn't simple enough.

So we examined other options:

  * Splitting project in two repos (Git + SVN). It was
    thought to be the worst idea because we lost commit
    atomicity

  * Use GitHub SVN integration [2]. Rejected due to security
    considerations: our closed-source project isn't allowed to be
    hosted outside.

  * Use GitHub Enterprise: rejected due to pricing

  * Use SubGit [3]: rejected because of its architecture.

Then, a lost'n'forgotten git_svn_server [4] was found. After playing
with it, we found out that its approach can work, though several
decisions (Python and extensive forking of `git`) made it very slow.

So we thought "we're programmers, after all".

And that's when *git-as-svn* [5] was born. It is a daemon that sits
on top of Git repository and talks svn:// protocol.

Features supported:

  * checkout/update

  * log

  * blame
                                                                                                                                                             
  * commit (!)                                                                                                                                               
                                                                                                                                                             
  * rename detection (though a bit slow yet)                                                                                                                 
                                                                                                                                                             
  * svn:eol-style                                                                                                                                            
                                                                                                                                                             
  * Git pre-receive hooks                                                                                                                                    
                                                                                                                                                             
  * simple or LDAP authentication                                                                                                                            
                                                                                                                                                             
  * partial checkout                                                                                                                                         
                                                                                                                                                             
  * sparse working copy (svn --depth/--set-depth)                                                                                                            
                                                                                                                                                             
  * git submodules                                                                                                                                           
                                                                                                                                                             
Current limitations:                                                                                                                                         
                                                                                                                                                             
  * Only a single Git branch from a single repository

  * Needs at least one commit in Git

  * Parses whole history on startup and doesn't cache it anywhere

  * You must not do 'inverted merges'. Old HEAD must be reachable from
    new HEAD by first-parent traversal.

[1]: http://marc.info/?l=git&m=139866660018802
[2]: https://help.github.com/articles/support-for-subversion-clients
[3]: http://subgit.com/
[4]: http://git.q42.co.uk/git_svn_server.git
[5]: https://github.com/bozaro/git-as-svn/
