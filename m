From: Hannu Koivisto <azure@iki.fi>
Subject: git-cvsimport doesn't support the default branch mechanism?
Date: Wed, 27 Dec 2006 23:03:15 +0200
Organization: NOYB
Message-ID: <874prhvyp8.fsf@trews52.bothi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 27 22:03:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzfvu-0004m7-1o
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 22:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbWL0VD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 16:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbWL0VD0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 16:03:26 -0500
Received: from main.gmane.org ([80.91.229.2]:43814 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbWL0VDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 16:03:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gzfvn-0005yN-1F
	for git@vger.kernel.org; Wed, 27 Dec 2006 22:03:23 +0100
Received: from her-gw.ionific.com ([195.197.73.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 22:03:23 +0100
Received: from azure by her-gw.ionific.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 22:03:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: her-gw.ionific.com
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/22.0.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:vltZt+jQZdjX8wMY3XGjSv3PDg4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35479>

Greetings,

I tried to git-cvsimport an existing project but there seemed to be
something wrong with the result.  On closer inspection I noticed
that contents of files that had never been modified in trunk
corresponded to revision 1.1 instead of the tip of the vendor
branch in the generated master and origin branches.

In other words (using zsh):

> mkdir test
> cd test
> mkdir repo
> export CVSROOT=`pwd`/repo
> cvs init
> mkdir foo
> cd foo
> echo lahna > kala.txt
> cvs import -m "Initial vendor import." foo vendor vendor-v1
> cd ..
> rm -r foo
> cvs co foo
> cd foo
> cvs up -rvendor
> echo hauki >! kala.txt
> cvs commit -m "Fake 2nd. vendor import."
> cvs up -A
> cat kala.txt
hauki
> cd ..
> git-cvsimport -d $CVSROOT -C foo.git foo
> cd foo.git
> git-checkout -f master
> cat kala.txt
lahna

I would have expected to get "hauki" from that last "cat kala.txt"
as well.  Is this a known problem or a feature?  In either case, how
should I work around it?

-- 
Hannu
