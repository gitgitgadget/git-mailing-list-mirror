From: Mike Hommey <mh@glandium.org>
Subject: git rebase bug?
Date: Wed, 7 Jul 2010 17:05:45 +0200
Message-ID: <20100707150545.GA24814@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 17:28:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWWYP-0001Bq-G1
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 17:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab0GGP2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 11:28:49 -0400
Received: from vuizook.err.no ([85.19.221.46]:56234 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756301Ab0GGP2r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 11:28:47 -0400
X-Greylist: delayed 1375 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2010 11:28:47 EDT
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1OWWC2-0008Jy-FS
	for git@vger.kernel.org; Wed, 07 Jul 2010 17:05:49 +0200
Received: from mh by glandium.org with local (Exim 4.72)
	(envelope-from <mh@glandium.org>)
	id 1OWWC1-00078J-59
	for git@vger.kernel.org; Wed, 07 Jul 2010 17:05:45 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 2.5): No, score=2.5 required=5.0 tests=DNS_FROM_OPENWHOIS,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150478>

Hi,

I got a really weird result from a rebase today, and I'm wondering if
that's a corner case or if that could be considered a bug in rebase.

This is reproducible with the following setup:
$ git clone git://git.debian.org/pkg-mozilla/xulrunner/experimental xulrunner-1.9.2
$ cd xulrunner-1.9.2
$ git remote add upstream git://git.debian.org/pkg-mozilla/upstream
$ git fetch upstream xulrunner/2.0:xulrunner/2.0
$ git checkout -b test upstream/1.9.2.4
$ git cherry-pick 67e469ef725ac3f4cdf043809066c353e6843db4

The patch that is cherry picked here has the following stats:
 security/manager/ssl/public/Makefile.in            |    1 +
 security/manager/ssl/public/nsIBadCertListener.idl |  155 ++++++++++++++++++++
 security/manager/ssl/src/nsNSSIOLayer.cpp          |  103 +++++++++++++-
 security/manager/ssl/src/nsNSSIOLayer.h            |    8 +

$ git rebase --onto xulrunner/2.0 upstream/1.9.2.4 test

The resulting commit has the following stats:
 security/manager/ssl/public/Makefile.in        |    1 +
 security/manager/ssl/src/nsNSSIOLayer.cpp      |  103 ++++++++++++++++-
 security/manager/ssl/src/nsNSSIOLayer.h        |    8 ++
 xulrunner/examples/simple/content/contents.rdf |  155 ++++++++++++++++++++++++

See how the security/manager/ssl/public/nsIBadCertListener.idl file that
was created by the original patch is created as
xulrunner/examples/simple/content/contents.rdf.

Please note that as the xulrunner/2.0 commit has no parent, I also tried
grafting it on top of upstream/1.9.2.4, which didn't change anything.

So, corner case or definite bug?

Cheers,

Mike

PS: this all is with current master
