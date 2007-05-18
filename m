From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive: convert archive entries like checkouts do
Date: Sat, 19 May 2007 00:58:10 +0200
Message-ID: <464E2F82.7090309@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <200705171928.34927.johan@herland.net> <464E2425.2030904@lsrfire.ath.cx> <Pine.LNX.4.64.0705181826220.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 00:58:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpBP2-0000xL-Ik
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXERW6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbXERW6T
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:58:19 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43987
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752338AbXERW6T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 18:58:19 -0400
Received: from [10.0.1.201] (p508E74AF.dip.t-dialin.net [80.142.116.175])
	by neapel230.server4you.de (Postfix) with ESMTP id 4A34239000;
	Sat, 19 May 2007 00:58:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <Pine.LNX.4.64.0705181826220.18541@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47676>

Daniel Barkalow schrieb:
> Conditional needs a "+ 1", too.
[...]
> Same here.

Thank you for spotting this.  Fix-up patch below.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
Embarrassing.  I'm off to go to sleep now.

 archive-tar.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index eb0abc7..33e7657 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -82,7 +82,7 @@ static void strbuf_append_string(struct strbuf *sb, const char *s)
 {
 	int slen = strlen(s);
 	int total = sb->len + slen;
-	if (total > sb->alloc) {
+	if (total + 1 > sb->alloc) {
 		sb->buf = xrealloc(sb->buf, total + 1);
 		sb->alloc = total + 1;
 	}
@@ -271,7 +271,7 @@ static int write_tar_entry(const unsigned char *sha1,
 		path.alloc = PATH_MAX;
 		path.len = path.eof = 0;
 	}
-	if (path.alloc < baselen + filenamelen) {
+	if (path.alloc < baselen + filenamelen + 1) {
 		free(path.buf);
 		path.buf = xmalloc(baselen + filenamelen + 1);
 		path.alloc = baselen + filenamelen + 1;
