From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: egit problem with sym linked eclipse project dirs
Date: Tue, 13 Jan 2009 15:00:34 -0500
Message-ID: <p0624081cc5928e2885fd@[192.168.1.114]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Cc: Scott Cytacki <scytacki@fastmail.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 21:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpSj-0007Pp-5X
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbZAMUAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 15:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbZAMUAp
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:00:45 -0500
Received: from deanbrook.org ([72.52.70.192]:49160 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753254AbZAMUAo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:00:44 -0500
Received: from ::ffff:71.161.144.33 ([71.161.144.33]) by deanbrook.org for <git@vger.kernel.org>; Tue, 13 Jan 2009 12:00:40 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105525>

To hack around Eclipse's problem with projects in nested directories 
I clone a repo and then create a new top-level dir that just has 
symbolic links to all the project directories.

However when I Team/Share with git using egit the resources become 
untracked when displayed in Eclipse -- they still are tracked however 
when I check from the command line.

---- more details ----

using v0.4.0.200901041117 of egit

I've got a large dir structure in a git repo in which there are many 
eclipse projects at different levels of the tree.

However Eclipse doesn't work with projects at different levels in a 
nested dir structure (bad Eclipse) -- see: Eclipse bug: 
https://bugs.eclipse.org/bugs/show_bug.cgi?id=35973

When we work with these projects with svn we checkout each one 
individually into it's own dir to create the flat hierarchy Eclipse 
needs.  Updating all these separate projects takes forever -- at 
least compared to using Git.

I created a Ruby script to create a new dir named 'workspace' at the 
top level of a checkout with symbolic links to all the enclosed 
directories that have a .project file inside them.

http://svn.concord.org/svn/projects/trunk/common/flatten_projects.rb

or here in the git mirror:

http://gitorious.org/projects/otrunk-examples/repos/mainline/blobs/raw/5c5ca6ff830f4ad3e4d427df92c1a5dff64831b5/flatten_projects.rb

(warning: repos are public but very big)

The result is a dir: workspace/ that emulates the flat project space 
that Eclipse needs:

   http://gist.github.com/4658 (a bunch of these are legacy projects)

Then I open Eclipse, switch to a new Workspace, select the 
newly-created 'workspace' dir and import the projects to work on.

This works fine for Eclipse. The projects build and reference each other.

But when I then turn on the team/sharing/git for each project ...

The operation completes -- the git decorator appears showing [Git @ master] ...

but the files are all untracked.

Screenshots showing the sequence after importing just 7 projects:

   apple-support, framework, frameworkview, otrunk, swing, thirdparty-jars

share projects:
   http://skitch.com/stepheneb/bbnqf/skitched-20090113-144412

select git:
   http://img.skitch.com/20090113-peu5y38a1yqm4kfqasf6hh9r9t.png

iterate through each project:
   http://img.skitch.com/20090113-k6wf8xgs2bc4ehy9siscdyteqr.png
   http://img.skitch.com/20090113-jughm7eatnuum43gfuedmctrw5.png

showing untracked files on master branch:
   http://skitch.com/stepheneb/bbnqc/skitched-20090113-144646

However from the command line git shows the appropriate untracked 
files after an Eclipse build:

$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	java/core/apple-support/bin/
#	java/core/framework/lib/
#	java/core/frameworkview/lib/
#	java/core/swing/lib/
#	java/otrunk/otrunk/lib/
#	java/thirdparty/phet-simulations-java/simulations/cck/cck
#	rails/portal/portal
#	workspace/
