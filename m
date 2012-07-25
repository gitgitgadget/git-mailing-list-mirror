From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: False positive from orphaned_commit_warning() ?
Date: Wed, 25 Jul 2012 14:53:43 -0400
Message-ID: <20120725185343.GA6937@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 20:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su6iU-0004fW-Ek
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 20:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab2GYSxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 14:53:47 -0400
Received: from mail1.windriver.com ([147.11.146.13]:36851 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2GYSxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 14:53:45 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6PIridO002241
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 25 Jul 2012 11:53:44 -0700 (PDT)
Received: from yow-pgortmak-d1 (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 25 Jul
 2012 11:53:45 -0700
Received: from paul by yow-pgortmak-d1 with local (Exim 4.74)	(envelope-from
 <paul.gortmaker@windriver.com>)	id 1Su6iN-0001qx-Ok	for git@vger.kernel.org;
 Wed, 25 Jul 2012 14:53:43 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202186>

Has anyone else noticed false positives coming from the
orphan check?  It is warning me about commits that are
clearly on master.  Here is an example, where I checkout
master~2 and then switch back to master.  It somehow thinks
that master~2 is orphaned, when master~2 is by definition
in the commit chain leading to master.

The repo is tiny, so anyone can try and reproduce this. (I've
done so on v1.7.9 and v1.7.11, on two different machines).

git://git.yoctoproject.org/yocto-kernel-tools.git

Paul.
-------------

paul@foo:~/git/yocto-kernel-tools$ git checkout master~2
Note: checking out 'master~2'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in
this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again.
Example:

  git checkout -b new_branch_name

HEAD is now at e693754... kgit-checkpoint: fix verify_branch variable
name typo
paul@foo:~/git/yocto-kernel-tools$ git checkout master
Warning: you are leaving 38 commits behind, not connected to
any of your branches:

  e693754 kgit-checkpoint: fix verify_branch variable name typo
  ee67a7b kgit-config-cleaner: fix redefintion processing
  579b1ba meta: support flexible meta branch naming
  4673bdb scc: allow kconf fragment searching
 ... and 34 more.

If you want to keep them by creating a new branch, this may be a good time
to do so with:

 git branch new_branch_name e6937544e030637cec029edee34737846a036ece

Switched to branch 'master'
paul@foo:~/git/yocto-kernel-tools$ git branch --contains e6937544e030637cec029edee34737846a036ece
* master
paul@foo:~/git/yocto-kernel-tools$ git --version
git version 1.7.11.1
paul@foo:~/git/yocto-kernel-tools$ cat .git/config 
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = git://git.yoctoproject.org/yocto-kernel-tools.git
[branch "master"]
	remote = origin
	merge = refs/heads/master
paul@foo:~/git/yocto-kernel-tools$ 
---------------
