From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Short rant about git usability - make 'git clone' work on an empty
	remote repository
Date: Thu, 22 Jan 2009 10:02:30 +0000
Message-ID: <20090122100230.GA9653@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 11:04:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPwPp-0005Sv-FH
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 11:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbZAVKCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 05:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755164AbZAVKCg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 05:02:36 -0500
Received: from mx2.redhat.com ([66.187.237.31]:33370 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534AbZAVKCf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 05:02:35 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0MA2W1Z008287
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 05:02:32 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0MA2XpT005325
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 05:02:33 -0500
Received: from localhost (vpn-6-47.fab.redhat.com [10.33.6.47])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0MA2WQY012493
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 05:02:33 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106739>

This is a rant, those offended by rants should stop reading now.

When I want to check out a remote repository, I do:

  git clone URL...

Except when the repository is empty, when for no explicable reason
this familiar command doesn't work.

  $ git clone git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git
  Initialized empty Git repository in /home/rjones/d/ocaml-autoconf/.git/
  fatal: no matching remote head

  $ git init ocaml-autoconf
  usage: git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]
  $ mkdir ocaml-autoconf
  $ cd ocaml-autoconf
  $ git init
  Initialized empty Git repository in /home/rjones/d/ocaml-autoconf/.git/
  $ ls
  $ ls -a
  .  ..  .git

Following advice on a website ...

  $ git-remote origin git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git
  error: Unknown subcommand: origin
  usage: git remote
     or: git remote add <name> <url>
     or: git remote rm <name>
     or: git remote show <name>
     or: git remote prune <name>
     or: git remote update [group]

      -v, --verbose         be verbose

  $ git remote add origin git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git

  $ git status
  # On branch master
  #
  # Initial commit
  #
  nothing to commit (create/copy files and use "git add" to track)
  $ git branch
  $ git checkout
  fatal: You are on a branch yet to be born
  $ git status
  # On branch master
  #
  # Initial commit
  #
  nothing to commit (create/copy files and use "git add" to track)
  $ echo test > README
  $ git commit -a
  # On branch master
  #
  # Initial commit
  #
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #	README
  nothing added to commit but untracked files present (use "git add" to track)
  $ git add README
  $ git commit -a
  Created initial commit 2c9a63a: Create repository.
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 README

  $ git push
  No refs in common and none specified; doing nothing.
  Perhaps you should specify a branch such as 'master'.
  fatal: The remote end hung up unexpectedly
  error: failed to push some refs to 'git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git'
  $ git push master
  fatal: 'master': unable to chdir or not a git archive
  fatal: The remote end hung up unexpectedly
  $ git branch master
  fatal: A branch named 'master' already exists.
  $ git status
  # On branch master
  nothing to commit (working directory clean)
  $ git push
  No refs in common and none specified; doing nothing.
  Perhaps you should specify a branch such as 'master'.
  fatal: The remote end hung up unexpectedly
  error: failed to push some refs to 'git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git'
  $ man git-push
  $ git pull
  You asked me to pull without telling me which branch you
  want to merge with, and 'branch.master.merge' in
  your configuration file does not tell me either.  Please
  name which branch you want to merge on the command line and
  try again (e.g. 'git pull <repository> <refspec>').
  See git-pull(1) for details on the refspec.
  
  If you often merge with the same branch, you may want to
  configure the following variables in your configuration
  file:
  
      branch.master.remote = <nickname>
      branch.master.merge = <remote-ref>
      remote.<nickname>.url = <url>
      remote.<nickname>.fetch = <refspec>
  
  See git-config(1) for details.

Arrggghhhh, just MAKE GIT CLONE WORK!!!

Rich.

-- 
Richard Jones, Emerging Technologies, Red Hat  http://et.redhat.com/~rjones
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://et.redhat.com/~rjones/virt-df/
