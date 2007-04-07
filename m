From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] t5300-pack-object.sh: portability issue using /usr/bin/stat
Date: Fri, 06 Apr 2007 22:33:34 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704062227430.28181@xanadu.home>
References: <20070406234903.GJ3854@regex.yaph.org>
 <7vfy7dgcn1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 04:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha0kU-0006S0-Rt
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 04:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbXDGCdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 22:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbXDGCdg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 22:33:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37177 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965109AbXDGCdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 22:33:35 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG300LLPWFYYQ60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Apr 2007 22:33:34 -0400 (EDT)
In-reply-to: <7vfy7dgcn1.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43956>

On Fri, 6 Apr 2007, Junio C Hamano wrote:

> arjen@yaph.org (Arjen Laarhoven) writes:
> 
> > In the test 'compare delta flavors', /usr/bin/stat is used to get file size.
> > This isn't portable.  There already is a dependency on Perl, use its '-s'
> > operator to get the file size.
> 
> If you do use Perl, then you do not want to do it as two
> separate invocations with their result compared with test.
> 
> How about this on top of your patch?

Well... since this test already depends on wc then why not just use that 
instead of adding a perl dependency?

Something like:

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 35e036a..ba785cf 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -125,8 +125,8 @@ cd "$TRASH"
 
 test_expect_success \
     'compare delta flavors' \
-    'size_2=`stat -c "%s" test-2-${packname_2}.pack` &&
-     size_3=`stat -c "%s" test-3-${packname_3}.pack` &&
+    'size_2=`wc -c < test-2-${packname_2}.pack` &&
+     size_3=`wc -c < test-3-${packname_3}.pack` &&
      test $size_2 -gt $size_3'
 
 rm -fr .git2
