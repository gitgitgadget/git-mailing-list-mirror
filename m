From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-p4: fix keyword-expansion regex
Date: Wed, 26 Nov 2008 13:52:15 -0500
Message-ID: <20081126185215.GA11037@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 20:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5PdM-00034d-V0
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 20:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbYKZS7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 13:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYKZS7x
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 13:59:53 -0500
Received: from marge.padd.com ([99.188.165.110]:43342 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbYKZS7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 13:59:52 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Nov 2008 13:59:52 EST
Received: from oink.padd.com (oink.padd.com [69.36.12.13])
	by marge.padd.com (Postfix) with ESMTPSA id 0A79710F81C5
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 10:51:19 -0800 (PST)
Received: by oink.padd.com (Postfix, from userid 7770)
	id 1C7B7FD416C; Wed, 26 Nov 2008 13:52:15 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101758>

This text:

     my $dir = $File::Find::dir;
     return if ($dir !~ m,$options->{dirpat}$,);

was improperly converted to:

     my $dir = $File$dir !~ m,$options->{dirpat}$,);

by the keyword identifier expansion code.  Add a \n
to make sure the regex doesn't go across end-of-line
boundaries.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 9b04ca5..09317af 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1005,7 +1005,7 @@ class P4Sync(Command):
             if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
                 text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
             elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
-                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)
+                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$',r'$\1$', text)
 
             contents[stat['depotFile']] = text
 
-- 
1.5.6.5
