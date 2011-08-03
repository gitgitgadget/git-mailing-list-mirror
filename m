From: Udo <u.offermann@gmail.com>
Subject: git clone does not checkout active branch
Date: Wed, 3 Aug 2011 16:56:43 +0000 (UTC)
Message-ID: <loom.20110803T185528-8@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 19:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoeo0-0004Tz-KA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 19:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab1HCRAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 13:00:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:40237 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283Ab1HCRAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 13:00:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qoenf-0004EO-QY
	for git@vger.kernel.org; Wed, 03 Aug 2011 19:00:07 +0200
Received: from p5B121AD7.dip.t-dialin.net ([91.18.26.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 19:00:07 +0200
Received: from u.offermann by p5B121AD7.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 19:00:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.18.26.215 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:5.0.1) Gecko/20100101 Firefox/5.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178595>

I have a remote bare repository with two branches 'master' and 'testing', where
HEAD refers to 'testing'. When cloning this repository git checks out 'master',
if 'master' and 'testing' are on the same revision (i.e. HEAD == testing ==
master). Only if 'testing' is one (or more) commit(s) behind or ahead, git clone
checks out the 'testing' branch on the local side. I tried this with git 1.7.5
on Mac OS X (10.6.8).

Addendum: I just tried the same with a non-bare repository:

mkdir A
cd A
git init
touch a
git add a
git commit -m "init repo A with a"
git checkout -b testing

now back in the root dir:

cd ..
git clone A B
cd B
git branch -v -a
* master                 28f599b init A
  remotes/origin/HEAD    -> origin/master
  remotes/origin/master  28f599b init A
  remotes/origin/testing 28f599b init A

it's 'master'! Back to repo A (we are still in branch 'testing'):

cd ../A
touch b
git add b
git commit -m "add b in branch testing"

now 'testing' is one commit ahead 'master'. Now let's clone A again:

cd ..
git clone A C
cd C
git branch -a -v
* testing                23bca39 add b in branch testing
  remotes/origin/HEAD    -> origin/testing
  remotes/origin/master  28f599b init A
  remotes/origin/testing 23bca39 add b in branch testing

You can re-verify this weird behavior by going back to A, checkout 'master' and
merge it with 'testing' (so that all branches have the same head). Now clone A
into D and D will be checked out on master!
