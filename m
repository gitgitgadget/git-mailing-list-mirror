From: Francesco Pretto <ceztkoml@gmail.com>
Subject: [Patch] Documentation: enhanced "git for CVS users" doc about shared
 repositories
Date: Mon, 05 Nov 2007 23:32:24 +0100
Message-ID: <472F99F8.4010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 23:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAUs-0007pj-Fq
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbXKEWca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXKEWca
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:32:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:21154 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbXKEWc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:32:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1000540ugc
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 14:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=dlTMbyVR0zgdQXQozalgfY0KqhPhnRAfRJmYhlkOTIc=;
        b=BnstNTqd1jKBYz/OqPInqFfZ+QVPb49pGTGkKaMQ9HrgVagqeN7YXn93mOymriQFJeYy50keLhBOlo80y5stUZeZmjjhTrXCwrrSrl93yixofyWCvw9xh/ZYJMuR5xy649gLhHGhi4ryxj2l4uPZJbaE22rg1mBnSuoVU8lunBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=pVQmccZoHYqTxvBd24MHOymeHMucOK76pZLrqQLFOGjvXMCbfyL7+bRc1tfUDO5Ra0amFojrkVhK8d6iEuSZT+AD4DYAPr6dHDw0SswfqNrNQgXK8Blij0Feu6pSGP51sOrTG+skJJN/tmt4NMssTb4w4+ezEzxYoZXkDKjpII0=
Received: by 10.67.32.14 with SMTP id k14mr2836729ugj.1194301946636;
        Mon, 05 Nov 2007 14:32:26 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id i40sm5728316ugf.2007.11.05.14.32.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 14:32:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63576>

More detailed instructions on how to set up shared repositories.
Added a reference to "git for CVS users" doc in git-init manual.

Signed-off-by: Francesco Pretto <ceztkoml@gmail.com>
---
 Documentation/cvs-migration.txt |   72 ++++++++++++++++++++++++++++++--------
 Documentation/git-init.txt      |    7 ++++
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 3b6b494..c92ed49 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -13,12 +13,12 @@ link:tutorial.html[tutorial introduction to git] should be sufficient.
 Developing against a shared repository
 --------------------------------------
 
-Suppose a shared repository is set up in /pub/repo.git on the host
+Suppose a shared repository is set up in /pub/scm/repo.git on the host
 foo.com.  Then as an individual committer you can clone the shared
 repository over ssh with:
 
 ------------------------------------------------
-$ git clone foo.com:/pub/repo.git/ my-project
+$ git clone foo.com:/pub/scm/repo.git/ my-project
 $ cd my-project
 ------------------------------------------------
 
@@ -68,37 +68,79 @@ other than `master`.
 Setting Up a Shared Repository
 ------------------------------
 
-We assume you have already created a git repository for your project,
-possibly created from scratch or from a tarball (see the
-link:tutorial.html[tutorial]), or imported from an already existing CVS
-repository (see the next section).
+We assume you have admin privilege on the remote machine. Moreover, we assume
+you have already created a git repository for your project, possibly created
+from scratch or from a tarball (see the link:tutorial.html[tutorial]),or
+imported  from an already existing CVS repository (see the next section).
 
-Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
-repository (a repository without a working tree) and fetch your project into
-it:
+First, let's create a common directory for all the projects you'll want to
+track with git:
+
+-----------------------------------------------
+$ mkdir -p /pub/scm
+-----------------------------------------------
+
+It's recommended, but not necessary, to create a specific group of commiters
+for every project/repository. With root credentials launch:
+
+------------------------------------------------
+$ groupadd $group
+------------------------------------------------
+
+Assume your existing repository is at /home/alice/myproject.  Create a new
+"bare" repository (a repository without a working tree) and fetch your project
+into it:
 
 ------------------------------------------------
-$ mkdir /pub/my-repo.git
+$ mkdir /pub/scm/my-repo.git
 $ cd /pub/my-repo.git
 $ git --bare init --shared
 $ git --bare fetch /home/alice/myproject master:master
 ------------------------------------------------
 
+Now, set the group ownership of the git repository you've just created to the
+same group of the commiters:
+
+------------------------------------------------
+$ chgrp -R $group /pub/scm/my-repo.git
+------------------------------------------------
+
 Next, give every team member read/write access to this repository.  One
 easy way to do this is to give all the team members ssh access to the
 machine where the repository is hosted.  If you don't want to give them a
 full shell on the machine, there is a restricted shell which only allows
 users to do git pushes and pulls; see gitlink:git-shell[1].
 
-Put all the committers in the same group, and make the repository
-writable by that group:
+First, enable it putting on the trusted shells list of the system:
+
+------------------------------------------------
+$ echo `which git-shell` >> /etc/shells
+------------------------------------------------
+
+Ensure users will not have write permission on /pub/scm. Now, let's create
+them with the following command launched with root credentials:
 
 ------------------------------------------------
-$ chgrp -R $group /pub/my-repo.git
+$ useradd -g $group -d /pub/scm -s `which git-shell` $username
 ------------------------------------------------
 
-Make sure committers have a umask of at most 027, so that the directories
-they create are writable and searchable by other group members.
+They will be enabled to push on repositories owned by the group $group.
+Later, you can give users access to other projects simply by adding them to
+other groups.
+
+[NOTE]
+================================
+With previous versions of git, it could be necessary to set umask variable of
+all commiters with values like 002 or 007. If you still need to support them,
+you can do it in the following way; assuming that all users have their home
+positionated at /pub/scm, like in the previous example, launch the command:
+
+------------------------------------------------
+$ echo "umask 022" >> /pub/scm/.profile
+------------------------------------------------
+
+At the next login, users will have their umask variable automatically set.
+================================
 
 Importing a CVS archive
 -----------------------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 07484a4..f5f363d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -101,6 +101,13 @@ $ git-add .     <2>
 <2> add all existing file to the index
 
 
+SHARED REPOSITORIES
+-------------------
+
+Please refer to link:cvs-migration.html[git for CVS users], section "Setting Up
+a Shared Repository", for details on how to set up shared repositories.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
