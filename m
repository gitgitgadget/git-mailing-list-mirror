From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/5] hg-to-git: abort if the project directory is not a hg repo
Date: Sun,  6 Jul 2008 05:15:18 +0200
Message-ID: <ca2e01fa1446afa551f5a6a36242a03d79cb685c.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
 <89a68bb21125c4ff706412cde5c04f5d96658789.1215313871.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 05:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFKjp-0000sb-Rd
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 05:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbYGFDPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 23:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYGFDPN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 23:15:13 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57908 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbYGFDPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 23:15:11 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 6BF131DDC5B;
	Sun,  6 Jul 2008 05:15:08 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8185C1A9CF1; Sun,  6 Jul 2008 05:15:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <89a68bb21125c4ff706412cde5c04f5d96658789.1215313871.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87489>

Check the exit code of the first hg command, and abort to avoid a later
ValueError exception.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hg-to-git/hg-to-git.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 25d9941..130b1c4 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -106,7 +106,10 @@ if state:
     else:
         print 'State does not exist, first run'
 
-tip = os.popen('hg tip --template "{rev}"').read()
+sock = os.popen('hg tip --template "{rev}"')
+tip = sock.read()
+if sock.close():
+    sys.exit(1)
 if verbose:
     print 'tip is', tip
 
-- 
1.5.6.1.322.ge904b.dirty
