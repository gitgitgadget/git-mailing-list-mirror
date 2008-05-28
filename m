From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [BISECTED] git-svn: "Failed to read object ..." during clone
Date: Wed, 28 May 2008 05:01:28 +0200
Message-ID: <20080528030128.GA28904@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed May 28 05:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Bw0-0007EF-30
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 05:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbYE1DBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 23:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYE1DBd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 23:01:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:50193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751303AbYE1DBc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 23:01:32 -0400
Received: (qmail invoked by alias); 28 May 2008 03:01:30 -0000
Received: from i577BAB6E.versanet.de (EHLO atjola.local) [87.123.171.110]
  by mail.gmx.net (mp033) with SMTP; 28 May 2008 05:01:30 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/9Dr038Q39gimnMcPDEM0S0WDFcFwXJm1QHb2HtF
	aeSNdoj2aUB0DE
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83067>

Hi Adam,

when cloning the SVN repository at svn://svn.debian.org/estron/ git-svn=
 bails
out with:
=46ailed to read object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 at
/usr/local/bin/git-svn line 3195, <GEN36> line 645.

Bisection led to:
ffe256f9bac8a40ff751a9341a5869d98f72c285 is first bad commit
commit ffe256f9bac8a40ff751a9341a5869d98f72c285
Author: Adam Roben <aroben@apple.com>
Date:   Fri May 23 16:19:41 2008 +0200

    git-svn: Speed up fetch
   =20
    We were spending a lot of time forking/execing git-cat-file and
    git-hash-object. We now maintain a global Git repository object in =
order to use
    Git.pm's more efficient hash_and_insert_object and cat_blob methods=
=2E

I can reliable reproduce the problem using this command:
git svn clone -r215:230 svn://svn.debian.org/estron/trunk

$ git --version
git version 1.5.6.rc0.13.g2d392
$ git svn --version
git-svn version 1.5.6.rc0.13.g2d392 (svn 1.4.6)

Bj=F6rn
