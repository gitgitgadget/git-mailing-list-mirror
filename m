From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix signedness on return value from xread()
Date: Tue, 15 May 2007 14:39:25 +0200
Message-ID: <200705151439.25871.johan@herland.net>
References: <34a7ae040705150447k2e770b5ag3629632f61b813a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Paolo Teti <paolo.teti@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 14:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnwJr-0007Ol-8s
	for gcvg-git@gmane.org; Tue, 15 May 2007 14:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbXEOMjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 08:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbXEOMjw
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 08:39:52 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56340 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbXEOMjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 08:39:51 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JI300N0V1UD1P00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 15 May 2007 14:39:49 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI300KM91TQG7C0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 15 May 2007 14:39:26 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI3004QG1TQ6E90@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 15 May 2007 14:39:26 +0200 (CEST)
In-reply-to: <34a7ae040705150447k2e770b5ag3629632f61b813a0@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47341>

The return value from xread() is ssize_t. 
Paolo Teti <paolo.teti@gmail.com> pointed out that in this case, the 
signed return value was assigned to an unsigned type (size_t). This patch 
fixes that.

Signed-off-by: Johan Herland <johan@herland.net>
---

Using this as an opportunity to get used to sending patches... :)

Is this what you were looking for, Paolo?

 pack-write.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index de72f44..ae2e481 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -25,7 +25,7 @@ void fixup_pack_header_footer(int pack_fd,
 
 	buf = xmalloc(buf_sz);
 	for (;;) {
-		size_t n = xread(pack_fd, buf, buf_sz);
+		ssize_t n = xread(pack_fd, buf, buf_sz);
 		if (!n)
 			break;
 		if (n < 0)
-- 
1.5.1.4
