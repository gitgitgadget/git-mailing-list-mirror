From: "R. Steve McKown" <rsmckown@yahoo.com>
Subject: Subprojects: a user perspective
Date: Fri, 17 Mar 2006 19:11:45 -0700
Message-ID: <200603171911.45725.rsmckown@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Mar 18 03:08:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKQrs-0004t7-0r
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 03:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWCRCId (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 21:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCRCId
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 21:08:33 -0500
Received: from 227-146-120-209.mesanetworks.net ([209.120.146.227]:10688 "EHLO
	server.titaniummirror.com") by vger.kernel.org with ESMTP
	id S1751675AbWCRCIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 21:08:32 -0500
Received: from dhcp129.titaniummirror.com (dhcp129.titaniummirror.com [172.16.0.129])
	by server.titaniummirror.com (8.12.9-20030917/8.12.9) with ESMTP id k2I1w9Gq022356
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 17 Mar 2006 18:58:09 -0700
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on server.titaniummirror.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17681>

We are looking to migrate from CVS to a distributed VCS like git.  I've read 
the discussions on this list WRT subprojects and wanted to present another 
user's perspective.  The history of this list is active, so I apologize if my 
post is redundant or unwanted.  Send flames my way!  ;^)

Our repository is relatively large and extensively uses the CVS vendor branch 
feature to use and track software components managed by other groups, such as 
the linux kernel, openssl, busybox, uclibc, etc.  These are the tasks that we 
perform to manage components:

1. Occasionally import new revisions of components we use into
   the component's private branch (like an incoming branch).
   This provides a version history of each component's "pristine
   source" as used within the project over its lifetime.

2. Each component gets a subdirectory in the project branch(es).
   Component versions are merged from the component's incoming
   branch into this subdirectory as new components or component
   revisions are incorporated into the project.

3. Local modifications, as necessary, are made to component
   code within the project branch(es), not the incoming
   branches which only hold pristine sources.

4. Patches of local changes made to a component, like for
   submission to the upstream maintainer, are built by diffing
   a project branch's component subdir with the component's
   incoming branch.

I think git can do all of this if the component incoming branches have the 
same path information as the project branches.  In other words, if the 
project places the busybox component at /src/components/busybox, then the 
busybox incoming branch must place the busybox code 
into /src/component/busybox.

So, in terms of adding specific support for subprojects, the only thing I see 
that could be improved would be the ability to reference a sub-tree in git 
operations that currently expect a tree (aka tree-ish or refspec parameters).  
I liked Junio's concept of subproject linking, but only because it provided a 
way to conceptually address a sub-tree.

With sub-tree addressing, a component branch could be naturally rooted, and 
diffing its head against the a project branch head at the component's subdir:

   git diff linux-incoming proj-branch@/src/components/linux

or merging a new linux version into the project:

   git checkout linux-incoming
   #suck in a new linux release from upstream
   git commit -a
   git tag linux-2.4.16
   git checkout master
   git pull . linux-2.4.16:.@/src/components/linux

All the best,
Steve
