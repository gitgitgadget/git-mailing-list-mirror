From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Patch to make README more newbie-friendly
Date: Thu, 14 Jul 2005 18:01:01 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.14.16.00.53.434018@smurf.noris.de>
References: <42D5F10B.5050708@pason.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 14 18:05:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt6Bp-0002Oo-OP
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 18:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVGNQDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNQCk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 12:02:40 -0400
Received: from main.gmane.org ([80.91.229.2]:35788 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263051AbVGNQCi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 12:02:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dt69O-0001uO-7G
	for git@vger.kernel.org; Thu, 14 Jul 2005 18:01:26 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jul 2005 18:01:26 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jul 2005 18:01:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Jerry Seutter wrote:

> I'd also like to include stuff about branches, but I haven't gotten my 
> head wrapped around how they work yet.  cg-branch-add expects a location
> after the branch name and I'm not sure what to give it.

Cogito branch creation is based on the idea that you have a different
archive _somewhere_else_ that you pull from, so it wants to store the
source URL in .git/branches/<name>.

Git doesn't have that assumption; "git checkout -b <name>" simply
creates a new branch and switches to it. However, the git branch idea came
somewhat later, so there's a bit of a mismatch at the moment.

Simply switching branches isn't supposed to have any effect unless you
actually have changes in different branches. I tend to work along these
lines:

#!/bin/sh

cd /tmp
rm -rf test.$$
mkdir test.$$
cd test.$$
git-init-db
echo not-quite-empty >testfile
cg-add testfile
echo Created test | cg-commit
git checkout -b one
echo foo >>testfile
echo added foo to testfile | cg-commit
git checkout -b two master
echo bar >> testfile
echo added bar to testfile | cg-commit
cg-diff -r one:two | cat
git checkout master
cg-merge one
cg-merge two

The first merge fast-forwards your master tree to "one"; the second 
creates a conflict (lines were added at the same location) which you'll
have to resolve (edit the file).

vi testfile
echo Merged one and two | cg-commit
gitk

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Apollo, the God of light, of reason, of proportion, harmony, number --
Apollo blinds those who press too close in worship. Don't look straight
at the sun. Go into a dark bar and have a beer with Dionysos, every now
and then. -- Ursula K. LeGuin
