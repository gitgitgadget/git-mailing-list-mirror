From: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
Subject: svn to git with non-standard layout
Date: Wed, 23 Nov 2011 20:23:34 +0100
Message-ID: <jajh7m$it7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 20:25:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTIRj-0000vS-9G
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 20:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab1KWTZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 14:25:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:42259 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062Ab1KWTZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 14:25:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RTIRP-0000kS-Qt
	for git@vger.kernel.org; Wed, 23 Nov 2011 20:25:07 +0100
Received: from tc-gate1.pci.uni-heidelberg.de ([129.206.21.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 20:25:07 +0100
Received: from bernd.schubert by tc-gate1.pci.uni-heidelberg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 20:25:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: tc-gate1.pci.uni-heidelberg.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185867>

Hi all,

we just want to migrate from subversion to git, but so far all attempts 
to do that resulted in missing commit information.

So we have an svn repo with multiple sub-repos. The trouble is now that 
those sub-repos have their own trunk/tags (no branches) directories, but 
actually those projects are very dependent on each other and lots of 
commits go to many sub-project in a single commit.
So our new git repository shall meld all sub-projects into a new common 
repository.

So we have something like this:

svn-root -> main-project
             /       |    \
            /        |     \
           proj1    proj2   proj{n}
          /    \     /   \    /    \
         /      \   /     \  trunk  tags
        /       \ trunk   tags
        trunk   tags
                /   \
               tag1 tag{2...n}


I think the same issue has been asked a few times before, for example here:

http://comments.gmane.org/gmane.comp.version-control.git/163491

but I still do not know how to properly convert the old structure into a 
new global one. So we simply want to have:

branches,tags <- main-project -> {proj1, proj2, ..., projN}

I think the above link suggests something like

[svn-remote "svn"]
         url = https://some-repo-url
         fetch=/:refs/remotes/svnroot
         fetch = build_scripts/trunk:refs/remotes/build_scripts/trunk
         fetch = create_repos/trunk:refs/remotes/create_repos/trunk


When I'm going to to 'svn fetch' this, files from different projects are 
going to be in the same directory. But of course, the project directory 
structure is supposed to stay as it it.

Any ideas what I still could try to do?


Thanks,
Bernd
