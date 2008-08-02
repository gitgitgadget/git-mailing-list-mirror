From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: email address handling
Date: Sat, 2 Aug 2008 13:31:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808021321500.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org> <20080801221539.GA8617@mit.edu> <20080801152720.56dbff09.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011534260.6819@nehalem.linux-foundation.org>
 <20080801154902.c60717e5.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011554350.6819@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808011608150.6819@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 13:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPFIx-0004bL-6c
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 13:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbYHBL1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 07:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbYHBL1N
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 07:27:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:34775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752522AbYHBL1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 07:27:13 -0400
Received: (qmail invoked by alias); 02 Aug 2008 11:27:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 02 Aug 2008 13:27:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EoOkZ+qQE1PHciAx6QTr8Td0lxlp49/kZYfmOHZ
	DjKcQ9vYHUMHTy
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.1.10.0808011608150.6819@nehalem.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91141>

Hi,

On Fri, 1 Aug 2008, Linus Torvalds wrote:

> The thing is, you can actually get git to output the crazy names. Just 
> do
> 
> 	git show --pretty=email 37a4c940749670671adab211a2d9c9fed9f3f757
> 
> and now you get the email-prettified thing for at least the author.

Ah, there lies the rub (you forgot that the original complaint was about 
a comma, and pretty=email does not handle those):

-- snipsnap --

 pretty.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 33ef34a..9db0333 100644
--- a/pretty.c
+++ b/pretty.c
@@ -79,7 +79,8 @@ int non_ascii(int ch)
 
 static int is_rfc2047_special(char ch)
 {
-	return (non_ascii(ch) || (ch == '=') || (ch == '?') || (ch == '_'));
+	return (non_ascii(ch) || (ch == '=') || (ch == '?') || (ch == '_') ||
+		(ch == ',') || (ch == '"') || (ch == '\''));
 }
 
 static void add_rfc2047(struct strbuf *sb, const char *line, int len,
@@ -89,7 +90,7 @@ static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 
 	for (i = 0; i < len; i++) {
 		int ch = line[i];
-		if (non_ascii(ch))
+		if (is_rfc2047_special(ch))
 			goto needquote;
 		if ((i + 1 < len) && (ch == '=' && line[i+1] == '?'))
 			goto needquote;
