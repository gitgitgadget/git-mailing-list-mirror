From: Christian Couder <chriscool@tuxfamily.org>
Subject: Possible d/f conflict bug or regression
Date: Sat, 29 Mar 2008 08:13:08 +0100
Message-ID: <200803290813.08419.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio Hamano <junkio@cox.net>, krh@redhat.com
X-From: git-owner@vger.kernel.org Sat Mar 29 08:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfVAv-0002PX-SC
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 08:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbYC2HHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 03:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYC2HHb
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 03:07:31 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:48131 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYC2HHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 03:07:31 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3F32B1AB2D8;
	Sat, 29 Mar 2008 08:07:30 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1F4811AB2CD;
	Sat, 29 Mar 2008 08:07:30 +0100 (CET)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78448>

Hi,

When doing something like:

mkdir testdir &&
        cd testdir &&
        touch foo &&
        git init &&
        git add . &&
        git commit -m 'Initial commit.' &&
        rm foo &&
        mkdir foo &&
        git commit -a -m 'Test.'

I get:

Initialized empty Git repository in .git/
Created initial commit 3f945ca: Initial commit.
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
fatal: unable to index file foo

I think it's quite bad that it doesn't work.

It seems it also doesn't work when adding "touch foo/bar" before "git 
commit -a -m 'Test.'".

I used:

$ git --version
git version 1.5.5.rc2

It worked with 1.5.3 and I bisected it to the git commit port to C:

commit f5bbc3225c4b073a7ff3218164a0c820299bc9c6
Author: Kristian H<C3><B8>gsberg <krh@redhat.com>
Date:   Thu Nov 8 11:59:00 2007 -0500

    Port git commit to C.

    This makes git commit a builtin and moves git-commit.sh to
    contrib/examples.  This also removes the git-runstatus
    helper, which was mostly just a git-status.sh implementation detail.

    Signed-off-by: Kristian H<C3><B8>gsberg <krh@redhat.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks,
Christian.
