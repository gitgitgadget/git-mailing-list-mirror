From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 10:39:33 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 11:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNPev-0007qL-1G
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 11:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759249AbZAOKjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 05:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbZAOKjo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 05:39:44 -0500
Received: from main.gmane.org ([80.91.229.2]:52315 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266AbZAOKjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 05:39:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LNPdW-0000pl-C3
	for git@vger.kernel.org; Thu, 15 Jan 2009 10:39:42 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 10:39:42 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 10:39:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105778>

Hello all,

While trying to understand "rebase -p", I came across some
very unexpected behaviour that made me throw in the towel
and ask for help!

The outputs I got really confused me.  Before the "rebase
-p", the tree looked like
    
    * 78ffda9... (refs/heads/work) b4
    * be1e3a4... b3
    *   cd8d893... Merge branch 'master' into work
    |\
    | * 0153c27... (refs/heads/master) a4
    | * 74f4387... a3
    * | f1b0c1c... b2
    * | 2e202d0... b1
    |/
    * b37ae36... a2
    * ed1e1bc... a1

But afterward, this is what it looks like -- all the "b"
commits are gone!

    * 0153c27... (refs/heads/work, refs/heads/master) a4
    * 74f4387... a3
    * b37ae36... a2
    * ed1e1bc... a1

What did I do wrong/misunderstand?

Here's how to recreate.  Note that "testci" is a shell
function and "lg" is a git alias.  They are, respectively,
(1) testci() { for i; do echo $i > $i; git add $i; git commit -m $i; done; }
(2) git config alias.lg log --graph --pretty=oneline --abbrev-commit --decorate

    git init
    testci a1 a2
    git checkout -b work
    testci b1 b2
    git checkout master
    testci a3 a4
    git checkout work
    git merge master
    testci b3 b4
    git --no-pager lg   # graph before rebase -p
    git rebase -p master
    git --no-pager lg   # graph after rebase -p
