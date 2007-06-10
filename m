From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fail if tag name and keywords is not within "printable ASCII"
Date: Sun, 10 Jun 2007 02:35:24 +0200
Message-ID: <200706100235.24358.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
 <7vfy50d67q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 02:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxBPB-0006Z9-LT
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 02:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbXFJAfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 20:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbXFJAfk
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 20:35:40 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56756 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbXFJAfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 20:35:39 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00K079NAD200@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 02:35:34 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00J9Q9N03V00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 02:35:25 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE0094I9N0PBD0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 02:35:24 +0200 (CEST)
In-reply-to: <7vfy50d67q.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49646>

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 10 June 2007, Junio C Hamano wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> > And what is so special about 0x7f?
> 
> It is DEL, but as the code uses uchar, it probably also error on
> 0x80 or higher, if the intent is "printable ASCII".

Is this better?


...Johan

 tag.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tag.c b/tag.c
index 2307ec9..2b92465 100644
--- a/tag.c
+++ b/tag.c
@@ -183,8 +183,8 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		/* Verify tag name: disallow control characters or spaces */
 		if (tag_len) { /* tag name was given */
 			for (i = 0; i < tag_len; ++i) {
-				unsigned char c = tag_line[i];
-				if (c > ' ' && c != 0x7f)
+				char c = tag_line[i];
+				if (c > ' ' && c < 0x7f)
 					continue;
 				return FAIL("Tag object (@ char " PD_FMT "): "
 					"Could not verify tag name",
@@ -198,13 +198,13 @@ int parse_and_verify_tag_buffer(struct tag *item,
 		 */
 		if (keywords_len) { /* keywords line was given */
 			for (i = 0; i < keywords_len; ++i) {
-				unsigned char c = keywords_line[i];
+				char c = keywords_line[i];
 				if (c == ',' && keywords_line[i + 1] == ',')
 					/* consecutive commas */
 					return FAIL("Tag object (@ char "
 						PD_FMT "): Found empty keyword",
 						keywords_line + i - data);
-				if (c > ' ' && c != 0x7f)
+				if (c > ' ' && c < 0x7f)
 					continue;
 				return FAIL("Tag object (@ char " PD_FMT "): "
 					"Could not verify keywords",
-- 
1.5.2.1.144.gabc40

	
