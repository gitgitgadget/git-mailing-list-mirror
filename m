From: Josh Triplett <josh@joshtriplett.org>
Subject: Cloning a remote tag without using git-fetch-pack directly?
Date: Tue, 19 Apr 2011 15:20:53 -0700
Message-ID: <20110419222050.GA3304@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCJIf-0004Cw-1T
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 00:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab1DSWVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 18:21:30 -0400
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:59797 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab1DSWV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 18:21:29 -0400
X-WhiteListed: mail was accepted with no delay
X-WhiteListed: mail was accepted with no delay
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id F1C4287544
	for <git@vger.kernel.org>; Wed, 20 Apr 2011 00:21:25 +0200 (CEST)
X-Originating-IP: 217.70.178.137
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id D39F2172079;
	Wed, 20 Apr 2011 00:21:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter8-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id YBstnCjM1s3r; Wed, 20 Apr 2011 00:20:59 +0200 (CEST)
X-Originating-IP: 131.252.247.124
Received: from feather (host-247-124.pubnet.pdx.edu [131.252.247.124])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9BC1B172081;
	Wed, 20 Apr 2011 00:20:55 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171822>

Using fetch-pack, I can clone a single tag from a repository:

/tmp/testrepo$ git init
Initialized empty Git repository in /tmp/testrepo/.git/
/tmp/testrepo$ git fetch-pack /home/josh/src/linux-2.6/.git refs/tags/v2.6.12
remote: Counting objects: 31617, done.
remote: Compressing objects: 100% (21083/21083), done.
Receiving objects: 100% (31617/31617), 52.56 MiB | 5.27 MiB/s, done.
remote: Total 31617 (delta 12862), reused 19495 (delta 10331)
Resolving deltas: 100% (12862/12862), done.
keep    c80bd1def293bc11591159c96970d8becfe3b2d9
26791a8bcf0e6d33f43aef7682bdb555236d56de refs/tags/v2.6.12
/tmp/testrepo$ git show 26791a8bcf0e6d33f43aef7682bdb555236d56de | head -20
tag v2.6.12

This is the final 2.6.12 release
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCsykyF3YsRnbiHLsRAvPNAJ482tCZwuxp/bJRz7Q98MHlN83TpACdHr37
o6X/3T+vm8K3bf3driRr34c=
=sBHn
-----END PGP SIGNATURE-----

commit 9ee1c939d1cb936b1f98e8d81aeffab57bae46ab
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Fri Jun 17 12:48:29 2005 -0700

    Linux 2.6.12

diff --git a/Makefile b/Makefile
index 9e005e1..0d1e74d 100644
--- a/Makefile



However, I can't seem to find any way to convince git clone to do the
same thing for me.  git clone will clone a branch, but not a tag.

/tmp/testrepo$ git clone /home/josh/src/linux-2.6/.git -b refs/tags/v2.6.12
Cloning into linux-2.6...
done.
warning: Remote branch refs/tags/v2.6.12 not found in upstream origin, using HEAD instead


On a different note, git fetch-pack seems to silently fail if asked to
fetch a remote tag which points at a tree object rather than a commit
object:

/tmp/testrepo$ git init
Initialized empty Git repository in /tmp/testrepo/.git/
/tmp/testrepo$ git fetch-pack /home/josh/src/linux-2.6/.git refs/tags/v2.6.12-tree
(1) /tmp/testrepo$ echo $?
1


I realize that I want to do something strange here, but it seems like a
kind of strange that git already supports in at least some ways, just
not in others.  Am I missing something?

Thanks,
Josh Triplett
