From: Edgar Toernig <froese@gmx.de>
Subject: Re: git pull on ia64 linux tree
Date: Thu, 28 Apr 2005 03:13:02 +0200
Message-ID: <20050428031302.50fbe006.froese@gmx.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:08:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxVT-0003aR-NT
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVD1BNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVD1BNK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:13:10 -0400
Received: from pop.gmx.de ([213.165.64.20]:34996 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262144AbVD1BNF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:13:05 -0400
Received: (qmail invoked by alias); 28 Apr 2005 01:13:04 -0000
Received: from p50904A7D.dip.t-dialin.net (EHLO dialup) [80.144.74.125]
  by mail.gmx.net (mp012) with SMTP; 28 Apr 2005 03:13:04 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> One problem with this is that "grep" always thinks lines end in '\n', and 
> what we'd really want (from a scriptability angle) is
> 
> 	diff-tree -z -r $orig $final | grep -0 '^-'

Don't you think it's much easier to reject filenames with control
chars?  Forget all this -z/-0 stuff.  It only complicates life and
supporting filenames with embedded newlines is useless in practice.

--- x/update-cache.c Thu Apr 21 19:58:47 2005
+++ y/update-cache.c Thu Apr 28 02:55:27 2005
@@ -227,7 +227,8 @@
  * are hidden, for chist sake.
  *
  * Also, we don't want double slashes or slashes at the
- * end that can make pathnames ambiguous.
+ * end that can make pathnames ambiguous nor any control
+ * chars.
  */
 static int verify_path(char *path)
 {
@@ -237,6 +238,8 @@
 	for (;;) {
 		if (!c)
 			return 1;
+		if ((unsigned char)c < 32)
+			return 0;
 		if (c == '/') {
 inside:
 		c = *path++;


Ciao, ET.
