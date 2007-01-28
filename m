From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Teach for-each-ref about a little language called Tcl.
Date: Sun, 28 Jan 2007 12:58:51 -0800
Message-ID: <7v4pqaeulw.fsf@assigned-by-dhcp.cox.net>
References: <20070128073913.GA9915@spearce.org>
	<20070128094909.GA3740@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Sun Jan 28 21:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBH75-0005sa-SK
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 21:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932820AbXA1U6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 15:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbXA1U6x
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 15:58:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49362 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbXA1U6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 15:58:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128205852.DPJJ16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 15:58:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gkxt1W00N1kojtg0000000; Sun, 28 Jan 2007 15:57:54 -0500
In-Reply-To: <20070128094909.GA3740@procyon.home> (Sergey Vlasov's message of
	"Sun, 28 Jan 2007 12:49:09 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38048>

Sergey Vlasov <vsu@altlinux.ru> writes:

> This is better; however, wrapping this format inside { ... } (which
> you may want to do in the template for some uses) won't work if the
> string contains unmatched braces.  Quoting '{' and '}' characters with
> backslashes should fix this.

Then I'd commit after applying this on top of Shawn's.  Ok?

diff --git a/quote.c b/quote.c
index 01db5e2..fb9e4ca 100644
--- a/quote.c
+++ b/quote.c
@@ -395,11 +395,9 @@ void tcl_quote_print(FILE *stream, const char *src)
 	fputc('"', stream);
 	while ((c = *src++)) {
 		switch (c) {
-		case '[':
-		case ']':
-		case '$':
-		case '\\':
-		case '"':
+		case '[': case ']':
+		case '{': case '}':
+		case '$': case '\\': case '"':
 			fputc('\\', stream);
 		default:
 			fputc(c, stream);
