From: Yann Dirson <ydirson@free.fr>
Subject: [BUG] git-gui regression in 2.0rcX within submodule
Date: Tue, 13 May 2014 01:45:19 +0200
Message-ID: <20140512234518.GB5529@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 13 01:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjzuT-0000X3-FV
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 01:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbaELXpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 19:45:22 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:61565 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbaELXpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 19:45:21 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 19B4B4C802E
	for <git@vger.kernel.org>; Tue, 13 May 2014 01:44:12 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.82)
	(envelope-from <ydirson@free.fr>)
	id 1WjzuJ-0002l5-Bk
	for git@vger.kernel.org; Tue, 13 May 2014 01:45:19 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248744>

In 2.0rc2, git-gui is unable to work inside submodules, where 1.9.2
did not show such a problem:


yann@home:~$ cd /tmp/
yann@home:tmp$ mkdir foo
yann@home:tmp$ cd foo/
yann@home:foo$ git init
Initialized empty Git repository in /tmp/foo/.git/
yann@home:foo (master)$ git submodule add git://git.debian.org/git/collab-maint/tulip.git debian
Cloning into 'debian'...
remote: Counting objects: 317, done.
remote: Compressing objects: 100% (199/199), done.
remote: Total 317 (delta 184), reused 166 (delta 95)
Receiving objects: 100% (317/317), 73.81 KiB | 0 bytes/s, done.
Resolving deltas: 100% (184/184), done.
Checking connectivity... done.
yann@home:foo (master)$ git status 
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   .gitmodules
        new file:   debian

yann@home:foo (master)$ (cd debian/ && git gui)
[errors out after showing the following error dialog]

| No working directory ../../../debian:
| 
| couldn't change working directory
| to "../../../debian": no such file or
| directory


strace shows the failing chdir call is from git-gui itself, after
getcwd() told him that it is in the dir that is indeed the workdir
already.
