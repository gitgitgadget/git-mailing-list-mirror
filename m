From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] format-patch -n: make sorting easier by padding number
Date: Fri, 9 Feb 2007 01:43:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702090142100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702082158.56463.andyparkins@gmail.com>
 <200702082331.13095.andyparkins@gmail.com> <20070208234153.GB1556@spearce.org>
 <7vk5ysw6a3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702081623460.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJrt-0005Gx-8E
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbXBIAn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945946AbXBIAn5
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:43:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:39977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945945AbXBIAn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:43:56 -0500
Received: (qmail invoked by alias); 09 Feb 2007 00:43:55 -0000
X-Provags-ID: V01U2FsdGVkX1/9tcJ2Zqr9vR+cWuANN1oHuOeDc27B1psaa28i3/
	tzJQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702081623460.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39142>


Now, when format-patch outputs more than 9 patches, the numbers
are padded accordingly. Example:

	[PATCH 009/167] The 9th patch of a series of 167

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Thu, 8 Feb 2007, Linus Torvalds wrote:
	
	> On Thu, 8 Feb 2007, Junio C Hamano wrote:
	> > 
	> > This came up before, but when you have more than 9 in your
	> > series, we _could_ do [PATCH 01/12] ... [PATCH 12/12] to line
	> > them up in e-mail client of the recipients better.
	> 
	> Not just "line them up". It's more than just a visual thing.

	How about this?

	Yes, it calculates the width over and over again, but it's not
	like it's a really performance critical part.

 log-tree.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 85acd66..89c29e2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -102,6 +102,16 @@ static int append_signoff(char *buf, int buf_sz, int at, const char *signoff)
 	return at;
 }
 
+static unsigned int log10(unsigned int number)
+{
+	unsigned int i = 10, result = 1;
+	while (i < number) {
+		i *= 10;
+		result++;
+	}
+	return result;
+}
+
 void show_log(struct rev_info *opt, const char *sep)
 {
 	static char this_header[16384];
@@ -155,7 +165,8 @@ void show_log(struct rev_info *opt, const char *sep)
 		if (opt->total > 0) {
 			static char buffer[64];
 			snprintf(buffer, sizeof(buffer),
-					"Subject: [PATCH %d/%d] ",
+					"Subject: [PATCH %0*d/%d] ",
+					log10(opt->total),
 					opt->nr, opt->total);
 			subject = buffer;
 		} else if (opt->total == 0)
