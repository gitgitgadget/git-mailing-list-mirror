From: moe <moe-git@mbox.bz>
Subject: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 18:30:26 +0200
Message-ID: <20070809163026.GD568@mbox.bz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 18:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJAuB-0000as-1O
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 18:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761779AbXHIQa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 12:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761464AbXHIQa3
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 12:30:29 -0400
Received: from mx02.qsc.de ([213.148.130.14]:51958 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760858AbXHIQa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 12:30:28 -0400
X-Greylist: delayed 1410 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2007 12:30:28 EDT
Received: from x.xxs.cc (port-212-202-38-87.dynamic.qsc.de [212.202.38.87])
	by mx02.qsc.de (Postfix) with ESMTP id 901BC16C036B
	for <git@vger.kernel.org>; Thu,  9 Aug 2007 18:30:26 +0200 (CEST)
Received: (qmail 11799 invoked by uid 1000); 9 Aug 2007 16:30:26 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55458>

hi guys,

earlier today i imported one of my larger trees
(~70k files) into git and was quite disappointed
by the performance.

i made some tests on latest master branch
(1.5.3.rc4.29.g74276) and it seems like git
hits a wall somewhere above ~50k files.

i'm seeing 'commit' timings of 30s and
up as well as 'status' timings in the 10s
ballpark.

here's a test-case (should be safe to
copy/paste on linux, bash):

#
# first create a tree of roughly 100k files
#
mkdir bummer
cd bummer
for ((i=0;i<100;i++)); do
mkdir $i && pushd $i;
for ((j=0;j<1000;j++)); do
echo "$j" >$j; done; popd;
done

#
# init and add this to git
#
time git init
git config user.email "no@thx"
git config user.name "nothx"
time git add .
time git commit -m 'buurrrrn' -a

#
# git-status, tunes in at around ~10s for me
#
time git-status
time git-status
time git-status

#
# git-commit, takes a whopping 52s for me
#
date >50/500
time git commit -m 'expose the turtle' 50/500


regards,
moe
