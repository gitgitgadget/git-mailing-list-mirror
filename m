From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 23:16:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808012314580.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 23:13:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1w0-0001c3-4B
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 23:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761242AbYHAVLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 17:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761232AbYHAVLn
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 17:11:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:59795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761234AbYHAVLm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 17:11:42 -0400
Received: (qmail invoked by alias); 01 Aug 2008 21:11:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 01 Aug 2008 23:11:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Bu5chpu/BV8wr6Vt67LnE5+GmB6wdpG6hVY/BbP
	xDTaVz7ZohS18j
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080801135421.5ca0f6af.akpm@linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91100>

Hi,

On Fri, 1 Aug 2008, Andrew Morton wrote:

> I very very frequently copy and paste name+email address out of git 
> output and into an MUA.  Have done it thousands and thousands of times, 
> and it has always worked.  I'm sure that many others do the same thing.

$ git log --pretty=email

after this patch:

-- snipsnap --

 pretty.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 33ef34a..ba50b54 100644
--- a/pretty.c
+++ b/pretty.c
@@ -140,14 +140,20 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	if (fmt == CMIT_FMT_EMAIL) {
 		char *name_tail = strchr(line, '<');
 		int display_name_length;
+		int need_quotes;
 		if (!name_tail)
 			return;
 		while (line < name_tail && isspace(name_tail[-1]))
 			name_tail--;
 		display_name_length = name_tail - line;
+		need_quotes = !!memchr(line, ',', display_name_length);
 		filler = "";
 		strbuf_addstr(sb, "From: ");
+		if (need_quotes)
+			strbuf_addch(sb, '"');
 		add_rfc2047(sb, line, display_name_length, encoding);
+		if (need_quotes)
+			strbuf_addch(sb, '"');
 		strbuf_add(sb, name_tail, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
 	} else {
